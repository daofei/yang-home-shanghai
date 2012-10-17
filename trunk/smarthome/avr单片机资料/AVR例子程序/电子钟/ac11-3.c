#include <iom16v.h>			
#include<eeprom.h>
#define uchar unsigned char
#define uint  unsigned int	
uchar const SEG7[10]={0x3f,0x06,0x5b, 
0x4f,0x66,0x6d,0x7d,0x07,0x7f,0x6f};
uchar const ACT[4]={0xfe,0xfd,0xfb,0xf7};
#define LED1_0  (PORTB=PORTB&0xfe)	
#define S1 (PIND&0x10)
#define S2 (PIND&0x20)
#define S3 (PIND&0x40)
#define S4 (PIND&0x80)
#define SINT0 (PIND&0x04)
#define SINT1 (PIND&0x08)
uchar dpw,dpt,write_flag,time_flag,cnt;
uint key_cnt,ms_cnt;		
uchar sec,min,set_sec,set_min;		
/************************************************/
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
//***************************
void timer0_init(void)	
{							
TCNT0 = 0x83; 			
TCCR0 = 0x03; 			
TIMSK = 0x01; 
}							
/*********************************************/
void init_devices(void)		
{							
 port_init();		
 timer0_init();			
 SREG=0x80;	
}							
//***************************
#pragma interrupt_handler timer0_ovf_isr:10
void timer0_ovf_isr(void)	
{							
 TCNT0 = 0x83; 			
 if(++key_cnt>300)key_cnt=0;
 if(++cnt>7)cnt=0;	
 if(++ms_cnt>999){ms_cnt=0;sec++;}
 if(sec>59){min++;sec=0;}	
 if(min>59)min=59;		
 switch(cnt)	
 {
 case 0:PORTA=SEG7[sec%10];PORTC=ACT[0];break;
 case 1:PORTA=SEG7[sec/10];PORTC=ACT[1];break;
 case 2:PORTA=SEG7[min%10];PORTC=ACT[2];break;
 case 3:PORTA=SEG7[min/10];PORTC=ACT[3];break;
 case 4:if(dpw==1){PORTA=SEG7[set_sec%10]|0x80;}
 	    else {PORTA=SEG7[set_sec%10];}
		PORTC=ACT[4];break;
 case 5:PORTA=SEG7[set_sec/10];PORTC=ACT[5];break;
 case 6:PORTA=SEG7[set_min%10];PORTC=ACT[6];break;
 case 7:if(dpt==1){PORTA=SEG7[set_min/10]|0x80;}
 	    else {PORTA=SEG7[set_min/10];} 
		PORTC=ACT[7];break;
 default:break;
 }
 if(key_cnt==0)		
 {
 if(S1==0){sec++;if(sec>59)sec=0;}
 if(S2==0){min++;if(min>59)min=0;}
 if(S3==0){set_sec++;if(set_sec>59)set_sec=0;} 
 if(S4==0){set_min++;if(set_min>59)set_min=0;} 
 if(SINT0==0){time_flag=1;} 
 if(SINT1==0){write_flag=1;}
 }
}
/***********************/
void delay(uint k)	
{
uint i,j;
	 for(i=0;i<k;i++)
	 {	 
	 for(j=0;j<140;j++); 
	 }
}
/***********************/
void main(void)	
{	 					
init_devices();		
  while(1)			
  {						
   		if(write_flag==1) 
		{SREG=0x00;	
		EEPROM_WRITE(200,set_sec);delay(10); 
		EEPROM_WRITE(201,set_min);delay(10); 
		write_flag=0;	
		dpw=1;			
		SREG|=0x80;
		}
		if(time_flag==1)
		{SREG=0x00;		
		EEPROM_READ(200,set_sec);delay(10);
		EEPROM_READ(201,set_min);delay(10); 
		SREG|=0x80;	
		dpt=1;		
		time_flag=0;
		}
		if(dpt==1)	
		{
		if((sec==set_sec)&&(min==set_min))LED1_0;
		}
  }
}
