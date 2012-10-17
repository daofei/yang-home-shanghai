#include <iom16v.h>			
#define uchar unsigned char	
#define uint  unsigned int	
uchar const SEG7[10]={0x3f,0x06,0x5b, 
0x4f,0x66,0x6d,0x7d,0x07,0x7f,0x6f};
uchar const ACT[4]={0xfe,0xfd,0xfb,0xf7};
uchar val,DispBuff[4];		
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
//***************写EEPROM子函数*****************
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
//****************数据转换子函数*********************
void conv(uchar i)	
{
DispBuff[3]=i/1000;
DispBuff[2]=(i%1000)/100;
DispBuff[1]=(i%100)/10;
DispBuff[0]=i%10;
}
//*************************************
void display(uchar p[4]) 
{
PORTA=SEG7[p[0]];
PORTC=ACT[0];
delay_ms(1);
PORTA=SEG7[p[1]];
PORTC=ACT[1];
delay_ms(1);
PORTA=SEG7[p[2]];
PORTC=ACT[2];
delay_ms(1);
PORTA=SEG7[p[3]];
PORTC=ACT[3];
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
 DDRD  = 0xFF;			
}							
//*************************************
void main(void)			
{
port_init();		
W_EEP(488,21);delay_ms(10);	
val=R_EEP(488);delay_ms(10);
conv(val);				
while(1)	
{
display(DispBuff);	
}
}
