	.module DIV.c
	.area data(ram, con, rel)
_shukk::
	.blkb 2
	.area idata
	.byte 48,49
	.area data(ram, con, rel)
	.blkb 2
	.area idata
	.byte 50,51
	.area data(ram, con, rel)
	.blkb 2
	.area idata
	.byte 52,53
	.area data(ram, con, rel)
	.blkb 2
	.area idata
	.byte 54,55
	.area data(ram, con, rel)
	.blkb 2
	.area idata
	.byte 56,57
	.area data(ram, con, rel)
	.dbfile F:\AVR例子程序\1602DI~1\DIV.c
	.dbsym e shukk _shukk A[10:10]c
_addr::
	.blkb 2
	.area idata
	.byte 133,134
	.area data(ram, con, rel)
	.dbfile F:\AVR例子程序\1602DI~1\DIV.c
	.blkb 2
	.area idata
	.byte 135,136
	.area data(ram, con, rel)
	.dbfile F:\AVR例子程序\1602DI~1\DIV.c
	.dbsym e addr _addr A[4:4]c
_llbit::
	.blkb 1
	.area idata
	.byte 1
	.area data(ram, con, rel)
	.dbfile F:\AVR例子程序\1602DI~1\DIV.c
	.dbsym e llbit _llbit c
_irsign::
	.blkb 1
	.area idata
	.byte 0
	.area data(ram, con, rel)
	.dbfile F:\AVR例子程序\1602DI~1\DIV.c
	.dbsym e irsign _irsign c
	.area text(rom, con, rel)
	.dbfile F:\AVR例子程序\1602DI~1\DIV.c
	.dbfunc e port_init _port_init fV
	.even
_port_init::
	.dbline -1
	.dbline 39
