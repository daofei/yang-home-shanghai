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
//======================================
#define DataPort PORTA	//字节定义	
#define Busy 0x80		
#define xtal 8   		
//======================================
const uchar str0[]={"-This is a LCD-!"};
const uchar str1[]={"-Design by ZXH-!"};
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
//******************************************
void main(void)				
{
    Delay_nms(400);			
	DDRA=0xff;PORTA=0x00;	
	DDRB=0xff;PORTB=0x00;
	InitLcd();				
	/********************************************/
		while(1)              
		{
		   LcdWriteCommand(0x01,1); 
		   LcdWriteCommand(0x0c,1);	  
		   DisplayOneChar(0,1,0x41); 
		   ePutstr(0,0,str0); 
		   Delay_nms(2000);	
		   LcdWriteCommand(0x01,1);  
		   LcdWriteCommand(0x0c,1);  
		   DisplayOneChar(8,0,0x42);	
		   ePutstr(0,1,str1);  
		   Delay_nms(2000); 
	   }
}		   
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
