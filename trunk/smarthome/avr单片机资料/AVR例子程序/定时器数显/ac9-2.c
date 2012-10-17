#include <iom16v.h> 
#define uchar unsigned char	
#define uint unsigned int
uchar const SEG7[10]={0x3f,0x06,0x5b, 
0x4f,0x66,	0x6d,0x7d,0x07,0x7f,0x6f};//共阴极0~9值
uchar const ACT[8]={0xfe,0xfd,0xfb,0xf7, 
0xef,0xdf,0xbf,0x7f};       //位码
uchar i;			
void main(void) 
 {			
 PORTA = 0x00; 
 DDRA  = 0xFF; 
 PORTC = 0xFF; 
 DDRC  = 0xFF; 
 TCNT0 = 0x83;//1MS定时
 TCCR0 = 0x03;//预分频64
 TIMSK = 0x01;//使能T0中断
 SREG=0x80; //使能中中断
while(1);
 }

#pragma interrupt_handler timer0_ovf_isr:10
void timer0_ovf_isr(void)
{
 TCNT0 = 0x83;  //重装初值
 if(++i>7)i=0;
 PORTA=SEG7[i];
 PORTC=ACT[i];
}
