#include <iom16v.h>
#include <macros.h>
/*************************************************/
void port_init(void) 
{
 PORTA = 0xFF; 
 DDRA  = 0x00; 
 PORTB = 0xFF; 
 DDRB  = 0xFF; 
 PORTC = 0xFF; 
 DDRC  = 0x00; 
 PORTD = 0xFF; 
 DDRD  = 0x02;
}
/**************************************************/
void uart0_init(void) 
{
 UCSRB = 0x00; 
 UCSRA = 0x02;
 UCSRC = 0x06;
 UBRRL = 0x67; 
 UBRRH = 0x00; 
 UCSRB = 0x18;
}
/********************************************************/
void init_devices(void) 
{
 port_init();
 uart0_init();
 }
//**********************************************
void uart0_send(unsigned char i)
{
while(!(UCSRA&(1<<UDRE)));
UDR=i;
}
/*******************************************/
void str_send(char *s) //发送一串字符的函数
{
  while(*s)             //等待发送的字符为空
 {
 uart0_send(*s);        //发送1个字符
 s++;                   //指针向下一个字符
 }
}
/*********************************************/
unsigned char uart0_receive(void) 
{
while(!(UCSRA&(1<<RXC)));
return UDR;
}
/********************************************/
void main(void)
{
unsigned char temp; 
init_devices();
str_send("公司测试程序  ");
str_send("AVR单片机RS232通信测试程序  ");
str_send("http://www.hlelectron.com  ");
 while(1) 
 {
 temp=uart0_receive();
 str_send("当前按键是：");
 uart0_send(temp); 
 str_send("  ");
 }	
}
