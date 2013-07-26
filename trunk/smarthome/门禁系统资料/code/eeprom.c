#include<iom16v.h>
#include <macros.h>

#include "util.h"
#include "iic.h"
#include "eeprom.h"

/* 一个通用的24C01－24C256共9种EEPROM的字节读写操作程序，   
此程序有五个入口条件，分别为读写数据缓冲区指针,   
进行读写的字节数，EEPROM首址，EEPROM控制字节，   
以及EEPROM类型。此程序结构性良好，具有极好的容错性，程序机器码也不多:   
DataBuff为读写数据输入／输出缓冲区的首址   
Length 为要读写数据的字节数量   
Addr 为EEPROM的片内地址 AT24256为0～32767   
Control 为EEPROM的控制字节，具体形式为(1)(0)(1)(0)(A2)(A1)(A0)(R/W),其中R/W=1,   
表示读操作,R/W=0为写操作,A2,A1,A0为EEPROM的页选或片选地址;   
enumer为枚举变量,需为AT2401至AT24256中的一种,分别对应AT24C01至AT24C256;   
函数返回值为一个位变量，若返回1表示此次操作失效，0表示操作成功;   
ERROR为允许最大次数，若出现ERRORCOUNT次操作失效后，则函数中止操作，并返回1   
SDA和SCL由用户自定义，这里暂定义为P3^0和P3^1; */   
/*对于1K位，2K位，4K位，8K位，16K位芯片采用一个8位长的字节地址码，对于32K位以上   
的采用2个8位长的字节地址码直接寻址，而4K位，8K位，16K位配合页面地址来寻址*/   
   
/* －－－－－  AT24C01～AT24C256 的读写程序 －－－－－－ */

#define AT24C256DEVADDR 0xa0

#define MAXRETRY    10

//pc7 scl
//pc6 sda
void at24c256_init(void)
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

