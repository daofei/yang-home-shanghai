#include <iom16v.h>			
#include <macros.h>
//-----------------------------------------------
#define uchar unsigned char	
#define uint unsigned int
//-------------------引脚电平的宏定义---------
#define LCM_RS_1 PORTB|=BIT(PB0)	
#define LCM_RS_0 PORTB&=~BIT(PB0) 
#define LCM_RW_1 PORTB|=BIT(PB1)	
#define LCM_RW_0 PORTB&=~BIT(PB1) 
#define LCM_EN_1 PORTB|=BIT(PB2)	
#define LCM_EN_0 PORTB&=~BIT(PB2)  
#define LED_1 PORTB|=BIT(PB7)
#define LED_0 PORTB&=~BIT(PB7)

#define rd_device_add 0xa1
#define wr_device_add 0xa0

//======================================
//TWI状态定义
//MT 主方式传输  MR 主方式接收
#define START 0x08 
#define RE_START 0x10
#define MT_SLA_ACK 0x18
#define MT_SLA_NOACK 0x20
#define MT_DATA_ACK  0x28
#define MT_DATA_NOACK 0x30
#define MR_SLA_ACK  0x40
#define MR_SLA_NOACK 0x48
#define MR_DATA_ACK 0x50
#define MR_DATA_NOACK 0x58

//常用TWI操作(主模式写和主模式读)
#define Start()    	  (TWCR=(1<<TWINT)|(1<<TWSTA)|(1<<TWEN))
#define Stop()     	  (TWCR=(1<<TWINT)|(1<<TWSTO)|(1<<TWEN))
#define Wait()	   	  {while(!(TWCR&(1<<TWINT)));}
#define TestAck() 	  (TWSR&0xf8)
#define SetAck()	  (TWCR|=(1<<TWEA))
#define SetNoAck()    (TWCR&=~(1<<TWEA))
#define Twi()	  	  (TWCR=(1<<TWINT)|(1<<TWEN))
#define Write8Bit(x)  {TWDR=(x);TWCR=(1<<TWINT)|(1<<TWEN);} 

#define DataPort PORTA		
#define Busy 0x80			
#define xtal 8   		

//======================================
const uchar str0[]={"-Time   :  :  --"};//待显字符串
const uchar str1[]={"-ATime   :  : --"};//待显字符串

//========函数声明=========
void WaitForEnable(void);
void LcdWriteData(uchar W);
void LcdWriteCommand(uchar CMD,uchar Attribc);
void InitLcd(void);
void Display(uchar dd);
void DisplayOneChar(uchar x,uchar y,uchar Wdata);
void ePutstr(uchar x,uchar y,uchar const *ptr);
void port_init(void);
void delay_ms(unsigned int time);
void delay_us(int time);
void init_devices(void);

//**********************显示指定座标的一串字符子函数**************
void ePutstr(uchar x,uchar y,uchar const *ptr)
{
uchar i,l=0;
	while(ptr[l]>31){l++;}
	for(i=0;i<l;i++){
	DisplayOneChar(x++,y,ptr[i]);
	if(x==16){
		x=0;y^=1;
	}
  }
}

//*******************显示光标定位子函数******************
void LocateXY(char posx,char posy)
{
uchar temp;
	temp&=0x7f;
	temp=posx&0x0f;
	posy&=0x01;
	if(posy)temp|=0x40;
	temp|=0x80;
	LcdWriteCommand(temp,0);
}

//*******************显示指定座标的一个字符子函数*******************
void DisplayOneChar(uchar x,uchar y,uchar Wdata)
{
LocateXY(x,y);
LcdWriteData(Wdata);
}

//*******************LCD初始化子函数*********************
void InitLcd(void) 
{
LcdWriteCommand(0x38,0); 
delay_ms(5);
LcdWriteCommand(0x38,0); 
delay_ms(5);
LcdWriteCommand(0x38,0);
delay_ms(5);
LcdWriteCommand(0x38,1); 
LcdWriteCommand(0x08,1); 
LcdWriteCommand(0x01,1); 
LcdWriteCommand(0x06,1); 
LcdWriteCommand(0x0c,1); 
}

