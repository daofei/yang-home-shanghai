#include<iom16v.h>	
#define uchar unsigned char
#define uint unsigned int
#define BZ_0  (PORTD=PORTD&0xdf) 
#define BZ_1  (PORTD=PORTD|0x20) 
uint cnt;
//=============================
void delay_ms(uint k)
{
uint i,j;			
    for(i=0;i<k;i++)
    {
       for(j=0;j<1140;j++)
       ;
    }
}
//=============================
void main(void)	
{				
PORTB=0xff;	
DDRB=0xff;	
PORTD=0xff;	
DDRD  = 0xf3;
MCUCR = 0x0A; 
GICR  = 0xC0; 
SREG=0x80; 
   while(1)		
   {	
   PORTB=0x00;
   delay_ms(500);
   PORTB=0xff; 
   delay_ms(500); 
   }			
}			
//***************************************************
#pragma interrupt_handler int0_isr:2
void int0_isr(void)
{
 PORTB=0x0f;
  delay_ms(2000);
}
//****************************************
#pragma interrupt_handler int1_isr:3
void int1_isr(void)
{
SREG=0x80;				
 for(cnt=0;cnt<5000;cnt++)
 {BZ_1;delay_ms(2); BZ_0;}
}
