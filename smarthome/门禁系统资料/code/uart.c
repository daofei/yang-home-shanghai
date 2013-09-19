#include<iom16v.h>
#include <macros.h>

#include "password.h"
#include "locker.h"
#include "timer.h"
#include "uart.h"

//uart0 init. for printf.
void uart0_init(void)
{
	//port init
	DDRD &= 0xfc;
	PORTD &= 0xfc;
	//uart init
    UCSRB = 0x00;                //禁止UART发送和接收
    UCSRA = 0x02;               //倍速
    UCSRC = 0x06;                //8位数据
    UBRRL = 0x67;                 //9600bps
    UBRRH = 0x00;
    UCSRB = 0x98;
}

//uart0 send char.
void uart0_send(unsigned char i)
{
    while(!(UCSRA&(1<<UDRE)));
    UDR = i;
}

//uart0 receive.
unsigned char uart0_receive(void)
{
    while(!(UCSRA&(1<<RXC)));
    return UDR;
}

//uart0 send buffer
void uart0_send_buffer(unsigned char* buffer, unsigned char len)
{
    unsigned char i;
    for(i=0;i<len;++i)
    {
        uart0_send(buffer[i]);
    }
    return;
}
//uart0 send buffer
unsigned char uart0_read_buffer(unsigned char* buffer, unsigned char len)
{
    unsigned char i;
    for(i=0;i<len;++i)
    {
        buffer[i] = uart0_receive();
    }
    return len;
}

static void uart0_returnCommd(unsigned char commId, unsigned char type,
    unsigned long idCard, unsigned long passwordH, unsigned long passwordL)
{
    uart0_send(commId);
    uart0_send(type);
    uart0_send_buffer((unsigned char*)(&idCard), 4);
    uart0_send_buffer((unsigned char*)(&passwordH), 4);
    uart0_send_buffer((unsigned char*)(&passwordL), 4);
    return;    
}

#define COMMANDITEMLENGTH	14
static void uart0_handle_command(void);
static char commandBuffer[COMMANDITEMLENGTH];
static char commandRecCount = 0;

static void uart0_handle_timeout(char timer)
{
	if((timer==UART0RECTIMEOUTTIMER)&&(commandRecCount==COMMANDITEMLENGTH))
		uart0_handle_command();
	commandRecCount = 0;
	return;
}

#pragma interrupt_handler uart0_handleCommand_isr:12
void uart0_handleCommand_isr(void)
{
	if(commandRecCount<14) commandBuffer[commandRecCount++] = uart0_receive();
	else
	{
		uart0_receive();
		++commandRecCount;
	}
	//set time out. 
	set_timer2(UART0RECTIMEOUTTIMER, 2, uart0_handle_timeout);
}

#define u32 unsigned long
#define u8 unsigned char

#define Read32(h2, h1, l2, l1) ((u32)(((((u32)h2)&0xff)<<24)|((((u32)h1)&0xff)<<16)|((((u32)l2)&0xff)<<8)|(l1)))
//#define Read32(h2, h1, l2, l1) ((u32)((24<<(((u32)(h2))&0xff))|(16<<((u32(h1))&0xff))|(16<<((u32(l2))&0xff))|(l1)))
static void uart0_handle_command(void)
{
    unsigned char comId = 0;
    unsigned char type = 0;
    unsigned long idCard = 0;
    unsigned long passwordH = 0;
    unsigned long passwordL = 0;

	//for(comId=0;comId<commandRecCount;comId++)
	//{
	//	uart0_send(commandBuffer[comId]);
	//}
	//return;
    comId = commandBuffer[0];
    type = commandBuffer[1];
	idCard = Read32(((u8)(commandBuffer[2])), ((u8)(commandBuffer[3])), ((u8)(commandBuffer[4])), ((u8)(commandBuffer[5])));
	passwordH = Read32(((u8)commandBuffer[6]), ((u8)commandBuffer[7]), ((u8)commandBuffer[8]), ((u8)commandBuffer[9]));
	passwordL = Read32(((u8)commandBuffer[10]), ((u8)commandBuffer[11]), ((u8)commandBuffer[12]), ((u8)commandBuffer[13]));

    switch(comId)
    {
        case COMMANDIDREADITEMNUM: //read item num
        {
            unsigned char itemNum = readPasswordItemNum();
            uart0_returnCommd(COMMANDIDRETURNITEMNUM, itemNum, 0, 0, 0);
            break;
        }
        case COMMANDIDREADITEM: //read item by index
        {
            passwordItem_t item = readPasswordItem(type);
            uart0_returnCommd(COMMANDIDRETURNITEM, item.flags, item.idCard, item.passwordH, item.passwordL);
            break;
        }
        case COMMANDIDDELETEITEMS: //delete all item
        {
            unsigned char itemNum = readPasswordItemNum();
            if(itemNum==type)
            {
                writePasswordItemNum(0);
                uart0_returnCommd(COMMANDRETURNOK, 0, 0, 0, 0);
            }
            break;
        }
        case COMMANDIDINSERTITEM: //insert a item
        {
            passwordItem_t item;
            unsigned char itemNum = readPasswordItemNum();
            item.flags = type;
            item.idCard = idCard;
            item.passwordH = passwordH;
            item.passwordL = passwordL;
            insertPasswordItem(itemNum+1, item);
            writePasswordItemNum(itemNum+1);
            uart0_returnCommd(COMMANDRETURNOK, 0, 0, 0, 0);
            break;
        }
        case COMMANDIDUNLOCK: //unlock by id or password
        {
            passwordItem_t item = readPasswordItem(type);
            if((item.idCard==idCard)&&(item.passwordH==passwordH)&&(item.passwordL==passwordL))
            	locker_unlock();
            uart0_returnCommd(COMMANDRETURNOK, type, idCard, passwordH, passwordL);
            break;
        }
        default:
            break;        
    }
    return;
}
