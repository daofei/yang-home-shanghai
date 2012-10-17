#include<iom16v.h>	
//=============================
void main(void)	
{				
DDRB=0xff;		
PORTB=0xff;		
DDRD=0x00;		
PORTD=0xff;		
   while(1)		
   {			
   	if((PIND&0x10)==0)	
   	PORTB=0xaa;		
	else if((PIND&0x20)==0)	
    PORTB=0x55;		
   	else 			
	PORTB=0xff;		
   }				
}		