; /*********************************************************/
; /* Target : ATmage16L                                    */
; /* Crystal: 8.00MHz                                      */
; /* KV-878 PCB                                            */
; /*遥控型号：UPD6121    //LCD 1602                        */
; /*硬件接入引脚：PD6(ICP1) //PIN15                        */
; /*解码方式：定时器捕获中断                               */
; /*********************************************************/
;  #define LED_1  PORTD|=BIT(PD1)   //
;  #define LED_0  PORTD&=~BIT(PD1)  //背光
;  
;  #define RS_0    PORTC &= ~(1 << PC0)
;  #define RS_1    PORTC |= (1 << PC0)
;  //RS为寄存器选择，高电平时选择数据寄存器、低电平时选择指令寄存器。
;  #define RW_0    PORTC &= ~(1 << PC1)
;  #define RW_1    PORTC |= (1 << PC1)
; //RW为读写信号线，高电平时进行读操作，低电平时进行写操作。
; //当RS和RW共同为低电平时可以写入指令或者显示地址，当RS为
; //低电平RW为高电平时可以读忙信号，当RS为高电平RW为低电平时可以写入数据。
; 
;  #define EN_0    PORTC &= ~(1 << PC2)
;  #define EN_1    PORTC |= (1 << PC2)
; //EN端为使能端，当E端由高电平跳变成低电平时，液晶模块执行命令。  
; //*************头文件*******************
;  #include <iom16v.h>
;  #include <macros.h>
;  #include <eeprom.h>
;  #define  uchar unsigned char 
;  #define  uint unsigned int  
; ////////////////////////////////////////
; 
; uchar shukk[10]={0x30,0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39};/*0到9的ASCII码值*/
; uchar addr[4]={0x85,0x86,0x87,0x88};/*显示起始地址*/
; uchar llbit=1;
; uchar i,j,unin,head,irsign=0;//unin连发标志，head引导标志，irsign红外标志
; uchar bitnum,data0,data1,data2,data3;//bitnum位数，data0~3寄存四字节数据
;  //*************I/O口设置*****************
;  void port_init(void)
;  {  //--PA,PB不用--
	.dbline 40
;     PORTA = 0xff;                /*打开上拉*/
	ldi R24,255
	out 0x1b,R24
	.dbline 41
;     DDRA = 0xff;                /*方向输入*/
	out 0x1a,R24
	.dbline 42
;     PORTB = 0xff;                /*电平设置*/
	out 0x18,R24
	.dbline 43
;     DDRB = 0x00;                /*方向输出*/
	clr R2
	out 0x17,R2
	.dbline 45
; 	//--PC数据，PD各通讯
;     PORTC = 0xff;
	out 0x15,R24
	.dbline 46
;     DDRC = 0xff;
	out 0x14,R24
	.dbline 47
;     PORTD = 0xfe;
	ldi R24,254
	out 0x12,R24
	.dbline 48
;     DDRD = 0x3f;
	ldi R24,63
	out 0x11,R24
	.dbline -2
L1:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e ys1ms _ys1ms fV
;              i -> R16,R17
	.even
_ys1ms::
	.dbline -1
	.dbline 53
; 
;  }
;  //***************1毫秒级延时*************
;  void ys1ms (void)
;  {
	.dbline 55
	ldi R16,1324
	ldi R17,5
	xjmp L6
L3:
	.dbline 55
L4:
	.dbline 55
	subi R16,1
	sbci R17,0
L6:
	.dbline 55
;    uint i;
;    for (i=1324;i>0;i--);
	cpi R16,0
	cpc R16,R17
	brne L3
X0:
	.dbline -2
L2:
	.dbline 0 ; func end
	ret
	.dbsym r i 16 i
	.dbend
	.dbfunc e delaym _delaym fV
;              i -> R20,R21
;              n -> R22,R23
	.even
_delaym::
	xcall push_gset2
	movw R22,R16
	.dbline -1
	.dbline 59
;   }  
; //***************n毫秒延时****************
;  void delaym (uint n)
;  {
	.dbline 60
;    uint i=0;
	clr R20
	clr R21
	.dbline 61
;    for (i=0;i<n;i++)
	xjmp L11
L8:
	.dbline 62
	xcall _ys1ms
L9:
	.dbline 61
	subi R20,255  ; offset = 1
	sbci R21,255
L11:
	.dbline 61
	cp R20,R22
	cpc R21,R23
	brlo L8
	.dbline -2
L7:
	xcall pop_gset2
	.dbline 0 ; func end
	ret
	.dbsym r i 20 i
	.dbsym r n 22 i
	.dbend
	.dbfunc e EEPROM_W _EEPROM_W fV
;         eepdat -> R20
;         eepadd -> R22,R23
	.even
_EEPROM_W::
	xcall push_gset2
	mov R20,R18
	movw R22,R16
	.dbline -1
	.dbline 66
;    ys1ms();
;   }   
;  //************写EEPROM*****************   
;    void EEPROM_W(uint eepadd,uchar eepdat)
;    {
	.dbline 67
;     CLI();
	cli
	.dbline 68
;     delaym(3);
	ldi R16,3
	ldi R17,0
	xcall _delaym
	.dbline 69
;     EEAR=eepadd;            //送高地址
	out 0x1f,R23
	out 0x1e,R22
	.dbline 70
; 	EEDR=eepdat;            //送数据
	out 0x1d,R20
	.dbline 71
; 	EECR=EECR|0x04;         //主写使能置位
	sbi 0x1c,2
	.dbline 72
; 	EECR=EECR|0x02;         //写使能置位
	sbi 0x1c,1
	.dbline 73
; 	EECR=0;
	clr R2
	out 0x1c,R2
	.dbline 74
; 	delaym(3);
	ldi R16,3
	ldi R17,0
	xcall _delaym
	.dbline 75
; 	SEI();
	sei
	.dbline -2
L12:
	xcall pop_gset2
	.dbline 0 ; func end
	ret
	.dbsym r eepdat 20 c
	.dbsym r eepadd 22 i
	.dbend
	.dbfunc e timer1_init _timer1_init fV
	.even
_timer1_init::
	.dbline -1
	.dbline 79
;    }
;  //-------------------------------------
;  void timer1_init(void)
;  {
	.dbline 80
;   TIMSK=0x20; //使能T1捕获中断 
	ldi R24,32
	out 0x39,R24
	.dbline 81
;   TCCR1A=0x00;//使能噪声抑制，下降沿触发
	clr R2
	out 0x2f,R2
	.dbline 82
;   TCCR1B=0x82;//T/C1时钟为系统时钟/8；时钟周期1us
	ldi R24,130
	out 0x2e,R24
	.dbline 83
;   SEI();  //总中断
	sei
	.dbline -2
L13:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e t0_start _t0_start fV
	.even
_t0_start::
	.dbline -1
	.dbline 88
;   
;   }
; //==============T0开始========================
;   void  t0_start (void)	 
;   {
	.dbline 89
;    TCNT0=0x00;                  //清空
	clr R2
	out 0x32,R2
	.dbline 90
;    TCCR0=0x05;                  //1024分频
	ldi R24,5
	out 0x33,R24
	.dbline 91
;    TIMSK=(1<<TOIE0)|(1<<TICIE1);//t0溢出中断开
	ldi R24,33
	out 0x39,R24
	.dbline 92
;    SEI(); 
	sei
	.dbline -2
L14:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e rxd_init _rxd_init fV
	.even
_rxd_init::
	.dbline -1
	.dbline 96
;   }  	
;  //=============RXD===========================
;  void rxd_init(void)
;  {
	.dbline 97
;  UCSRB=0x00;//禁止接收和发送
	clr R2
	out 0xa,R2
	.dbline 98
;  UCSRA=0x02;//倍速
	ldi R24,2
	out 0xb,R24
	.dbline 99
;  UCSRC=0x06;//8位数据
	ldi R24,6
	out 0x20,R24
	.dbline 100
;  UBRRL=0x67;
	ldi R24,103
	out 0x9,R24
	.dbline 101
;  UBRRH=0x00;//9600b/s波特率
	out 0x20,R2
	.dbline 102
;  UCSRB=0x18;//开启接收发送
	ldi R24,24
	out 0xa,R24
	.dbline -2
L15:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e send _send fV
;              a -> R16
	.even
_send::
	.dbline -1
	.dbline 106
;  }	
; //=============send一字节=============================
;  void send(uchar a)
;   {
L17:
	.dbline 107
L18:
	.dbline 107
;   while(!(UCSRA&(1<<UDRE)));//UDRE为0说明发送区已清空
	sbis 0xb,5
	rjmp L17
	.dbline 108
;   UDR=a;
	out 0xc,R16
	.dbline -2
L16:
	.dbline 0 ; func end
	ret
	.dbsym r a 16 c
	.dbend
	.dbfunc e send3 _send3 fV
;           subr -> R20
	.even
_send3::
	xcall push_gset1
	mov R20,R16
	.dbline -1
	.dbline 112
;   } 	
; //==============发送3字节代码=========================
; void send3(uchar subr)
;  {LED_1;
	.dbline 112
	sbi 0x12,1
	.dbline 113
;   send(0x55); 
	ldi R16,85
	xcall _send
	.dbline 114
;   delaym(2);
	ldi R16,2
	ldi R17,0
	xcall _delaym
	.dbline 115
;   send(subr);
	mov R16,R20
	xcall _send
	.dbline 116
;   delaym(2);
	ldi R16,2
	ldi R17,0
	xcall _delaym
	.dbline 117
;   send(0x81);
	ldi R16,129
	xcall _send
	.dbline 118
;   delaym(2);
	ldi R16,2
	ldi R17,0
	xcall _delaym
	.dbline 119
;   LED_0;
	cbi 0x12,1
	.dbline -2
L20:
	xcall pop_gset1
	.dbline 0 ; func end
	ret
	.dbsym r subr 20 c
	.dbend
	.dbfunc e delay_us _delay_us fV
;           time -> R16,R17
	.even
_delay_us::
	.dbline -1
	.dbline 124
;   } 
; //----------------------------------  
;   //微秒级延时程序晶振8MHZ
; void delay_us(int time)
; {    
L22:
	.dbline 126
;  do
;   {
	.dbline 127
;    time--;
	subi R16,1
	sbci R17,0
	.dbline 128
;   }    
L23:
	.dbline 129
;  while (time>1);
	ldi R24,1
	ldi R25,0
	cp R24,R16
	cpc R25,R17
	brlt L22
	.dbline -2
L21:
	.dbline 0 ; func end
	ret
	.dbsym r time 16 I
	.dbend
	.dbfunc e delay_ms _delay_ms fV
;           time -> R20,R21
	.even
_delay_ms::
	xcall push_gset1
	movw R20,R16
	.dbline -1
	.dbline 134
; }
; //-----------------------------------      
; //毫秒级延时程序晶振8MHZ 
; void delay_ms(uint time)
; {
	xjmp L27
L26:
	.dbline 136
	.dbline 137
	ldi R16,1000
	ldi R17,3
	xcall _delay_us
	.dbline 138
	subi R20,1
	sbci R21,0
	.dbline 139
L27:
	.dbline 135
;  while(time!=0)
	cpi R20,0
	cpc R20,R21
	brne L26
X1:
	.dbline -2
L25:
	xcall pop_gset1
	.dbline 0 ; func end
	ret
	.dbsym r time 20 i
	.dbend
	.dbfunc e LCD_write_com _LCD_write_com fV
;            com -> R20
	.even
_LCD_write_com::
	xcall push_gset1
	mov R20,R16
	.dbline -1
	.dbline 144
;   {        
;    delay_us(1000);
;    time--;
;   }
; }
; //-------------------------------------
; /*显示屏命令写入函数*/
; void LCD_write_com(uchar com) 
;   {
	.dbline 145
;    RS_0;//低电平命令
	cbi 0x15,0
	.dbline 146
;    RW_0;//低电平写
	cbi 0x15,1
	.dbline 147
;    PORTA = com;
	out 0x1b,R20
	.dbline 149
;    //PORTB = com;
;    EN_1;
	sbi 0x15,2
	.dbline 150
;    delay_us(20);
	ldi R16,20
	ldi R17,0
	xcall _delay_us
	.dbline 151
;    EN_0;//EN由高到低使能
	cbi 0x15,2
	.dbline -2
L29:
	xcall pop_gset1
	.dbline 0 ; func end
	ret
	.dbsym r com 20 c
	.dbend
	.dbfunc e LCD_write_data _LCD_write_data fV
;           data -> R20
	.even
_LCD_write_data::
	xcall push_gset1
	mov R20,R16
	.dbline -1
	.dbline 156
;   }
; //-------------------------------------
; /*显示屏命令写入函数*/
; void LCD_write_data(uchar data) 
;  {
	.dbline 157
;   RS_1;//高电平数据
	sbi 0x15,0
	.dbline 158
;   RW_0;//低电平写
	cbi 0x15,1
	.dbline 159
;   PORTA = data;
	out 0x1b,R20
	.dbline 161
;   //PORTB = data;
;   EN_1;
	sbi 0x15,2
	.dbline 162
;   delay_us(200);
	ldi R16,200
	ldi R17,0
	xcall _delay_us
	.dbline 163
;   EN_0;//EN由高到低使能
	cbi 0x15,2
	.dbline -2
L30:
	xcall pop_gset1
	.dbline 0 ; func end
	ret
	.dbsym r data 20 c
	.dbend
	.dbfunc e LCD_clear _LCD_clear fV
	.even
_LCD_clear::
	.dbline -1
	.dbline 168
; }
; //-----------------------------------
; /*显示屏清空显示*/
; void LCD_clear(void) 
;  {
	.dbline 169
;   LCD_write_com(0x01);//清显示，指令码01H,光标复位到地址00H位置
	ldi R16,1
	xcall _LCD_write_com
	.dbline 170
;   delay_ms(5);
	ldi R16,5
	ldi R17,0
	xcall _delay_ms
	.dbline -2
L31:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e LCD_write_str _LCD_write_str fV
;              s -> R20,R21
;              y -> R10
;              x -> R22
	.even
_LCD_write_str::
	xcall push_gset3
	mov R10,R18
	mov R22,R16
	ldd R20,y+6
	ldd R21,y+7
	.dbline -1
	.dbline 175
;  }
; //----------------------------------
; /*显示屏字符串写入函数*/
; void LCD_write_str(uchar x,uchar y,uchar *s)//x起始位置，y行位置，*s数据 
;  {
	.dbline 176
;   if (y == 0)//1行
	tst R10
	brne L33
	.dbline 177
;   {
	.dbline 178
;    LCD_write_com(0x80 + x);
	mov R16,R22
	subi R16,128    ; addi 128
	xcall _LCD_write_com
	.dbline 179
;   }
	xjmp L36
L33:
	.dbline 181
;   else      //2行
;   {
	.dbline 182
;    LCD_write_com(0xC0 + x);
	mov R16,R22
	subi R16,64    ; addi 192
	xcall _LCD_write_com
	.dbline 183
;   }
	xjmp L36
L35:
	.dbline 186
	.dbline 187
	movw R30,R20
	ldd R16,z+0
	xcall _LCD_write_data
	.dbline 188
	subi R20,255  ; offset = 1
	sbci R21,255
	.dbline 190
L36:
	.dbline 185
;     
;   while (*s)
	movw R30,R20
	ldd R2,z+0
	tst R2
	brne L35
	.dbline -2
L32:
	xcall pop_gset3
	.dbline 0 ; func end
	ret
	.dbsym r s 20 pc
	.dbsym r y 10 c
	.dbsym r x 22 c
	.dbend
	.dbfunc e LCD_write_char _LCD_write_char fV
;           data -> y+4
;              y -> R22
;              x -> R20
	.even
_LCD_write_char::
	xcall push_gset2
	mov R22,R18
	mov R20,R16
	.dbline -1
	.dbline 195
;   {
;    LCD_write_data( *s);
;    s ++;
;    //delay_ms(5);
;   }
; }
; //------------------------------------
; /*显示屏单字符写入函数*/
; void LCD_write_char(uchar x,uchar y,uchar data) //x起始位置，y行位置，data数据
;  {
	.dbline 196
;   if (y == 0)//1行
	tst R22
	brne L39
	.dbline 197
;    {
	.dbline 198
;     LCD_write_com(0x80 + x);
	mov R16,R20
	subi R16,128    ; addi 128
	xcall _LCD_write_com
	.dbline 199
;    }
	xjmp L40
L39:
	.dbline 201
;   else      //2行
;    {
	.dbline 202
;     LCD_write_com(0xC0 + x);
	mov R16,R20
	subi R16,64    ; addi 192
	xcall _LCD_write_com
	.dbline 203
;    }
L40:
	.dbline 205
;     
;     LCD_write_data(data);  
	ldd R16,y+4
	xcall _LCD_write_data
	.dbline -2
L38:
	xcall pop_gset2
	.dbline 0 ; func end
	ret
	.dbsym l data 4 c
	.dbsym r y 22 c
	.dbsym r x 20 c
	.dbend
	.dbfunc e LCD_init _LCD_init fV
	.even
_LCD_init::
	.dbline -1
	.dbline 210
;  }
; //---------------------------------------
; /*显示屏初始化函数*/
; void LCD_init(void) 
;  {
	.dbline 211
;    DDRA = 0xff;                        /*I/O口方向设置*/
	ldi R24,255
	out 0x1a,R24
	.dbline 212
;    DDRC |= (1 << PC0) | (1 << PC1) | (1 << PC2);
	in R24,0x14
	ori R24,7
	out 0x14,R24
	.dbline 214
;    
;    delay_ms(15);
	ldi R16,15
	ldi R17,0
	xcall _delay_ms
	.dbline 215
;    LCD_write_com(0x38);                /*显示模式设置*/
	ldi R16,56
	xcall _LCD_write_com
	.dbline 216
;    delay_ms(5);
	ldi R16,5
	ldi R17,0
	xcall _delay_ms
	.dbline 217
;    LCD_write_com(0x38);
	ldi R16,56
	xcall _LCD_write_com
	.dbline 218
;    delay_ms(5);
	ldi R16,5
	ldi R17,0
	xcall _delay_ms
	.dbline 219
;    LCD_write_com(0x38);
	ldi R16,56
	xcall _LCD_write_com
	.dbline 220
;    delay_ms(5);
	ldi R16,5
	ldi R17,0
	xcall _delay_ms
	.dbline 221
;    LCD_write_com(0x38);                //16*2显示，5*7点阵，8位数据
	ldi R16,56
	xcall _LCD_write_com
	.dbline 223
;     
;    LCD_write_com(0x08);                /*显示关闭*/
	ldi R16,8
	xcall _LCD_write_com
	.dbline 224
;    LCD_write_com(0x01);                /*显示清屏*/
	ldi R16,1
	xcall _LCD_write_com
	.dbline 225
;    LCD_write_com(0x06);                /*显示光标移动设置，读写1字符后光标加1*/
	ldi R16,6
	xcall _LCD_write_com
	.dbline 226
;    LCD_write_com(0x0C);                /*显示开*/
	ldi R16,12
	xcall _LCD_write_com
	.dbline 227
;    delay_ms(5);
	ldi R16,5
	ldi R17,0
	xcall _delay_ms
	.dbline -2
L41:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e main _main fV
;              i -> R20
;              p -> R22,R23
	.even
_main::
	sbiw R28,1
	.dbline -1
	.dbline 232
; }
; 
; //-----------------------------------------
; void main(void) 
; {
	.dbline 235
;  uchar i;
;  uchar *p;
;  delay_ms(50);
	ldi R16,50
	ldi R17,0
	xcall _delay_ms
	.dbline 236
;  port_init();
	xcall _port_init
	.dbline 237
;  delay_ms(50);
	ldi R16,50
	ldi R17,0
	xcall _delay_ms
	.dbline 238
;  timer1_init();     //定时器初始化  
	xcall _timer1_init
	.dbline 239
;  delay_ms(50);
	ldi R16,50
	ldi R17,0
	xcall _delay_ms
	.dbline 240
;  LCD_init();        //LCD初始化
	xcall _LCD_init
	.dbline 241
;  delay_ms(200);
	ldi R16,200
	ldi R17,0
	xcall _delay_ms
	.dbline 242
;  LCD_clear();       //清LCD
	xcall _LCD_clear
	.dbline 243
;  delay_ms(200);
	ldi R16,200
	ldi R17,0
	xcall _delay_ms
	.dbline 245
; //-------------------------------- 
;   {loop:
L43:
	.dbline 246
;    i = 4;
	ldi R20,4
	.dbline 247
;    p = "Welcome";
	ldi R22,<L44
	ldi R23,>L44
	.dbline 249
;    //LCD_write_str(2,1,"I Love You");
;    delay_ms(50);
	ldi R16,50
	ldi R17,0
	xcall _delay_ms
	xjmp L46
L45:
	.dbline 252
	.dbline 253
	movw R30,R22
	ldd R2,z+0
	std y+0,R2
	clr R18
	mov R16,R20
	xcall _LCD_write_char
	.dbline 254
	inc R20
	.dbline 255
	subi R22,255  ; offset = 1
	sbci R23,255
	.dbline 256
	ldi R16,180
	ldi R17,0
	xcall _delay_ms
	.dbline 257
L46:
	.dbline 251
;         
;    while (*p) 
	movw R30,R22
	ldd R2,z+0
	tst R2
	brne L45
	.dbline 259
;     {
;      LCD_write_char(i,0,*p);
;      i ++;
;      p ++;
;      delay_ms(180);
;     }
; 	///////////////
; 	i=2;
	ldi R20,2
	.dbline 260
; 	p="haohandianzi";
	ldi R22,<L48
	ldi R23,>L48
	xjmp L50
L49:
	.dbline 262
	.dbline 263
	movw R30,R22
	ldd R2,z+0
	std y+0,R2
	ldi R18,1
	mov R16,R20
	xcall _LCD_write_char
	.dbline 264
	inc R20
	.dbline 265
	subi R22,255  ; offset = 1
	sbci R23,255
	.dbline 266
	ldi R16,181
	ldi R17,0
	xcall _delay_ms
	.dbline 267
L50:
	.dbline 261
; 	 while (*p) 
	movw R30,R22
	ldd R2,z+0
	tst R2
	brne L49
	.dbline 268
;     {
;      LCD_write_char(i,1,*p);
;      i ++;
;      p ++;
;      delay_ms(181);
;     }
;    delay_ms(500);
	ldi R16,500
	ldi R17,1
	xcall _delay_ms
	.dbline 269
;    llbit=0;
	clr R2
	sts _llbit,R2
	.dbline 271
;    //LED_0;
;   }
	.dbline -2
L42:
	adiw R28,1
	.dbline 0 ; func end
	ret
	.dbsym r i 20 c
	.dbsym r p 22 pc
	.dbend
	.area vector(rom, abs)
	.org 20
	jmp _timer1_in
	.area text(rom, con, rel)
	.dbfile F:\AVR例子程序\1602DI~1\DIV.c
	.area bss(ram, con, rel)
	.dbfile F:\AVR例子程序\1602DI~1\DIV.c
L53:
	.blkb 2
	.area text(rom, con, rel)
	.dbfile F:\AVR例子程序\1602DI~1\DIV.c
	.dbfunc e timer1_in _timer1_in fV
	.dbsym s old_data L53 i
;          temp0 -> R16,R17
;       new_data -> R16,R17
;           temp -> R18,R19
	.even
_timer1_in::
	st -y,R2
	st -y,R3
	st -y,R16
	st -y,R17
	st -y,R18
	st -y,R19
	st -y,R24
	st -y,R25
	st -y,R30
	in R2,0x3f
	st -y,R2
	.dbline -1
	.dbline 365
;  /*/-------------------------------------
;  while(1)
;  {
;   if(irsign==1)
;    {
;     irsign=0;
; 	//----------------------------------
; 	if(data2==0x58)
; 	 {
;      LCD_clear();
;      LCD_write_str(6,0,"REDAY!");//空格6，1行
;      delay_ms(50);
;      LCD_write_str(6,1,"RESET");//空格5，2行
;      delay_ms(800);
; 	 LCD_clear();
; 	 goto loop;
; 	 }
;      //--------------------------------------
; 	 else if((data2==0xd8)&&(llbit==0))
; 	  {
; 	   LCD_clear();
; 	   llbit=1;
; 	   LED_1;
; 	   LCD_write_str(1,0,"background lamp");
; 	   delay_ms(50);
; 	   LCD_write_str(6,1,"ON");
; 	   delay_ms(50);
; 	  }
; 	 else if((data2==0xd8)&&(llbit==1))
; 	  {
; 	   LCD_clear();
; 	   llbit=0;
; 	   LED_0;
; 	   LCD_write_str(1,0,"background lamp");
; 	   delay_ms(50);
; 	   LCD_write_str(6,1,"OFF");
; 	   delay_ms(50);
; 	  } 
; 	//----------------------------------
; 	if(data2==0x70)
; 	 {
; 	  LCD_clear();
;       LCD_write_str(2,0,"This code is");
; 	  delay_ms(50);
; 	  LCD_write_str(6,1,"0x70");
; 	 } 
;     //----------------------------------
; 	if(data2==0xf0)
; 	 {
; 	  LCD_clear();
;       LCD_write_str(2,0,"This code is");
; 	  delay_ms(50);
; 	  LCD_write_str(6,1,"0xf0");
; 	 }     
; 	//----------------------------------
; 	if(data2==0x48)
; 	 {
; 	  LCD_clear();
;       LCD_write_str(2,0,"This code is");
; 	  delay_ms(50);
; 	  LCD_write_str(6,1,"0x48");
; 	 }   
; 	//----------------------------------
; 	if(data2==0xc8)
; 	 {
; 	  LCD_clear();
;       LCD_write_str(2,0,"This code is");
; 	  delay_ms(50);
; 	  LCD_write_str(6,1,"0xc8");
; 	 } 
; 	//----------------------------------
; 	if(data2==0x68)
; 	 {
; 	  LCD_clear();
;       LCD_write_str(2,0,"This code is");
; 	  delay_ms(50);
; 	  LCD_write_str(6,1,"0x68");
; 	 }
;    //----------------------------------
; 	if(data2==0xe8)
; 	 {
; 	  LCD_clear();
;       LCD_write_str(2,0,"This code is");
; 	  delay_ms(50);
; 	  LCD_write_str(6,1,"0xe8");
; 	 }     	                    
;     }
;   } */	
; }
;  
; //--------------中断----------------------
; #pragma interrupt_handler timer1_in:6
;  void timer1_in(void)
;  {
	.dbline 368
;   static uint old_data;
;    uint temp,temp0,new_data;//定义变量
;    new_data=ICR1;           //读值
	in R16,0x26
	in R17,0x27
	.dbline 369
;    temp=new_data-old_data;  //当次脉宽
	lds R2,L53
	lds R3,L53+1
	movw R18,R16
	sub R18,R2
	sbc R19,R3
	.dbline 370
;    old_data=new_data;       //底数保存
	sts L53+1,R17
	sts L53,R16
	.dbline 372
;    
;   if(temp>1024&&temp<1225)     //0
	ldi R24,1024
	ldi R25,4
	cp R24,R18
	cpc R25,R19
	brsh L54
	cpi R18,201
	ldi R30,4
	cpc R19,R30
	brsh L54
	.dbline 373
;    {temp0=0;}
	.dbline 373
	clr R16
	clr R17
	.dbline 373
	xjmp L55
L54:
	.dbline 374
;   else if(temp>2145&&temp<2345)//1
	ldi R24,2145
	ldi R25,8
	cp R24,R18
	cpc R25,R19
	brsh L56
	cpi R18,41
	ldi R30,9
	cpc R19,R30
	brsh L56
	.dbline 375
;    {temp0=1;}
	.dbline 375
	ldi R16,1
	ldi R17,0
	.dbline 375
	xjmp L57
L56:
	.dbline 376
;   else if(temp>11150&&temp<11350)//连发
	ldi R24,11150
	ldi R25,43
	cp R24,R18
	cpc R25,R19
	brsh L58
	cpi R18,86
	ldi R30,44
	cpc R19,R30
	brsh L58
	.dbline 377
;    {unin=1;   //连发码标志置位
	.dbline 377
	ldi R24,1
	sts _unin,R24
	.dbline 378
;     bitnum=0; //位数
	clr R2
	sts _bitnum,R2
	.dbline 379
;     data0=0;  //1字节数据					  
	sts _data0,R2
	.dbline 380
;     data1=0;  //2字节数据
	sts _data1,R2
	.dbline 381
;     data2=0;  //3字节数据
	sts _data2,R2
	.dbline 382
;     data3=0;  //4字节数据
	sts _data3,R2
	.dbline 383
;     return;   //为uninterrupted返回待下次接收
	xjmp L52
L58:
	.dbline 385
;    }
;   else if(temp>13400&&temp<13600)//引导
	ldi R24,13400
	ldi R25,52
	cp R24,R18
	cpc R25,R19
	brlo X3
	xjmp L52
X3:
	cpi R18,32
	ldi R30,53
	cpc R19,R30
	brlo X4
	xjmp L52
X4:
	.dbline 386
;   {
	.dbline 387
;    head=1;   //引导码标志置位
	ldi R24,1
	sts _head,R24
	.dbline 388
;    bitnum=0; //位数
	clr R2
	sts _bitnum,R2
	.dbline 389
;    data0=0;  //1字节数据					  
	sts _data0,R2
	.dbline 390
;    data1=0;  //2字节数据
	sts _data1,R2
	.dbline 391
;    data2=0;  //3字节数据
	sts _data2,R2
	.dbline 392
;    data3=0;  //4字节数据
	sts _data3,R2
	.dbline 393
;    return;   //为header返回待下次接收
	xjmp L52
X2:
	.dbline 396
;   }
;   else 
;   return;    //不符合以上，为干扰脉冲，放弃返回接收
L57:
L55:
	.dbline 398
;   
;   bitnum++;  //为0或1时位数递加
	lds R24,_bitnum
	subi R24,255    ; addi 1
	sts _bitnum,R24
	.dbline 399
;  if(bitnum<8)//小于8位时放入1
	cpi R24,8
	brsh L62
	.dbline 400
;  {data0=data0|(uint)temp0;
	.dbline 400
	lds R2,_data0
	clr R3
	or R2,R16
	or R3,R17
	sts _data0,R2
	.dbline 401
;   data0=data0<<1;}   //左移
	lsl R2
	sts _data0,R2
	.dbline 401
	xjmp L63
L62:
	.dbline 402
;   else if(bitnum==8) //等于8时，最后一位放入1字节
	lds R24,_bitnum
	cpi R24,8
	brne L64
	.dbline 403
;   {data0=data0|(uint)temp0;}
	.dbline 403
	lds R2,_data0
	clr R3
	or R2,R16
	or R3,R17
	sts _data0,R2
	.dbline 403
	xjmp L65
L64:
	.dbline 404
;   else if(bitnum<16) //小于16位时放入2字节
	lds R24,_bitnum
	cpi R24,16
	brsh L66
	.dbline 405
;   {data1=data1|(uint)temp0;
	.dbline 405
	lds R2,_data1
	clr R3
	or R2,R16
	or R3,R17
	sts _data1,R2
	.dbline 406
;    data1=data1<<1;}
	lsl R2
	sts _data1,R2
	.dbline 406
	xjmp L67
L66:
	.dbline 407
;   else if(bitnum==16)//等于16时，最后一位放入2字节
	lds R24,_bitnum
	cpi R24,16
	brne L68
	.dbline 408
;   {data1=data1|(uint)temp0;}
	.dbline 408
	lds R2,_data1
	clr R3
	or R2,R16
	or R3,R17
	sts _data1,R2
	.dbline 408
	xjmp L69
L68:
	.dbline 410
;   
;   else if(bitnum<24) //小于16位时放入3字节
	lds R24,_bitnum
	cpi R24,24
	brsh L70
	.dbline 411
;   {data2=data2|(uint)temp0;
	.dbline 411
	lds R2,_data2
	clr R3
	or R2,R16
	or R3,R17
	sts _data2,R2
	.dbline 412
;    data2=data2<<1;}
	lsl R2
	sts _data2,R2
	.dbline 412
	xjmp L71
L70:
	.dbline 413
;   else if(bitnum==24)//等于16时，最后一位放入3字节
	lds R24,_bitnum
	cpi R24,24
	brne L72
	.dbline 414
;   {data2=data2|(uint)temp0;}
	.dbline 414
	lds R2,_data2
	clr R3
	or R2,R16
	or R3,R17
	sts _data2,R2
	.dbline 414
	xjmp L73
L72:
	.dbline 416
;   
;    else if(bitnum<32)//小于32位时放入4字节
	lds R24,_bitnum
	cpi R24,32
	brsh L74
	.dbline 417
;   {data3=data3|(uint)temp0;
	.dbline 417
	lds R2,_data3
	clr R3
	or R2,R16
	or R3,R17
	sts _data3,R2
	.dbline 418
;    data3=data3<<1;}
	lsl R2
	sts _data3,R2
	.dbline 418
	xjmp L75
L74:
	.dbline 420
;    
;   else if(bitnum==32)//等于32时，最后一位放入4字节
	lds R24,_bitnum
	cpi R24,32
	brne L76
	.dbline 421
;   {data3=data3|(uint)temp0;
	.dbline 421
	lds R2,_data3
	clr R3
	or R2,R16
	or R3,R17
	sts _data3,R2
	.dbline 422
;    bitnum=0;        //位数清0
	clr R2
	sts _bitnum,R2
	.dbline 423
;    irsign=1;        //IR完成标志位置位
	ldi R24,1
	sts _irsign,R24
	.dbline 424
;    CLI();           //总中断暂关
	cli
	.dbline 425
;    } 
L76:
L75:
L73:
L71:
L69:
L67:
L65:
L63:
	.dbline -2
L52:
	ld R2,y+
	out 0x3f,R2
	ld R30,y+
	ld R25,y+
	ld R24,y+
	ld R19,y+
	ld R18,y+
	ld R17,y+
	ld R16,y+
	ld R3,y+
	ld R2,y+
	.dbline 0 ; func end
	reti
	.dbsym r temp0 16 i
	.dbsym r new_data 16 i
	.dbsym r temp 18 i
	.dbend
	.area vector(rom, abs)
	.org 4
	jmp _int0
	.area text(rom, con, rel)
	.dbfile F:\AVR例子程序\1602DI~1\DIV.c
	.dbfunc e int0 _int0 fV
	.even
_int0::
	.dbline -1
	.dbline 431
;  }        
; ///////////////////////////////////////////////////////
;  //-------------其它中断处理---------------------
;  #pragma  interrupt_handler int0:2 //外部中断0
;  void  int0 (void)		
;    {return;}	
	.dbline 431
	.dbline -2
