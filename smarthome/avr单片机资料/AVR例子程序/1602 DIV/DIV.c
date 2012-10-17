/*********************************************************/
/* Target : ATmage16L                                    */
/* Crystal: 8.00MHz                                      */
/* KV-878 PCB                                            */
/*遥控型号：UPD6121    //LCD 1602                        */
/*硬件接入引脚：PD6(ICP1) //PIN15                        */
/*解码方式：定时器捕获中断                               */
/*********************************************************/
 #define LED_1  PORTD|=BIT(PD1)   //
 #define LED_0  PORTD&=~BIT(PD1)  //背光
 
 #define RS_0    PORTC &= ~(1 << PC0)
 #define RS_1    PORTC |= (1 << PC0)
 //RS为寄存器选择，高电平时选择数据寄存器、低电平时选择指令寄存器。
 #define RW_0    PORTC &= ~(1 << PC1)
 #define RW_1    PORTC |= (1 << PC1)
//RW为读写信号线，高电平时进行读操作，低电平时进行写操作。
//当RS和RW共同为低电平时可以写入指令或者显示地址，当RS为
//低电平RW为高电平时可以读忙信号，当RS为高电平RW为低电平时可以写入数据。

 #define EN_0    PORTC &= ~(1 << PC2)
 #define EN_1    PORTC |= (1 << PC2)
//EN端为使能端，当E端由高电平跳变成低电平时，液晶模块执行命令。  
//*************头文件*******************
 #include <iom16v.h>
 #include <macros.h>
 #include <eeprom.h>
 #define  uchar unsigned char 
 #define  uint unsigned int  
////////////////////////////////////////

uchar shukk[10]={0x30,0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39};/*0到9的ASCII码值*/
uchar addr[4]={0x85,0x86,0x87,0x88};/*显示起始地址*/
uchar llbit=1;
uchar i,j,unin,head,irsign=0;//unin连发标志，head引导标志，irsign红外标志
uchar bitnum,data0,data1,data2,data3;//bitnum位数，data0~3寄存四字节数据
 //*************I/O口设置*****************
 void port_init(void)
 {  //--PA,PB不用--
    PORTA = 0xff;                /*打开上拉*/
    DDRA = 0xff;                /*方向输入*/
    PORTB = 0xff;                /*电平设置*/
    DDRB = 0x00;                /*方向输出*/
	//--PC数据，PD各通讯
    PORTC = 0xff;
    DDRC = 0xff;
    PORTD = 0xfe;
    DDRD = 0x3f;

 }
 //***************1毫秒级延时*************
 void ys1ms (void)
 {
   uint i;
   for (i=1324;i>0;i--);
  }  
//***************n毫秒延时****************
 void delaym (uint n)
 {
   uint i=0;
   for (i=0;i<n;i++)
   ys1ms();
  }   
 //************写EEPROM*****************   
   void EEPROM_W(uint eepadd,uchar eepdat)
   {
    CLI();
    delaym(3);
    EEAR=eepadd;            //送高地址
	EEDR=eepdat;            //送数据
	EECR=EECR|0x04;         //主写使能置位
	EECR=EECR|0x02;         //写使能置位
	EECR=0;
	delaym(3);
	SEI();
   }
 //-------------------------------------
 void timer1_init(void)
 {
  TIMSK=0x20; //使能T1捕获中断 
  TCCR1A=0x00;//使能噪声抑制，下降沿触发
  TCCR1B=0x82;//T/C1时钟为系统时钟/8；时钟周期1us
  SEI();  //总中断
  
  }
//==============T0开始========================
  void  t0_start (void)	 
  {
   TCNT0=0x00;                  //清空
   TCCR0=0x05;                  //1024分频
   TIMSK=(1<<TOIE0)|(1<<TICIE1);//t0溢出中断开
   SEI(); 
  }  	
 //=============RXD===========================
 void rxd_init(void)
 {
 UCSRB=0x00;//禁止接收和发送
 UCSRA=0x02;//倍速
 UCSRC=0x06;//8位数据
 UBRRL=0x67;
 UBRRH=0x00;//9600b/s波特率
 UCSRB=0x18;//开启接收发送
 }	
