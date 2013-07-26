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
    char err = 1;  /*   出错标志   */   
    while(i--)    
    {    
        start();  /*   启动总线   */
        sendByte(AT24C256DEVADDR |0x00); /*   向IIC总线写数据，器件地址 */   
        if(recAck()) continue; /*   如写不正确结束本次循环   */   
        sendByte((unsigned char)(addr >> 8));//把整型数据转换为字符型数据：弃高取低，只取低8位.如果容量大于32K位，使用16位地址寻址，写入高八位地址    
        if(recAck())  continue;    
        sendByte((unsigned char)addr); /*   向IIC总线写数据   */   
        if(recAck())  continue; /*   如写正确结束本次循环   */
        if(rwFlag == RW24C256WRITE)   //判断是读器件还是写器件    
        {
            err=0;         /* 清错误特征位 */   
            while(len--)    
            {
                sendByte(*(data++)); /*   向IIC总线写数据   */   
                if(!recAck()) continue; /*   如写正确结束本次循环   */   
                err=1;    
                break;    
            }    
            if(err==1) continue;    
            break;    
        }    
        else   
        { 
            start();  /*   启动总线   */   
            sendByte(AT24C256DEVADDR |0x01); /*   向IIC总线写数据   */   
            if(recAck()) continue;//器件没应答结束本次本层循环    
            //循环数量要减一。
            len--;
            while(len--)  /*   字节长为0结束   */   
            {
                *(data++)= receiveByte();    
                ack();   /*   对IIC总线产生应答   */   
            }    
            *data=receiveByte(); /* 读最后一个字节 */   
            noAck();  /*   不对IIC总线产生应答   */   
            err=0;    
            break;    
        }    
    }    
    stop();  /*   停止IIC总线   */   
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