L78:
	.dbline 0 ; func end
	reti
	.dbend
	.area vector(rom, abs)
	.org 8
	jmp _int1
	.area text(rom, con, rel)
	.dbfile F:\AVR例子程序\1602DI~1\DIV.c
	.dbfunc e int1 _int1 fV
	.even
_int1::
	.dbline -1
	.dbline 435
;  //------------------------------------------
;  #pragma  interrupt_handler int1:3 //外部中断1
;  void  int1 (void)		
;    {return;
	.dbline 435
	.dbline -2
L79:
	.dbline 0 ; func end
	reti
	.dbend
	.area vector(rom, abs)
	.org 12
	jmp _t2_comp
	.area text(rom, con, rel)
	.dbfile F:\AVR例子程序\1602DI~1\DIV.c
	.dbfunc e t2_comp _t2_comp fV
	.even
_t2_comp::
	.dbline -1
	.dbline 440
;    }
;  //------------------------------------------	
;  #pragma  interrupt_handler t2_comp:4  //定时器2比较
;  void  t2_comp (void)		
;    {return; }	
	.dbline 440
	.dbline -2
L80:
	.dbline 0 ; func end
	reti
	.dbend
	.area vector(rom, abs)
	.org 16
	jmp _t2_ovf
	.area text(rom, con, rel)
	.dbfile F:\AVR例子程序\1602DI~1\DIV.c
	.dbfunc e t2_ovf _t2_ovf fV
	.even
