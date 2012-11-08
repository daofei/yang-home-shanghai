#include<iom16v.h>
#include <macros.h>

#include "util.h"
#include "eeprom.h"

/* һ��ͨ�õ�24C01��24C256��9��EEPROM���ֽڶ�д��������   
�˳������������������ֱ�Ϊ��д���ݻ�����ָ��,   
���ж�д���ֽ�����EEPROM��ַ��EEPROM�����ֽڣ�   
�Լ�EEPROM���͡��˳���ṹ�����ã����м��õ��ݴ��ԣ����������Ҳ����:   
DataBuffΪ��д�������룯�������������ַ   
Length ΪҪ��д���ݵ��ֽ�����   
Addr ΪEEPROM��Ƭ�ڵ�ַ AT24256Ϊ0��32767   
Control ΪEEPROM�Ŀ����ֽڣ�������ʽΪ(1)(0)(1)(0)(A2)(A1)(A0)(R/W),����R/W=1,   
��ʾ������,R/W=0Ϊд����,A2,A1,A0ΪEEPROM��ҳѡ��Ƭѡ��ַ;   
enumerΪö�ٱ���,��ΪAT2401��AT24256�е�һ��,�ֱ��ӦAT24C01��AT24C256;   
��������ֵΪһ��λ������������1��ʾ�˴β���ʧЧ��0��ʾ�����ɹ�;   
ERRORΪ������������������ERRORCOUNT�β���ʧЧ��������ֹ������������1   
SDA��SCL���û��Զ��壬�����ݶ���ΪP3^0��P3^1; */   
/*����1Kλ��2Kλ��4Kλ��8Kλ��16KλоƬ����һ��8λ�����ֽڵ�ַ�룬����32Kλ����   
�Ĳ���2��8λ�����ֽڵ�ַ��ֱ��Ѱַ����4Kλ��8Kλ��16Kλ���ҳ���ַ��Ѱַ*/   
   
/* ����������  AT24C01��AT24C256 �Ķ�д���� ������������ */

#define AT24C256DEVADDR 0xa0

#define MAXRETRY    10

#define SET_SCL (PORTC|=0x10)
#define CLR_SCL (PORTC&=0xef)
#define SET_SDA (PORTC|=0x20)
#define CLR_SDA (PORTC&=0xdf)
#define TEST_SDA ((PINC&0x20)?1:0)
#define SDA_OUT (DDRC|=0x20)
#define SDA_IN (DDRC&=0xdf,PORTC|=0x20)

static void start(void);
static void stop(void);
static unsigned char recAck(void);
static void ack(void);
static void noAck(void);
static void sendByte(unsigned char byte);
static unsigned char receiveByte(void);

//pc4 scl
//pc5 sda
void at24c256_init(void)
{
    //pc4 and pc5 output mode.
    DDRC |= 0x30;
    PORTC |= 0x30;
    //printf("H");
    delay_ms(5000);
    PORTC &= 0xef;
    //printf("L");
    delay_ms(5000);
    PORTC |= 0x10;
    //printf("H");
    delay_ms(5000);
    PORTC &= 0xef;
    //printf("L");
    delay_ms(5000);
    PORTC |= 0x10;	
    //printf("H");
    delay_ms(5000);
    PORTC &= 0xef;
    //printf("L");
    delay_ms(5000);
    PORTC |= 0x10;	
    return;
}

char rw24c256(unsigned char *data,unsigned char len,unsigned int addr, unsigned char rwFlag)    
{    

    unsigned char j, i = MAXRETRY;    
    char err = 1;  /*   �����־   */   
    while(i--)    
    {    
        start();  /*   ��������   */
        //if(rwFlag == RW24C256WRITE)
            sendByte(AT24C256DEVADDR |0x00); /*   ��IIC����д���ݣ�������ַ */   
        //else
        //    sendByte(AT24C256DEVADDR |0x01); /*   ��IIC���߶����ݣ�������ַ */  
            //printf("11111"); 
        if(recAck()) continue; /*   ��д����ȷ��������ѭ��   */   
        //printf("2222"); 
        sendByte((unsigned char)(addr >> 8));//����������ת��Ϊ�ַ������ݣ�����ȡ�ͣ�ֻȡ��8λ.�����������32Kλ��ʹ��16λ��ַѰַ��д��߰�λ��ַ    
        //printf("33333"); 
        if(recAck())  continue;    
        //printf("4444"); 
        sendByte((unsigned char)addr); /*   ��IIC����д����   */   
        //printf("5555"); 
        if(recAck())  continue; /*   ��д��ȷ��������ѭ��   */
        //printf("6666"); 
        if(rwFlag == RW24C256WRITE)   //�ж��Ƕ���������д����    
        {    
            j=len;    
            err=0;         /* ���������λ */   
            while(j--)    
            {    
                sendByte(*(data++)); /*   ��IIC����д����   */   
                if(!recAck()) continue; /*   ��д��ȷ��������ѭ��   */   
                err=1;    
                break;    
            }    
            if(err==1) continue;    
            break;    
        }    
        else   
        {    
            //printf("to read.");
            start();  /*   ��������   */   
            sendByte(AT24C256DEVADDR|0x01); /*   ��IIC����д����   */   
            if(recAck()) continue;//����ûӦ��������α���ѭ��    
            while(len--)  /*   �ֽڳ�Ϊ0����   */   
            {
                //printf("to read12.");     
                *(data++)= receiveByte();    
                ack();   /*   ��IIC���߲���Ӧ��   */   
            }    
            *data=receiveByte(); /* �����һ���ֽ� */   
            noAck();  /*   ����IIC���߲���Ӧ��   */   
            err=0;    
            break;    
        }    
    }    
    stop();  /*   ֹͣIIC����   */   
    if(rwFlag == RW24C256WRITE)    
    {     
        delay_ms(50);    
    }    
    return err;    
}    
   
