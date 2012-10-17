#include<iom16v.h>			
#define uchar unsigned char 
#define uint unsigned int
//=============================================
#define xtal 8   			
void delay_1ms(void)		
{ uint i;
 for(i=1;i<(uint)(xtal*143-2);i++)
    ;
}
//=============================================
void delay_ms(uint n)	
{
 uint i=0;
   while(i<n)
   {delay_1ms();
    i++;
   }
}
//================================================
void init_IO(void)      
{
 DDRD=0xff;		
 PORTD=0x00;	
 TCCR2=0x71;	
}
/******************Ö÷º¯Êý******************/
void main(void)	
{	uchar wide;	
init_IO();		
	while(1)	
    {	
	delay_ms(20);	
	if(++wide==255)wide=0;
	OCR2=wide;	
	}
}