_t2_ovf::
	.dbline -1
	.dbline 444
;  //------------------------------------------
;  #pragma  interrupt_handler t2_ovf:5  //定时器2溢出
;  void  t2_ovf (void)		
;    {return;}	   
	.dbline 444
	.dbline -2
L81:
	.dbline 0 ; func end
	reti
	.dbend
	.area vector(rom, abs)
	.org 24
	jmp _t1_compa
	.area text(rom, con, rel)
	.dbfile F:\AVR例子程序\1602DI~1\DIV.c
	.dbfunc e t1_compa _t1_compa fV
	.even
_t1_compa::
	.dbline -1
	.dbline 448
;  //------------------------------------------
;  #pragma  interrupt_handler t1_compa:7  //定时器1比较a
;  void  t1_compa (void)		
;    {return;    
	.dbline 448
	.dbline -2
L82:
	.dbline 0 ; func end
	reti
	.dbend
	.area vector(rom, abs)
	.org 28
	jmp _t1_compb
	.area text(rom, con, rel)
	.dbfile F:\AVR例子程序\1602DI~1\DIV.c
	.dbfunc e t1_compb _t1_compb fV
	.even
_t1_compb::
	.dbline -1
	.dbline 453
;    }	
;  //------------------------------------------  
;  #pragma  interrupt_handler t1_compb:8  //定时器1比较b
;  void  t1_compb (void)		
;    {return;    
	.dbline 453
	.dbline -2
L83:
	.dbline 0 ; func end
	reti
	.dbend
	.area vector(rom, abs)
	.org 32
	jmp _t1_ovf
	.area text(rom, con, rel)
	.dbfile F:\AVR例子程序\1602DI~1\DIV.c
	.dbfunc e t1_ovf _t1_ovf fV
	.even
_t1_ovf::
	.dbline -1
	.dbline 458
;    }	
;  //------------------------------------------
;  #pragma  interrupt_handler t1_ovf:9   //定时器1溢出
;  void  t1_ovf (void)		
;    {
	.dbline 459
;     return;
	.dbline -2
L84:
	.dbline 0 ; func end
	reti
	.dbend
	.area vector(rom, abs)
	.org 36
	jmp _t0_ovf
	.area text(rom, con, rel)
	.dbfile F:\AVR例子程序\1602DI~1\DIV.c
	.dbfunc e t0_ovf _t0_ovf fV
	.even
_t0_ovf::
	.dbline -1
	.dbline 464
;    }	  
;  //------------------------------------------
;  #pragma  interrupt_handler t0_ovf:10  //定时器0溢出用于自动清OSD
;  void  t0_ovf (void)		
;    {return;}
	.dbline 464
	.dbline -2
