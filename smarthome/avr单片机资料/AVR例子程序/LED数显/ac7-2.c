#include<iom16v.h>			
#define uchar unsigned char	
#define uint unsigned int
uchar const SEG7[10]={0x3f,0x06,0x5b,0x4f,0x66,	
                0x6d,0x7d,0x07,0x7f,0x6f};
uchar const ACT[2]={0xfe,0xfd};				
//=============================
void delay_ms(uint k)			
{
    uint i,j;
    for(i=0;i<k;i++)
    {
       for(j=0;j<570;j++);
    }
}
//=============================
void main(void)	
{				
uchar i,counter;	
DDRA=0xff;			
DDRC=0xff;		
PORTA=0x00;		
PORTC=0xff;		
   while(1)		
   {			
   		   for(i=0;i<100;i++)	
   		   {					
		   PORTA=SEG7[counter%10];	
   		   PORTC=ACT[0];			
   		   delay_ms(1);				
   		   PORTA=SEG7[counter/10];	
   		   PORTC=ACT[1];			
   		   delay_ms(1);			
		   }					
		   counter++;		
		   if(counter>99)counter=0;	
   }						
}							
