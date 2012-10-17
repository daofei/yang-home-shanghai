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
#define SCL_1 PORTC|=BIT(PC0)
#define SCL_0 PORTC&=~BIT(PC0)
#define SDA_1 PORTC|=BIT(PC1)
#define SDA_0 PORTC&=~BIT(PC1)
#define LED_1 PORTB|=BIT(PB7)
#define LED_0 PORTB&=~BIT(PB7)
//======================================
#define PIN_SDA (PINC&0x02)
#define DataPort PORTA		
#define Busy 0x80			
#define xtal 8   			
#define Some_NOP();  _NOP();_NOP();_NOP();_NOP();_NOP();_NOP();_NOP();_NOP();
//======================================
const uchar str0[]={"-Time   :  :  --"};//待显字符串
const uchar str1[]={"-ATime   :  : --"};//待显字符串
//========函数声明=========
void Delay_1ms(void);
void Delay_nms(uint n);
void WaitForEnable(void);
void LcdWriteData(uchar W);
void LcdWriteCommand(uchar CMD,uchar Attribc);
void InitLcd(void);
void Display(uchar dd);
void DisplayOneChar(uchar x,uchar y,uchar Wdata);
void ePutstr(uchar x,uchar y,uchar const *ptr);
void port_init(void);
void init_devices(void);
void timer1_init(void);
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
Delay_nms(5);
LcdWriteCommand(0x38,0); 
Delay_nms(5);
LcdWriteCommand(0x38,0); 
Delay_nms(5);
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
//****************************************
void Delay_1ms(void)		//1mS延时子函数
{ uint i;
 for(i=1;i<(uint)(xtal*143-2);i++)
    ;
}
//====================================
void Delay_nms(uint n)		//n*1mS延时子函数
{
 uint i=0;
   while(i<n)
   {Delay_1ms();
    i++;
   }
}
/*******************定义结构体变量time1,time2*******************/
struct date
{
uchar hour;
uchar min;
uchar sec;
uchar dida;
}time1,time2;

/*******************端口初始化*******************/
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
/*************************************/
char com_data;		
uchar cnt;			
void delay_iic(int n);	
uchar rd_24c01(char a);	
void wr_24c01(char a,char b);
/******************扫描按键***************/
uchar scan_key(void)		
{					
uchar temp;			
temp=PIND;				
return temp;			
}					
/***************延时子函数******************/
void delay(uint k)		
{					
uint i,j;			
for(i=0;i<k;i++)			
{for(j=0;j<121;j++)		
{;}}				
}					

/*****************启动读写时序子函数******************/
void start(void)			
{DDRC=0x03;					
SDA_1;Some_NOP();
SCL_1;Some_NOP();
SDA_0;Some_NOP();
SCL_0;Some_NOP();
}					
//********************停止操作子函数*********************
void stop(void)			
{	DDRC=0x03;			
SDA_0;Some_NOP();
SCL_1;Some_NOP();
SDA_1;Some_NOP();
}				
//************应答子函数*************
void ack(void)			
{	DDRC=0x03;				
SCL_1;Some_NOP();
SCL_0;Some_NOP();
}					
//*************写入8位子函数*************
void shift8(char a)		
{					
uchar i,j;			
DDRC=0x03;
com_data=a;			
for(i=0;i<8;i++)	
{	
j=com_data&0x80;
if(j==0)SDA_0;
else SDA_1;

SCL_1;Some_NOP();
SCL_0;Some_NOP();
com_data=com_data<<1;		
}					
}					
//**************读24C01A中a地址单元的数据************
uchar rd_24c01(char a)		
{					
uchar i,command;		
DDRC=0x03;
SDA_1;Some_NOP();
SCL_0;Some_NOP();
start();				
command=160;			
shift8(command);		
ack();				
shift8(a);			
ack();				
start();				
command=161;			
shift8(command);		
ack();				

SDA_1;Some_NOP();	
for(i=0;i<8;i++)			
{
DDRC=0x01;				
com_data=com_data<<1;		
SCL_1;Some_NOP();	
if(PIN_SDA==0)com_data&=0xfe;
else com_data|=0x01;
SCL_0;Some_NOP();
}					
stop();				
return(com_data);	
}					
//********将RAM中b地址单元的数据写入24C01A中a地址单元中***********
void wr_24c01(char a,char b)	
{					
uchar command;		
DDRC=0x03;
SDA_1;Some_NOP();
SCL_0;Some_NOP();
start();				
command=160;			
shift8(command);		
ack();				
shift8(a);				
ack();				
shift8(b);				
ack();				
stop();				
Some_NOP();
}					
//**************延时子函数***********
void delay_iic(int n)		
{					
int i;				
for(i=1;i<n;i++){;}		
}					

