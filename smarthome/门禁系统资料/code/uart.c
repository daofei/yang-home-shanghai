#include<iom16v.h>
#include <macros.h>

#include "uart.h"

//uart0 init.
void uart0_init(void)
{
 UCSRB = 0x00;                //禁止UART发送和接收
 UCSRA = 0x02;				  //倍速
 UCSRC = 0x06;				  //8位数据
 UBRRL = 0x67;				  //9600bps
 UBRRH = 0x00;
 UCSRB = 0x18;
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
//uart0 send string
void uart0_send_string(char* string)
{
 while(*string)
 {
  uart0_send(*string);
  string++;
 }
}