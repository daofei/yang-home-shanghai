#include<iom16v.h>
#include <macros.h>

#include "util.h"
#include "iic.h"

#define SET_SCL (PORTC|=0x80)
#define CLR_SCL (PORTC&=0x7f)
#define SET_SDA (PORTC|=0x40)
#define CLR_SDA (PORTC&=0xbf)
#define TEST_SDA ((PINC&0x40)?1:0)
#define SDA_OUT (DDRC|=0x40)
#define SDA_IN (DDRC&=0xbf,PORTC|=0x40)

//pc7 scl
//pc6 sda
void iicport_init(void)
{
    //hi-z
    DDRC &= 0x3f;
    PORTC &= 0x3f;
    return;
}

/* * * * * 以下是对IIC总线的操作子程序 * * * * */   
/* * * * * * 启动总线 * * * * */   
void start(void)    
{
    //pc6 and pc7 output mode.
    DDRC |= 0xc0;
    PORTC |= 0xc0;
    NOP();
    //SCL=0; /* SCL处于高电平时,SDA从高电平转向低电平表示 */   
    //CLR_SCL;
    //SDA=1; /* 一个"开始"状态,该状态必须在其他命令之前执行 */   
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
   
/* * * * * 停止IIC总线 * * * * */   
void stop(void)    
{     
    //SCL=0; /*SCL处于高电平时,SDA从低电平转向高电平 */
    //CLR_SCL;   
    //SDA=0; /*表示一个"停止"状态,该状态终止所有通讯 */
    CLR_SDA;
    NOP();
    //SCL=1;
    SET_SCL;
    NOP(); NOP(); NOP(); /* 空操作 */
    //SDA=1;
    SET_SDA;
    NOP(); NOP(); NOP();
    //SCL=0;
    //CLR_SCL;

    //hi-z
    DDRC &= 0x3f;
    PORTC &= 0x3f;
    return;
}    
   
/* * * * * 检查应答位 * * * * */   
unsigned char recAck(void)    
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
    //CY=SDA;     /* 因为返回值总是放在CY中的 */
    while(TEST_SDA&&(i>250)) i++;
    result = TEST_SDA;
    //SCL=0;
    CLR_SCL;
    //SDA_OUT;
    SDA_OUT;
    return result;
}    
   
/* * * * *对IIC总线产生应答 * * * * */   
void ack(void)    
{     
    //SDA=0; /* EEPROM通过在收到每个地址或数据之后, */
    CLR_SDA;
    //SCL=1; /* 置SDA低电平的方式确认表示收到读SDA口状态 */
    SET_SCL;
    NOP(); NOP(); NOP(); NOP();
    //SCL=0;
    CLR_SCL;   
    NOP();
    //SDA=1;
    SET_SDA;

    return;
}    
   
/* * * * * * * * * 不对IIC总线产生应答 * * * * */   
void noAck(void)    
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
   
/* * * * * * * * * 向IIC总线写数据 * * * * */   
void sendByte(unsigned char byte)    
{
    unsigned char mask = 0x80;
    for(;mask>0;)    
    {
        //SCL=0;
        CLR_SCL;
        NOP();NOP();
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
        NOP();NOP();
        //SCL=1;
        SET_SCL;
        NOP();NOP();
    }
    //SCL=0;
    CLR_SCL;

    return;
}
   
/* * * * * * * * * 从IIC总线上读数据子程序 * * * * */   
unsigned char receiveByte(void)    
{     
    unsigned char receivebyte = 0, i=8;     
    //SCL=0;
    CLR_SCL;
    //SDA = 1;
    SET_SDA;
    SDA_IN;
    NOP();NOP();
    while(i--)    
    {     
        //SCL=1;
        SET_SCL;
        NOP();NOP();
        receivebyte = (receivebyte <<1 ) | TEST_SDA;
        //SCL=0;
        CLR_SCL;
        NOP();
    }
    SDA_OUT;
    return receivebyte;    
}


#define MAXRETRY    10

char rwiic(unsigned char comAddr, unsigned char *data,unsigned char len,unsigned int addr, unsigned char rwFlag)    
{
    unsigned char i = MAXRETRY;
    char err = 1;  /*   出错标志   */   
    while(i--)    
    {    
        start();  /*   启动总线   */
        sendByte(comAddr |0x00); /*   向IIC总线写数据，器件地址 */   
        if(recAck()) continue; /*   如写不正确结束本次循环   */   
        sendByte((unsigned char)(addr >> 8));//把整型数据转换为字符型数据：弃高取低，只取低8位.如果容量大于32K位，使用16位地址寻址，写入高八位地址    
        if(recAck())  continue;    
        sendByte((unsigned char)addr); /*   向IIC总线写数据   */   
        if(recAck())  continue; /*   如写正确结束本次循环   */
        if(rwFlag == RWWRITE)   //判断是读器件还是写器件    
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
            sendByte(comAddr |0x01); /*   向IIC总线写数据   */   
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
    if(rwFlag == RWWRITE)    
    {     
        delay_ms(50);    
    }    
    return err;    
}    

/*
unsigned long rwiicInt(unsigned char comAddr, unsigned long data, unsigned int addr, unsigned char rwFlag)
{
    unsigned char tmp[4] = {0, 0, 0, 0};
	unsigned long out = 0;

    if(rwFlag==RWWRITE)
    {
        tmp[0] = (unsigned char)(data&0x000000ff);
        tmp[1] = (unsigned char)((data>>8)&0x000000ff);
        tmp[2] = (unsigned char)((data>>16)&0x000000ff);
        tmp[3] = (unsigned char)((data>>24)&0x000000ff);
        rwiic(comAddr, (unsigned char*)&tmp, 4, addr, RWWRITE);
		out = data;
    }
    else
    {
        rwiic(comAddr, (unsigned char*)&tmp, 4, addr, RWREAD);

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
*/