/**************定时器1初始化****************/
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
    Delay_nms(400);			
	InitLcd();			
	LcdWriteCommand(0x01,1); 
	LcdWriteCommand(0x0c,1); 
	ePutstr(0,0,str0);  
	Delay_nms(10);
	ePutstr(0,1,str1);   
	Delay_nms(10);
	/********************************************/
		while(1)              
		{
		   DisplayOneChar(6,0,(time1.hour/10)+0x30);
		   Delay_nms(10);
		   DisplayOneChar(7,0,(time1.hour%10)+0x30);
		   Delay_nms(10); 
		   DisplayOneChar(9,0,(time1.min/10)+0x30);
		   Delay_nms(10); 
		   DisplayOneChar(10,0,(time1.min%10)+0x30);
		   Delay_nms(10); 
		   DisplayOneChar(12,0,(time1.sec/10)+0x30);
		   Delay_nms(10); 
		   DisplayOneChar(13,0,(time1.sec%10)+0x30);
		   Delay_nms(10); 
		   
	   	   DisplayOneChar(7,1,(time2.hour/10)+0x30);
		   Delay_nms(10); 
		   DisplayOneChar(8,1,(time2.hour%10)+0x30);
		   Delay_nms(10); 
		   DisplayOneChar(10,1,(time2.min/10)+0x30);
		   Delay_nms(10); 
    	   DisplayOneChar(11,1,(time2.min%10)+0x30);
		   Delay_nms(10); 

		   key_val=scan_key();	

		   switch(key_val)		
	   	   {				
	   	   	case 0xef:time1.min++;
			          if(time1.min>59){time1.min=0;
					                  if(time1.hour<23)time1.hour++;
								      }break;  
	   		case 0xdf:time1.hour++;if(time1.hour>23)time1.hour=0;break;														//加法调整"时"
	   		case 0xbf:time2.min++;
			          if(time2.min>59){time2.min=0;
					                  if(time2.hour<23)time2.hour++;
								      }break; 
	   		case 0x7f:time2.hour++;if(time2.hour>23)time2.hour=0;break;	
											
			//*************************
			case 0xfb:wr_24c01(11,time2.hour);
				 Delay_nms(10); 
				 wr_24c01(12,time2.min); 
				 Delay_nms(10); 
				 DisplayOneChar(13,1,0x57); 
				 Delay_nms(10);break; 
	   		case 0xf7:time2.hour=rd_24c01(11); 
				 Delay_nms(10); 
				 time2.min=rd_24c01(12); 
				 Delay_nms(10); 
				 DisplayOneChar(13,1,0x52); 
				 Delay_nms(10);break;	 
	   		default:break;		
	   		}				
			Delay_nms(300);
			DisplayOneChar(13,1,0x20); 
			Delay_nms(10); 
						
  		 }				
}		   
/*********************定时器T1中断子函数************************/
#pragma interrupt_handler timer1_ovf_isr:9
void timer1_ovf_isr(void)
{
 //TIMER1 has overflowed
 TCNT1H = 0xF3; //reload counter high value
 TCNT1L = 0xCB; //reload counter low value
 if(++time1.dida>=10){time1.dida=0;time1.sec++;}//计时
 if(time1.sec>=60){time1.sec=0;time1.min++;}
 if(time1.min>=60){time1.min=0;time1.hour++;}
 if(time1.hour>=24){time1.hour=0;}
 //-------------------
 if((time1.hour==time2.hour)&&(time1.min==time2.min))LED_0;
 else LED_1;
}
/**********************器件初始化***********************/
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