//********************写命令到LCM子函数********************
void LcdWriteCommand(uchar CMD,uchar Attribc)
{
if(Attribc)WaitForEnable();
LCM_RS_0;LCM_RW_0;_NOP();
DataPort=CMD;_NOP();
LCM_EN_1;_NOP();_NOP();LCM_EN_0;
}

//*******************写数据到LCM子函数********************
void LcdWriteData(uchar dataW)
{
WaitForEnable();
LCM_RS_1;LCM_RW_0;_NOP();
DataPort=dataW;_NOP();
LCM_EN_1;_NOP();_NOP();LCM_EN_0;
}

//*******************检测LCD忙信号子函数*********************
void WaitForEnable(void)
{
uchar val;
DataPort=0xff;
LCM_RS_0;LCM_RW_1;_NOP();
LCM_EN_1;_NOP();_NOP();
DDRA=0x00;
val=PINA;
while(val&Busy)val=PINA;
LCM_EN_0;
DDRA=0xff;
}

/******************定义结构体变量time1,time2********************/
struct date
{
uchar hour;
uchar min;
uchar sec;
uchar dida;
}time1,time2;

/******************端口初始化**********************/
void port_init(void)
{
 PORTA = 0x00;
 DDRA  = 0xFF;
 PORTB = 0x00;
 DDRB  = 0xFF;
 PORTC = 0x00; 
 DDRC  = 0x03;
 PORTD = 0xFF;
 DDRD  = 0x00;
}

/*****************扫描按键*****************/
uchar scan_key(void)		
{					
uchar temp;			
temp=PIND;				
return temp;			
}					

/******************************************
               I2C总线读一个字节
			   如果读失败返回0
*******************************************/
unsigned char i2c_Read(unsigned char RomAddress) 
      {
	   unsigned char temp;
	   Start();
	   Wait();
	   if (TestAck()!=START) return 0;	   
	   Write8Bit(wr_device_add);
	   Wait(); 
	   if (TestAck()!=MT_SLA_ACK) return 0;
	   Write8Bit(RomAddress);
	   Wait();
	   if (TestAck()!=MT_DATA_ACK) return 0;
	   Start();
	   Wait();
	   if (TestAck()!=RE_START)  return 0;
	   Write8Bit(rd_device_add);
	   Wait();
	   if(TestAck()!=MR_SLA_ACK)  return 0;
	   Twi();
	   Wait();
	   if(TestAck()!=MR_DATA_NOACK) return 0;	
	   temp=TWDR;
       Stop();
	   return temp;
      }
	  
/******************************************
               I2C总线写一个字节
			    返回0:写成功
				返回非0:写失败
*******************************************/
unsigned char i2c_Write(unsigned char RomAddress,unsigned char Wdata) 
{
	  Start();
	  Wait();
	  if(TestAck()!=START) return 1;
	  Write8Bit(wr_device_add);
	  Wait();
	  if(TestAck()!=MT_SLA_ACK) return 1;
	  Write8Bit(RomAddress);
	  Wait();
	  if(TestAck()!=MT_DATA_ACK) return 1;
	  Write8Bit(Wdata);
	  Wait();
	  if(TestAck()!=MT_DATA_ACK) return 1;	
	  Stop();
 	  delay_ms(10);
	  return 0;
}

/*****************定时器1初始化*************/
void timer1_init(void)
{
 TCNT1H = 0xF3; //setup
 TCNT1L = 0xCB;
 TCCR1B = 0x04; //start Timer
}

