	.module ac15-1.c
	.area lit(rom, con, rel)
_str0::
	.byte 'W,'r,'i,'t,'e,32,58,32,0
	.dbfile d:\MYDOCU~1\ac15-1\ac15-1.c
	.dbsym e str0 _str0 A[9:9]kc
_str1::
	.byte 'R,'e,'a,'d,32,58,32,0
	.dbsym e str1 _str1 A[8:8]kc
	.area text(rom, con, rel)
	.dbfile d:\MYDOCU~1\ac15-1\ac15-1.c
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
	.dbline 39
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
; //======================================
; #define PIN_SDA (PINC&0x02)
; #define DataPort PORTA		
; #define Busy 0x80			
; #define xtal 8   			
; #define Some_NOP();  _NOP();_NOP();_NOP();_NOP();_NOP();_NOP();_NOP();_NOP();
; //=====================================
; const uchar str0[]={"Write : "};//待显字符串
; const uchar str1[]={"Read : "};//待显字符串
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
; //**********************显示指定座标的一串字符子函数**************
; void ePutstr(uchar x,uchar y,uchar const *ptr)
; {
	.dbline 40
; uchar i,l=0;
	clr R20
	xjmp L3
L2:
	.dbline 41
	.dbline 41
	inc R20
	.dbline 41
L3:
	.dbline 41
; 	while(ptr[l]>31){l++;}
	mov R30,R20
	clr R31
	add R30,R10
	adc R31,R11
	lpm R30,Z
	ldi R24,31
	cp R24,R30
	brlo L2
	.dbline 42
	clr R22
	xjmp L8
L5:
	.dbline 42
; 	for(i=0;i<l;i++){
	.dbline 43
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
	.dbline 44
; 	if(x==16){
	mov R24,R14
	cpi R24,16
	brne L9
	.dbline 44
	.dbline 45
; 		x=0;y^=1;
	clr R14
	.dbline 45
	ldi R24,1
	eor R12,R24
	.dbline 46
; 	}
L9:
	.dbline 47
L6:
	.dbline 42
	inc R22
L8:
	.dbline 42
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
	.dbline 51
;   }
; }
; //*******************显示光标定位子函数******************
; void LocateXY(char posx,char posy)
; {
	.dbline 53
; uchar temp;
; 	temp&=0x7f;
	andi R20,127
	.dbline 54
; 	temp=posx&0x0f;
	mov R20,R10
	andi R20,15
	.dbline 55
; 	posy&=0x01;
	andi R22,1
	.dbline 56
; 	if(posy)temp|=0x40;
	breq L12
	.dbline 56
	ori R20,64
L12:
	.dbline 57
; 	temp|=0x80;
	ori R20,128
	.dbline 58
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
	.dbline 62
; }
; //*******************显示指定座标的一个字符子函数*******************
; void DisplayOneChar(uchar x,uchar y,uchar Wdata)
; {
	.dbline 63
; LocateXY(x,y);
	mov R18,R22
	mov R16,R20
	xcall _LocateXY
	.dbline 64
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
	.dbline 68
; }
; //*******************LCD初始化子函数*********************
; void InitLcd(void) 
; {
	.dbline 69
; LcdWriteCommand(0x38,0); 
	clr R18
	ldi R16,56
	xcall _LcdWriteCommand
	.dbline 70
; Delay_nms(5);
	ldi R16,5
	ldi R17,0
	xcall _Delay_nms
	.dbline 71
; LcdWriteCommand(0x38,0); 
	clr R18
	ldi R16,56
	xcall _LcdWriteCommand
	.dbline 72
; Delay_nms(5);
	ldi R16,5
	ldi R17,0
	xcall _Delay_nms
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
; LcdWriteCommand(0x38,1); 
	ldi R18,1
	ldi R16,56
	xcall _LcdWriteCommand
	.dbline 76
; LcdWriteCommand(0x08,1); 
	ldi R18,1
	ldi R16,8
	xcall _LcdWriteCommand
	.dbline 77
; LcdWriteCommand(0x01,1); 
	ldi R18,1
	ldi R16,1
	xcall _LcdWriteCommand
	.dbline 78
; LcdWriteCommand(0x06,1); 
	ldi R18,1
	ldi R16,6
	xcall _LcdWriteCommand
	.dbline 79
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
	.dbline 83
; }
; //********************写命令到LCM子函数********************
; void LcdWriteCommand(uchar CMD,uchar Attribc)
; {
	.dbline 84
; if(Attribc)WaitForEnable();
	tst R22
	breq L17
	.dbline 84
	xcall _WaitForEnable
L17:
	.dbline 85
; LCM_RS_0;LCM_RW_0;_NOP();
	cbi 0x18,0
	.dbline 85
	cbi 0x18,1
	.dbline 85
	nop
	.dbline 86
; DataPort=CMD;_NOP();
	out 0x1b,R20
	.dbline 86
	nop
	.dbline 87
; LCM_EN_1;_NOP();_NOP();LCM_EN_0;
	sbi 0x18,2
	.dbline 87
	nop
	.dbline 87
	nop
	.dbline 87
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
	.dbline 91
; }
; //*******************写数据到LCM子函数********************
; void LcdWriteData(uchar dataW)
; {
	.dbline 92
; WaitForEnable();
	xcall _WaitForEnable
	.dbline 93
; LCM_RS_1;LCM_RW_0;_NOP();
	sbi 0x18,0
	.dbline 93
	cbi 0x18,1
	.dbline 93
	nop
	.dbline 94
; DataPort=dataW;_NOP();
	out 0x1b,R20
	.dbline 94
	nop
	.dbline 95
; LCM_EN_1;_NOP();_NOP();LCM_EN_0;
	sbi 0x18,2
	.dbline 95
	nop
	.dbline 95
	nop
	.dbline 95
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
	.dbline 99
; }
; //*******************检测LCD忙信号子函数*********************
; void WaitForEnable(void)
; {
	.dbline 101
; uchar val;
; DataPort=0xff;
	ldi R24,255
	out 0x1b,R24
	.dbline 102
; LCM_RS_0;LCM_RW_1;_NOP();
	cbi 0x18,0
	.dbline 102
	sbi 0x18,1
	.dbline 102
	nop
	.dbline 103
; LCM_EN_1;_NOP();_NOP();
	sbi 0x18,2
	.dbline 103
	nop
	.dbline 103
	nop
	.dbline 104
; DDRA=0x00;
	clr R2
	out 0x1a,R2
	.dbline 105
; val=PINA;
	in R16,0x19
	xjmp L22
L21:
	.dbline 106
	in R16,0x19
L22:
	.dbline 106
; while(val&Busy)val=PINA;
	sbrc R16,7
	rjmp L21
	.dbline 107
; LCM_EN_0;
	cbi 0x18,2
	.dbline 108
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
	.dbline 112
; }
; //****************************************
; void Delay_1ms(void)		//1mS延时子函数
; { uint i;
	.dbline 113
;  for(i=1;i<(uint)(xtal*143-2);i++)
	ldi R16,1
	ldi R17,0
	xjmp L28
L25:
	.dbline 114
L26:
	.dbline 113
	subi R16,255  ; offset = 1
	sbci R17,255
L28:
	.dbline 113
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
	.dbline 118
;     ;
; }
; //====================================
; void Delay_nms(uint n)		//n*1mS延时子函数
; {
	.dbline 119
;  uint i=0;
	clr R20
	clr R21
	xjmp L31
L30:
	.dbline 121
	.dbline 121
	xcall _Delay_1ms
	.dbline 122
	subi R20,255  ; offset = 1
	sbci R21,255
	.dbline 123
L31:
	.dbline 120
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
	.dbline 127
;    {Delay_1ms();
;     i++;
;    }
; }
; /*****************端口初始化********************/
; void port_init(void)
; {
	.dbline 128
;  PORTA = 0x00;
	clr R2
	out 0x1b,R2
	.dbline 129
;  DDRA  = 0xFF;
	ldi R24,255
	out 0x1a,R24
	.dbline 130
;  PORTB = 0x00;
	out 0x18,R2
	.dbline 131
;  DDRB  = 0xFF;
	out 0x17,R24
	.dbline 132
;  PORTC = 0x00; 
	out 0x15,R2
	.dbline 133
;  DDRC  = 0x03;
	ldi R24,3
	out 0x14,R24
	.dbline 134
;  PORTD = 0xFF;
	ldi R24,255
	out 0x12,R24
	.dbline 135
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
	.dbline 145
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
	.dbline 147
; uchar temp;			
; temp=PIND;				
	in R16,0x10
	.dbline 148
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
	.dbline 152
; }					
; /***************延时子函数******************/
; void delay(uint k)		
; {					
	.dbline 154
; uint i,j;			
; for(i=0;i<k;i++)			
	clr R20
	clr R21
	xjmp L39
L36:
	.dbline 155
; {for(j=0;j<121;j++)		
	.dbline 155
	clr R22
	clr R23
	xjmp L43
L40:
	.dbline 156
	.dbline 156
	.dbline 156
L41:
	.dbline 155
	subi R22,255  ; offset = 1
	sbci R23,255
L43:
	.dbline 155
	cpi R22,121
	ldi R30,0
	cpc R23,R30
	brlo L40
	.dbline 156
L37:
	.dbline 154
	subi R20,255  ; offset = 1
	sbci R21,255
L39:
	.dbline 154
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
	.dbline 160
; {;}}				
; }					
; /*****************启动读写时序子函数******************/
; void start(void)			
; {DDRC=0x03;					
	.dbline 160
	ldi R24,3
	out 0x14,R24
	.dbline 161
; SDA_1;Some_NOP();
	sbi 0x15,1
	.dbline 161
	.dbline 161
	nop
	.dbline 161
	nop
	.dbline 161
	nop
	.dbline 161
	nop
	.dbline 161
	nop
	.dbline 161
	nop
	.dbline 161
	nop
	.dbline 161
	nop
	.dbline 161
	.dbline 162
; SCL_1;Some_NOP();
	sbi 0x15,0
	.dbline 162
	.dbline 162
	nop
	.dbline 162
	nop
	.dbline 162
	nop
	.dbline 162
	nop
	.dbline 162
	nop
	.dbline 162
	nop
	.dbline 162
	nop
	.dbline 162
	nop
	.dbline 162
	.dbline 163
; SDA_0;Some_NOP();
	cbi 0x15,1
	.dbline 163
	.dbline 163
	nop
	.dbline 163
	nop
	.dbline 163
	nop
	.dbline 163
	nop
	.dbline 163
	nop
	.dbline 163
	nop
	.dbline 163
	nop
	.dbline 163
	nop
	.dbline 163
	.dbline 164
; SCL_0;Some_NOP();
	cbi 0x15,0
	.dbline 164
	.dbline 164
	nop
	.dbline 164
	nop
	.dbline 164
	nop
	.dbline 164
	nop
	.dbline 164
	nop
	.dbline 164
	nop
	.dbline 164
	nop
	.dbline 164
	nop
	.dbline 164
	.dbline -2
L44:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e stop _stop fV
	.even
_stop::
	.dbline -1
	.dbline 168
; }					
; //********************停止操作子函数*********************
; void stop(void)			
; {	DDRC=0x03;			
	.dbline 168
	ldi R24,3
	out 0x14,R24
	.dbline 169
; SDA_0;Some_NOP();
	cbi 0x15,1
	.dbline 169
	.dbline 169
	nop
	.dbline 169
	nop
	.dbline 169
	nop
	.dbline 169
	nop
	.dbline 169
	nop
	.dbline 169
	nop
	.dbline 169
	nop
	.dbline 169
	nop
	.dbline 169
	.dbline 170
; SCL_1;Some_NOP();
	sbi 0x15,0
	.dbline 170
	.dbline 170
	nop
	.dbline 170
	nop
	.dbline 170
	nop
	.dbline 170
	nop
	.dbline 170
	nop
	.dbline 170
	nop
	.dbline 170
	nop
	.dbline 170
	nop
	.dbline 170
	.dbline 171
; SDA_1;Some_NOP();
	sbi 0x15,1
	.dbline 171
	.dbline 171
	nop
	.dbline 171
	nop
	.dbline 171
	nop
	.dbline 171
	nop
	.dbline 171
	nop
	.dbline 171
	nop
	.dbline 171
	nop
	.dbline 171
	nop
	.dbline 171
	.dbline -2
L45:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e ack _ack fV
	.even
_ack::
	.dbline -1
	.dbline 175
; }				
; //************应答子函数*************
; void ack(void)			
; {	DDRC=0x03;				
	.dbline 175
	ldi R24,3
	out 0x14,R24
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
; SCL_0;Some_NOP();
	cbi 0x15,0
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
	.dbline 181
; }					
; //*************写入8位子函数*************
; void shift8(char a)		
; {					
	.dbline 183
; uchar i,j;			
; DDRC=0x03;
	ldi R24,3
	out 0x14,R24
	.dbline 184
; com_data=a;			
	sts _com_data,R16
	.dbline 185
; for(i=0;i<8;i++)	
	clr R22
	xjmp L51
L48:
	.dbline 186
; {	
	.dbline 187
; j=com_data&0x80;
	lds R20,_com_data
	andi R20,128
	.dbline 188
; if(j==0)SDA_0;
	brne L52
	.dbline 188
	cbi 0x15,1
	xjmp L53
L52:
	.dbline 189
; else SDA_1;
	sbi 0x15,1
L53:
	.dbline 191
	sbi 0x15,0
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
	.dbline 192
	cbi 0x15,0
	.dbline 192
	.dbline 192
	nop
	.dbline 192
	nop
	.dbline 192
	nop
	.dbline 192
	nop
	.dbline 192
	nop
	.dbline 192
	nop
	.dbline 192
	nop
	.dbline 192
	nop
	.dbline 192
	.dbline 193
	lds R2,_com_data
	lsl R2
	sts _com_data,R2
	.dbline 194
L49:
	.dbline 185
	inc R22
L51:
	.dbline 185
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
	.dbline 198
; 
; SCL_1;Some_NOP();
; SCL_0;Some_NOP();
; com_data=com_data<<1;		
; }					
; }					
; //**************读24C01A中a地址单元的数据************
; uchar rd_24c01(char a)		
; {					
	.dbline 200
; uchar i,command;		
; DDRC=0x03;
	ldi R24,3
	out 0x14,R24
	.dbline 201
; SDA_1;Some_NOP();
	sbi 0x15,1
	.dbline 201
	.dbline 201
	nop
	.dbline 201
	nop
	.dbline 201
	nop
	.dbline 201
	nop
	.dbline 201
	nop
	.dbline 201
	nop
	.dbline 201
	nop
	.dbline 201
	nop
	.dbline 201
	.dbline 202
; SCL_0;Some_NOP();
	cbi 0x15,0
	.dbline 202
	.dbline 202
	nop
	.dbline 202
	nop
	.dbline 202
	nop
	.dbline 202
	nop
	.dbline 202
	nop
	.dbline 202
	nop
	.dbline 202
	nop
	.dbline 202
	nop
	.dbline 202
	.dbline 203
; start();				
	xcall _start
	.dbline 204
; command=160;			
	ldi R20,160
	.dbline 205
; shift8(command);		
	mov R16,R20
	xcall _shift8
	.dbline 206
; ack();				
	xcall _ack
	.dbline 207
; shift8(a);			
	mov R16,R22
	xcall _shift8
	.dbline 208
; ack();				
	xcall _ack
	.dbline 209
; start();				
	xcall _start
	.dbline 210
; command=161;			
	ldi R20,161
	.dbline 211
; shift8(command);		
	mov R16,R20
	xcall _shift8
	.dbline 212
; ack();				
	xcall _ack
	.dbline 214
; 
; SDA_1;Some_NOP();	
	sbi 0x15,1
	.dbline 214
	.dbline 214
	nop
	.dbline 214
	nop
	.dbline 214
	nop
	.dbline 214
	nop
	.dbline 214
	nop
	.dbline 214
	nop
	.dbline 214
	nop
	.dbline 214
	nop
	.dbline 214
	.dbline 215
; for(i=0;i<8;i++)			
	clr R20
	xjmp L58
L55:
	.dbline 216
; {
	.dbline 217
; DDRC=0x01;				
	ldi R24,1
	out 0x14,R24
	.dbline 218
; com_data=com_data<<1;		
	lds R2,_com_data
	lsl R2
	sts _com_data,R2
	.dbline 219
; SCL_1;Some_NOP();	
	sbi 0x15,0
	.dbline 219
	.dbline 219
	nop
	.dbline 219
	nop
	.dbline 219
	nop
	.dbline 219
	nop
	.dbline 219
	nop
	.dbline 219
	nop
	.dbline 219
	nop
	.dbline 219
	nop
	.dbline 219
	.dbline 220
; if(PIN_SDA==0)com_data&=0xfe;
	sbic 0x13,1
	rjmp L59
	.dbline 220
	mov R24,R2
	andi R24,254
	sts _com_data,R24
	xjmp L60
L59:
	.dbline 221
; else com_data|=0x01;
	lds R24,_com_data
	ori R24,1
	sts _com_data,R24
L60:
	.dbline 222
	cbi 0x15,0
	.dbline 222
	.dbline 222
	nop
	.dbline 222
	nop
	.dbline 222
	nop
	.dbline 222
	nop
	.dbline 222
	nop
	.dbline 222
	nop
	.dbline 222
	nop
	.dbline 222
	nop
	.dbline 222
	.dbline 223
L56:
	.dbline 215
	inc R20
L58:
	.dbline 215
	cpi R20,8
	brlo L55
	.dbline 224
; SCL_0;Some_NOP();
; }					
; stop();				
	xcall _stop
	.dbline 225
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
	.dbline 229
; }					
; //********将RAM中b地址单元的数据写入24C01A中a地址单元中***********
; void wr_24c01(char a,char b)	
; {					
	.dbline 231
; uchar command;		
; DDRC=0x03;
	ldi R24,3
	out 0x14,R24
	.dbline 232
; SDA_1;Some_NOP();
	sbi 0x15,1
	.dbline 232
	.dbline 232
	nop
	.dbline 232
	nop
	.dbline 232
	nop
	.dbline 232
	nop
	.dbline 232
	nop
	.dbline 232
	nop
	.dbline 232
	nop
	.dbline 232
	nop
	.dbline 232
	.dbline 233
; SCL_0;Some_NOP();
	cbi 0x15,0
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
; start();				
	xcall _start
	.dbline 235
; command=160;			
	ldi R24,160
	mov R10,R24
	.dbline 236
; shift8(command);		
	mov R16,R24
	xcall _shift8
	.dbline 237
; ack();				
	xcall _ack
	.dbline 238
; shift8(a);				
	mov R16,R22
	xcall _shift8
	.dbline 239
; ack();				
	xcall _ack
	.dbline 240
; shift8(b);				
	mov R16,R20
	xcall _shift8
	.dbline 241
; ack();				
	xcall _ack
	.dbline 242
; stop();				
	xcall _stop
	.dbline 243
; Some_NOP();
	.dbline 243
	nop
	.dbline 243
	nop
	.dbline 243
	nop
	.dbline 243
	nop
	.dbline 243
	nop
	.dbline 243
	nop
	.dbline 243
	nop
	.dbline 243
	nop
	.dbline 243
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
	.dbline 247
; }					
; //**************延时子函数***********
; void delay_iic(int n)		
; {					
	.dbline 249
	ldi R20,1
	ldi R21,0
	xjmp L66
L63:
	.dbline 249
	.dbline 249
	.dbline 249
L64:
	.dbline 249
	subi R20,255  ; offset = 1
	sbci R21,255
L66:
	.dbline 249
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
	.dbfunc e main _main fV
;        key_val -> R10
;         rd_val -> R22
;         wr_val -> R20
	.even
_main::
	sbiw R28,2
	.dbline -1
	.dbline 253
; }					
; //******************************************
; void main(void)				
; {
	.dbline 254
;  	 uchar key_val,wr_val=0,rd_val=0;	
	clr R20
	.dbline 254
	clr R22
	.dbline 255
; 	 port_init();
	xcall _port_init
	.dbline 256
;     Delay_nms(400);			
	ldi R16,400
	ldi R17,1
	xcall _Delay_nms
	.dbline 257
; 	InitLcd();				
	xcall _InitLcd
	.dbline 258
; 	LcdWriteCommand(0x01,1); 
	ldi R18,1
	ldi R16,1
	xcall _LcdWriteCommand
	.dbline 259
; 	LcdWriteCommand(0x0c,1);	
	ldi R18,1
	ldi R16,12
	xcall _LcdWriteCommand
	.dbline 260
; 	ePutstr(0,0,str0);  
	ldi R24,<_str0
	ldi R25,>_str0
	std y+1,R25
	std y+0,R24
	clr R18
	clr R16
	xcall _ePutstr
	.dbline 261
; 	Delay_nms(10);
	ldi R16,10
	ldi R17,0
	xcall _Delay_nms
	.dbline 262
; 	ePutstr(0,1,str1);   
	ldi R24,<_str1
	ldi R25,>_str1
	std y+1,R25
	std y+0,R24
	ldi R18,1
	clr R16
	xcall _ePutstr
	.dbline 263
; 	Delay_nms(10);
	ldi R16,10
	ldi R17,0
	xcall _Delay_nms
	xjmp L69
L68:
	.dbline 266
; 	/********************************************/
; 		while(1)           
; 		{
	.dbline 267
; 		  DisplayOneChar(9,0,wr_val/100+0x30);
	ldi R17,100
	mov R16,R20
	xcall div8u
	mov R24,R16
	subi R24,208    ; addi 48
	std y+0,R24
	clr R18
	ldi R16,9
	xcall _DisplayOneChar
	.dbline 268
; 		   Delay_nms(10);
	ldi R16,10
	ldi R17,0
	xcall _Delay_nms
	.dbline 269
; 		   DisplayOneChar(10,0,(wr_val/10)%10+0x30); 
	ldi R17,10
	mov R16,R20
	xcall div8u
	ldi R17,10
	xcall mod8u
	mov R24,R16
	subi R24,208    ; addi 48
	std y+0,R24
	clr R18
	ldi R16,10
	xcall _DisplayOneChar
	.dbline 270
; 		   Delay_nms(10); 
	ldi R16,10
	ldi R17,0
	xcall _Delay_nms
	.dbline 271
; 		   DisplayOneChar(11,0,wr_val%10+0x30);	  
	ldi R17,10
	mov R16,R20
	xcall mod8u
	mov R24,R16
	subi R24,208    ; addi 48
	std y+0,R24
	clr R18
	ldi R16,11
	xcall _DisplayOneChar
	.dbline 272
; 		   Delay_nms(10); 
	ldi R16,10
	ldi R17,0
	xcall _Delay_nms
	.dbline 274
; 	   
; 		   DisplayOneChar(8,1,rd_val/100+0x30);	  
	ldi R17,100
	mov R16,R22
	xcall div8u
	mov R24,R16
	subi R24,208    ; addi 48
	std y+0,R24
	ldi R18,1
	ldi R16,8
	xcall _DisplayOneChar
	.dbline 275
; 		   Delay_nms(10); 
	ldi R16,10
	ldi R17,0
	xcall _Delay_nms
	.dbline 276
; 		   DisplayOneChar(9,1,(rd_val/10%10)+0x30);	 
	ldi R17,10
	mov R16,R22
	xcall div8u
	ldi R17,10
	xcall mod8u
	mov R24,R16
	subi R24,208    ; addi 48
	std y+0,R24
	ldi R18,1
	ldi R16,9
	xcall _DisplayOneChar
	.dbline 277
; 		   Delay_nms(10); 
	ldi R16,10
	ldi R17,0
	xcall _Delay_nms
	.dbline 278
; 		   DisplayOneChar(10,1,rd_val%10+0x30);	 
	ldi R17,10
	mov R16,R22
	xcall mod8u
	mov R24,R16
	subi R24,208    ; addi 48
	std y+0,R24
	ldi R18,1
	ldi R16,10
	xcall _DisplayOneChar
	.dbline 279
; 		   Delay_nms(10); 
	ldi R16,10
	ldi R17,0
	xcall _Delay_nms
	.dbline 281
; 		   
; 		   key_val=scan_key();
	xcall _scan_key
	mov R10,R16
	.dbline 282
; 		   switch(key_val)
	mov R12,R10
	clr R13
	movw R24,R12
	cpi R24,191
	ldi R30,0
	cpc R25,R30
	breq L80
	ldi R24,191
	cp R24,R12
	cpc R25,R13
	brlt L83
L82:
	movw R24,R12
	cpi R24,127
	ldi R30,0
	cpc R25,R30
	breq L81
	xjmp L72
L83:
	movw R24,R12
	cpi R24,223
	ldi R30,0
	cpc R25,R30
	breq L77
	cpi R24,223
	ldi R30,0
	cpc R25,R30
	brlt L72
L84:
	movw R24,R12
	cpi R24,239
	ldi R30,0
	cpc R25,R30
	breq L74
	xjmp L72
X0:
	.dbline 283
; 	   	   {				
L74:
	.dbline 284
; 	   	   	case 0xef:if(wr_val<255)wr_val++;break;
	cpi R20,255
	brsh L72
	.dbline 284
	inc R20
	.dbline 284
	xjmp L72
L77:
	.dbline 285
; 	   		case 0xdf:if(wr_val>0)wr_val--;break;
	clr R2
	cp R2,R20
	brsh L72
	.dbline 285
	dec R20
	.dbline 285
	xjmp L72
L80:
	.dbline 286
; 	   		case 0xbf:wr_24c01(10,wr_val);delay_iic(2500);
	mov R18,R20
	ldi R16,10
	xcall _wr_24c01
	.dbline 286
	ldi R16,2500
	ldi R17,9
	xcall _delay_iic
	.dbline 287
; 				 DisplayOneChar(15,0,0xef);break;	
	ldi R24,239
	std y+0,R24
	clr R18
	ldi R16,15
	xcall _DisplayOneChar
	.dbline 287
	xjmp L72
L81:
	.dbline 288
; 	   		case 0x7f:rd_val=rd_24c01(10);delay_iic(2500);
	ldi R16,10
	xcall _rd_24c01
	mov R22,R16
	.dbline 288
	ldi R16,2500
	ldi R17,9
	xcall _delay_iic
	.dbline 289
; 			     DisplayOneChar(15,1,0xef);break;	
	ldi R24,239
	std y+0,R24
	ldi R18,1
	ldi R16,15
	xcall _DisplayOneChar
	.dbline 289
	.dbline 290
; 	   		default:break;		
L72:
	.dbline 292
	ldi R16,200
	ldi R17,0
	xcall _Delay_nms
	.dbline 293
	ldi R24,32
	std y+0,R24
	clr R18
	ldi R16,15
	xcall _DisplayOneChar
	.dbline 293
	ldi R16,10
	ldi R17,0
	xcall _Delay_nms
	.dbline 294
	ldi R24,32
	std y+0,R24
	ldi R18,1
	ldi R16,15
	xcall _DisplayOneChar
	.dbline 294
	ldi R16,10
	ldi R17,0
	xcall _Delay_nms
	.dbline 296
L69:
	.dbline 265
	xjmp L68
X1:
	.dbline -2
L67:
	adiw R28,2
	.dbline 0 ; func end
	ret
	.dbsym r key_val 10 c
	.dbsym r rd_val 22 c
	.dbsym r wr_val 20 c
	.dbend
	.area bss(ram, con, rel)
	.dbfile d:\MYDOCU~1\ac15-1\ac15-1.c
_cnt::
	.blkb 1
	.dbsym e cnt _cnt c
_com_data::
	.blkb 1
	.dbsym e com_data _com_data c
