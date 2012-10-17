#include <iom16v.h>			
#define uchar unsigned char	
#define uint  unsigned int	
uchar const SEG7[10]={0x3f,0x06,0x5b, 
0x4f,0x66,0x6d,0x7d,0x07,0x7f,0x6f};
uchar const ACT[4]={0xfe,0xfd,0xfb,0xf7};
uchar x,y;				
//*************************************
void delay_ms(uint k) 
{
uint i,j;			
    for(i=0;i<k;i++)
    {
       for(j=0;j<1140;j++)
       ;
    }
}
//************写EEPROM子函数**************
void W_EEP(uint add,uchar dat) 
{
while(EECR&(1<<EEWE));	
EEAR=add;			
EEDR=dat;			
EECR|=(1<<EEMWE);
EECR|=(1<<EEWE);	
}
//****************读EEPROM子函数*******************
uchar R_EEP(uint add)
{
while(EECR&(1<<EEWE));
EEAR=add;			
EECR|=(1<<EERE);
return EEDR;
}
//*************************************
void display(void)	
{
PORTA=SEG7[y%10];
PORTC=ACT[0];
delay_ms(1);
PORTA=SEG7[(y%100)/10];
PORTC=ACT[1];
delay_ms(1);
PORTA=SEG7[(y%1000)/100];
PORTC=ACT[2];
delay_ms(1);
PORTA=SEG7[y/1000];
PORTC=ACT[3];
delay_ms(1);
//----------------------
PORTA=SEG7[x%10];
PORTC=ACT[4];
delay_ms(1);
PORTA=SEG7[(x%100)/10];
PORTC=ACT[5];
delay_ms(1);
PORTA=SEG7[(x%1000)/100];
PORTC=ACT[6];
delay_ms(1);
PORTA=SEG7[x/1000];
PORTC=ACT[7];
delay_ms(1);
}
//*************************************
void port_init(void)
{							
 PORTA = 0xFF;			
 DDRA  = 0xFF;		
 PORTB = 0xFF;			
 DDRB  = 0xFF;			
 PORTC = 0xFF; 			
 DDRC  = 0xFF;		
 PORTD = 0xFF;		
 DDRD  = 0x00;		
}
//*************************************
void main(void)		
{uchar i;			
port_init();		
while(1)
		{
		if((PIND&0x10)==0)	
		{
		if(x<255)x++;		
		for(i=0;i<25;i++)	
		display();			
		}
//---------------
		if((PIND&0x20)==0)	
		{
		if(x>0)x--;			
		for(i=0;i<50;i++)	
		display();		
		}
//***************
		if((PIND&0x40)==0){W_EEP(200,x);delay_ms(10);} 
		if((PIND&0x80)==0){y=R_EEP(200);delay_ms(10);} 
		display();		
		}
}
