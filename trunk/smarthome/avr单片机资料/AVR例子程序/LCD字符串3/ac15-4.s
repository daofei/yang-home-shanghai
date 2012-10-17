	.module ac15-4.c
	.area lit(rom, con, rel)
_str0::
	.byte 45,'T,'i,'m,'e,32,32,32,58,32,32,58,32,32,45,45
	.byte 0
	.dbfile d:\MYDOCU~1\ac15-4\ac15-4.c
	.dbsym e str0 _str0 A[17:17]kc
_str1::
	.byte 45,'A,'T,'i,'m,'e,32,32,32,58,32,32,58,32,45,45
	.byte 0
	.dbsym e str1 _str1 A[17:17]kc
	.area text(rom, con, rel)
	.dbfile d:\MYDOCU~1\ac15-4\ac15-4.c
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
	.dbline 66
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
; #define LED_1 PORTB|=BIT(PB7)
; #define LED_0 PORTB&=~BIT(PB7)
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
; //======================================
; const uchar str0[]={"-Time   :  :  --"};//待显字符串
; const uchar str1[]={"-ATime   :  : --"};//待显字符串
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
; void init_devices(void);
; 
; //**********************显示指定座标的一串字符子函数**************
; void ePutstr(uchar x,uchar y,uchar const *ptr)
; {
	.dbline 67
; uchar i,l=0;
	clr R20
	xjmp L3
L2:
	.dbline 68
	.dbline 68
	inc R20
	.dbline 68
L3:
	.dbline 68
; 	while(ptr[l]>31){l++;}
	mov R30,R20
	clr R31
	add R30,R10
	adc R31,R11
	lpm R30,Z
	ldi R24,31
	cp R24,R30
	brlo L2
	.dbline 69
	clr R22
	xjmp L8
L5:
	.dbline 69
; 	for(i=0;i<l;i++){
	.dbline 70
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
	.dbline 71
; 	if(x==16){
	mov R24,R14
	cpi R24,16
	brne L9
	.dbline 71
	.dbline 72
; 		x=0;y^=1;
	clr R14
	.dbline 72
	ldi R24,1
	eor R12,R24
	.dbline 73
; 	}
L9:
	.dbline 74
L6:
	.dbline 69
	inc R22
L8:
	.dbline 69
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
	.dbline 79
;   }
; }
; 
; //*******************显示光标定位子函数******************
; void LocateXY(char posx,char posy)
; {
	.dbline 81
; uchar temp;
; 	temp&=0x7f;
	andi R20,127
	.dbline 82
; 	temp=posx&0x0f;
	mov R20,R10
	andi R20,15
	.dbline 83
; 	posy&=0x01;
	andi R22,1
	.dbline 84
; 	if(posy)temp|=0x40;
	breq L12
	.dbline 84
	ori R20,64
L12:
	.dbline 85
; 	temp|=0x80;
	ori R20,128
	.dbline 86
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
	.dbline 91
; }
; 
; //*******************显示指定座标的一个字符子函数*******************
; void DisplayOneChar(uchar x,uchar y,uchar Wdata)
; {
	.dbline 92
; LocateXY(x,y);
	mov R18,R22
	mov R16,R20
	xcall _LocateXY
	.dbline 93
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
	.dbline 98
; }
; 
; //*******************LCD初始化子函数*********************
; void InitLcd(void) 
; {
	.dbline 99
; LcdWriteCommand(0x38,0); 
	clr R18
	ldi R16,56
	xcall _LcdWriteCommand
	.dbline 100
; delay_ms(5);
	ldi R16,5
	ldi R17,0
	xcall _delay_ms
	.dbline 101
; LcdWriteCommand(0x38,0); 
	clr R18
	ldi R16,56
	xcall _LcdWriteCommand
	.dbline 102
; delay_ms(5);
	ldi R16,5
	ldi R17,0
	xcall _delay_ms
	.dbline 103
; LcdWriteCommand(0x38,0);
	clr R18
	ldi R16,56
	xcall _LcdWriteCommand
	.dbline 104
; delay_ms(5);
	ldi R16,5
	ldi R17,0
	xcall _delay_ms
	.dbline 105
; LcdWriteCommand(0x38,1); 
	ldi R18,1
	ldi R16,56
	xcall _LcdWriteCommand
	.dbline 106
; LcdWriteCommand(0x08,1); 
	ldi R18,1
	ldi R16,8
	xcall _LcdWriteCommand
	.dbline 107
; LcdWriteCommand(0x01,1); 
	ldi R18,1
	ldi R16,1
	xcall _LcdWriteCommand
	.dbline 108
; LcdWriteCommand(0x06,1); 
	ldi R18,1
	ldi R16,6
	xcall _LcdWriteCommand
	.dbline 109
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
	.dbline 114
; }
; 
; //********************写命令到LCM子函数********************
; void LcdWriteCommand(uchar CMD,uchar Attribc)
; {
	.dbline 115
; if(Attribc)WaitForEnable();
	tst R22
	breq L17
	.dbline 115
	xcall _WaitForEnable
L17:
	.dbline 116
; LCM_RS_0;LCM_RW_0;_NOP();
	cbi 0x18,0
	.dbline 116
	cbi 0x18,1
	.dbline 116
	nop
	.dbline 117
; DataPort=CMD;_NOP();
	out 0x1b,R20
	.dbline 117
	nop
	.dbline 118
; LCM_EN_1;_NOP();_NOP();LCM_EN_0;
	sbi 0x18,2
	.dbline 118
	nop
	.dbline 118
	nop
	.dbline 118
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
	.dbline 123
; }
; 
; //*******************写数据到LCM子函数********************
; void LcdWriteData(uchar dataW)
; {
	.dbline 124
; WaitForEnable();
	xcall _WaitForEnable
	.dbline 125
; LCM_RS_1;LCM_RW_0;_NOP();
	sbi 0x18,0
	.dbline 125
	cbi 0x18,1
	.dbline 125
	nop
	.dbline 126
; DataPort=dataW;_NOP();
	out 0x1b,R20
	.dbline 126
	nop
	.dbline 127
; LCM_EN_1;_NOP();_NOP();LCM_EN_0;
	sbi 0x18,2
	.dbline 127
	nop
	.dbline 127
	nop
	.dbline 127
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
	.dbline 132
; }
; 
; //*******************检测LCD忙信号子函数*********************
; void WaitForEnable(void)
; {
	.dbline 134
; uchar val;
; DataPort=0xff;
	ldi R24,255
	out 0x1b,R24
	.dbline 135
; LCM_RS_0;LCM_RW_1;_NOP();
	cbi 0x18,0
	.dbline 135
	sbi 0x18,1
	.dbline 135
	nop
	.dbline 136
; LCM_EN_1;_NOP();_NOP();
	sbi 0x18,2
	.dbline 136
	nop
	.dbline 136
	nop
	.dbline 137
; DDRA=0x00;
	clr R2
	out 0x1a,R2
	.dbline 138
; val=PINA;
	in R16,0x19
	xjmp L22
L21:
	.dbline 139
	in R16,0x19
L22:
	.dbline 139
; while(val&Busy)val=PINA;
	sbrc R16,7
	rjmp L21
	.dbline 140
; LCM_EN_0;
	cbi 0x18,2
	.dbline 141
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
	.dbline 155
; }
; 
; /******************定义结构体变量time1,time2********************/
; struct date
; {
; uchar hour;
; uchar min;
; uchar sec;
; uchar dida;
; }time1,time2;
; 
; /******************端口初始化**********************/
; void port_init(void)
; {
	.dbline 156
;  PORTA = 0x00;
	clr R2
	out 0x1b,R2
	.dbline 157
;  DDRA  = 0xFF;
	ldi R24,255
	out 0x1a,R24
	.dbline 158
;  PORTB = 0x00;
	out 0x18,R2
	.dbline 159
;  DDRB  = 0xFF;
	out 0x17,R24
	.dbline 160
;  PORTC = 0x00; 
	out 0x15,R2
	.dbline 161
;  DDRC  = 0x03;
	ldi R24,3
	out 0x14,R24
	.dbline 162
;  PORTD = 0xFF;
	ldi R24,255
	out 0x12,R24
	.dbline 163
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
	.dbline 168
; }
; 
; /*****************扫描按键*****************/
; uchar scan_key(void)		
; {					
	.dbline 170
; uchar temp;			
; temp=PIND;				
	in R16,0x10
	.dbline 171
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
	.dbline 179
; }					
; 
; /******************************************
;                I2C总线读一个字节
; 			   如果读失败返回0
; *******************************************/
; unsigned char i2c_Read(unsigned char RomAddress) 
;       {
	.dbline 181
; 	   unsigned char temp;
; 	   Start();
	ldi R24,164
	out 0x36,R24
	.dbline 182
L27:
	.dbline 182
L28:
	.dbline 182
; 	   Wait();
	in R2,0x36
	sbrs R2,7
	rjmp L27
	.dbline 182
	.dbline 182
	.dbline 183
; 	   if (TestAck()!=START) return 0;	   
	in R24,0x1
	andi R24,248
	cpi R24,8
	breq L30
	.dbline 183
	clr R16
	xjmp L26
L30:
	.dbline 184
; 	   Write8Bit(wr_device_add);
	.dbline 184
	ldi R24,160
	out 0x3,R24
	.dbline 184
	ldi R24,132
	out 0x36,R24
	.dbline 184
	.dbline 184
	.dbline 185
L32:
	.dbline 185
L33:
	.dbline 185
; 	   Wait(); 
	in R2,0x36
	sbrs R2,7
	rjmp L32
	.dbline 185
	.dbline 185
	.dbline 186
; 	   if (TestAck()!=MT_SLA_ACK) return 0;
	in R24,0x1
	andi R24,248
	cpi R24,24
	breq L35
	.dbline 186
	clr R16
	xjmp L26
L35:
	.dbline 187
; 	   Write8Bit(RomAddress);
	.dbline 187
	out 0x3,R16
	.dbline 187
	ldi R24,132
	out 0x36,R24
	.dbline 187
	.dbline 187
	.dbline 188
L37:
	.dbline 188
L38:
	.dbline 188
; 	   Wait();
	in R2,0x36
	sbrs R2,7
	rjmp L37
	.dbline 188
	.dbline 188
	.dbline 189
; 	   if (TestAck()!=MT_DATA_ACK) return 0;
	in R24,0x1
	andi R24,248
	cpi R24,40
	breq L40
	.dbline 189
	clr R16
	xjmp L26
L40:
	.dbline 190
; 	   Start();
	ldi R24,164
	out 0x36,R24
	.dbline 191
L42:
	.dbline 191
L43:
	.dbline 191
; 	   Wait();
	in R2,0x36
	sbrs R2,7
	rjmp L42
	.dbline 191
	.dbline 191
	.dbline 192
; 	   if (TestAck()!=RE_START)  return 0;
	in R24,0x1
	andi R24,248
	cpi R24,16
	breq L45
	.dbline 192
	clr R16
	xjmp L26
L45:
	.dbline 193
; 	   Write8Bit(rd_device_add);
	.dbline 193
	ldi R24,161
	out 0x3,R24
	.dbline 193
	ldi R24,132
	out 0x36,R24
	.dbline 193
	.dbline 193
	.dbline 194
L47:
	.dbline 194
L48:
	.dbline 194
; 	   Wait();
	in R2,0x36
	sbrs R2,7
	rjmp L47
	.dbline 194
	.dbline 194
	.dbline 195
; 	   if(TestAck()!=MR_SLA_ACK)  return 0;
	in R24,0x1
	andi R24,248
	cpi R24,64
	breq L50
	.dbline 195
	clr R16
	xjmp L26
L50:
	.dbline 196
; 	   Twi();
	ldi R24,132
	out 0x36,R24
	.dbline 197
L52:
	.dbline 197
L53:
	.dbline 197
; 	   Wait();
	in R2,0x36
	sbrs R2,7
	rjmp L52
	.dbline 197
	.dbline 197
	.dbline 198
; 	   if(TestAck()!=MR_DATA_NOACK) return 0;	
	in R24,0x1
	andi R24,248
	cpi R24,88
	breq L55
	.dbline 198
	clr R16
	xjmp L26
L55:
	.dbline 199
; 	   temp=TWDR;
	in R20,0x3
	.dbline 200
;        Stop();
	ldi R24,148
	out 0x36,R24
	.dbline 201
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
	.dbline 210
;       }
; 	  
; /******************************************
;                I2C总线写一个字节
; 			    返回0:写成功
; 				返回非0:写失败
; *******************************************/
; unsigned char i2c_Write(unsigned char RomAddress,unsigned char Wdata) 
; {
	.dbline 211
; 	  Start();
	ldi R24,164
	out 0x36,R24
	.dbline 212
L58:
	.dbline 212
L59:
	.dbline 212
; 	  Wait();
	in R2,0x36
	sbrs R2,7
	rjmp L58
	.dbline 212
	.dbline 212
	.dbline 213
; 	  if(TestAck()!=START) return 1;
	in R24,0x1
	andi R24,248
	cpi R24,8
	breq L61
	.dbline 213
	ldi R16,1
	xjmp L57
L61:
	.dbline 214
; 	  Write8Bit(wr_device_add);
	.dbline 214
	ldi R24,160
	out 0x3,R24
	.dbline 214
	ldi R24,132
	out 0x36,R24
	.dbline 214
	.dbline 214
	.dbline 215
L63:
	.dbline 215
L64:
	.dbline 215
; 	  Wait();
	in R2,0x36
	sbrs R2,7
	rjmp L63
	.dbline 215
	.dbline 215
	.dbline 216
; 	  if(TestAck()!=MT_SLA_ACK) return 1;
	in R24,0x1
	andi R24,248
	cpi R24,24
	breq L66
	.dbline 216
	ldi R16,1
	xjmp L57
L66:
	.dbline 217
; 	  Write8Bit(RomAddress);
	.dbline 217
	out 0x3,R22
	.dbline 217
	ldi R24,132
	out 0x36,R24
	.dbline 217
	.dbline 217
	.dbline 218
L68:
	.dbline 218
L69:
	.dbline 218
; 	  Wait();
	in R2,0x36
	sbrs R2,7
	rjmp L68
	.dbline 218
	.dbline 218
	.dbline 219
; 	  if(TestAck()!=MT_DATA_ACK) return 1;
	in R24,0x1
	andi R24,248
	cpi R24,40
	breq L71
	.dbline 219
	ldi R16,1
	xjmp L57
L71:
	.dbline 220
; 	  Write8Bit(Wdata);
	.dbline 220
	out 0x3,R20
	.dbline 220
	ldi R24,132
	out 0x36,R24
	.dbline 220
	.dbline 220
	.dbline 221
L73:
	.dbline 221
L74:
	.dbline 221
; 	  Wait();
	in R2,0x36
	sbrs R2,7
	rjmp L73
	.dbline 221
	.dbline 221
	.dbline 222
; 	  if(TestAck()!=MT_DATA_ACK) return 1;	
	in R24,0x1
	andi R24,248
	cpi R24,40
	breq L76
	.dbline 222
	ldi R16,1
	xjmp L57
L76:
	.dbline 223
; 	  Stop();
	ldi R24,148
	out 0x36,R24
	.dbline 224
;  	  delay_ms(10);
	ldi R16,10
	ldi R17,0
	xcall _delay_ms
	.dbline 225
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
	.dbfunc e timer1_init _timer1_init fV
	.even
_timer1_init::
	.dbline -1
	.dbline 230
; }
; 
; /*****************定时器1初始化*************/
; void timer1_init(void)
; {
	.dbline 231
;  TCNT1H = 0xF3; //setup
	ldi R24,243
	out 0x2d,R24
	.dbline 232
;  TCNT1L = 0xCB;
	ldi R24,203
	out 0x2c,R24
	.dbline 233
;  TCCR1B = 0x04; //start Timer
	ldi R24,4
	out 0x2e,R24
	.dbline -2
L78:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e main _main fV
;        key_val -> R22
	.even
_main::
	sbiw R28,2
	.dbline -1
	.dbline 238
; }
; 
; //******************************************
; void main(void)				
; {
	.dbline 240
;  	 uchar key_val;	
; 	 init_devices();
	xcall _init_devices
	.dbline 241
;     delay_ms(400);			
	ldi R16,400
	ldi R17,1
	xcall _delay_ms
	.dbline 242
; 	InitLcd();		
	xcall _InitLcd
	.dbline 243
; 	LcdWriteCommand(0x01,1); 
	ldi R18,1
	ldi R16,1
	xcall _LcdWriteCommand
	.dbline 244
; 	LcdWriteCommand(0x0c,1); 
	ldi R18,1
	ldi R16,12
	xcall _LcdWriteCommand
	.dbline 245
; 	ePutstr(0,0,str0);  
	ldi R24,<_str0
	ldi R25,>_str0
	std y+1,R25
	std y+0,R24
	clr R18
	clr R16
	xcall _ePutstr
	.dbline 246
; 	delay_ms(10);
	ldi R16,10
	ldi R17,0
	xcall _delay_ms
	.dbline 247
; 	ePutstr(0,1,str1);  
	ldi R24,<_str1
	ldi R25,>_str1
	std y+1,R25
	std y+0,R24
	ldi R18,1
	clr R16
	xcall _ePutstr
	.dbline 248
; 	delay_ms(10);
	ldi R16,10
	ldi R17,0
	xcall _delay_ms
	xjmp L81
L80:
	.dbline 251
; 	/********************************************/
; 		while(1)             
; 		{
	.dbline 252
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
	.dbline 253
; 		   delay_ms(10);
	ldi R16,10
	ldi R17,0
	xcall _delay_ms
	.dbline 254
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
	.dbline 255
; 		   delay_ms(10);
	ldi R16,10
	ldi R17,0
	xcall _delay_ms
	.dbline 256
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
	.dbline 257
; 		   delay_ms(10);
	ldi R16,10
	ldi R17,0
	xcall _delay_ms
	.dbline 258
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
	.dbline 259
; 		   delay_ms(10);
	ldi R16,10
	ldi R17,0
	xcall _delay_ms
	.dbline 260
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
	.dbline 261
; 		   delay_ms(10);
	ldi R16,10
	ldi R17,0
	xcall _delay_ms
	.dbline 262
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
	.dbline 263
; 		   delay_ms(10);
	ldi R16,10
	ldi R17,0
	xcall _delay_ms
	.dbline 265
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
	.dbline 266
; 		   delay_ms(10);
	ldi R16,10
	ldi R17,0
	xcall _delay_ms
	.dbline 267
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
	.dbline 268
; 		   delay_ms(10);
	ldi R16,10
	ldi R17,0
	xcall _delay_ms
	.dbline 269
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
	.dbline 270
; 		   delay_ms(10);
	ldi R16,10
	ldi R17,0
	xcall _delay_ms
	.dbline 271
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
	.dbline 272
; 		   delay_ms(10);
	ldi R16,10
	ldi R17,0
	xcall _delay_ms
	.dbline 273
; 		   key_val=scan_key();	
	xcall _scan_key
	mov R22,R16
	.dbline 274
; 		   switch(key_val)		
	mov R20,R22
	clr R21
	cpi R20,223
	ldi R30,0
	cpc R21,R30
	brne X2
	xjmp L100
X2:
	ldi R24,223
	ldi R25,0
	cp R24,R20
	cpc R25,R21
	brlt L119
L118:
	cpi R20,127
	ldi R30,0
	cpc R21,R30
	brne X3
	xjmp L111
X3:
	cpi R20,127
	ldi R30,0
	cpc R21,R30
	brge X4
	xjmp L90
X4:
L120:
	cpi R20,191
	ldi R30,0
	cpc R21,R30
	brne X5
	xjmp L103
X5:
	xjmp L90
L119:
	cpi R20,247
	ldi R30,0
	cpc R21,R30
	brne X6
	xjmp L116
X6:
	ldi R24,247
	ldi R25,0
	cp R24,R20
	cpc R25,R21
	brlt L122
L121:
	cpi R20,239
	ldi R30,0
	cpc R21,R30
	breq L92
	xjmp L90
L122:
	cpi R20,251
	ldi R30,0
	cpc R21,R30
	brne X7
	xjmp L114
X7:
	xjmp L90
X0:
	.dbline 275
; 	   	   {				
L92:
	.dbline 276
; 	   	   	case 0xef:time1.min++;
	lds R24,_time1+1
	subi R24,255    ; addi 1
	sts _time1+1,R24
	.dbline 277
; 			          if(time1.min>59){time1.min=0;
	ldi R24,59
	lds R2,_time1+1
	cp R24,R2
	brlo X8
	xjmp L90
X8:
	.dbline 277
	.dbline 277
	clr R2
	sts _time1+1,R2
	.dbline 278
; 					                  if(time1.hour<23)time1.hour++;
	lds R24,_time1
	cpi R24,23
	brlo X9
	xjmp L90
X9:
	.dbline 278
	subi R24,255    ; addi 1
	sts _time1,R24
	.dbline 279
; 								      }break; 
	.dbline 279
	xjmp L90
L100:
	.dbline 280
; 	   		case 0xdf:time1.hour++;if(time1.hour>23)time1.hour=0;break;	
	lds R24,_time1
	subi R24,255    ; addi 1
	sts _time1,R24
	.dbline 280
	ldi R24,23
	lds R2,_time1
	cp R24,R2
	brlo X10
	xjmp L90
X10:
	.dbline 280
	clr R2
	sts _time1,R2
	.dbline 280
	xjmp L90
L103:
	.dbline 282
; 											
; 	   		case 0xbf:time2.min++;
	lds R24,_time2+1
	subi R24,255    ; addi 1
	sts _time2+1,R24
	.dbline 283
; 			          if(time2.min>59){time2.min=0;
	ldi R24,59
	lds R2,_time2+1
	cp R24,R2
	brlo X11
	xjmp L90
X11:
	.dbline 283
	.dbline 283
	clr R2
	sts _time2+1,R2
	.dbline 284
; 					                  if(time2.hour<23)time2.hour++;
	lds R24,_time2
	cpi R24,23
	brlo X12
	xjmp L90
X12:
	.dbline 284
	subi R24,255    ; addi 1
	sts _time2,R24
	.dbline 285
; 								      }break; 
	.dbline 285
	xjmp L90
L111:
	.dbline 286
; 	   		case 0x7f:time2.hour++;if(time2.hour>23)time2.hour=0;break;	
	lds R24,_time2
	subi R24,255    ; addi 1
	sts _time2,R24
	.dbline 286
	ldi R24,23
	lds R2,_time2
	cp R24,R2
	brsh L90
	.dbline 286
	clr R2
	sts _time2,R2
	.dbline 286
	xjmp L90
L114:
	.dbline 289
; 											
; 			//*************************
; 			case 0xfb:i2c_Write(11,time2.hour); 
	lds R18,_time2
	ldi R16,11
	xcall _i2c_Write
	.dbline 290
; 				 delay_ms(10);
	ldi R16,10
	ldi R17,0
	xcall _delay_ms
	.dbline 291
; 				 i2c_Write(12,time2.min);		
	lds R18,_time2+1
	ldi R16,12
	xcall _i2c_Write
	.dbline 292
; 				 delay_ms(10);
	ldi R16,10
	ldi R17,0
	xcall _delay_ms
	.dbline 293
; 				 DisplayOneChar(13,1,0x57); 
	ldi R24,87
	std y+0,R24
	ldi R18,1
	ldi R16,13
	xcall _DisplayOneChar
	.dbline 294
; 				 delay_ms(10);break;	
	ldi R16,10
	ldi R17,0
	xcall _delay_ms
	.dbline 294
	xjmp L90
L116:
	.dbline 295
; 	   		case 0xf7:time2.hour=i2c_Read(11); 
	ldi R16,11
	xcall _i2c_Read
	sts _time2,R16
	.dbline 296
; 				 delay_ms(10);
	ldi R16,10
	ldi R17,0
	xcall _delay_ms
	.dbline 297
; 				 time2.min=i2c_Read(12);
	ldi R16,12
	xcall _i2c_Read
	sts _time2+1,R16
	.dbline 298
; 				 delay_ms(10);
	ldi R16,10
	ldi R17,0
	xcall _delay_ms
	.dbline 299
; 				 DisplayOneChar(13,1,0x52); 
	ldi R24,82
	std y+0,R24
	ldi R18,1
	ldi R16,13
	xcall _DisplayOneChar
	.dbline 300
; 				 delay_ms(10);break;	
	ldi R16,10
	ldi R17,0
	xcall _delay_ms
	.dbline 300
	.dbline 301
; 	   		default:break;		
L90:
	.dbline 303
	ldi R16,300
	ldi R17,1
	xcall _delay_ms
	.dbline 304
	ldi R24,32
	std y+0,R24
	ldi R18,1
	ldi R16,13
	xcall _DisplayOneChar
	.dbline 305
	ldi R16,10
	ldi R17,0
	xcall _delay_ms
	.dbline 307
L81:
	.dbline 250
	xjmp L80
X1:
	.dbline -2
L79:
	adiw R28,2
	.dbline 0 ; func end
	ret
	.dbsym r key_val 22 c
	.dbend
	.area vector(rom, abs)
	.org 32
	jmp _timer1_ovf_isr
	.area text(rom, con, rel)
	.dbfile d:\MYDOCU~1\ac15-4\ac15-4.c
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
	.dbline 312
; 	   		}					
; 			delay_ms(300); 
; 			DisplayOneChar(13,1,0x20); 
; 			delay_ms(10);
; 						
;   		 }				
; }		   
; /***********************定时器T1中断子函数**********************/
; #pragma interrupt_handler timer1_ovf_isr:9
; void timer1_ovf_isr(void)
; {
	.dbline 314
;  //TIMER1 has overflowed
;  TCNT1H = 0xF3; //reload counter high value
	ldi R24,243
	out 0x2d,R24
	.dbline 315
;  TCNT1L = 0xCB; //reload counter low value
	ldi R24,203
	out 0x2c,R24
	.dbline 316
;  if(++time1.dida>=10){time1.dida=0;time1.sec++;}
	lds R24,_time1+3
	subi R24,255    ; addi 1
	mov R2,R24
	sts _time1+3,R2
	cpi R24,10
	brlo L124
	.dbline 316
	.dbline 316
	clr R2
	sts _time1+3,R2
	.dbline 316
	lds R24,_time1+2
	subi R24,255    ; addi 1
	sts _time1+2,R24
	.dbline 316
L124:
	.dbline 317
;  if(time1.sec>=60){time1.sec=0;time1.min++;}
	lds R24,_time1+2
	cpi R24,60
	brlo L129
	.dbline 317
	.dbline 317
	clr R2
	sts _time1+2,R2
	.dbline 317
	lds R24,_time1+1
	subi R24,255    ; addi 1
	sts _time1+1,R24
	.dbline 317
L129:
	.dbline 318
;  if(time1.min>=60){time1.min=0;time1.hour++;}
	lds R24,_time1+1
	cpi R24,60
	brlo L134
	.dbline 318
	.dbline 318
	clr R2
	sts _time1+1,R2
	.dbline 318
	lds R24,_time1
	subi R24,255    ; addi 1
	sts _time1,R24
	.dbline 318
L134:
	.dbline 319
;  if(time1.hour>=24){time1.hour=0;}
	lds R24,_time1
	cpi R24,24
	brlo L138
	.dbline 319
	.dbline 319
	clr R2
	sts _time1,R2
	.dbline 319
L138:
	.dbline 321
;  //-------------------
;  if((time1.hour==time2.hour)&&(time1.min==time2.min))LED_0; 
	lds R2,_time2
	lds R3,_time1
	cp R3,R2
	brne L140
	lds R2,_time2+1
	lds R3,_time1+1
	cp R3,R2
	brne L140
	.dbline 321
	cbi 0x18,7
	xjmp L141
L140:
	.dbline 322
	sbi 0x18,7
L141:
	.dbline -2
L123:
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
	.dbline 326
;  else LED_1;
; }
; /*********************************************/
; void init_devices(void)
; {
	.dbline 328
;  //stop errant interrupts until set up
;  CLI(); //disable all interrupts
	cli
	.dbline 329
;  port_init();
	xcall _port_init
	.dbline 330
;  timer1_init();
	xcall _timer1_init
	.dbline 331
;  MCUCR = 0x00;
	clr R2
	out 0x35,R2
	.dbline 332
;  GICR  = 0x00;
	out 0x3b,R2
	.dbline 333
;  TIMSK = 0x04; //timer interrupt sources
	ldi R24,4
	out 0x39,R24
	.dbline 334
;  SEI(); //re-enable interrupts
	sei
	.dbline -2
L144:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e delay_ms _delay_ms fV
;           time -> R20,R21
	.even
_delay_ms::
	xcall push_gset1
	movw R20,R16
	.dbline -1
	.dbline 340
;  //all peripherals are now initialized
; }
; 
; /*******************器件初始化********************/
; void delay_ms(unsigned int time)
; 	 {
	xjmp L147
L146:
	.dbline 342
	.dbline 343
	ldi R16,1000
	ldi R17,3
	xcall _delay_us
	.dbline 344
	subi R20,1
	sbci R21,0
	.dbline 345
L147:
	.dbline 341
; 	  while(time!=0)
	cpi R20,0
	cpc R20,R21
	brne L146
X13:
	.dbline -2
L145:
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
	.dbline 350
; 	  	  {		
; 		   delay_us(1000);
; 		   time--;
; 		  }
; 	 }
; 	 					
; /*****************廷时子函数************************/
; void delay_us(int time)
; 	 {     
L150:
	.dbline 352
;   	  do
; 	  	{
	.dbline 353
; 		 time--;
	subi R16,1
	sbci R17,0
	.dbline 354
; 		}	
L151:
	.dbline 355
;   	  while (time>1);
	ldi R24,1
	ldi R25,0
	cp R24,R16
	cpc R25,R17
	brlt L150
	.dbline -2
L149:
	.dbline 0 ; func end
	ret
	.dbsym r time 16 I
	.dbend
	.area bss(ram, con, rel)
	.dbfile d:\MYDOCU~1\ac15-4\ac15-4.c
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
