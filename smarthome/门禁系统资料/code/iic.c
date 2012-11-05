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
   _delay_loop_2(8*250); 8M 晶振
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

//AT24C256的读写函数(包括随机读，连续读，字节写，页写)
//根据sla的最低位决定(由中断程序中判断)
//bit0=1 TW_READ 读
//bit0=0 TW_WRITE 写
// sla   器件地址(不能搞错)
// addr EEPROM地址(0~32767)
// *ptr 读写数据缓冲区
// len   读数据长度(1~32768)，写数据长度(1 or 8 or 16 or 32 or 64)
// 返回值 是否能执行当前操作
unsigned char twi_rw(unsigned char slAddr, unsigned int dataAddr, unsigned char *ptr, unsigned int len)
{
    if (strTWI.status==TW_BUSY)
    { 
        //TWI忙，不能进行操作
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
    TWCR=(1<<TWSTA)|TW_ACT;      //启动start信号
    return OP_RUN;
}

void twi_isr(void)  //IIC中断
{
    unsigned char action,state,status;
    action=strTWI.SLA&TW_READ;     //取操作模式
    state=strTWI.STATE;
    status=TWSR&0xF8;       //屏蔽预分频位
    if ((status>=0x60)||(status==0x00))
    {//总线错误或从机模式引发的中断,不予处理
        return;
    }
    switch(state)
    {
    case ST_START: //START状态检查
        if(status==TW_START)
        {//发送start信号成功
            TWDR=strTWI.SLA&0xFE;    //发送器件地址写SLAW
            TWCR=TW_ACT;             //触发下一步动作，同时清start发送标志
        }
        else
        {//发送start信号出错
            state=ST_FAIL;
        }
        break;
    case ST_SLAW: //SLAW状态检查
        if(status==TW_MT_SLA_ACK)
        {//发送器件高位地址成功
            TWDR=strTWI.ADDR_H;     //发送eeprom地址
            TWCR=TW_ACT;             //触发下一步动作
        }
        else
        {//发送器件地址出错
            state=ST_FAIL;
        }
        break;
    case ST_WADDR_H: //ADDR状态检查
        if(status==TW_MT_DATA_ACK)
        {//发送器件低位地址成功
            TWDR=strTWI.ADDR_L;     //发送eeprom地址
            TWCR=TW_ACT;             //触发下一步动作
        }
        else
        {//发送器件地址出错
            state=ST_FAIL;
        }
        break;
    case ST_WADDR_L: //ADDR状态检查
        if(status==TW_MT_DATA_ACK)
        {//发送eeprom地址成功
            if (action==TW_READ)
            {//读操作模式
                TWCR=(1<<TWSTA)|TW_ACT;   //发送restart信号,下一步将跳到RESTART分支
            }
            else
            {//写操作模式
                TWDR=*strTWI.pBUF++;          //写第一个字节
                strTWI.DATALEN--;
                state=ST_WDATA-1;    //下一步将跳到WDATA分支
                TWCR=TW_ACT;            //触发下一步动作
            }
        }
        else
        {//发送eeprom地址出错
            state=ST_FAIL;
        }
        break;
    case ST_RESTART: //RESTART状态检查，只有读操作模式才能跳到这里
        if(status==TW_REP_START)
        {//发送restart信号成功
            TWDR=strTWI.SLA;     //发器件地址读SLAR
            TWCR=TW_ACT;             //触发下一步动作，同时清start发送标志
        }
        else
        {//重发start信号出错
            state=ST_FAIL;
        }
        break;
    case ST_SLAR: //SLAR状态检查，只有读操作模式才能跳到这里
        if(status==TW_MR_SLA_ACK)
        {//发送器件地址成功
            if (strTWI.DATALEN--)
            {//多个数据
                TWCR=(1<<TWEA)|TW_ACT;   //设定ACK，触发下一步动作
            }
            else
            {//只有一个数据
                TWCR=TW_ACT;     //设定NAK，触发下一步动作
            }
        }
        else
        {//发送器件地址出错
            state=ST_FAIL;
        }
        break;
    case ST_RDATA: //读取数据状态检查，只有读操作模式才能跳到这里
        state--;        //循环,直到读完指定长度数据
        if(status==TW_MR_DATA_ACK)
        {//读取数据成功，但不是最后一个数据
            *strTWI.pBUF++=TWDR;
            if (strTWI.DATALEN--)
            {//还有多个数据
                TWCR=(1<<TWEA)|TW_ACT;   //设定ACK，触发下一步动作
            }
            else
            {//准备读最后一个数据
                TWCR=TW_ACT;     //设定NAK，触发下一步动作
            }
        }
        else if(status==TW_MR_DATA_NACK)
        {//已经读完最后一个数据
            *strTWI.pBUF++=TWDR;
            TWCR=(1<<TWSTO)|TW_ACT;    //发送停止信号，不会再产生中断了
            strTWI.STATUS=TW_OK;
        }
        else
        {//读取数据出错
            state=ST_FAIL;
        }
        break;
    case ST_WDATA: //写数据状态检查，只有写操作模式才能跳到这里
        state--;        //循环,直到写完指定长度数据
        if(status==TW_MT_DATA_ACK)
        {//写数据成功
            if (strTWI.DATALEN)
            {//还要写
                TWDR=*strTWI.pBUF++;
                strTWI.DATALEN--;
                TWCR=TW_ACT;            //触发下一步动作
            }
            else
            {//写够了
                TWCR=(1<<TWSTO)|TW_ACT;   //发送停止信号，不会再产生中断了
                strTWI.STATUS=TW_OK;
                //启动写命令后需要10ms(最大)的编程时间才能真正的把数据记录下来
                //编程期间器件不响应任何命令
            }
        }
        else
        {//写数据失败
            state=ST_FAIL;
        }
        break;
    default:
        //错误状态
        state=ST_FAIL;
        break;
    }

    if (state==ST_FAIL)
    {//错误处理
        strTWI.FAILCNT++;
        if (strTWI.FAILCNT<FAIL_MAX)
        {//重试次数未超出最大值，
            TWCR=(1<<TWSTA)|TW_ACT;    //发生错误,启动start信号
        }
        else
        {//否则停止
            TWCR=(1<<TWSTO)|TW_ACT;    //发送停止信号，不会再产生中断了
            strTWI.STATUS=TW_FAIL;
        }
    }
    state++;
    strTWI.STATE=state;       //保存状态
}

