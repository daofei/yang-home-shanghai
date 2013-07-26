#include<iom16v.h>
#include <macros.h>

#include "util.h"
#include "iic.h"
#include "connectToserver.h"


#define MINI2440SERVERADDR 0xa1

#define MAXRETRY    10

//pc7 scl
//pc6 sda
void mini2440_init(void)
{
    //pc6 and pc7 output mode.
    DDRC |= 0xc0;
    PORTC |= 0xc0;
    return;
}

char rw24c256(unsigned char *data,unsigned char len,unsigned int addr, unsigned char rwFlag)    
{
    unsigned char i = MAXRETRY;
    char err = 1;  /*   �����־   */   
    while(i--)    
    {    
        start();  /*   ��������   */
        sendByte(AT24C256DEVADDR |0x00); /*   ��IIC����д���ݣ�������ַ */   
        if(recAck()) continue; /*   ��д����ȷ��������ѭ��   */   
        sendByte((unsigned char)(addr >> 8));//����������ת��Ϊ�ַ������ݣ�����ȡ�ͣ�ֻȡ��8λ.�����������32Kλ��ʹ��16λ��ַѰַ��д��߰�λ��ַ    
        if(recAck())  continue;    
        sendByte((unsigned char)addr); /*   ��IIC����д����   */   
        if(recAck())  continue; /*   ��д��ȷ��������ѭ��   */
        if(rwFlag == RW24C256WRITE)   //�ж��Ƕ���������д����    
        {
            err=0;         /* ���������λ */   
            while(len--)    
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
            start();  /*   ��������   */   
            sendByte(AT24C256DEVADDR |0x01); /*   ��IIC����д����   */   
            if(recAck()) continue;//����ûӦ��������α���ѭ��    
            //ѭ������Ҫ��һ��
            len--;
            while(len--)  /*   �ֽڳ�Ϊ0����   */   
            {
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

unsigned long rw24c256Int(unsigned long data, unsigned int addr, unsigned char rwFlag)
{
    unsigned char tmp[4] = {0, 0, 0, 0};
	unsigned long out = 0;

    if(rwFlag==RW24C256WRITE)
    {
        tmp[0] = (unsigned char)(data&0x000000ff);
        tmp[1] = (unsigned char)((data>>8)&0x000000ff);
        tmp[2] = (unsigned char)((data>>16)&0x000000ff);
        tmp[3] = (unsigned char)((data>>24)&0x000000ff);
        rw24c256((unsigned char*)&tmp, 4, addr, RW24C256WRITE);
		out = data;
    }
    else
    {
        rw24c256((unsigned char*)&tmp, 4, addr, RW24C256READ);

        out= 0;
        out |= tmp[0];
        out <<= 8;
        out |= tmp[1];
        out <<= 8;
        out |= tmp[2];
        out <<= 8;
        out |= tmp[3];
    }
    return out;
}

