#include<iom16v.h>
#include <macros.h>

#include "iic.h"

#include <avr/io.h>
#include <compat/twi.h>
#include <avr/signal.h>

#include <util/delay.h>

#include "EEPROM.h"

static strTWI_t strTWI;

void delay_nms(unsigned int ms)                        
{     
for(int i=0;i<ms;i++)
   _delay_loop_2(8*250); 8M ����
}

void EEprom_RW(unsigned RW,unsigned int addr,unsigned char *ptr,unsigned int len)
{
strTWI.STATUS=TW_OK;

if(RW == EEPROM_READ)
   TWI_RW(SLA_24CXX+(ADDR_24C256<<1)+TW_READ,addr,ptr,len);
else if(RW == EEPROM_WRITE)
   TWI_RW(SLA_24CXX+(ADDR_24C256<<1)+TW_WRITE,addr,ptr,len);
  
while(strTWI.STATUS==TW_BUSY);

if(RW == EEPROM_WRITE)
   delay_nms(10);
}

//AT24C256�Ķ�д����(��������������������ֽ�д��ҳд)
//����sla�����λ����(���жϳ������ж�)
//bit0=1 TW_READ ��
//bit0=0 TW_WRITE д
// sla   ������ַ(���ܸ��)
// addr EEPROM��ַ(0~32767)
// *ptr ��д���ݻ�����
// len   �����ݳ���(1~32768)��д���ݳ���(1 or 8 or 16 or 32 or 64)
// ����ֵ �Ƿ���ִ�е�ǰ����
unsigned char twi_rw(unsigned char slAddr, unsigned int dataAddr, unsigned char *ptr, unsigned int len)
{
    if (strTWI.status==TW_BUSY)
    { 
        //TWIæ�����ܽ��в���
        return OP_BUSY;
    }
    strTWI.status=TW_BUSY;
    strTWI.sladdr=slAddr;
    strTWI.sldaddrH=(unsigned char)((dataAddr>>8)&0xff);
    strTWI.sldaddrL=(unsigned char)(dataAddr&0xff);
    strTWI.data=ptr;
    strTWI.dataLen=len;
    strTWI.state=ST_START;
    strTWI.retry=0;
    TWCR=(1<<TWSTA)|TW_ACT;      //����start�ź�
    return OP_RUN;
}