L85:
	.dbline 0 ; func end
	reti
	.dbend
	.area vector(rom, abs)
	.org 40
	jmp _spi_end
	.area text(rom, con, rel)
	.dbfile F:\AVR例子程序\1602DI~1\DIV.c
	.dbfunc e spi_end _spi_end fV
	.even
_spi_end::
	.dbline -1
	.dbline 468
;  //------------------------------------------
;  #pragma  interrupt_handler spi_end:11  //SPI结束
;  void  spi_end (void)		
;    {return;}	  
	.dbline 468
	.dbline -2
L86:
	.dbline 0 ; func end
	reti
	.dbend
	.area vector(rom, abs)
	.org 44
	jmp _rx_end
	.area text(rom, con, rel)
	.dbfile F:\AVR例子程序\1602DI~1\DIV.c
	.dbfunc e rx_end _rx_end fV
	.even
_rx_end::
	.dbline -1
	.dbline 472
;  //------------------------------------------
;  #pragma  interrupt_handler rx_end:12  //rx结束
;  void  rx_end (void)		
;    {return;    
	.dbline 472
	.dbline -2
L87:
	.dbline 0 ; func end
	reti
	.dbend
	.area vector(rom, abs)
	.org 48
	jmp _usart_nop
	.area text(rom, con, rel)
	.dbfile F:\AVR例子程序\1602DI~1\DIV.c
	.dbfunc e usart_nop _usart_nop fV
	.even
_usart_nop::
	.dbline -1
	.dbline 477
;    }	  
;  //------------------------------------------
;  #pragma  interrupt_handler usart_nop:13  //USART空
;  void  usart_nop (void)		
;    { return;   
	.dbline 477
	.dbline -2
L88:
	.dbline 0 ; func end
	reti
	.dbend
	.area vector(rom, abs)
	.org 52
	jmp _tx_end
	.area text(rom, con, rel)
	.dbfile F:\AVR例子程序\1602DI~1\DIV.c
	.dbfunc e tx_end _tx_end fV
	.even
_tx_end::
	.dbline -1
	.dbline 482
;    }	 
;  //------------------------------------------
;  #pragma  interrupt_handler tx_end:14   //tx结束
;  void  tx_end (void)		
;    {return;    
	.dbline 482
	.dbline -2
L89:
	.dbline 0 ; func end
	reti
	.dbend
	.area vector(rom, abs)
	.org 56
	jmp _adc_end
	.area text(rom, con, rel)
	.dbfile F:\AVR例子程序\1602DI~1\DIV.c
	.dbfunc e adc_end _adc_end fV
	.even
_adc_end::
	.dbline -1
	.dbline 487
;    }	  
; //------------------------------------------
;  #pragma  interrupt_handler adc_end:15  //adv结束
;  void  adc_end (void)		
;    { return;   
	.dbline 487
	.dbline -2
L90:
	.dbline 0 ; func end
	reti
	.dbend
	.area vector(rom, abs)
	.org 60
	jmp _eep_rdy
	.area text(rom, con, rel)
	.dbfile F:\AVR例子程序\1602DI~1\DIV.c
	.dbfunc e eep_rdy _eep_rdy fV
	.even
_eep_rdy::
	.dbline -1
	.dbline 492
;    }	   
; //------------------------------------------
;  #pragma  interrupt_handler eep_rdy:16  //eeprom就绪
;  void  eep_rdy (void)		
;    { return;   
	.dbline 492
	.dbline -2
L91:
	.dbline 0 ; func end
	reti
	.dbend
	.area vector(rom, abs)
	.org 64
	jmp _ana_comp
	.area text(rom, con, rel)
	.dbfile F:\AVR例子程序\1602DI~1\DIV.c
	.dbfunc e ana_comp _ana_comp fV
	.even
_ana_comp::
	.dbline -1
	.dbline 497
;    }	
; //------------------------------------------
;  #pragma  interrupt_handler ana_comp:17  //模拟比较器
;  void  ana_comp (void)		
;    { return;   
	.dbline 497
	.dbline -2
L92:
	.dbline 0 ; func end
	reti
	.dbend
	.area vector(rom, abs)
	.org 68
	jmp _twi
	.area text(rom, con, rel)
	.dbfile F:\AVR例子程序\1602DI~1\DIV.c
	.dbfunc e twi _twi fV
	.even
_twi::
	.dbline -1
	.dbline 502
;    }	  
; //------------------------------------------
;  #pragma  interrupt_handler twi:18       //iic
;  void  twi (void)		
;    {  return;  
	.dbline 502
	.dbline -2
L93:
	.dbline 0 ; func end
	reti
	.dbend
	.area vector(rom, abs)
	.org 72
	jmp _spm_rdy
	.area text(rom, con, rel)
	.dbfile F:\AVR例子程序\1602DI~1\DIV.c
	.dbfunc e spm_rdy _spm_rdy fV
	.even
_spm_rdy::
	.dbline -1
	.dbline 507
;    }	  
;  //------------------------------------------
;  #pragma  interrupt_handler spm_rdy:19   //程序储存就绪
;  void  spm_rdy (void)		
;    {  return;  
	.dbline 507
	.dbline -2
L94:
	.dbline 0 ; func end
	reti
	.dbend
	.area bss(ram, con, rel)
	.dbfile F:\AVR例子程序\1602DI~1\DIV.c
_data3::
	.blkb 1
	.dbsym e data3 _data3 c
_data2::
	.blkb 1
	.dbsym e data2 _data2 c
_data1::
	.blkb 1
	.dbsym e data1 _data1 c
_data0::
	.blkb 1
	.dbsym e data0 _data0 c
_bitnum::
	.blkb 1
	.dbsym e bitnum _bitnum c
_head::
	.blkb 1
	.dbsym e head _head c
_unin::
	.blkb 1
	.dbsym e unin _unin c
_j::
	.blkb 1
	.dbsym e j _j c
_i::
	.blkb 1
	.dbsym e i _i c
	.area data(ram, con, rel)
	.dbfile F:\AVR例子程序\1602DI~1\DIV.c
L48:
	.blkb 13
	.area idata
	.byte 'h,'a,'o,'h,'a,'n,'d,'i,'a,'n,'z,'i,0
	.area data(ram, con, rel)
	.dbfile F:\AVR例子程序\1602DI~1\DIV.c
L44:
	.blkb 8
	.area idata
	.byte 'W,'e,'l,'c,'o,'m,'e,0
	.area data(ram, con, rel)
	.dbfile F:\AVR例子程序\1602DI~1\DIV.c
