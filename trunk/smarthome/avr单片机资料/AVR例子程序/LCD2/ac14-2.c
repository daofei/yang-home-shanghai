#include <iom16v.h>
#include <macros.h>
//----------------------------
#define uchar unsigned char
#define uint unsigned int
//----------------------------
#define LCM_RS_1 PORTB|=BIT(PB0)
#define LCM_RS_0 PORTB&=~BIT(PB0)
#define LCM_RW_1 PORTB|=BIT(PB1)
#define LCM_RW_0 PORTB&=~BIT(PB1)
#define LCM_EN_1 PORTB|=BIT(PB2)
#define LCM_EN_0 PORTB&=~BIT(PB2)
//------------------------------
#define DataPort PORTA
#define Busy 0x80
#define xtal 8   			
//---------------------------------
const uchar exampl[]="--ELECTRONICS--  WORLD magazine\n";
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
    uchar temp;
	Delay_nms(400);
	DDRA=0xff;PORTA=0x00;
	DDRB=0xff;PORTB=0x00;
	InitLcd();
	temp=32;
	ePutstr(0,0,exampl);
	Delay_nms(3200);
	while(1)
	{
		temp&=0x7f;
		if(temp<32)temp=32;
		Display(temp++);
		Delay_nms(400);
	}
}
//************************************
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
//*************************************
void Display(uchar dd)
{
uchar i;
	for(i=0;i<16;i++){
	DisplayOneChar(i,1,dd++);
	dd&=0x7f;
	if(dd<32)dd=32;
	}
}
//*************************************
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
//**************************************
void DisplayOneChar(uchar x,uchar y,uchar Wdata)
{
LocateXY(x,y);
LcdWriteData(Wdata);
}
//****************************************
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
//****************************************
void LcdWriteCommand(uchar CMD,uchar Attribc)
{
if(Attribc)WaitForEnable();
LCM_RS_0;LCM_RW_0;_NOP();
DataPort=CMD;_NOP();
LCM_EN_1;_NOP();_NOP();LCM_EN_0;
}
//***************************************
void LcdWriteData(uchar dataW)
{
WaitForEnable();
LCM_RS_1;LCM_RW_0;_NOP();
DataPort=dataW;_NOP();
LCM_EN_1;_NOP();_NOP();LCM_EN_0;
}
//****************************************
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
void Delay_1ms(void)		
{ uint i;
 for(i=1;i<(uint)(xtal*143-2);i++)
    ;
}
//=============================================
void Delay_nms(uint n)		
{
 uint i=0;
   while(i<n)
   {Delay_1ms();
    i++;
   }
}
