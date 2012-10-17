/*窗口电压，当输入电压大于3V时，D2点亮报警灯。2V~3V之间不亮*/
#include <iom16v.h>			
#define uchar unsigned char	
#define uint  unsigned int
#define OUT1_0  (PORTB=PORTB&0xfe) //定义D1低电平
#define OUT1_1  (PORTB=PORTB|0x01) //定义D1高电平
#define OUT2_0  (PORTB=PORTB&0xfd) //定义D2低电平
#define OUT2_1  (PORTB=PORTB|0x02) //定义D2高电平
uchar const SEG7[10]={0x3f,0x06,0x5b,
0x4f,0x66,0x6d,0x7d,0x07,0x7f,0x6f};
uchar const ACT[4]={0xfe,0xfd,0xfb,0xf7};
uint value,dis_val; 
uchar i,flag; 
/****************************************/
void port_init(void)	
{						
 PORTA = 0x7F;	
 DDRA  = 0x7F;		
 PORTB = 0xFF;		
 DDRB  = 0xFF;
 PORTC = 0xFF; 			
 DDRC  = 0xFF;		
 PORTD = 0xFF;			
 DDRD  = 0xFF;			
}				
/************************************/
void timer0_init(void) 
{
 TCNT0 = 0x83; 	  //1MS
 OCR0  = 0x7D;
 TCCR0 = 0x03; 	  //预分频
}
/*************************************/
#pragma interrupt_handler timer0_ovf_isr:10 
void timer0_ovf_isr(void)
{
 TCNT0 = 0x83; 	
 if(++i>3)i=0;	
 switch(i) 		
 {
 case 0:PORTA=SEG7[dis_val%10];PORTC=ACT[0];break;
 case 1:PORTA=SEG7[(dis_val/10)%10];PORTC=ACT[1];break;
 case 2:PORTA=SEG7[(dis_val/100)%10];PORTC=ACT[2];break;
 case 3:PORTA=SEG7[dis_val/1000];PORTC=ACT[3];break;
 default:break;
 }
}
/************************************/
void timer1_init(void) 	
{
 TCNT1H = 0xE7; 	//50MS
 TCNT1L = 0x96;
 TCCR1B = 0x03; 	
}
/***************************************************/
#pragma interrupt_handler timer1_ovf_isr:9 
void timer1_ovf_isr(void)
{
 TCNT1H = 0xE7; 		
 TCNT1L = 0x96; //重装初值50MS
 }
/****************************************************/
void adc_init(void) 
{
 ADMUX = 0x07;        //通道7
 ACSR  = 0x80;        //关ADC  
 ADCSR = 0xE9;        //ADC中断使能，ADC转换使能，自动触发使能
}
/****************************************************/
#pragma interrupt_handler adc_isr:15 
void adc_isr(void)
{
 //conversion complete, read value (int) using...
  value=ADCL;            //取模数值
  value|=(int)ADCH << 8; 
  flag=1;	         //标志位置1
}
/***************************************/
void init_devices(void) 
{
 port_init();	
 timer0_init();	
 timer1_init();	
 adc_init();	
 TIMSK = 0x05;  //T0/T1溢出中断使能
 SREG=0x80;     //总中断使能
}
/***************************************/
void delay(uint k) 
{
uint i,j;
	 for(i=0;i<k;i++)
	 {	 
	 for(j=0;j<140;j++); 
	 }
}
/******************************************/
uint conv(uint i) 
{
long x; 	
uint y; 
x=(5000*(long)i)/1023; 
y=(uint)x; 	
return y; 	    //数据转换
} 
/******************************************/
void main(void) 	
{	 				
init_devices();		
  while(1) 	
  {
   		if(flag==1)          //判标志位
		{
		dis_val=conv(value); 
		  if(dis_val<2000){OUT2_1;OUT1_0;} 
		  else if(dis_val<3000){OUT1_1;OUT2_1;} 
		  else {OUT2_0;OUT1_1;} 
		flag=0;			
		}
		delay(10);		
  }
} 