//******************************************
void main(void)				
{
 	 uchar key_val;	
	 init_devices();
    delay_ms(400);			
	InitLcd();		
	LcdWriteCommand(0x01,1); 
	LcdWriteCommand(0x0c,1); 
	ePutstr(0,0,str0);  
	delay_ms(10);
	ePutstr(0,1,str1);  
	delay_ms(10);
	/********************************************/
		while(1)             
		{
		   DisplayOneChar(6,0,(time1.hour/10)+0x30);
		   delay_ms(10);
		   DisplayOneChar(7,0,(time1.hour%10)+0x30);
		   delay_ms(10);
		   DisplayOneChar(9,0,(time1.min/10)+0x30);
		   delay_ms(10);
		   DisplayOneChar(10,0,(time1.min%10)+0x30);
		   delay_ms(10);
		   DisplayOneChar(12,0,(time1.sec/10)+0x30);
		   delay_ms(10);
		   DisplayOneChar(13,0,(time1.sec%10)+0x30);
		   delay_ms(10);
		   
	   	   DisplayOneChar(7,1,(time2.hour/10)+0x30);
		   delay_ms(10);
		   DisplayOneChar(8,1,(time2.hour%10)+0x30);
		   delay_ms(10);
		   DisplayOneChar(10,1,(time2.min/10)+0x30);
		   delay_ms(10);
    	   DisplayOneChar(11,1,(time2.min%10)+0x30);
		   delay_ms(10);
		   key_val=scan_key();	
		   switch(key_val)		
	   	   {				
	   	   	case 0xef:time1.min++;
			          if(time1.min>59){time1.min=0;
					                  if(time1.hour<23)time1.hour++;
								      }break; 
	   		case 0xdf:time1.hour++;if(time1.hour>23)time1.hour=0;break;	
											
	   		case 0xbf:time2.min++;
			          if(time2.min>59){time2.min=0;
					                  if(time2.hour<23)time2.hour++;
								      }break; 
	   		case 0x7f:time2.hour++;if(time2.hour>23)time2.hour=0;break;	
											
			//*************************
			case 0xfb:i2c_Write(11,time2.hour); 
				 delay_ms(10);
				 i2c_Write(12,time2.min);		
				 delay_ms(10);
				 DisplayOneChar(13,1,0x57); 
				 delay_ms(10);break;	
	   		case 0xf7:time2.hour=i2c_Read(11); 
				 delay_ms(10);
				 time2.min=i2c_Read(12);
				 delay_ms(10);
				 DisplayOneChar(13,1,0x52); 
				 delay_ms(10);break;	
	   		default:break;		
	   		}					
			delay_ms(300); 
			DisplayOneChar(13,1,0x20); 
			delay_ms(10);
						
  		 }				
}		   
/***********************定时器T1中断子函数**********************/
#pragma interrupt_handler timer1_ovf_isr:9
void timer1_ovf_isr(void)
{
 //TIMER1 has overflowed
 TCNT1H = 0xF3; //reload counter high value
 TCNT1L = 0xCB; //reload counter low value
 if(++time1.dida>=10){time1.dida=0;time1.sec++;}
 if(time1.sec>=60){time1.sec=0;time1.min++;}
 if(time1.min>=60){time1.min=0;time1.hour++;}
 if(time1.hour>=24){time1.hour=0;}
 //-------------------
 if((time1.hour==time2.hour)&&(time1.min==time2.min))LED_0; 
 else LED_1;
}
/*********************************************/
void init_devices(void)
{
 //stop errant interrupts until set up
 CLI(); //disable all interrupts
 port_init();
 timer1_init();
 MCUCR = 0x00;
 GICR  = 0x00;
 TIMSK = 0x04; //timer interrupt sources
 SEI(); //re-enable interrupts
 //all peripherals are now initialized
}

/*******************器件初始化********************/
void delay_ms(unsigned int time)
	 {
	  while(time!=0)
	  	  {		
		   delay_us(1000);
		   time--;
		  }
	 }
	 					
/*****************廷时子函数************************/
void delay_us(int time)
	 {     
  	  do
	  	{
		 time--;
		}	
  	  while (time>1);
	 }	  
