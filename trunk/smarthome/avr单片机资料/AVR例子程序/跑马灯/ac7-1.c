#include<iom16v.h>
#define uchar unsigned char
#define uint unsigned int
//=============================
void delay_ms(uint k)
{
    uint i,j;			
    for(i=0;i<k;i++)
    {
       for(j=0;j<570;j++)
       ;
    }
}
//=============================
void main(void)	
{				
DDRB=0xff;		
PORTB=0xff;		
   while(1)	
   {		
   PORTB=0xaa;
   delay_ms(500);
   PORTB=0x55; 
   delay_ms(500); 
   }			
}			
