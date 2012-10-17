#include <iom16v.h>		
#include<eeprom.h>
#define uchar unsigned char	
#define uint  unsigned int	
uchar const SEG7[10]={0x3f,0x06,0x5b, 
0x4f,0x66,0x6d,0x7d,0x07,0x7f,0x6f};
uchar const ACT[4]={0xfe,0xfd,0xfb,0xf7};
uint key_cnt,cnt;
uint Wide,Disval;
#define SINT0 (PIND&0x04)
#define SINT1 (PIND&0x08)

void port_init(void)		
{							
 PORTA = 0xFF;			
 DDRA  = 0xFF;			
 PORTB = 0xFF;			
 DDRB  = 0xFF;			
 PORTC = 0xFF; 			
 DDRC  = 0xFF;			
 PORTD = 0xFF;		
 DDRD  = 0x20;			
}				
//***************************
void timer0_init(void)
{							
TCNT0 = 0x83; 	//1MS初值	
TCCR0 = 0x03; 	//64分频		
TIMSK = 0x01;   //使能T0中断		
}				
//TIMER1 initialize - prescale:8
// WGM: 0) Normal, TOP=0xFFFF
// desired value: 1000Hz
// actual value: 1000.000Hz (0.0%)
void timer1_init(void)		
{
 TCCR1A = 0x83;	//比较匹配时OC1A清0 ，10位相位校正PWM		
 TCCR1B = 0x02; 		
}			
/*********************************************/
void init_devices(void)	
{							
 port_init();		
 timer0_init();			
 timer1_init();			
 SREG=0x80;			
}							

/******************主函数******************/
void main(void)
{	long x;					
init_devices();			
	while(1)			
    {	
	x=(long)Wide;		
	x=x*5000/1023;
	Disval=(uint)x;
	OCR1AH=(uchar)(Wide>>8);
	OCR1AL=(uchar)(Wide&0x00ff); 
	}
}
//**************T/C0中断服务子函数*************
#pragma interrupt_handler timer0_ovf_isr:10
void timer0_ovf_isr(void)	
{							
 TCNT0 = 0x83; 			
 if(++key_cnt>100)key_cnt=0;
 if(++cnt>3)cnt=0;	
 
 switch(cnt)
 {
 case 0:PORTA=SEG7[Disval%10];PORTC=ACT[0];break;
 case 1:PORTA=SEG7[(Disval%100)/10];PORTC=ACT[1];break;
 case 2:PORTA=SEG7[(Disval%1000)/100];PORTC=ACT[2];break;
 case 3:PORTA=SEG7[Disval/1000]|0x80;PORTC=ACT[3];break;
 default:break;
 }
 if(key_cnt==0)	
 {
 if(SINT0==0){if(Wide<1023)Wide++;}
 if(SINT1==0){if(Wide>0)Wide--;}
 }
}