//=============send一字节=============================
 void send(uchar a)
  {
  while(!(UCSRA&(1<<UDRE)));//UDRE为0说明发送区已清空
  UDR=a;
  } 	
//==============发送3字节代码=========================
void send3(uchar subr)
 {LED_1;
  send(0x55); 
  delaym(2);
  send(subr);
  delaym(2);
  send(0x81);
  delaym(2);
  LED_0;
  } 
//----------------------------------  
  //微秒级延时程序晶振8MHZ
void delay_us(int time)
{    
 do
  {
   time--;
  }    
 while (time>1);
}
//-----------------------------------      
//毫秒级延时程序晶振8MHZ 
void delay_ms(uint time)
{
 while(time!=0)
  {        
   delay_us(1000);
   time--;
  }
}
//-------------------------------------
/*显示屏命令写入函数*/
void LCD_write_com(uchar com) 
  {
   RS_0;//低电平命令
   RW_0;//低电平写
   PORTA = com;
   //PORTB = com;
   EN_1;
   delay_us(20);
   EN_0;//EN由高到低使能
  }
//-------------------------------------
/*显示屏命令写入函数*/
void LCD_write_data(uchar data) 
 {
  RS_1;//高电平数据
  RW_0;//低电平写
  PORTA = data;
  //PORTB = data;
  EN_1;
  delay_us(200);
  EN_0;//EN由高到低使能
}
//-----------------------------------
/*显示屏清空显示*/
void LCD_clear(void) 
 {
  LCD_write_com(0x01);//清显示，指令码01H,光标复位到地址00H位置
  delay_ms(5);
 }
//----------------------------------
/*显示屏字符串写入函数*/
void LCD_write_str(uchar x,uchar y,uchar *s)//x起始位置，y行位置，*s数据 
 {
  if (y == 0)//1行
  {
   LCD_write_com(0x80 + x);
  }
  else      //2行
  {
   LCD_write_com(0xC0 + x);
  }
    
  while (*s)
  {
   LCD_write_data( *s);
   s ++;
   //delay_ms(5);
  }
}
//------------------------------------
/*显示屏单字符写入函数*/
void LCD_write_char(uchar x,uchar y,uchar data) //x起始位置，y行位置，data数据
 {
  if (y == 0)//1行
   {
    LCD_write_com(0x80 + x);
   }
  else      //2行
   {
    LCD_write_com(0xC0 + x);
   }
    
    LCD_write_data(data);  
 }
//---------------------------------------
/*显示屏初始化函数*/
void LCD_init(void) 
 {
   DDRA = 0xff;                        /*I/O口方向设置*/
   DDRC |= (1 << PC0) | (1 << PC1) | (1 << PC2);
   
   delay_ms(15);
   LCD_write_com(0x38);                /*显示模式设置*/
   delay_ms(5);
   LCD_write_com(0x38);
   delay_ms(5);
   LCD_write_com(0x38);
   delay_ms(5);
   LCD_write_com(0x38);                //16*2显示，5*7点阵，8位数据
    
   LCD_write_com(0x08);                /*显示关闭*/
   LCD_write_com(0x01);                /*显示清屏*/
   LCD_write_com(0x06);                /*显示光标移动设置，读写1字符后光标加1*/
   LCD_write_com(0x0C);                /*显示开*/
   delay_ms(5);
}

