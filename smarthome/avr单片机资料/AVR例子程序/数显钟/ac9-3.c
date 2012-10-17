#include <iom16v.h>	
#define uchar unsigned char
#define uint unsigned int
uchar const SEG7[10]={0x3f,0x06,0x5b, 
	  0x4f,0x66,0x6d,0x7d,0x07,0x7f,0x6f};
uchar const ACT[4]={0xfe,0xfd,0xfb,0xf7}; 
uint cnt; 
uchar start_flag; 
uchar i; 
#define S1 (PIND&0x10)	

void port_init(void)
{
 PORTA = 0x00; 
 DDRA  = 0xFF; 
 PORTC = 0xFF; 
 DDRC  = 0xFF; 
 PORTD = 0xFF; 
 DDRD  = 0x00; 
}

void timer0_init(void)
{
 TCNT0 = 0x83; 
 TCCR0 = 0x03;         //T0初始化为定时1MS
}

#pragma interrupt_handler timer0_ovf_isr:10
void timer0_ovf_isr(void)
{
 SREG=0x80;               //重新开放总中断，确保准确计时
 TCNT0 = 0x83;           //重装初值
 if(++i>3)i=0;  
 switch(i)
 {
 case 0: PORTA=SEG7[cnt%10]; PORTC=ACT[i];break;
 case 1: PORTA=SEG7[(cnt/10)%10]; PORTC=ACT[i];break;
 case 2: PORTA=SEG7[(cnt/100)%10]|0x80; PORTC=ACT[i];break;
 case 3: PORTA=SEG7[cnt/1000]; PORTC=ACT[i];break;
 default:break;
 }
}

void timer1_init(void) 
{
 TCNT1H = 0xD8; 
 TCNT1L = 0xF0;           //10MS定时初值
}

#pragma interrupt_handler timer1_ovf_isr:9
void timer1_ovf_isr(void)
{
 TCNT1H = 0xD8; 
 TCNT1L = 0xF0;          //重装//秒表精确度为毫秒级
 if(++cnt>9999)cnt=0;
}

#pragma interrupt_handler int0_isr:2
void int0_isr(void)
{
if(cnt<10)start_flag=0xff;//计时未开始，启动标志置高
else start_flag=0x00;     //计时开始，启动标志置低
}

void init_devices(void)
{
 port_init();
 timer0_init();
 timer1_init();
 MCUCR = 0x02; //INT0下降沿触发
 GICR  = 0x40;  //使能INTO中断
 TIMSK = 0x05; //使能T1/T0中断
 SREG=0x80;    //使能总中断
}

void scan_s1(void)
{
if(S1==0)cnt=0;      //S1按下，清0
}

void main(void) 
{
init_devices();         //芯片初始化
  while(1) 
  {
  if(start_flag==0xff)TCCR1B = 0x02;          //查标志，未计时则开始计时
if(start_flag==0x00){TCCR1B = 0x00;scan_s1();}//否则，停止计时
							
  }						
}					