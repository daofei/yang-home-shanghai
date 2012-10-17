	.module ac15-3.c
	.area lit(rom, con, rel)
_str0::
	.byte 'W,'r,'i,'t,'e,32,58,32,0
	.dbfile d:\MYDOCU~1\ac15-3\ac15-3.c
	.dbsym e str0 _str0 A[9:9]kc
_str1::
	.byte 'R,'e,'a,'d,32,58,32,0
	.dbsym e str1 _str1 A[8:8]kc
	.area text(rom, con, rel)
	.dbfile d:\MYDOCU~1\ac15-3\ac15-3.c
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
	.dbline 63
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
; 
; #define rd_device_add 0xa1
; #define wr_device_add 0xa0
; 
; //======================================
; //TWI状态定义
; //MT 主方式传输  MR 主方式接收
; #define START 0x08 
; #define RE_START 0x10
; #define MT_SLA_ACK 0x18
; #define MT_SLA_NOACK 0x20
; #define MT_DATA_ACK  0x28
; #define MT_DATA_NOACK 0x30
; #define MR_SLA_ACK  0x40
; #define MR_SLA_NOACK 0x48
; #define MR_DATA_ACK 0x50
; #define MR_DATA_NOACK 0x58
; 
; //常用TWI操作(主模式写和主模式读)
; #define Start()    	  (TWCR=(1<<TWINT)|(1<<TWSTA)|(1<<TWEN))
; #define Stop()     	  (TWCR=(1<<TWINT)|(1<<TWSTO)|(1<<TWEN))
; #define Wait()	   	  {while(!(TWCR&(1<<TWINT)));}
; #define TestAck() 	  (TWSR&0xf8)
; #define SetAck()	  (TWCR|=(1<<TWEA))
; #define SetNoAck()    (TWCR&=~(1<<TWEA))
; #define Twi()	  	  (TWCR=(1<<TWINT)|(1<<TWEN))
; #define Write8Bit(x)  {TWDR=(x);TWCR=(1<<TWINT)|(1<<TWEN);} 
; 
; #define DataPort PORTA		
; #define Busy 0x80			
; #define xtal 8   			
; 
; //=====================================
; const uchar str0[]={"Write : "};//待显字符串
; const uchar str1[]={"Read : "};//待显字符串
; 
; //========函数声明=========
; void WaitForEnable(void);
; void LcdWriteData(uchar W);
; void LcdWriteCommand(uchar CMD,uchar Attribc);
; void InitLcd(void);
; void Display(uchar dd);
; void DisplayOneChar(uchar x,uchar y,uchar Wdata);
; void ePutstr(uchar x,uchar y,uchar const *ptr);
; void port_init(void);
; void delay_ms(unsigned int time);
; void delay_us(int time);
; 
; //**********************显示指定座标的一串字符子函数**************
; void ePutstr(uchar x,uchar y,uchar const *ptr)
; {
	.dbline 64
; uchar i,l=0;
	clr R20
	xjmp L3
L2:
	.dbline 65
	.dbline 65
	inc R20
	.dbline 65
L3:
	.dbline 65
; 	while(ptr[l]>31){l++;}
	mov R30,R20
	clr R31
	add R30,R10
	adc R31,R11
	lpm R30,Z
	ldi R24,31
	cp R24,R30
	brlo L2
	.dbline 66
	clr R22
	xjmp L8
L5:
	.dbline 66
; 	for(i=0;i<l;i++){
	.dbline 67
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
	.dbline 68
; 	if(x==16){
	mov R24,R14
	cpi R24,16
	brne L9
	.dbline 68
	.dbline 69
; 		x=0;y^=1;
	clr R14
	.dbline 69
	ldi R24,1
	eor R12,R24
	.dbline 70
; 	}
L9:
	.dbline 71
L6:
	.dbline 66
	inc R22
L8:
	.dbline 66
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
	.dbline 76
;   }
; }
; 
; //*******************显示光标定位子函数******************
; void LocateXY(char posx,char posy)
; {
	.dbline 78
; uchar temp;
; 	temp&=0x7f;
	andi R20,127
	.dbline 79
; 	temp=posx&0x0f;
	mov R20,R10
	andi R20,15
	.dbline 80
; 	posy&=0x01;
	andi R22,1
	.dbline 81
; 	if(posy)temp|=0x40;
	breq L12
	.dbline 81
	ori R20,64
L12:
	.dbline 82
; 	temp|=0x80;
	ori R20,128
	.dbline 83
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
	.dbline 88
; }
; 
; //*******************显示指定座标的一个字符子函数*******************
; void DisplayOneChar(uchar x,uchar y,uchar Wdata)
; {
	.dbline 89
; LocateXY(x,y);
	mov R18,R22
	mov R16,R20
	xcall _LocateXY
	.dbline 90
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
	.dbline 95
; }
; 
; //*******************LCD初始化子函数*********************
; void InitLcd(void) 
; {
	.dbline 96
; LcdWriteCommand(0x38,0); 
	clr R18
	ldi R16,56
	xcall _LcdWriteCommand
	.dbline 97
; delay_ms(5);
	ldi R16,5
	ldi R17,0
	xcall _delay_ms
	.dbline 98
; LcdWriteCommand(0x38,0); 
	clr R18
	ldi R16,56
	xcall _LcdWriteCommand
	.dbline 99
; delay_ms(5);
	ldi R16,5
	ldi R17,0
	xcall _delay_ms
	.dbline 100
; LcdWriteCommand(0x38,0); 
	clr R18
	ldi R16,56
	xcall _LcdWriteCommand
	.dbline 101
; delay_ms(5);
	ldi R16,5
	ldi R17,0
	xcall _delay_ms
	.dbline 102
; LcdWriteCommand(0x38,1); 
	ldi R18,1
	ldi R16,56
	xcall _LcdWriteCommand
	.dbline 103
; LcdWriteCommand(0x08,1); 
	ldi R18,1
	ldi R16,8
	xcall _LcdWriteCommand
	.dbline 104
; LcdWriteCommand(0x01,1); 
	ldi R18,1
	ldi R16,1
	xcall _LcdWriteCommand
	.dbline 105
; LcdWriteCommand(0x06,1); 
	ldi R18,1
	ldi R16,6
	xcall _LcdWriteCommand
	.dbline 106
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
	.dbline 111
; }
; 
; //********************写命令到LCM子函数********************
; void LcdWriteCommand(uchar CMD,uchar Attribc)
; {
	.dbline 112
; if(Attribc)WaitForEnable();
	tst R22
	breq L17
	.dbline 112
	xcall _WaitForEnable
L17:
	.dbline 113
; LCM_RS_0;LCM_RW_0;_NOP();
	cbi 0x18,0
	.dbline 113
	cbi 0x18,1
	.dbline 113
	nop
	.dbline 114
; DataPort=CMD;_NOP();
	out 0x1b,R20
	.dbline 114
	nop
	.dbline 115
; LCM_EN_1;_NOP();_NOP();LCM_EN_0;
	sbi 0x18,2
	.dbline 115
	nop
	.dbline 115
	nop
	.dbline 115
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
	.dbline 120
; }
; 
; //*******************写数据到LCM子函数********************
; void LcdWriteData(uchar dataW)
; {
	.dbline 121
; WaitForEnable();
	xcall _WaitForEnable
	.dbline 122
; LCM_RS_1;LCM_RW_0;_NOP();
	sbi 0x18,0
	.dbline 122
	cbi 0x18,1
	.dbline 122
	nop
	.dbline 123
; DataPort=dataW;_NOP();
	out 0x1b,R20
	.dbline 123
	nop
	.dbline 124
; LCM_EN_1;_NOP();_NOP();LCM_EN_0;
	sbi 0x18,2
	.dbline 124
	nop
	.dbline 124
	nop
	.dbline 124
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
	.dbline 129
; }
; 
; //*******************检测LCD忙信号子函数*********************
; void WaitForEnable(void)
; {
	.dbline 131
; uchar val;
; DataPort=0xff;
	ldi R24,255
	out 0x1b,R24
	.dbline 132
; LCM_RS_0;LCM_RW_1;_NOP();
	cbi 0x18,0
	.dbline 132
	sbi 0x18,1
	.dbline 132
	nop
	.dbline 133
; LCM_EN_1;_NOP();_NOP();
	sbi 0x18,2
	.dbline 133
	nop
	.dbline 133
	nop
	.dbline 134
; DDRA=0x00;
	clr R2
	out 0x1a,R2
	.dbline 135
; val=PINA;
	in R16,0x19
	xjmp L22
L21:
	.dbline 136
	in R16,0x19
L22:
	.dbline 136
; while(val&Busy)val=PINA;
	sbrc R16,7
	rjmp L21
	.dbline 137
; LCM_EN_0;
	cbi 0x18,2
	.dbline 138
; DDRA=0xff;
	ldi R24,255
	out 0x1a,R24
	.dbline -2
L20:
	.dbline 0 ; func end
	ret
	.dbsym r val 16 c
	.dbend
	.dbfunc e port_init _port_init fV
	.even
_port_init::
	.dbline -1
	.dbline 143
; }
; 
; /********************端口初始化******************/
; void port_init(void)
; {
	.dbline 144
;  PORTA = 0x00;
	clr R2
	out 0x1b,R2
	.dbline 145
;  DDRA  = 0xFF;
	ldi R24,255
	out 0x1a,R24
	.dbline 146
;  PORTB = 0x00;
	out 0x18,R2
	.dbline 147
;  DDRB  = 0xFF;
	out 0x17,R24
	.dbline 148
;  PORTC = 0x00; 
	out 0x15,R2
	.dbline 149
;  DDRC  = 0x03;
	ldi R24,3
	out 0x14,R24
	.dbline 150
;  PORTD = 0xFF;
	ldi R24,255
	out 0x12,R24
	.dbline 151
;  DDRD  = 0x00;
	out 0x11,R2
	.dbline -2
L24:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e scan_key _scan_key fc
;           temp -> R16
	.even
_scan_key::
	.dbline -1
	.dbline 156
; }
; 
; /*******************扫描按键******************/
; uchar scan_key(void)		
; {					
	.dbline 158
; uchar temp;			
; temp=PIND;				
	in R16,0x10
	.dbline 159
; return temp;			
	.dbline -2
L25:
	.dbline 0 ; func end
	ret
	.dbsym r temp 16 c
	.dbend
	.dbfunc e i2c_Read _i2c_Read fc
;           temp -> R20
;     RomAddress -> R16
	.even
_i2c_Read::
	xcall push_gset1
	.dbline -1
	.dbline 167
; }					
; 
; /******************************************
;                I2C总线读一个字节
; 			   如果读失败返回0
; *******************************************/
; unsigned char i2c_Read(unsigned char RomAddress) 
;       {
	.dbline 169
; 	   unsigned char temp;
; 	   Start();
	ldi R24,164
	out 0x36,R24
	.dbline 170
L27:
	.dbline 170
L28:
	.dbline 170
; 	   Wait();
	in R2,0x36
	sbrs R2,7
	rjmp L27
	.dbline 170
	.dbline 170
	.dbline 171
; 	   if (TestAck()!=START) return 0;	   
	in R24,0x1
	andi R24,248
	cpi R24,8
	breq L30
	.dbline 171
	clr R16
	xjmp L26
L30:
	.dbline 172
; 	   Write8Bit(wr_device_add);
	.dbline 172
	ldi R24,160
	out 0x3,R24
	.dbline 172
	ldi R24,132
	out 0x36,R24
	.dbline 172
	.dbline 172
	.dbline 173
L32:
	.dbline 173
L33:
	.dbline 173
; 	   Wait(); 
	in R2,0x36
	sbrs R2,7
	rjmp L32
	.dbline 173
	.dbline 173
	.dbline 174
; 	   if (TestAck()!=MT_SLA_ACK) return 0;
	in R24,0x1
	andi R24,248
	cpi R24,24
	breq L35
	.dbline 174
	clr R16
	xjmp L26
L35:
	.dbline 175
; 	   Write8Bit(RomAddress);
	.dbline 175
	out 0x3,R16
	.dbline 175
	ldi R24,132
	out 0x36,R24
	.dbline 175
	.dbline 175
	.dbline 176
L37:
	.dbline 176
L38:
	.dbline 176
; 	   Wait();
	in R2,0x36
	sbrs R2,7
	rjmp L37
	.dbline 176
	.dbline 176
	.dbline 177
; 	   if (TestAck()!=MT_DATA_ACK) return 0;
	in R24,0x1
	andi R24,248
	cpi R24,40
	breq L40
	.dbline 177
	clr R16
	xjmp L26
L40:
	.dbline 178
; 	   Start();
	ldi R24,164
	out 0x36,R24
	.dbline 179
L42:
	.dbline 179
L43:
	.dbline 179
; 	   Wait();
	in R2,0x36
	sbrs R2,7
	rjmp L42
	.dbline 179
	.dbline 179
	.dbline 180
; 	   if (TestAck()!=RE_START)  return 0;
	in R24,0x1
	andi R24,248
	cpi R24,16
	breq L45
	.dbline 180
	clr R16
	xjmp L26
L45:
	.dbline 181
; 	   Write8Bit(rd_device_add);
	.dbline 181
	ldi R24,161
	out 0x3,R24
	.dbline 181
	ldi R24,132
	out 0x36,R24
	.dbline 181
	.dbline 181
	.dbline 182
L47:
	.dbline 182
L48:
	.dbline 182
; 	   Wait();
	in R2,0x36
	sbrs R2,7
	rjmp L47
	.dbline 182
	.dbline 182
	.dbline 183
; 	   if(TestAck()!=MR_SLA_ACK)  return 0;
	in R24,0x1
	andi R24,248
	cpi R24,64
	breq L50
	.dbline 183
	clr R16
	xjmp L26
L50:
	.dbline 184
; 	   Twi();
	ldi R24,132
	out 0x36,R24
	.dbline 185
L52:
	.dbline 185
L53:
	.dbline 185
; 	   Wait();
	in R2,0x36
	sbrs R2,7
	rjmp L52
	.dbline 185
	.dbline 185
	.dbline 186
; 	   if(TestAck()!=MR_DATA_NOACK) return 0;	
	in R24,0x1
	andi R24,248
	cpi R24,88
	breq L55
	.dbline 186
	clr R16
	xjmp L26
L55:
	.dbline 187
; 	   temp=TWDR;
	in R20,0x3
	.dbline 188
;        Stop();
	ldi R24,148
	out 0x36,R24
	.dbline 189
; 	   return temp;
	mov R16,R20
	.dbline -2
L26:
	xcall pop_gset1
	.dbline 0 ; func end
	ret
	.dbsym r temp 20 c
	.dbsym r RomAddress 16 c
	.dbend
	.dbfunc e i2c_Write _i2c_Write fc
;          Wdata -> R20
;     RomAddress -> R22
	.even
_i2c_Write::
	xcall push_gset2
	mov R20,R18
	mov R22,R16
	.dbline -1
	.dbline 198
;       }
; 	  
; /******************************************
;                I2C总线写一个字节
; 			    返回0:写成功
; 				返回非0:写失败
; *******************************************/
; unsigned char i2c_Write(unsigned char RomAddress,unsigned char Wdata) 
; {
	.dbline 199
; 	  Start();
	ldi R24,164
	out 0x36,R24
	.dbline 200
L58:
	.dbline 200
L59:
	.dbline 200
; 	  Wait();
	in R2,0x36
	sbrs R2,7
	rjmp L58
	.dbline 200
	.dbline 200
	.dbline 201
; 	  if(TestAck()!=START) return 1;
	in R24,0x1
	andi R24,248
	cpi R24,8
	breq L61
	.dbline 201
	ldi R16,1
	xjmp L57
L61:
	.dbline 202
; 	  Write8Bit(wr_device_add);
	.dbline 202
	ldi R24,160
	out 0x3,R24
	.dbline 202
	ldi R24,132
	out 0x36,R24
	.dbline 202
	.dbline 202
	.dbline 203
L63:
	.dbline 203
L64:
	.dbline 203
; 	  Wait();
	in R2,0x36
	sbrs R2,7
	rjmp L63
	.dbline 203
	.dbline 203
	.dbline 204
; 	  if(TestAck()!=MT_SLA_ACK) return 1;
	in R24,0x1
	andi R24,248
	cpi R24,24
	breq L66
	.dbline 204
	ldi R16,1
	xjmp L57
L66:
	.dbline 205
; 	  Write8Bit(RomAddress);
	.dbline 205
	out 0x3,R22
	.dbline 205
	ldi R24,132
	out 0x36,R24
	.dbline 205
	.dbline 205
	.dbline 206
L68:
	.dbline 206
L69:
	.dbline 206
; 	  Wait();
	in R2,0x36
	sbrs R2,7
	rjmp L68
	.dbline 206
	.dbline 206
	.dbline 207
; 	  if(TestAck()!=MT_DATA_ACK) return 1;
	in R24,0x1
	andi R24,248
	cpi R24,40
	breq L71
	.dbline 207
	ldi R16,1
	xjmp L57
L71:
	.dbline 208
; 	  Write8Bit(Wdata);
	.dbline 208
	out 0x3,R20
	.dbline 208
	ldi R24,132
	out 0x36,R24
	.dbline 208
	.dbline 208
	.dbline 209
L73:
	.dbline 209
L74:
	.dbline 209
; 	  Wait();
	in R2,0x36
	sbrs R2,7
	rjmp L73
	.dbline 209
	.dbline 209
	.dbline 210
; 	  if(TestAck()!=MT_DATA_ACK) return 1;	
	in R24,0x1
	andi R24,248
	cpi R24,40
	breq L76
	.dbline 210
	ldi R16,1
	xjmp L57
L76:
	.dbline 211
; 	  Stop();
	ldi R24,148
	out 0x36,R24
	.dbline 212
;  	  delay_ms(10);
	ldi R16,10
	ldi R17,0
	xcall _delay_ms
	.dbline 213
; 	  return 0;
	clr R16
	.dbline -2
L57:
	xcall pop_gset2
	.dbline 0 ; func end
	ret
	.dbsym r Wdata 20 c
	.dbsym r RomAddress 22 c
	.dbend
	.dbfunc e main _main fV
;        key_val -> R10
;         rd_val -> R22
;         wr_val -> R20
	.even
_main::
	sbiw R28,2
	.dbline -1
	.dbline 218
; }
; 
; //******************************************
; void main(void)				
; {
	.dbline 219
;  	 uchar key_val,wr_val=0,rd_val=0;	
	clr R20
	.dbline 219
	clr R22
	.dbline 220
; 	 port_init();
	xcall _port_init
	.dbline 221
;     delay_ms(400);			
	ldi R16,400
	ldi R17,1
	xcall _delay_ms
	.dbline 222
; 	InitLcd();				
	xcall _InitLcd
	.dbline 223
; 	LcdWriteCommand(0x01,1); 
	ldi R18,1
	ldi R16,1
	xcall _LcdWriteCommand
	.dbline 224
; 	LcdWriteCommand(0x0c,1);	 
	ldi R18,1
	ldi R16,12
	xcall _LcdWriteCommand
	.dbline 225
; 	ePutstr(0,0,str0);  
	ldi R24,<_str0
	ldi R25,>_str0
	std y+1,R25
	std y+0,R24
	clr R18
	clr R16
	xcall _ePutstr
	.dbline 226
; 	delay_ms(10);
	ldi R16,10
	ldi R17,0
	xcall _delay_ms
	.dbline 227
; 	ePutstr(0,1,str1);   
	ldi R24,<_str1
	ldi R25,>_str1
	std y+1,R25
	std y+0,R24
	ldi R18,1
	clr R16
	xcall _ePutstr
	.dbline 228
; 	delay_ms(10);
	ldi R16,10
	ldi R17,0
	xcall _delay_ms
	xjmp L80
L79:
	.dbline 231
; 	/********************************************/
; 		while(1)              
; 		{
	.dbline 232
; 		   DisplayOneChar(9,0,wr_val/100+0x30);	 
	ldi R17,100
	mov R16,R20
	xcall div8u
	mov R24,R16
	subi R24,208    ; addi 48
	std y+0,R24
	clr R18
	ldi R16,9
	xcall _DisplayOneChar
	.dbline 233
; 		   delay_ms(10);
	ldi R16,10
	ldi R17,0
	xcall _delay_ms
	.dbline 234
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
	.dbline 235
; 		   delay_ms(10);
	ldi R16,10
	ldi R17,0
	xcall _delay_ms
	.dbline 236
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
	.dbline 237
; 		   delay_ms(10);
	ldi R16,10
	ldi R17,0
	xcall _delay_ms
	.dbline 239
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
	.dbline 240
; 		   delay_ms(10);
	ldi R16,10
	ldi R17,0
	xcall _delay_ms
	.dbline 241
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
	.dbline 242
; 		   delay_ms(10);
	ldi R16,10
	ldi R17,0
	xcall _delay_ms
	.dbline 243
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
	.dbline 244
; 		   delay_ms(10);
	ldi R16,10
	ldi R17,0
	xcall _delay_ms
	.dbline 246
; 		   
; 		   key_val=scan_key();	
	xcall _scan_key
	mov R10,R16
	.dbline 247
; 		   switch(key_val)		
	mov R12,R10
	clr R13
	movw R24,R12
	cpi R24,191
	ldi R30,0
	cpc R25,R30
	breq L91
	ldi R24,191
	cp R24,R12
	cpc R25,R13
	brlt L94
L93:
	movw R24,R12
	cpi R24,127
	ldi R30,0
	cpc R25,R30
	breq L92
	xjmp L83
L94:
	movw R24,R12
	cpi R24,223
	ldi R30,0
	cpc R25,R30
	breq L88
	cpi R24,223
	ldi R30,0
	cpc R25,R30
	brlt L83
L95:
	movw R24,R12
	cpi R24,239
	ldi R30,0
	cpc R25,R30
	breq L85
	xjmp L83
X0:
	.dbline 248
; 	   	   {				
L85:
	.dbline 249
; 	   	   	case 0xef:if(wr_val<255)wr_val++;break;	
	cpi R20,255
	brsh L83
	.dbline 249
	inc R20
	.dbline 249
	xjmp L83
L88:
	.dbline 250
; 	   		case 0xdf:if(wr_val>0)wr_val--;break;	
	clr R2
	cp R2,R20
	brsh L83
	.dbline 250
	dec R20
	.dbline 250
	xjmp L83
L91:
	.dbline 251
; 	   		case 0xbf:i2c_Write(10,wr_val); 
	mov R18,R20
	ldi R16,10
	xcall _i2c_Write
	.dbline 252
; 				 DisplayOneChar(15,0,0xef);break;
	ldi R24,239
	std y+0,R24
	clr R18
	ldi R16,15
	xcall _DisplayOneChar
	.dbline 252
	xjmp L83
L92:
	.dbline 253
; 	   		case 0x7f:rd_val=i2c_Read(10); 
	ldi R16,10
	xcall _i2c_Read
	mov R22,R16
	.dbline 254
; 			     DisplayOneChar(15,1,0xef);break;
	ldi R24,239
	std y+0,R24
	ldi R18,1
	ldi R16,15
	xcall _DisplayOneChar
	.dbline 254
	.dbline 255
; 	   		default:break;		
L83:
	.dbline 257
	ldi R16,200
	ldi R17,0
	xcall _delay_ms
	.dbline 258
	ldi R24,32
	std y+0,R24
	clr R18
	ldi R16,15
	xcall _DisplayOneChar
	.dbline 258
	ldi R16,10
	ldi R17,0
	xcall _delay_ms
	.dbline 259
	ldi R24,32
	std y+0,R24
	ldi R18,1
	ldi R16,15
	xcall _DisplayOneChar
	.dbline 259
	ldi R16,10
	ldi R17,0
	xcall _delay_ms
	.dbline 261
L80:
	.dbline 230
	xjmp L79
X1:
	.dbline -2
L78:
	adiw R28,2
	.dbline 0 ; func end
	ret
	.dbsym r key_val 10 c
	.dbsym r rd_val 22 c
	.dbsym r wr_val 20 c
	.dbend
	.dbfunc e delay_ms _delay_ms fV
;           time -> R20,R21
	.even
_delay_ms::
	xcall push_gset1
	movw R20,R16
	.dbline -1
	.dbline 267
; 	   		}				
; 			delay_ms(200); 
; 			DisplayOneChar(15,0,0x20);delay_ms(10); 
; 			DisplayOneChar(15,1,0x20);delay_ms(10); 
; 					
;   		 }				
; 	
; }
; 		   
; /*********************延时time*1ms子函数*********************/
; void delay_ms(unsigned int time)
; 	 {
	xjmp L98
L97:
	.dbline 269
	.dbline 270
	ldi R16,1000
	ldi R17,3
	xcall _delay_us
	.dbline 271
	subi R20,1
	sbci R21,0
	.dbline 272
L98:
	.dbline 268
; 	  while(time!=0)
	cpi R20,0
	cpc R20,R21
	brne L97
X2:
	.dbline -2
L96:
	xcall pop_gset1
	.dbline 0 ; func end
	ret
	.dbsym r time 20 i
	.dbend
	.dbfunc e delay_us _delay_us fV
;           time -> R16,R17
	.even
_delay_us::
	.dbline -1
	.dbline 277
; 	  	  {		
; 		   delay_us(1000);
; 		   time--;
; 		  }
; 	 }
; 	 					
; /********************延时子函数*********************/
; void delay_us(int time)
; 	 {     
L101:
	.dbline 279
;   	  do
; 	  	{
	.dbline 280
; 		 time--;
	subi R16,1
	sbci R17,0
	.dbline 281
; 		}	
L102:
	.dbline 282
;   	  while (time>1);
	ldi R24,1
	ldi R25,0
	cp R24,R16
	cpc R25,R17
	brlt L101
	.dbline -2
L100:
	.dbline 0 ; func end
	ret
	.dbsym r time 16 I
	.dbend
