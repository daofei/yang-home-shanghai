#include<iom16v.h>
#include <macros.h>

#include "util.h"
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
    char err = 1;  /*   出错标志   */   
    while(i--)    
    {    
        start();  /*   启动总线   */
        //if(rwFlag == RW24C256WRITE)
            sendByte(AT24C256DEVADDR |0x00); /*   向IIC总线写数据，器件地址 */   
        //else
        //    sendByte(AT24C256DEVADDR |0x01); /*   向IIC总线读数据，器件地址 */  
            //printf("11111"); 
        if(recAck()) continue; /*   如写不正确结束本次循环   */   
        //printf("2222"); 
        sendByte((unsigned char)(addr >> 8));//把整型数据转换为字符型数据：弃高取低，只取低8位.如果容量大于32K位，使用16位地址寻址，写入高八位地址    
        //printf("33333"); 
        if(recAck())  continue;    
        //printf("4444"); 
        sendByte((unsigned char)addr); /*   向IIC总线写数据   */   
        //printf("5555"); 
        if(recAck())  continue; /*   如写正确结束本次循环   */
        //printf("6666"); 
        if(rwFlag == RW24C256WRITE)   //判断是读器件还是写器件    
        {    
            j=len;    
            err=0;         /* 清错误特征位 */   
            while(j--)    
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
            //printf("to read.");
            start();  /*   启动总线   */   
            sendByte(AT24C256DEVADDR|0x01); /*   向IIC总线写数据   */   
            if(recAck()) continue;//器件没应答结束本次本层循环    
            while(len--)  /*   字节长为0结束   */   
            {
                //printf("to read12.");     
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
   
/* * * * * 以下是对IIC总线的操作子程序 * * * * */   
/* * * * * * 启动总线 * * * * */   
static void start(void)    
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
static void stop(void)    
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
static void ack(void)    
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
   
/* * * * * * * * * 向IIC总线写数据 * * * * */   
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
   
/* * * * * * * * * 从IIC总线上读数据子程序 * * * * */   
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