//-----------------------------------------
void main(void) 
{
 uchar i;
 uchar *p;
 delay_ms(50);
 port_init();
 delay_ms(50);
 timer1_init();     //定时器初始化  
 delay_ms(50);
 LCD_init();        //LCD初始化
 delay_ms(200);
 LCD_clear();       //清LCD
 delay_ms(200);
//-------------------------------- 
  {loop:
   i = 4;
   p = "Welcome";
   //LCD_write_str(2,1,"I Love You");
   delay_ms(50);
        
   while (*p) 
    {
     LCD_write_char(i,0,*p);
     i ++;
     p ++;
     delay_ms(180);
    }
	///////////////
	i=2;
	p="haohandianzi";
	 while (*p) 
    {
     LCD_write_char(i,1,*p);
     i ++;
     p ++;
     delay_ms(181);
    }
   delay_ms(500);
   llbit=0;
   //LED_0;
  }
 /*/-------------------------------------
 while(1)
 {
  if(irsign==1)
   {
    irsign=0;
	//----------------------------------
	if(data2==0x58)
	 {
     LCD_clear();
     LCD_write_str(6,0,"REDAY!");//空格6，1行
     delay_ms(50);
     LCD_write_str(6,1,"RESET");//空格5，2行
     delay_ms(800);
	 LCD_clear();
	 goto loop;
	 }
     //--------------------------------------
	 else if((data2==0xd8)&&(llbit==0))
	  {
	   LCD_clear();
	   llbit=1;
	   LED_1;
	   LCD_write_str(1,0,"background lamp");
	   delay_ms(50);
	   LCD_write_str(6,1,"ON");
	   delay_ms(50);
	  }
	 else if((data2==0xd8)&&(llbit==1))
	  {
	   LCD_clear();
	   llbit=0;
	   LED_0;
	   LCD_write_str(1,0,"background lamp");
	   delay_ms(50);
	   LCD_write_str(6,1,"OFF");
	   delay_ms(50);
	  } 
	//----------------------------------
	if(data2==0x70)
	 {
	  LCD_clear();
      LCD_write_str(2,0,"This code is");
	  delay_ms(50);
	  LCD_write_str(6,1,"0x70");
	 } 
    //----------------------------------
	if(data2==0xf0)
	 {
	  LCD_clear();
      LCD_write_str(2,0,"This code is");
	  delay_ms(50);
	  LCD_write_str(6,1,"0xf0");
	 }     
	//----------------------------------
	if(data2==0x48)
	 {
	  LCD_clear();
      LCD_write_str(2,0,"This code is");
	  delay_ms(50);
	  LCD_write_str(6,1,"0x48");
	 }   
	//----------------------------------
	if(data2==0xc8)
	 {
	  LCD_clear();
      LCD_write_str(2,0,"This code is");
	  delay_ms(50);
	  LCD_write_str(6,1,"0xc8");
	 } 
	//----------------------------------
	if(data2==0x68)
	 {
	  LCD_clear();
      LCD_write_str(2,0,"This code is");
	  delay_ms(50);
	  LCD_write_str(6,1,"0x68");
	 }
   //----------------------------------
	if(data2==0xe8)
	 {
	  LCD_clear();
      LCD_write_str(2,0,"This code is");
	  delay_ms(50);
	  LCD_write_str(6,1,"0xe8");
	 }     	                    
    }
  } */	
}
 