/* * * * * �����Ƕ�IIC���ߵĲ����ӳ��� * * * * */   
/* * * * * * �������� * * * * */   
static void start(void)    
{    
    //SCL=0; /* SCL���ڸߵ�ƽʱ,SDA�Ӹߵ�ƽת��͵�ƽ��ʾ */   
    //CLR_SCL;
    //SDA=1; /* һ��"��ʼ"״̬,��״̬��������������֮ǰִ�� */   
    SET_SDA;
    NOP();
    //SCL=1;
    SET_SCL;
    NOP(); NOP(); NOP();    
    //SDA=0;
    CLR_SDA;
    NOP(); NOP(); NOP(); NOP();    
    //SCL=0;
    CLR_SCL;
    //SDA=1;
    //SET_SDA;

    return;
}    
   
/* * * * * ֹͣIIC���� * * * * */   
static void stop(void)    
{     
    //SCL=0; /*SCL���ڸߵ�ƽʱ,SDA�ӵ͵�ƽת��ߵ�ƽ */
    //CLR_SCL;   
    //SDA=0; /*��ʾһ��"ֹͣ"״̬,��״̬��ֹ����ͨѶ */
    CLR_SDA;
    NOP();
    //SCL=1;
    SET_SCL;
    NOP(); NOP(); NOP(); /* �ղ��� */
    //SDA=1;
    SET_SDA;
    NOP(); NOP(); NOP();
    //SCL=0;
    //CLR_SCL;
    
    return;
}    
   
/* * * * * ���Ӧ��λ * * * * */   
static unsigned char recAck(void)    
{
    unsigned char result;
     unsigned char i=0;
    
    //SCL=0;
    //CLR_SCL;   
    //SDA=1;
    SET_SDA;
    SDA_IN;
    //SCL=1;
    SET_SCL;
    //change sda input mode.
    NOP(); NOP(); NOP(); NOP();
    //CY=SDA;     /* ��Ϊ����ֵ���Ƿ���CY�е� */
     while(TEST_SDA&&(i>250)) i++;
    result = TEST_SDA;
    //SCL=0;
    CLR_SCL;
    //SDA_OUT;
    SDA_OUT;
    return result;
}    
   
/* * * * *��IIC���߲���Ӧ�� * * * * */   
static void ack(void)    
{     
    //SDA=0; /* EEPROMͨ�����յ�ÿ����ַ������֮��, */
    CLR_SDA;
    //SCL=1; /* ��SDA�͵�ƽ�ķ�ʽȷ�ϱ�ʾ�յ���SDA��״̬ */
    SET_SCL;
    NOP(); NOP(); NOP(); NOP();
    //SCL=0;
    CLR_SCL;   
    NOP();
    //SDA=1;
    SET_SDA;

    return;
}    
   
/* * * * * * * * * ����IIC���߲���Ӧ�� * * * * */   
static void noAck(void)    
{    
    //SDA=1;
    SET_SDA;
    //SCL=1;
    SET_SCL;
    NOP(); NOP(); NOP(); NOP();    
    //SCL=0;
    CLR_SCL;
    
    return;
}    
   
/* * * * * * * * * ��IIC����д���� * * * * */   
static void sendByte(unsigned char byte)    
{     
    unsigned char mask = 0x80;
    for(;mask>0;)    
    {
        //SCL=0;
        CLR_SCL;
        NOP();
        if(mask&byte)
        {
            //SDA=1;
            SET_SDA;
        }
        else
        {
            //SDA=0;
            CLR_SDA;
        }
        mask >>= 1;
        NOP();
        //SCL=1;
        SET_SCL;
        NOP();
    }
    //SCL=0;
    CLR_SCL;

    return;
}
   
/* * * * * * * * * ��IIC�����϶������ӳ��� * * * * */   
static unsigned char receiveByte(void)    
{     
    register receivebyte,i=8;
    //printf("to read123.");      
    //SCL=0;
    CLR_SCL;
     //SDA = 1;
     SET_SDA;
    SDA_IN;
    while(i--)    
    {     
        //SCL=1;
        SET_SCL;
        NOP();
        receivebyte = (receivebyte <<1 ) | TEST_SDA;
        //printf("receivebyte %d", receivebyte);
        //SCL=0;
        CLR_SCL;
        NOP();
    }
    SDA_OUT;
    return receivebyte;    
}

