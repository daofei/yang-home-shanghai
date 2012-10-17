#include<iom16v.h>	
#define uchar unsigned char	
/************************************/
#define FLASH_0  (PORTB=PORTB&0xfe) //定义端口为低电平
#define FLASH_1  (PORTB=PORTB|0x01) //定义端口为高电平
/************************************/
void main(void) 
{			
uchar cnt,status; 
 PORTB = 0x01; 
 DDRB  = 0x01; 
 TCNT1H = 0xCF;
 TCNT1L = 0x2C;              //100ms定时
 TCCR1B = 0x03;              //计数预分频64
   	for(;;)	
 	{	
		do {status=TIFR&0x04;}while(status!=0x04); //判TOV1是否溢出
		TIFR=0x04;              //此循环值为假时中止循环，顺序执行
		TCNT1H = 0xCF; 
		TCNT1L = 0x2C; 
		cnt++;		
		if(cnt==9)FLASH_0;
		if(cnt>=10){cnt=0;FLASH_1;}
		}		
}	
