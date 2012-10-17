#include<iom16v.h>		
#define uchar unsigned char	
#define uint unsigned int
	
uchar const SEG7[10]={0x3f,0x06,0x5b, 
0x4f,0x66,	0x6d,0x7d,0x07,0x7f,0x6f};
#define ALM_ON  (PORTB=PORTB&0xfe) 
uchar alm_flag1,alm_flag2;
//*************************************************
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
DDRA=0xff;		
DDRC=0xff;		
PORTA=0x00;		
PORTC=0xff;		
PORTB=0xff;		 
DDRB=0xff;		
PORTD=0xff;		 
DDRD  = 0xf3;	
MCUCR = 0x0A; 
GICR  = 0xC0; 
SREG=0x80; 
   while(1)	
   {			
     if(alm_flag1==1)
     {PORTA=SEG7[1];
     PORTC=0xfe;
	     ALM_ON;
     delay_ms(2000);
     }				
	 	if(alm_flag2==1) 
	 	{PORTA=SEG7[2]; 
     PORTC=0xfe; 
	 	ALM_ON; 
     delay_ms(2000);
     }		
   } 			
}				
//**************************************************
#pragma interrupt_handler int0_isr:2	
void int0_isr(void)
{
 alm_flag1=1;					
}
//****************************************
#pragma interrupt_handler int1_isr:3	
void int1_isr(void)
{
alm_flag2=1;			
}

