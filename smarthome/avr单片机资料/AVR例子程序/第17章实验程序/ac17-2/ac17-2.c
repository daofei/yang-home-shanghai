#include <iom16v.h>		
#include <macros.h>
#define  uchar unsigned char	
#define  uint unsigned int
//----------------------------------------
#define xtal 8	
void delay_1ms(void)	
{
uint i;
for(i=1;i<(uint)(xtal*143-2);i++)
	;
}
//=========================================
void delay_ms(uint n)	
{
uint i=0;
 while(i<n)
 {
 delay_1ms();
 i++;
 }
}
//-------------------------------------------
void port_init(void)	
{
 PORTA = 0x00;
 DDRA  = 0x00;
 PORTB = 0xFF;	
 DDRB  = 0xFF;	
 PORTC = 0x00; 
 DDRC  = 0x00;
 PORTD = 0x00;
 DDRD  = 0x00;
}
//*************** 
void watchdog_init(void)
{
 WDR(); 
 WDTCR = 0x08; 
}
//=========================================
void init_devices(void)
{
 port_init();
 watchdog_init();
 }
//*****************************************
void main(void)  
{
 init_devices();
 while(1)			
 {
 PORTB=0xfe;		
 delay_ms(3);	
 PORTB=0xfd;	
 delay_ms(3);
 PORTB=0xfb;	
 delay_ms(3);	
 PORTB=0xf7;	
 delay_ms(3);	
 PORTB=0xef;
 delay_ms(3);	
 PORTB=0xdf;	
 delay_ms(3);	
 PORTB=0xbf;	
 delay_ms(3);	
 PORTB=0x7f;	
 delay_ms(3);	
 PORTB=0xff;	
 delay_ms(3);	
 }
}
