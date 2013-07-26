#include<iom16v.h>
#include <macros.h>

#include "iic.h"

#define SET_SCL (PORTC|=0x80)
#define CLR_SCL (PORTC&=0x7f)
#define SET_SDA (PORTC|=0x40)
#define CLR_SDA (PORTC&=0xbf)
#define TEST_SDA ((PINC&0x40)?1:0)
#define SDA_OUT (DDRC|=0x40)
#define SDA_IN (DDRC&=0xbf,PORTC|=0x40)


/* * * * * 以下是对IIC总线的操作子程序 * * * * */   
/* * * * * * 启动总线 * * * * */   
void start(void)    
{    
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