void twi_isr(void)  //IIC�ж�
{
    unsigned char action,state,status;
    action=strTWI.SLA&TW_READ;     //ȡ����ģʽ
    state=strTWI.STATE;
    status=TWSR&0xF8;       //����Ԥ��Ƶλ
    if ((status>=0x60)||(status==0x00))
    {//���ߴ����ӻ�ģʽ�������ж�,���账��
        return;
    }
    switch(state)
    {
    case ST_START: //START״̬���
        if(status==TW_START)
        {//����start�źųɹ�
            TWDR=strTWI.SLA&0xFE;    //����������ַдSLAW
            TWCR=TW_ACT;             //������һ��������ͬʱ��start���ͱ�־
        }
        else
        {//����start�źų���
            state=ST_FAIL;
        }
        break;
    case ST_SLAW: //SLAW״̬���
        if(status==TW_MT_SLA_ACK)
        {//����������λ��ַ�ɹ�
            TWDR=strTWI.ADDR_H;     //����eeprom��ַ
            TWCR=TW_ACT;             //������һ������
        }
        else
        {//����������ַ����
            state=ST_FAIL;
        }
        break;
    case ST_WADDR_H: //ADDR״̬���
        if(status==TW_MT_DATA_ACK)
        {//����������λ��ַ�ɹ�
            TWDR=strTWI.ADDR_L;     //����eeprom��ַ
            TWCR=TW_ACT;             //������һ������
        }
        else
        {//����������ַ����
            state=ST_FAIL;
        }
        break;
    case ST_WADDR_L: //ADDR״̬���
        if(status==TW_MT_DATA_ACK)
        {//����eeprom��ַ�ɹ�
            if (action==TW_READ)
            {//������ģʽ
                TWCR=(1<<TWSTA)|TW_ACT;   //����restart�ź�,��һ��������RESTART��֧
            }
            else
            {//д����ģʽ
                TWDR=*strTWI.pBUF++;          //д��һ���ֽ�
                strTWI.DATALEN--;
                state=ST_WDATA-1;    //��һ��������WDATA��֧
                TWCR=TW_ACT;            //������һ������
            }
        }
        else
        {//����eeprom��ַ����
            state=ST_FAIL;
        }
        break;
    case ST_RESTART: //RESTART״̬��飬ֻ�ж�����ģʽ������������
        if(status==TW_REP_START)
        {//����restart�źųɹ�
            TWDR=strTWI.SLA;     //��������ַ��SLAR
            TWCR=TW_ACT;             //������һ��������ͬʱ��start���ͱ�־
        }
        else
        {//�ط�start�źų���
            state=ST_FAIL;
        }
        break;
    case ST_SLAR: //SLAR״̬��飬ֻ�ж�����ģʽ������������
        if(status==TW_MR_SLA_ACK)
        {//����������ַ�ɹ�
            if (strTWI.DATALEN--)
            {//�������
                TWCR=(1<<TWEA)|TW_ACT;   //�趨ACK��������һ������
            }
            else
            {//ֻ��һ������
                TWCR=TW_ACT;     //�趨NAK��������һ������
            }
        }
        else
        {//����������ַ����
            state=ST_FAIL;
        }
        break;
    case ST_RDATA: //��ȡ����״̬��飬ֻ�ж�����ģʽ������������
        state--;        //ѭ��,ֱ������ָ����������
        if(status==TW_MR_DATA_ACK)
        {//��ȡ���ݳɹ������������һ������
            *strTWI.pBUF++=TWDR;
            if (strTWI.DATALEN--)
            {//���ж������
                TWCR=(1<<TWEA)|TW_ACT;   //�趨ACK��������һ������
            }
            else
            {//׼�������һ������
                TWCR=TW_ACT;     //�趨NAK��������һ������
            }
        }
        else if(status==TW_MR_DATA_NACK)
        {//�Ѿ��������һ������
            *strTWI.pBUF++=TWDR;
            TWCR=(1<<TWSTO)|TW_ACT;    //����ֹͣ�źţ������ٲ����ж���
            strTWI.STATUS=TW_OK;
        }
        else
        {//��ȡ���ݳ���
            state=ST_FAIL;
        }
        break;
    case ST_WDATA: //д����״̬��飬ֻ��д����ģʽ������������
        state--;        //ѭ��,ֱ��д��ָ����������
        if(status==TW_MT_DATA_ACK)
        {//д���ݳɹ�
            if (strTWI.DATALEN)
            {//��Ҫд
                TWDR=*strTWI.pBUF++;
                strTWI.DATALEN--;
                TWCR=TW_ACT;            //������һ������
            }
            else
            {//д����
                TWCR=(1<<TWSTO)|TW_ACT;   //����ֹͣ�źţ������ٲ����ж���
                strTWI.STATUS=TW_OK;
                //����д�������Ҫ10ms(���)�ı��ʱ����������İ����ݼ�¼����
                //����ڼ���������Ӧ�κ�����
            }
        }
        else
        {//д����ʧ��
            state=ST_FAIL;
        }
        break;
    default:
        //����״̬
        state=ST_FAIL;
        break;
    }

    if (state==ST_FAIL)
    {//������
        strTWI.FAILCNT++;
        if (strTWI.FAILCNT<FAIL_MAX)
        {//���Դ���δ�������ֵ��
            TWCR=(1<<TWSTA)|TW_ACT;    //��������,����start�ź�
        }
        else
        {//����ֹͣ
            TWCR=(1<<TWSTO)|TW_ACT;    //����ֹͣ�źţ������ٲ����ж���
            strTWI.STATUS=TW_FAIL;
        }
    }
    state++;
    strTWI.STATE=state;       //����״̬
}

