#include <iom16v.h>
#include <macros.h>
//==================================
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
//**********************************************
void uart0_init(void)
{
 UCSRB = 0x00;                //禁止UART发送和接收
 UCSRA = 0x02;                //倍速
 UCSRC = 0x06;                //8位数据
 UBRRL = 0x67;                //9600B/S
 UBRRH = 0x00; 
 UCSRB = 0x18;                //允许UART发送和接收
}
//**********************************************
void init_devices(void) 
{
 port_init();
 uart0_init();
 }
//**********************************************
void uart0_send(unsigned char i)
{
while(!(UCSRA&(1<<UDRE)));  //等待发送缓冲区为空。
                            //UDRE为1说明缓冲器为空，已准备好进行数据接收
UDR=i;                      //发送1个字符//UDR为USART I/O 数据寄存器
}
//***********************************************
unsigned char uart0_receive(void) 
{
while(!(UCSRA&(1<<RXC)));  //等待接收数据
return UDR;                //返回到接收数据
}
//-----------------------------------------------
void main(void)
{
unsigned char temp;
init_devices();
 while(1) 
 {
 temp=uart0_receive();     //等待接收数据
 PORTB=~temp;              //接收的数据转换成低电平后点亮LED
 uart0_send(temp);         //将接收到的数据发送出去
 }
}