//--------------中断----------------------
#pragma interrupt_handler timer1_in:6
 void timer1_in(void)
 {
  static uint old_data;
   uint temp,temp0,new_data;//定义变量
   new_data=ICR1;           //读值
   temp=new_data-old_data;  //当次脉宽
   old_data=new_data;       //底数保存
   
  if(temp>1024&&temp<1225)     //0
   {temp0=0;}
  else if(temp>2145&&temp<2345)//1
   {temp0=1;}
  else if(temp>11150&&temp<11350)//连发
   {unin=1;   //连发码标志置位
    bitnum=0; //位数
    data0=0;  //1字节数据					  
    data1=0;  //2字节数据
    data2=0;  //3字节数据
    data3=0;  //4字节数据
    return;   //为uninterrupted返回待下次接收
   }
  else if(temp>13400&&temp<13600)//引导
  {
   head=1;   //引导码标志置位
   bitnum=0; //位数
   data0=0;  //1字节数据					  
   data1=0;  //2字节数据
   data2=0;  //3字节数据
   data3=0;  //4字节数据
   return;   //为header返回待下次接收
  }
  else 
  return;    //不符合以上，为干扰脉冲，放弃返回接收
  
  bitnum++;  //为0或1时位数递加
 if(bitnum<8)//小于8位时放入1
 {data0=data0|(uint)temp0;
  data0=data0<<1;}   //左移
  else if(bitnum==8) //等于8时，最后一位放入1字节
  {data0=data0|(uint)temp0;}
  else if(bitnum<16) //小于16位时放入2字节
  {data1=data1|(uint)temp0;
   data1=data1<<1;}
  else if(bitnum==16)//等于16时，最后一位放入2字节
  {data1=data1|(uint)temp0;}
  
  else if(bitnum<24) //小于16位时放入3字节
  {data2=data2|(uint)temp0;
   data2=data2<<1;}
  else if(bitnum==24)//等于16时，最后一位放入3字节
  {data2=data2|(uint)temp0;}
  
   else if(bitnum<32)//小于32位时放入4字节
  {data3=data3|(uint)temp0;
   data3=data3<<1;}
   
  else if(bitnum==32)//等于32时，最后一位放入4字节
  {data3=data3|(uint)temp0;
   bitnum=0;        //位数清0
   irsign=1;        //IR完成标志位置位
   CLI();           //总中断暂关
   } 
 }        
///////////////////////////////////////////////////////
 //-------------其它中断处理---------------------
 #pragma  interrupt_handler int0:2 //外部中断0
 void  int0 (void)		
   {return;}	
 //------------------------------------------
 #pragma  interrupt_handler int1:3 //外部中断1
 void  int1 (void)		
   {return;
   }
 //------------------------------------------	
 #pragma  interrupt_handler t2_comp:4  //定时器2比较
 void  t2_comp (void)		
   {return; }	
 //------------------------------------------
 #pragma  interrupt_handler t2_ovf:5  //定时器2溢出
 void  t2_ovf (void)		
   {return;}	   
 //------------------------------------------
 #pragma  interrupt_handler t1_compa:7  //定时器1比较a
 void  t1_compa (void)		
   {return;    
   }	
 //------------------------------------------  
 #pragma  interrupt_handler t1_compb:8  //定时器1比较b
 void  t1_compb (void)		
   {return;    
   }	
 //------------------------------------------
 #pragma  interrupt_handler t1_ovf:9   //定时器1溢出
 void  t1_ovf (void)		
   {
    return;
   }	  
 //------------------------------------------
 #pragma  interrupt_handler t0_ovf:10  //定时器0溢出用于自动清OSD
 void  t0_ovf (void)		
   {return;}
 //------------------------------------------
 #pragma  interrupt_handler spi_end:11  //SPI结束
 void  spi_end (void)		
   {return;}	  
 //------------------------------------------
 #pragma  interrupt_handler rx_end:12  //rx结束
 void  rx_end (void)		
   {return;    
   }	  
 //------------------------------------------
 #pragma  interrupt_handler usart_nop:13  //USART空
 void  usart_nop (void)		
   { return;   
   }	 
 //------------------------------------------
 #pragma  interrupt_handler tx_end:14   //tx结束
 void  tx_end (void)		
   {return;    
   }	  
//------------------------------------------
 #pragma  interrupt_handler adc_end:15  //adv结束
 void  adc_end (void)		
   { return;   
   }	   
//------------------------------------------
 #pragma  interrupt_handler eep_rdy:16  //eeprom就绪
 void  eep_rdy (void)		
   { return;   
   }	
//------------------------------------------
 #pragma  interrupt_handler ana_comp:17  //模拟比较器
 void  ana_comp (void)		
   { return;   
   }	  
//------------------------------------------
 #pragma  interrupt_handler twi:18       //iic
 void  twi (void)		
   {  return;  
   }	  
 //------------------------------------------
 #pragma  interrupt_handler spm_rdy:19   //程序储存就绪
 void  spm_rdy (void)		
   {  return;  
   }
   	     
//============================================
//-----------------------end------------------
//============================================  
 
 
  