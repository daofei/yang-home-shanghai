	.module ac15-2.c
	.area lit(rom, con, rel)
_str0::
	.byte 45,'T,'i,'m,'e,32,32,32,58,32,32,58,32,32,45,45
	.byte 0
	.dbfile d:\MYDOCU~1\ac15-2\ac15-2.c
	.dbsym e str0 _str0 A[17:17]kc
_str1::
	.byte 45,'A,'T,'i,'m,'e,32,32,32,58,32,32,58,32,45,45
	.byte 0
	.dbsym e str1 _str1 A[17:17]kc
	.area text(rom, con, rel)
	.dbfile d:\MYDOCU~1\ac15-2\ac15-2.c
	.dbfunc e ePutstr _ePutstr fV
;              l -> R20
;              i -> R22
;            ptr -> R10,R11
;              y -> R12
;              x -> R14
	.even
_ePutstr::
	xcall push_gset5
	mov R12,R18
	mov R14,R16
	sbiw R28,1
	ldd R10,y+11
	ldd R11,y+12
	.dbline -1
	.dbline 43
; #include <iom16v.h>			
; #include <macros.h>
; //-----------------------------------------------
; #define uchar unsigned char	
; #define uint unsigned int
; //-------------------引脚电平的宏定义---------
; #define LCM_RS_1 PORTB|=BIT(PB0)	
; #define LCM_RS_0 PORTB&=~BIT(PB0) 
; #define LCM_RW_1 PORTB|=BIT(PB1)	
; #define LCM_RW_0 PORTB&=~BIT(PB1) 
; #define LCM_EN_1 PORTB|=BIT(PB2)	
; #define LCM_EN_0 PORTB&=~BIT(PB2)  
; #define SCL_1 PORTC|=BIT(PC0)
; #define SCL_0 PORTC&=~BIT(PC0)
; #define SDA_1 PORTC|=BIT(PC1)
; #define SDA_0 PORTC&=~BIT(PC1)
; #define LED_1 PORTB|=BIT(PB7)
; #define LED_0 PORTB&=~BIT(PB7)
; //======================================
; #define PIN_SDA (PINC&0x02)
; #define DataPort PORTA		
; #define Busy 0x80			
; #define xtal 8   			
; #define Some_NOP();  _NOP();_NOP();_NOP();_NOP();_NOP();_NOP();_NOP();_NOP();
; //======================================
; const uchar str0[]={"-Time   :  :  --"};//待显字符串
; const uchar str1[]={"-ATime   :  : --"};//待显字符串
; //========函数声明=========
; void Delay_1ms(void);
; void Delay_nms(uint n);
; void WaitForEnable(void);
; void LcdWriteData(uchar W);
; void LcdWriteCommand(uchar CMD,uchar Attribc);
; void InitLcd(void);
; void Display(uchar dd);
; void DisplayOneChar(uchar x,uchar y,uchar Wdata);
; void ePutstr(uchar x,uchar y,uchar const *ptr);
; void port_init(void);
; void init_devices(void);
; void timer1_init(void);
; //**********************显示指定座标的一串字符子函数**************
; void ePutstr(uchar x,uchar y,uchar const *ptr)
; {
	.dbline 44
; uchar i,l=0;
	clr R20
	xjmp L3
L2:
	.dbline 45
	.dbline 45
	inc R20
	.dbline 45
L3:
	.dbline 45
; 	while(ptr[l]>31){l++;}
	mov R30,R20
	clr R31
	add R30,R10
	adc R31,R11
	lpm R30,Z
	ldi R24,31
	cp R24,R30
	brlo L2
	.dbline 46
	clr R22
	xjmp L8
L5:
	.dbline 46
; 	for(i=0;i<l;i++){
	.dbline 47
; 	DisplayOneChar(x++,y,ptr[i]);
	mov R30,R22
	clr R31
	add R30,R10
	adc R31,R11
	lpm R30,Z
	std y+0,R30
	mov R18,R12
	mov R2,R14
	mov R24,R2
	subi R24,255    ; addi 1
	mov R14,R24
	mov R16,R2
	xcall _DisplayOneChar
	.dbline 48
; 	if(x==16){
	mov R24,R14
	cpi R24,16
	brne L9
	.dbline 48
	.dbline 49
; 		x=0;y^=1;
	clr R14
	.dbline 49
	ldi R24,1
	eor R12,R24
	.dbline 50
; 	}
L9:
	.dbline 51
L6:
	.dbline 46
	inc R22
L8:
	.dbline 46
	cp R22,R20
	brlo L5
	.dbline -2
L1:
	adiw R28,1
	xcall pop_gset5
	.dbline 0 ; func end
	ret
	.dbsym r l 20 c
	.dbsym r i 22 c
	.dbsym r ptr 10 pkc
	.dbsym r y 12 c
	.dbsym r x 14 c
	.dbend
	.dbfunc e LocateXY _LocateXY fV
;           temp -> R20
;           posy -> R22
;           posx -> R10
	.even
_LocateXY::
	xcall push_gset3
	mov R22,R18
	mov R10,R16
	.dbline -1
	.dbline 55
;   }
; }
; //*******************显示光标定位子函数******************
; void LocateXY(char posx,char posy)
; {
	.dbline 57
; uchar temp;
; 	temp&=0x7f;
	andi R20,127
	.dbline 58
; 	temp=posx&0x0f;
	mov R20,R10
	andi R20,15
	.dbline 59
; 	posy&=0x01;
	andi R22,1
	.dbline 60
; 	if(posy)temp|=0x40;
	breq L12
	.dbline 60
	ori R20,64
L12:
	.dbline 61
; 	temp|=0x80;
	ori R20,128
	.dbline 62
; 	LcdWriteCommand(temp,0);
	clr R18
	mov R16,R20
	xcall _LcdWriteCommand
	.dbline -2
L11:
	xcall pop_gset3
	.dbline 0 ; func end
	ret
	.dbsym r temp 20 c
	.dbsym r posy 22 c
	.dbsym r posx 10 c
	.dbend
	.dbfunc e DisplayOneChar _DisplayOneChar fV
;          Wdata -> y+4
;              y -> R22
;              x -> R20
	.even
_DisplayOneChar::
	xcall push_gset2
	mov R22,R18
	mov R20,R16
	.dbline -1
	.dbline 66
; }
; //*******************显示指定座标的一个字符子函数*******************
; void DisplayOneChar(uchar x,uchar y,uchar Wdata)
; {
	.dbline 67
; LocateXY(x,y);
	mov R18,R22
	mov R16,R20
	xcall _LocateXY
	.dbline 68
; LcdWriteData(Wdata);
	ldd R16,y+4
	xcall _LcdWriteData
	.dbline -2
L14:
	xcall pop_gset2
	.dbline 0 ; func end
	ret
	.dbsym l Wdata 4 c
	.dbsym r y 22 c
	.dbsym r x 20 c
	.dbend
	.dbfunc e InitLcd _InitLcd fV
	.even
_InitLcd::
	.dbline -1
	.dbline 72
; }
; //*******************LCD初始化子函数*********************
; void InitLcd(void) 
; {
	.dbline 73
; LcdWriteCommand(0x38,0); 
	clr R18
	ldi R16,56
	xcall _LcdWriteCommand
	.dbline 74
; Delay_nms(5);
	ldi R16,5
	ldi R17,0
	xcall _Delay_nms
	.dbline 75
; LcdWriteCommand(0x38,0); 
	clr R18
	ldi R16,56
	xcall _LcdWriteCommand
	.dbline 76
; Delay_nms(5);
	ldi R16,5
	ldi R17,0
	xcall _Delay_nms
	.dbline 77
; LcdWriteCommand(0x38,0); 
	clr R18
	ldi R16,56
	xcall _LcdWriteCommand
	.dbline 78
; Delay_nms(5);
	ldi R16,5
	ldi R17,0
	xcall _Delay_nms
	.dbline 79
; LcdWriteCommand(0x38,1); 
	ldi R18,1
	ldi R16,56
	xcall _LcdWriteCommand
	.dbline 80
; LcdWriteCommand(0x08,1); 
	ldi R18,1
	ldi R16,8
	xcall _LcdWriteCommand
	.dbline 81
; LcdWriteCommand(0x01,1); 
	ldi R18,1
	ldi R16,1
	xcall _LcdWriteCommand
	.dbline 82
; LcdWriteCommand(0x06,1);
	ldi R18,1
	ldi R16,6
	xcall _LcdWriteCommand
	.dbline 83
; LcdWriteCommand(0x0c,1);
	ldi R18,1
	ldi R16,12
	xcall _LcdWriteCommand
	.dbline -2
L15:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e LcdWriteCommand _LcdWriteCommand fV
;        Attribc -> R22
;            CMD -> R20
	.even
_LcdWriteCommand::
	xcall push_gset2
	mov R22,R18
	mov R20,R16
	.dbline -1
	.dbline 87
; }
; //********************写命令到LCM子函数********************
; void LcdWriteCommand(uchar CMD,uchar Attribc)
; {
	.dbline 88
; if(Attribc)WaitForEnable();
	tst R22
	breq L17
	.dbline 88
	xcall _WaitForEnable
L17:
	.dbline 89
; LCM_RS_0;LCM_RW_0;_NOP();
	cbi 0x18,0
	.dbline 89
	cbi 0x18,1
	.dbline 89
	nop
	.dbline 90
; DataPort=CMD;_NOP();
	out 0x1b,R20
	.dbline 90
	nop
	.dbline 91
; LCM_EN_1;_NOP();_NOP();LCM_EN_0;
	sbi 0x18,2
	.dbline 91
	nop
	.dbline 91
	nop
	.dbline 91
	cbi 0x18,2
	.dbline -2
L16:
	xcall pop_gset2
	.dbline 0 ; func end
	ret
	.dbsym r Attribc 22 c
	.dbsym r CMD 20 c
	.dbend
	.dbfunc e LcdWriteData _LcdWriteData fV
;          dataW -> R20
	.even
_LcdWriteData::
	xcall push_gset1
	mov R20,R16
	.dbline -1
	.dbline 95
; }
; //*******************写数据到LCM子函数********************
; void LcdWriteData(uchar dataW)
; {
	.dbline 96
; WaitForEnable();
	xcall _WaitForEnable
	.dbline 97
; LCM_RS_1;LCM_RW_0;_NOP();
	sbi 0x18,0
	.dbline 97
	cbi 0x18,1
	.dbline 97
	nop
	.dbline 98
; DataPort=dataW;_NOP();
	out 0x1b,R20
	.dbline 98
	nop
	.dbline 99
; LCM_EN_1;_NOP();_NOP();LCM_EN_0;
	sbi 0x18,2
	.dbline 99
	nop
	.dbline 99
	nop
	.dbline 99
	cbi 0x18,2
	.dbline -2
L19:
	xcall pop_gset1
	.dbline 0 ; func end
	ret
	.dbsym r dataW 20 c
	.dbend
	.dbfunc e WaitForEnable _WaitForEnable fV
;            val -> R16
	.even
_WaitForEnable::
	.dbline -1
	.dbline 103
; }
; //*******************检测LCD忙信号子函数*********************
; void WaitForEnable(void)
; {
	.dbline 105
; uchar val;
; DataPort=0xff;
	ldi R24,255
	out 0x1b,R24
	.dbline 106
; LCM_RS_0;LCM_RW_1;_NOP();
	cbi 0x18,0
	.dbline 106
	sbi 0x18,1
	.dbline 106
	nop
	.dbline 107
; LCM_EN_1;_NOP();_NOP();
	sbi 0x18,2
	.dbline 107
	nop
	.dbline 107
	nop
	.dbline 108
; DDRA=0x00;
	clr R2
	out 0x1a,R2
	.dbline 109
; val=PINA;
	in R16,0x19
	xjmp L22
L21:
	.dbline 110
	in R16,0x19
L22:
	.dbline 110
; while(val&Busy)val=PINA;
	sbrc R16,7
	rjmp L21
	.dbline 111
; LCM_EN_0;
	cbi 0x18,2
	.dbline 112
; DDRA=0xff;
	ldi R24,255
	out 0x1a,R24
	.dbline -2
L20:
	.dbline 0 ; func end
	ret
	.dbsym r val 16 c
	.dbend
	.dbfunc e Delay_1ms _Delay_1ms fV
;              i -> R16,R17
	.even
_Delay_1ms::
	.dbline -1
	.dbline 116
; }
; //****************************************
; void Delay_1ms(void)		//1mS延时子函数
; { uint i;
	.dbline 117
;  for(i=1;i<(uint)(xtal*143-2);i++)
	ldi R16,1
	ldi R17,0
	xjmp L28
L25:
	.dbline 118
L26:
	.dbline 117
	subi R16,255  ; offset = 1
	sbci R17,255
L28:
	.dbline 117
	cpi R16,118
	ldi R30,4
	cpc R17,R30
	brlo L25
	.dbline -2
L24:
	.dbline 0 ; func end
	ret
	.dbsym r i 16 i
	.dbend
	.dbfunc e Delay_nms _Delay_nms fV
;              i -> R20,R21
;              n -> R22,R23
	.even
_Delay_nms::
	xcall push_gset2
	movw R22,R16
	.dbline -1
	.dbline 122
;     ;
; }
; //====================================
; void Delay_nms(uint n)		//n*1mS延时子函数
; {
	.dbline 123
;  uint i=0;
	clr R20
	clr R21
	xjmp L31
L30:
	.dbline 125
	.dbline 125
	xcall _Delay_1ms
	.dbline 126
	subi R20,255  ; offset = 1
	sbci R21,255
	.dbline 127
L31:
	.dbline 124
;    while(i<n)
	cp R20,R22
	cpc R21,R23
	brlo L30
	.dbline -2
L29:
	xcall pop_gset2
	.dbline 0 ; func end
	ret
	.dbsym r i 20 i
	.dbsym r n 22 i
	.dbend
	.dbfunc e port_init _port_init fV
	.even
_port_init::
	.dbline -1
	.dbline 140
;    {Delay_1ms();
;     i++;
;    }
; }
; /*******************定义结构体变量time1,time2*******************/
; struct date
; {
; uchar hour;
; uchar min;
; uchar sec;
; uchar dida;
; }time1,time2;
; 
; /*******************端口初始化*******************/
; void port_init(void)
; {
	.dbline 141
;  PORTA = 0x00;
	clr R2
	out 0x1b,R2
	.dbline 142
;  DDRA  = 0xFF;
	ldi R24,255
	out 0x1a,R24
	.dbline 143
;  PORTB = 0x00;
	out 0x18,R2
	.dbline 144
;  DDRB  = 0xFF;
	out 0x17,R24
	.dbline 145
;  PORTC = 0x00; 
	out 0x15,R2
	.dbline 146
;  DDRC  = 0x03;
	ldi R24,3
	out 0x14,R24
	.dbline 147
;  PORTD = 0xFF;
	ldi R24,255
	out 0x12,R24
	.dbline 148
;  DDRD  = 0x00;
	out 0x11,R2
	.dbline -2
L33:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e scan_key _scan_key fc
;           temp -> R16
	.even
_scan_key::
	.dbline -1
	.dbline 158
; }
; /*************************************/
; char com_data;		
; uchar cnt;			
; void delay_iic(int n);	
; uchar rd_24c01(char a);	
; void wr_24c01(char a,char b);
; /******************扫描按键***************/
; uchar scan_key(void)		
; {					
	.dbline 160
; uchar temp;			
; temp=PIND;				
	in R16,0x10
	.dbline 161
; return temp;			
	.dbline -2
L34:
	.dbline 0 ; func end
	ret
	.dbsym r temp 16 c
	.dbend
	.dbfunc e delay _delay fV
;              i -> R20,R21
;              j -> R22,R23
;              k -> R16,R17
	.even
_delay::
	xcall push_gset2
	.dbline -1
	.dbline 165
; }					
; /***************延时子函数******************/
; void delay(uint k)		
; {					
	.dbline 167
; uint i,j;			
; for(i=0;i<k;i++)			
	clr R20
	clr R21
	xjmp L39
L36:
	.dbline 168
; {for(j=0;j<121;j++)		
	.dbline 168
	clr R22
	clr R23
	xjmp L43
L40:
	.dbline 169
	.dbline 169
	.dbline 169
L41:
	.dbline 168
	subi R22,255  ; offset = 1
	sbci R23,255
L43:
	.dbline 168
	cpi R22,121
	ldi R30,0
	cpc R23,R30
	brlo L40
	.dbline 169
L37:
	.dbline 167
	subi R20,255  ; offset = 1
	sbci R21,255
L39:
	.dbline 167
	cp R20,R16
	cpc R21,R17
	brlo L36
	.dbline -2
L35:
	xcall pop_gset2
	.dbline 0 ; func end
	ret
	.dbsym r i 20 i
	.dbsym r j 22 i
	.dbsym r k 16 i
	.dbend
	.dbfunc e start _start fV
	.even
_start::
	.dbline -1
	.dbline 174
; {;}}				
; }					
; 
; /*****************启动读写时序子函数******************/
; void start(void)			
; {DDRC=0x03;					
	.dbline 174
	ldi R24,3
	out 0x14,R24
	.dbline 175
; SDA_1;Some_NOP();
	sbi 0x15,1
	.dbline 175
	.dbline 175
	nop
	.dbline 175
	nop
	.dbline 175
	nop
	.dbline 175
	nop
	.dbline 175
	nop
	.dbline 175
	nop
	.dbline 175
	nop
	.dbline 175
	nop
	.dbline 175
	.dbline 176
; SCL_1;Some_NOP();
	sbi 0x15,0
	.dbline 176
	.dbline 176
	nop
	.dbline 176
	nop
	.dbline 176
	nop
	.dbline 176
	nop
	.dbline 176
	nop
	.dbline 176
	nop
	.dbline 176
	nop
	.dbline 176
	nop
	.dbline 176
	.dbline 177
; SDA_0;Some_NOP();
	cbi 0x15,1
	.dbline 177
	.dbline 177
	nop
	.dbline 177
	nop
	.dbline 177
	nop
	.dbline 177
	nop
	.dbline 177
	nop
	.dbline 177
	nop
	.dbline 177
	nop
	.dbline 177
	nop
	.dbline 177
	.dbline 178
; SCL_0;Some_NOP();
	cbi 0x15,0
	.dbline 178
	.dbline 178
	nop
	.dbline 178
	nop
	.dbline 178
	nop
	.dbline 178
	nop
	.dbline 178
	nop
	.dbline 178
	nop
	.dbline 178
	nop
	.dbline 178
	nop
	.dbline 178
	.dbline -2
L44:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e stop _stop fV
	.even
_stop::
	.dbline -1
	.dbline 182
; }					
; //********************停止操作子函数*********************
; void stop(void)			
; {	DDRC=0x03;			
	.dbline 182
	ldi R24,3
	out 0x14,R24
	.dbline 183
; SDA_0;Some_NOP();
	cbi 0x15,1
	.dbline 183
	.dbline 183
	nop
	.dbline 183
	nop
	.dbline 183
	nop
	.dbline 183
	nop
	.dbline 183
	nop
	.dbline 183
	nop
	.dbline 183
	nop
	.dbline 183
	nop
	.dbline 183
	.dbline 184
; SCL_1;Some_NOP();
	sbi 0x15,0
	.dbline 184
	.dbline 184
	nop
	.dbline 184
	nop
	.dbline 184
	nop
	.dbline 184
	nop
	.dbline 184
	nop
	.dbline 184
	nop
	.dbline 184
	nop
	.dbline 184
	nop
	.dbline 184
	.dbline 185
; SDA_1;Some_NOP();
	sbi 0x15,1
	.dbline 185
	.dbline 185
	nop
	.dbline 185
	nop
	.dbline 185
	nop
	.dbline 185
	nop
	.dbline 185
	nop
	.dbline 185
	nop
	.dbline 185
	nop
	.dbline 185
	nop
	.dbline 185
	.dbline -2
L45:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e ack _ack fV
	.even
_ack::
	.dbline -1
	.dbline 189
; }				
; //************应答子函数*************
; void ack(void)			
; {	DDRC=0x03;				
	.dbline 189
	ldi R24,3
	out 0x14,R24
	.dbline 190
; SCL_1;Some_NOP();
	sbi 0x15,0
	.dbline 190
	.dbline 190
	nop
	.dbline 190
	nop
	.dbline 190
	nop
	.dbline 190
	nop
	.dbline 190
	nop
	.dbline 190
	nop
	.dbline 190
	nop
	.dbline 190
	nop
	.dbline 190
	.dbline 191
; SCL_0;Some_NOP();
	cbi 0x15,0
	.dbline 191
	.dbline 191
	nop
	.dbline 191
	nop
	.dbline 191
	nop
	.dbline 191
	nop
	.dbline 191
	nop
	.dbline 191
	nop
	.dbline 191
	nop
	.dbline 191
	nop
	.dbline 191
	.dbline -2
L46:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e shift8 _shift8 fV
;              j -> R20
;              i -> R22
;              a -> R16
	.even
_shift8::
	xcall push_gset2
	.dbline -1
	.dbline 195
; }					
; //*************写入8位子函数*************
; void shift8(char a)		
; {					
	.dbline 197
; uchar i,j;			
; DDRC=0x03;
	ldi R24,3
	out 0x14,R24
	.dbline 198
; com_data=a;			
	sts _com_data,R16
	.dbline 199
; for(i=0;i<8;i++)	
	clr R22
	xjmp L51
L48:
	.dbline 200
; {	
	.dbline 201
; j=com_data&0x80;
	lds R20,_com_data
	andi R20,128
	.dbline 202
; if(j==0)SDA_0;
	brne L52
	.dbline 202
	cbi 0x15,1
	xjmp L53
L52:
	.dbline 203
; else SDA_1;
	sbi 0x15,1
L53:
	.dbline 205
	sbi 0x15,0
	.dbline 205
	.dbline 205
	nop
	.dbline 205
	nop
	.dbline 205
	nop
	.dbline 205
	nop
	.dbline 205
	nop
	.dbline 205
	nop
	.dbline 205
	nop
	.dbline 205
	nop
	.dbline 205
	.dbline 206
	cbi 0x15,0
	.dbline 206
	.dbline 206
	nop
	.dbline 206
	nop
	.dbline 206
	nop
	.dbline 206
	nop
	.dbline 206
	nop
	.dbline 206
	nop
	.dbline 206
	nop
	.dbline 206
	nop
	.dbline 206
	.dbline 207
	lds R2,_com_data
	lsl R2
	sts _com_data,R2
	.dbline 208
L49:
	.dbline 199
	inc R22
L51:
	.dbline 199
	cpi R22,8
	brlo L48
	.dbline -2
L47:
	xcall pop_gset2
	.dbline 0 ; func end
	ret
	.dbsym r j 20 c
	.dbsym r i 22 c
	.dbsym r a 16 c
	.dbend
	.dbfunc e rd_24c01 _rd_24c01 fc
;        command -> R20
;              i -> R20
;              a -> R22
	.even
_rd_24c01::
	xcall push_gset2
	mov R22,R16
	.dbline -1
	.dbline 212
; 
; SCL_1;Some_NOP();
; SCL_0;Some_NOP();
; com_data=com_data<<1;		
; }					
; }					
; //**************读24C01A中a地址单元的数据************
; uchar rd_24c01(char a)		
; {					
	.dbline 214
; uchar i,command;		
; DDRC=0x03;
	ldi R24,3
	out 0x14,R24
	.dbline 215
; SDA_1;Some_NOP();
	sbi 0x15,1
	.dbline 215
	.dbline 215
	nop
	.dbline 215
	nop
	.dbline 215
	nop
	.dbline 215
	nop
	.dbline 215
	nop
	.dbline 215
	nop
	.dbline 215
	nop
	.dbline 215
	nop
	.dbline 215
	.dbline 216
; SCL_0;Some_NOP();
	cbi 0x15,0
	.dbline 216
	.dbline 216
	nop
	.dbline 216
	nop
	.dbline 216
	nop
	.dbline 216
	nop
	.dbline 216
	nop
	.dbline 216
	nop
	.dbline 216
	nop
	.dbline 216
	nop
	.dbline 216
	.dbline 217
; start();				
	xcall _start
	.dbline 218
; command=160;			
	ldi R20,160
	.dbline 219
; shift8(command);		
	mov R16,R20
	xcall _shift8
	.dbline 220
; ack();				
	xcall _ack
	.dbline 221
; shift8(a);			
	mov R16,R22
	xcall _shift8
	.dbline 222
; ack();				
	xcall _ack
	.dbline 223
; start();				
	xcall _start
	.dbline 224
; command=161;			
	ldi R20,161
	.dbline 225
; shift8(command);		
	mov R16,R20
	xcall _shift8
	.dbline 226
; ack();				
	xcall _ack
	.dbline 228
; 
; SDA_1;Some_NOP();	
	sbi 0x15,1
	.dbline 228
	.dbline 228
	nop
	.dbline 228
	nop
	.dbline 228
	nop
	.dbline 228
	nop
	.dbline 228
	nop
	.dbline 228
	nop
	.dbline 228
	nop
	.dbline 228
	nop
	.dbline 228
	.dbline 229
; for(i=0;i<8;i++)			
	clr R20
	xjmp L58
L55:
	.dbline 230
; {
	.dbline 231
; DDRC=0x01;				
	ldi R24,1
	out 0x14,R24
	.dbline 232
; com_data=com_data<<1;		
	lds R2,_com_data
	lsl R2
	sts _com_data,R2
	.dbline 233
; SCL_1;Some_NOP();	
	sbi 0x15,0
	.dbline 233
	.dbline 233
	nop
	.dbline 233
	nop
	.dbline 233
	nop
	.dbline 233
	nop
	.dbline 233
	nop
	.dbline 233
	nop
	.dbline 233
	nop
	.dbline 233
	nop
	.dbline 233
	.dbline 234
; if(PIN_SDA==0)com_data&=0xfe;
	sbic 0x13,1
	rjmp L59
	.dbline 234
	mov R24,R2
	andi R24,254
	sts _com_data,R24
	xjmp L60
L59:
	.dbline 235
; else com_data|=0x01;
	lds R24,_com_data
	ori R24,1
	sts _com_data,R24
L60:
	.dbline 236
	cbi 0x15,0
	.dbline 236
	.dbline 236
	nop
	.dbline 236
	nop
	.dbline 236
	nop
	.dbline 236
	nop
	.dbline 236
	nop
	.dbline 236
	nop
	.dbline 236
	nop
	.dbline 236
	nop
	.dbline 236
	.dbline 237
L56:
	.dbline 229
	inc R20
L58:
	.dbline 229
	cpi R20,8
	brlo L55
	.dbline 238
; SCL_0;Some_NOP();
; }					
; stop();				
	xcall _stop
	.dbline 239
; return(com_data);	
	lds R16,_com_data
	.dbline -2
L54:
	xcall pop_gset2
	.dbline 0 ; func end
	ret
	.dbsym r command 20 c
	.dbsym r i 20 c
	.dbsym r a 22 c
	.dbend
	.dbfunc e wr_24c01 _wr_24c01 fV
;        command -> R10
;              b -> R20
;              a -> R22
	.even
_wr_24c01::
	xcall push_gset3
	mov R20,R18
	mov R22,R16
	.dbline -1
	.dbline 243
; }					
; //********将RAM中b地址单元的数据写入24C01A中a地址单元中***********
; void wr_24c01(char a,char b)	
; {					
	.dbline 245
; uchar command;		
; DDRC=0x03;
	ldi R24,3
	out 0x14,R24
	.dbline 246
; SDA_1;Some_NOP();
	sbi 0x15,1
	.dbline 246
	.dbline 246
	nop
	.dbline 246
	nop
	.dbline 246
	nop
	.dbline 246
	nop
	.dbline 246
	nop
	.dbline 246
	nop
	.dbline 246
	nop
	.dbline 246
	nop
	.dbline 246
	.dbline 247
; SCL_0;Some_NOP();
	cbi 0x15,0
	.dbline 247
	.dbline 247
	nop
	.dbline 247
	nop
	.dbline 247
	nop
	.dbline 247
	nop
	.dbline 247
	nop
	.dbline 247
	nop
	.dbline 247
	nop
	.dbline 247
	nop
	.dbline 247
	.dbline 248
; start();				
	xcall _start
	.dbline 249
; command=160;			
	ldi R24,160
	mov R10,R24
	.dbline 250
; shift8(command);		
	mov R16,R24
	xcall _shift8
	.dbline 251
; ack();				
	xcall _ack
	.dbline 252
; shift8(a);				
	mov R16,R22
	xcall _shift8
	.dbline 253
; ack();				
	xcall _ack
	.dbline 254
; shift8(b);				
	mov R16,R20
	xcall _shift8
	.dbline 255
; ack();				
	xcall _ack
	.dbline 256
; stop();				
	xcall _stop
	.dbline 257
; Some_NOP();
	.dbline 257
	nop
	.dbline 257
	nop
	.dbline 257
	nop
	.dbline 257
	nop
	.dbline 257
	nop
	.dbline 257
	nop
	.dbline 257
	nop
	.dbline 257
	nop
	.dbline 257
	.dbline -2
L61:
	xcall pop_gset3
	.dbline 0 ; func end
	ret
	.dbsym r command 10 c
	.dbsym r b 20 c
	.dbsym r a 22 c
	.dbend
	.dbfunc e delay_iic _delay_iic fV
;              i -> R20,R21
;              n -> R16,R17
	.even
_delay_iic::
	xcall push_gset1
	.dbline -1
	.dbline 261
; }					
; //**************延时子函数***********
; void delay_iic(int n)		
; {					
	.dbline 263
	ldi R20,1
	ldi R21,0
	xjmp L66
L63:
	.dbline 263
	.dbline 263
	.dbline 263
L64:
	.dbline 263
	subi R20,255  ; offset = 1
	sbci R21,255
L66:
	.dbline 263
; int i;				
; for(i=1;i<n;i++){;}		
	cp R20,R16
	cpc R21,R17
	brlt L63
	.dbline -2
L62:
	xcall pop_gset1
	.dbline 0 ; func end
	ret
	.dbsym r i 20 I
	.dbsym r n 16 I
	.dbend
	.dbfunc e timer1_init _timer1_init fV
	.even
_timer1_init::
	.dbline -1
	.dbline 268
; }					
; 
; /**************定时器1初始化****************/
; void timer1_init(void)
; {
	.dbline 269
;  TCNT1H = 0xF3; //setup
	ldi R24,243
	out 0x2d,R24
	.dbline 270
;  TCNT1L = 0xCB;
	ldi R24,203
	out 0x2c,R24
	.dbline 271
;  TCCR1B = 0x04; //start Timer
	ldi R24,4
	out 0x2e,R24
	.dbline -2
L67:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e main _main fV
;        key_val -> R22
	.even
_main::
	sbiw R28,2
	.dbline -1
	.dbline 275
; }
; //******************************************
; void main(void)				
; {
	.dbline 277
;  	 uchar key_val;	
; 	 init_devices();
	xcall _init_devices
	.dbline 278
;     Delay_nms(400);			
	ldi R16,400
	ldi R17,1
	xcall _Delay_nms
	.dbline 279
; 	InitLcd();			
	xcall _InitLcd
	.dbline 280
; 	LcdWriteCommand(0x01,1); 
	ldi R18,1
	ldi R16,1
	xcall _LcdWriteCommand
	.dbline 281
; 	LcdWriteCommand(0x0c,1); 
	ldi R18,1
	ldi R16,12
	xcall _LcdWriteCommand
	.dbline 282
; 	ePutstr(0,0,str0);  
	ldi R24,<_str0
	ldi R25,>_str0
	std y+1,R25
	std y+0,R24
	clr R18
	clr R16
	xcall _ePutstr
	.dbline 283
; 	Delay_nms(10);
	ldi R16,10
	ldi R17,0
	xcall _Delay_nms
	.dbline 284
; 	ePutstr(0,1,str1);   
	ldi R24,<_str1
	ldi R25,>_str1
	std y+1,R25
	std y+0,R24
	ldi R18,1
	clr R16
	xcall _ePutstr
	.dbline 285
; 	Delay_nms(10);
	ldi R16,10
	ldi R17,0
	xcall _Delay_nms
	xjmp L70
L69:
	.dbline 288
; 	/********************************************/
; 		while(1)              
; 		{
	.dbline 289
; 		   DisplayOneChar(6,0,(time1.hour/10)+0x30);
	ldi R17,10
	lds R16,_time1
	xcall div8u
	mov R24,R16
	subi R24,208    ; addi 48
	std y+0,R24
	clr R18
	ldi R16,6
	xcall _DisplayOneChar
	.dbline 290
; 		   Delay_nms(10);
	ldi R16,10
	ldi R17,0
	xcall _Delay_nms
	.dbline 291
; 		   DisplayOneChar(7,0,(time1.hour%10)+0x30);
	ldi R17,10
	lds R16,_time1
	xcall mod8u
	mov R24,R16
	subi R24,208    ; addi 48
	std y+0,R24
	clr R18
	ldi R16,7
	xcall _DisplayOneChar
	.dbline 292
; 		   Delay_nms(10); 
	ldi R16,10
	ldi R17,0
	xcall _Delay_nms
	.dbline 293
; 		   DisplayOneChar(9,0,(time1.min/10)+0x30);
	ldi R17,10
	lds R16,_time1+1
	xcall div8u
	mov R24,R16
	subi R24,208    ; addi 48
	std y+0,R24
	clr R18
	ldi R16,9
	xcall _DisplayOneChar
	.dbline 294
; 		   Delay_nms(10); 
	ldi R16,10
	ldi R17,0
	xcall _Delay_nms
	.dbline 295
; 		   DisplayOneChar(10,0,(time1.min%10)+0x30);
	ldi R17,10
	lds R16,_time1+1
	xcall mod8u
	mov R24,R16
	subi R24,208    ; addi 48
	std y+0,R24
	clr R18
	ldi R16,10
	xcall _DisplayOneChar
	.dbline 296
; 		   Delay_nms(10); 
	ldi R16,10
	ldi R17,0
	xcall _Delay_nms
	.dbline 297
; 		   DisplayOneChar(12,0,(time1.sec/10)+0x30);
	ldi R17,10
	lds R16,_time1+2
	xcall div8u
	mov R24,R16
	subi R24,208    ; addi 48
	std y+0,R24
	clr R18
	ldi R16,12
	xcall _DisplayOneChar
	.dbline 298
; 		   Delay_nms(10); 
	ldi R16,10
	ldi R17,0
	xcall _Delay_nms
	.dbline 299
; 		   DisplayOneChar(13,0,(time1.sec%10)+0x30);
	ldi R17,10
	lds R16,_time1+2
	xcall mod8u
	mov R24,R16
	subi R24,208    ; addi 48
	std y+0,R24
	clr R18
	ldi R16,13
	xcall _DisplayOneChar
	.dbline 300
; 		   Delay_nms(10); 
	ldi R16,10
	ldi R17,0
	xcall _Delay_nms
	.dbline 302
; 		   
; 	   	   DisplayOneChar(7,1,(time2.hour/10)+0x30);
	ldi R17,10
	lds R16,_time2
	xcall div8u
	mov R24,R16
	subi R24,208    ; addi 48
	std y+0,R24
	ldi R18,1
	ldi R16,7
	xcall _DisplayOneChar
	.dbline 303
; 		   Delay_nms(10); 
	ldi R16,10
	ldi R17,0
	xcall _Delay_nms
	.dbline 304
; 		   DisplayOneChar(8,1,(time2.hour%10)+0x30);
	ldi R17,10
	lds R16,_time2
	xcall mod8u
	mov R24,R16
	subi R24,208    ; addi 48
	std y+0,R24
	ldi R18,1
	ldi R16,8
	xcall _DisplayOneChar
	.dbline 305
; 		   Delay_nms(10); 
	ldi R16,10
	ldi R17,0
	xcall _Delay_nms
	.dbline 306
; 		   DisplayOneChar(10,1,(time2.min/10)+0x30);
	ldi R17,10
	lds R16,_time2+1
	xcall div8u
	mov R24,R16
	subi R24,208    ; addi 48
	std y+0,R24
	ldi R18,1
	ldi R16,10
	xcall _DisplayOneChar
	.dbline 307
; 		   Delay_nms(10); 
	ldi R16,10
	ldi R17,0
	xcall _Delay_nms
	.dbline 308
;     	   DisplayOneChar(11,1,(time2.min%10)+0x30);
	ldi R17,10
	lds R16,_time2+1
	xcall mod8u
	mov R24,R16
	subi R24,208    ; addi 48
	std y+0,R24
	ldi R18,1
	ldi R16,11
	xcall _DisplayOneChar
	.dbline 309
; 		   Delay_nms(10); 
	ldi R16,10
	ldi R17,0
	xcall _Delay_nms
	.dbline 311
; 
; 		   key_val=scan_key();	
	xcall _scan_key
	mov R22,R16
	.dbline 313
; 
; 		   switch(key_val)		
	mov R20,R22
	clr R21
	cpi R20,223
	ldi R30,0
	cpc R21,R30
	brne X2
	xjmp L89
X2:
	ldi R24,223
	ldi R25,0
	cp R24,R20
	cpc R25,R21
	brlt L108
L107:
	cpi R20,127
	ldi R30,0
	cpc R21,R30
	brne X3
	xjmp L100
X3:
	cpi R20,127
	ldi R30,0
	cpc R21,R30
	brge X4
	xjmp L79
X4:
L109:
	cpi R20,191
	ldi R30,0
	cpc R21,R30
	brne X5
	xjmp L92
X5:
	xjmp L79
L108:
	cpi R20,247
	ldi R30,0
	cpc R21,R30
	brne X6
	xjmp L105
X6:
	ldi R24,247
	ldi R25,0
	cp R24,R20
	cpc R25,R21
	brlt L111
L110:
	cpi R20,239
	ldi R30,0
	cpc R21,R30
	breq L81
	xjmp L79
L111:
	cpi R20,251
	ldi R30,0
	cpc R21,R30
	brne X7
	xjmp L103
X7:
	xjmp L79
X0:
	.dbline 314
; 	   	   {				
L81:
	.dbline 315
; 	   	   	case 0xef:time1.min++;
	lds R24,_time1+1
	subi R24,255    ; addi 1
	sts _time1+1,R24
	.dbline 316
; 			          if(time1.min>59){time1.min=0;
	ldi R24,59
	lds R2,_time1+1
	cp R24,R2
	brlo X8
	xjmp L79
X8:
	.dbline 316
	.dbline 316
	clr R2
	sts _time1+1,R2
	.dbline 317
; 					                  if(time1.hour<23)time1.hour++;
	lds R24,_time1
	cpi R24,23
	brlo X9
	xjmp L79
X9:
	.dbline 317
	subi R24,255    ; addi 1
	sts _time1,R24
	.dbline 318
; 								      }break;  
	.dbline 318
	xjmp L79
L89:
	.dbline 319
; 	   		case 0xdf:time1.hour++;if(time1.hour>23)time1.hour=0;break;														//加法调整"时"
	lds R24,_time1
	subi R24,255    ; addi 1
	sts _time1,R24
	.dbline 319
	ldi R24,23
	lds R2,_time1
	cp R24,R2
	brlo X10
	xjmp L79
X10:
	.dbline 319
	clr R2
	sts _time1,R2
	.dbline 319
	xjmp L79
L92:
	.dbline 320
; 	   		case 0xbf:time2.min++;
	lds R24,_time2+1
	subi R24,255    ; addi 1
	sts _time2+1,R24
	.dbline 321
; 			          if(time2.min>59){time2.min=0;
	ldi R24,59
	lds R2,_time2+1
	cp R24,R2
	brlo X11
	xjmp L79
X11:
	.dbline 321
	.dbline 321
	clr R2
	sts _time2+1,R2
	.dbline 322
; 					                  if(time2.hour<23)time2.hour++;
	lds R24,_time2
	cpi R24,23
	brlo X12
	xjmp L79
X12:
	.dbline 322
	subi R24,255    ; addi 1
	sts _time2,R24
	.dbline 323
; 								      }break; 
	.dbline 323
	xjmp L79
L100:
	.dbline 324
; 	   		case 0x7f:time2.hour++;if(time2.hour>23)time2.hour=0;break;	
	lds R24,_time2
	subi R24,255    ; addi 1
	sts _time2,R24
	.dbline 324
	ldi R24,23
	lds R2,_time2
	cp R24,R2
	brsh L79
	.dbline 324
	clr R2
	sts _time2,R2
	.dbline 324
	xjmp L79
L103:
	.dbline 327
; 											
; 			//*************************
; 			case 0xfb:wr_24c01(11,time2.hour);
	lds R18,_time2
	ldi R16,11
	xcall _wr_24c01
	.dbline 328
; 				 Delay_nms(10); 
	ldi R16,10
	ldi R17,0
	xcall _Delay_nms
	.dbline 329
; 				 wr_24c01(12,time2.min); 
	lds R18,_time2+1
	ldi R16,12
	xcall _wr_24c01
	.dbline 330
; 				 Delay_nms(10); 
	ldi R16,10
	ldi R17,0
	xcall _Delay_nms
	.dbline 331
; 				 DisplayOneChar(13,1,0x57); 
	ldi R24,87
	std y+0,R24
	ldi R18,1
	ldi R16,13
	xcall _DisplayOneChar
	.dbline 332
; 				 Delay_nms(10);break; 
	ldi R16,10
	ldi R17,0
	xcall _Delay_nms
	.dbline 332
	xjmp L79
L105:
	.dbline 333
; 	   		case 0xf7:time2.hour=rd_24c01(11); 
	ldi R16,11
	xcall _rd_24c01
	sts _time2,R16
	.dbline 334
; 				 Delay_nms(10); 
	ldi R16,10
	ldi R17,0
	xcall _Delay_nms
	.dbline 335
; 				 time2.min=rd_24c01(12); 
	ldi R16,12
	xcall _rd_24c01
	sts _time2+1,R16
	.dbline 336
; 				 Delay_nms(10); 
	ldi R16,10
	ldi R17,0
	xcall _Delay_nms
	.dbline 337
; 				 DisplayOneChar(13,1,0x52); 
	ldi R24,82
	std y+0,R24
	ldi R18,1
	ldi R16,13
	xcall _DisplayOneChar
	.dbline 338
; 				 Delay_nms(10);break;	 
	ldi R16,10
	ldi R17,0
	xcall _Delay_nms
	.dbline 338
	.dbline 339
; 	   		default:break;		
L79:
	.dbline 341
	ldi R16,300
	ldi R17,1
	xcall _Delay_nms
	.dbline 342
	ldi R24,32
	std y+0,R24
	ldi R18,1
	ldi R16,13
	xcall _DisplayOneChar
	.dbline 343
	ldi R16,10
	ldi R17,0
	xcall _Delay_nms
	.dbline 345
L70:
	.dbline 287
	xjmp L69
X1:
	.dbline -2
L68:
	adiw R28,2
	.dbline 0 ; func end
	ret
	.dbsym r key_val 22 c
	.dbend
	.area vector(rom, abs)
	.org 32
	jmp _timer1_ovf_isr
	.area text(rom, con, rel)
	.dbfile d:\MYDOCU~1\ac15-2\ac15-2.c
	.dbfunc e timer1_ovf_isr _timer1_ovf_isr fV
	.even
_timer1_ovf_isr::
	st -y,R2
	st -y,R3
	st -y,R24
	st -y,R25
	in R2,0x3f
	st -y,R2
	.dbline -1
	.dbline 350
; 	   		}				
; 			Delay_nms(300);
; 			DisplayOneChar(13,1,0x20); 
; 			Delay_nms(10); 
; 						
;   		 }				
; }		   
; /*********************定时器T1中断子函数************************/
; #pragma interrupt_handler timer1_ovf_isr:9
; void timer1_ovf_isr(void)
; {
	.dbline 352
;  //TIMER1 has overflowed
;  TCNT1H = 0xF3; //reload counter high value
	ldi R24,243
	out 0x2d,R24
	.dbline 353
;  TCNT1L = 0xCB; //reload counter low value
	ldi R24,203
	out 0x2c,R24
	.dbline 354
;  if(++time1.dida>=10){time1.dida=0;time1.sec++;}//计时
	lds R24,_time1+3
	subi R24,255    ; addi 1
	mov R2,R24
	sts _time1+3,R2
	cpi R24,10
	brlo L113
	.dbline 354
	.dbline 354
	clr R2
	sts _time1+3,R2
	.dbline 354
	lds R24,_time1+2
	subi R24,255    ; addi 1
	sts _time1+2,R24
	.dbline 354
L113:
	.dbline 355
;  if(time1.sec>=60){time1.sec=0;time1.min++;}
	lds R24,_time1+2
	cpi R24,60
	brlo L118
	.dbline 355
	.dbline 355
	clr R2
	sts _time1+2,R2
	.dbline 355
	lds R24,_time1+1
	subi R24,255    ; addi 1
	sts _time1+1,R24
	.dbline 355
L118:
	.dbline 356
;  if(time1.min>=60){time1.min=0;time1.hour++;}
	lds R24,_time1+1
	cpi R24,60
	brlo L123
	.dbline 356
	.dbline 356
	clr R2
	sts _time1+1,R2
	.dbline 356
	lds R24,_time1
	subi R24,255    ; addi 1
	sts _time1,R24
	.dbline 356
L123:
	.dbline 357
;  if(time1.hour>=24){time1.hour=0;}
	lds R24,_time1
	cpi R24,24
	brlo L127
	.dbline 357
	.dbline 357
	clr R2
	sts _time1,R2
	.dbline 357
L127:
	.dbline 359
;  //-------------------
;  if((time1.hour==time2.hour)&&(time1.min==time2.min))LED_0;
	lds R2,_time2
	lds R3,_time1
	cp R3,R2
	brne L129
	lds R2,_time2+1
	lds R3,_time1+1
	cp R3,R2
	brne L129
	.dbline 359
	cbi 0x18,7
	xjmp L130
L129:
	.dbline 360
	sbi 0x18,7
L130:
	.dbline -2
L112:
	ld R2,y+
	out 0x3f,R2
	ld R25,y+
	ld R24,y+
	ld R3,y+
	ld R2,y+
	.dbline 0 ; func end
	reti
	.dbend
	.dbfunc e init_devices _init_devices fV
	.even
_init_devices::
	.dbline -1
	.dbline 364
;  else LED_1;
; }
; /**********************器件初始化***********************/
; void init_devices(void)
; {
	.dbline 366
;  //stop errant interrupts until set up
;  CLI(); //disable all interrupts
	cli
	.dbline 367
;  port_init();
	xcall _port_init
	.dbline 368
;  timer1_init();
	xcall _timer1_init
	.dbline 369
;  MCUCR = 0x00;
	clr R2
	out 0x35,R2
	.dbline 370
;  GICR  = 0x00;
	out 0x3b,R2
	.dbline 371
;  TIMSK = 0x04; //timer interrupt sources
	ldi R24,4
	out 0x39,R24
	.dbline 372
;  SEI(); //re-enable interrupts
	sei
	.dbline -2
L133:
	.dbline 0 ; func end
	ret
	.dbend
	.area bss(ram, con, rel)
	.dbfile d:\MYDOCU~1\ac15-2\ac15-2.c
_cnt::
	.blkb 1
	.dbsym e cnt _cnt c
_com_data::
	.blkb 1
	.dbsym e com_data _com_data c
_time2::
	.blkb 4
	.dbstruct 0 4 date
	.dbfield 0 hour c
	.dbfield 1 min c
	.dbfield 2 sec c
	.dbfield 3 dida c
	.dbend
	.dbsym e time2 _time2 S[date]
_time1::
	.blkb 4
	.dbsym e time1 _time1 S[date]
