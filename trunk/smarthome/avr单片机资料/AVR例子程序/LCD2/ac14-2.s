	.module ac14-2.c
	.area lit(rom, con, rel)
_exampl::
	.byte 45,45,'E,'L,'E,'C,'T,'R,'O,'N,'I,'C,'S,45,45,32
	.byte 32,'W,'O,'R,'L,'D,32,'m,'a,'g,'a,'z,'i,'n,'e,10
	.byte 0
	.dbfile d:\MYDOCU~1\ac14-2\ac14-2.c
	.dbsym e exampl _exampl A[33:33]kc
	.area text(rom, con, rel)
	.dbfile d:\MYDOCU~1\ac14-2\ac14-2.c
	.dbfunc e main _main fV
;           temp -> R20
	.even
_main::
	sbiw R28,2
	.dbline -1
	.dbline 30
; #include <iom16v.h>
; #include <macros.h>
; //----------------------------
; #define uchar unsigned char
; #define uint unsigned int
; //----------------------------
; #define LCM_RS_1 PORTB|=BIT(PB0)
; #define LCM_RS_0 PORTB&=~BIT(PB0)
; #define LCM_RW_1 PORTB|=BIT(PB1)
; #define LCM_RW_0 PORTB&=~BIT(PB1)
; #define LCM_EN_1 PORTB|=BIT(PB2)
; #define LCM_EN_0 PORTB&=~BIT(PB2)
; //------------------------------
; #define DataPort PORTA
; #define Busy 0x80
; #define xtal 8   			
; //---------------------------------
; const uchar exampl[]="--ELECTRONICS--  WORLD magazine\n";
; void Delay_1ms(void);
; void Delay_nms(uint n);
; void WaitForEnable(void);
; void LcdWriteData(uchar W);
; void LcdWriteCommand(uchar CMD,uchar Attribc);
; void InitLcd(void);
; void Display(uchar dd);
; void DisplayOneChar(uchar x,uchar y,uchar Wdata);
; void ePutstr(uchar x,uchar y,uchar const *ptr);
; //******************************************
; void main(void)
; {
	.dbline 32
;     uchar temp;
; 	Delay_nms(400);
	ldi R16,400
	ldi R17,1
	xcall _Delay_nms
	.dbline 33
; 	DDRA=0xff;PORTA=0x00;
	ldi R24,255
	out 0x1a,R24
	.dbline 33
	clr R2
	out 0x1b,R2
	.dbline 34
; 	DDRB=0xff;PORTB=0x00;
	out 0x17,R24
	.dbline 34
	out 0x18,R2
	.dbline 35
; 	InitLcd();
	xcall _InitLcd
	.dbline 36
; 	temp=32;
	ldi R20,32
	.dbline 37
; 	ePutstr(0,0,exampl);
	ldi R24,<_exampl
	ldi R25,>_exampl
	std y+1,R25
	std y+0,R24
	clr R18
	clr R16
	xcall _ePutstr
	.dbline 38
; 	Delay_nms(3200);
	ldi R16,3200
	ldi R17,12
	xcall _Delay_nms
	xjmp L3
L2:
	.dbline 40
; 	while(1)
; 	{
	.dbline 41
; 		temp&=0x7f;
	andi R20,127
	.dbline 42
; 		if(temp<32)temp=32;
	cpi R20,32
	brsh L5
	.dbline 42
	ldi R20,32
L5:
	.dbline 43
	mov R2,R20
	subi R20,255    ; addi 1
	mov R16,R2
	xcall _Display
	.dbline 44
	ldi R16,400
	ldi R17,1
	xcall _Delay_nms
	.dbline 45
L3:
	.dbline 39
	xjmp L2
X0:
	.dbline -2
L1:
	adiw R28,2
	.dbline 0 ; func end
	ret
	.dbsym r temp 20 c
	.dbend
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
	.dbline 49
; 		Display(temp++);
; 		Delay_nms(400);
; 	}
; }
; //************************************
; void ePutstr(uchar x,uchar y,uchar const *ptr)
; {
	.dbline 50
; uchar i,l=0;
	clr R20
	xjmp L9
L8:
	.dbline 51
	.dbline 51
	inc R20
	.dbline 51
L9:
	.dbline 51
; 	while(ptr[l]>31){l++;}
	mov R30,R20
	clr R31
	add R30,R10
	adc R31,R11
	lpm R30,Z
	ldi R24,31
	cp R24,R30
	brlo L8
	.dbline 52
	clr R22
	xjmp L14
L11:
	.dbline 52
; 	for(i=0;i<l;i++){
	.dbline 53
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
	.dbline 54
; 	if(x==16){
	mov R24,R14
	cpi R24,16
	brne L15
	.dbline 54
	.dbline 55
; 		x=0;y^=1;
	clr R14
	.dbline 55
	ldi R24,1
	eor R12,R24
	.dbline 56
; 	}
L15:
	.dbline 57
L12:
	.dbline 52
	inc R22
L14:
	.dbline 52
	cp R22,R20
	brlo L11
	.dbline -2
L7:
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
	.dbfunc e Display _Display fV
;              i -> R20
;             dd -> R22
	.even
_Display::
	xcall push_gset2
	mov R22,R16
	sbiw R28,1
	.dbline -1
	.dbline 61
;   }
; }
; //*************************************
; void Display(uchar dd)
; {
	.dbline 63
	clr R20
	xjmp L21
L18:
	.dbline 63
; uchar i;
; 	for(i=0;i<16;i++){
	.dbline 64
; 	DisplayOneChar(i,1,dd++);
	mov R2,R22
	subi R22,255    ; addi 1
	std y+0,R2
	ldi R18,1
	mov R16,R20
	xcall _DisplayOneChar
	.dbline 65
; 	dd&=0x7f;
	andi R22,127
	.dbline 66
; 	if(dd<32)dd=32;
	cpi R22,32
	brsh L22
	.dbline 66
	ldi R22,32
L22:
	.dbline 67
L19:
	.dbline 63
	inc R20
L21:
	.dbline 63
	cpi R20,16
	brlo L18
	.dbline -2
L17:
	adiw R28,1
	xcall pop_gset2
	.dbline 0 ; func end
	ret
	.dbsym r i 20 c
	.dbsym r dd 22 c
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
	.dbline 71
; 	}
; }
; //*************************************
; void LocateXY(char posx,char posy)
; {
	.dbline 73
; uchar temp;
; 	temp&=0x7f;
	andi R20,127
	.dbline 74
; 	temp=posx&0x0f;
	mov R20,R10
	andi R20,15
	.dbline 75
; 	posy&=0x01;
	andi R22,1
	.dbline 76
; 	if(posy)temp|=0x40;
	breq L25
	.dbline 76
	ori R20,64
L25:
	.dbline 77
; 	temp|=0x80;
	ori R20,128
	.dbline 78
; 	LcdWriteCommand(temp,0);
	clr R18
	mov R16,R20
	xcall _LcdWriteCommand
	.dbline -2
L24:
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
	.dbline 82
; }
; //**************************************
; void DisplayOneChar(uchar x,uchar y,uchar Wdata)
; {
	.dbline 83
; LocateXY(x,y);
	mov R18,R22
	mov R16,R20
	xcall _LocateXY
	.dbline 84
; LcdWriteData(Wdata);
	ldd R16,y+4
	xcall _LcdWriteData
	.dbline -2
L27:
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
	.dbline 88
; }
; //****************************************
; void InitLcd(void)
; {
	.dbline 89
; LcdWriteCommand(0x38,0);
	clr R18
	ldi R16,56
	xcall _LcdWriteCommand
	.dbline 90
; Delay_nms(5);
	ldi R16,5
	ldi R17,0
	xcall _Delay_nms
	.dbline 91
; LcdWriteCommand(0x38,0);
	clr R18
	ldi R16,56
	xcall _LcdWriteCommand
	.dbline 92
; Delay_nms(5);
	ldi R16,5
	ldi R17,0
	xcall _Delay_nms
	.dbline 93
; LcdWriteCommand(0x38,0);
	clr R18
	ldi R16,56
	xcall _LcdWriteCommand
	.dbline 94
; Delay_nms(5);
	ldi R16,5
	ldi R17,0
	xcall _Delay_nms
	.dbline 95
; LcdWriteCommand(0x38,1);
	ldi R18,1
	ldi R16,56
	xcall _LcdWriteCommand
	.dbline 96
; LcdWriteCommand(0x08,1);
	ldi R18,1
	ldi R16,8
	xcall _LcdWriteCommand
	.dbline 97
; LcdWriteCommand(0x01,1);
	ldi R18,1
	ldi R16,1
	xcall _LcdWriteCommand
	.dbline 98
; LcdWriteCommand(0x06,1);
	ldi R18,1
	ldi R16,6
	xcall _LcdWriteCommand
	.dbline 99
; LcdWriteCommand(0x0c,1);
	ldi R18,1
	ldi R16,12
	xcall _LcdWriteCommand
	.dbline -2
L28:
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
	.dbline 103
; }
; //****************************************
; void LcdWriteCommand(uchar CMD,uchar Attribc)
; {
	.dbline 104
; if(Attribc)WaitForEnable();
	tst R22
	breq L30
	.dbline 104
	xcall _WaitForEnable
L30:
	.dbline 105
; LCM_RS_0;LCM_RW_0;_NOP();
	cbi 0x18,0
	.dbline 105
	cbi 0x18,1
	.dbline 105
	nop
	.dbline 106
; DataPort=CMD;_NOP();
	out 0x1b,R20
	.dbline 106
	nop
	.dbline 107
; LCM_EN_1;_NOP();_NOP();LCM_EN_0;
	sbi 0x18,2
	.dbline 107
	nop
	.dbline 107
	nop
	.dbline 107
	cbi 0x18,2
	.dbline -2
L29:
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
	.dbline 111
; }
; //***************************************
; void LcdWriteData(uchar dataW)
; {
	.dbline 112
; WaitForEnable();
	xcall _WaitForEnable
	.dbline 113
; LCM_RS_1;LCM_RW_0;_NOP();
	sbi 0x18,0
	.dbline 113
	cbi 0x18,1
	.dbline 113
	nop
	.dbline 114
; DataPort=dataW;_NOP();
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
L32:
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
	.dbline 119
; }
; //****************************************
; void WaitForEnable(void)
; {
	.dbline 121
; uchar val;
; DataPort=0xff;
	ldi R24,255
	out 0x1b,R24
	.dbline 122
; LCM_RS_0;LCM_RW_1;_NOP();
	cbi 0x18,0
	.dbline 122
	sbi 0x18,1
	.dbline 122
	nop
	.dbline 123
; LCM_EN_1;_NOP();_NOP();
	sbi 0x18,2
	.dbline 123
	nop
	.dbline 123
	nop
	.dbline 124
; DDRA=0x00;
	clr R2
	out 0x1a,R2
	.dbline 125
; val=PINA;
	in R16,0x19
	xjmp L35
L34:
	.dbline 126
	in R16,0x19
L35:
	.dbline 126
; while(val&Busy)val=PINA;
	sbrc R16,7
	rjmp L34
	.dbline 127
; LCM_EN_0;
	cbi 0x18,2
	.dbline 128
; DDRA=0xff;
	ldi R24,255
	out 0x1a,R24
	.dbline -2
L33:
	.dbline 0 ; func end
	ret
	.dbsym r val 16 c
	.dbend
	.dbfunc e Delay_1ms _Delay_1ms fV
;              i -> R16,R17
	.even
_Delay_1ms::
	.dbline -1
	.dbline 132
; }
; //****************************************
; void Delay_1ms(void)		
; { uint i;
	.dbline 133
;  for(i=1;i<(uint)(xtal*143-2);i++)
	ldi R16,1
	ldi R17,0
	xjmp L41
L38:
	.dbline 134
L39:
	.dbline 133
	subi R16,255  ; offset = 1
	sbci R17,255
L41:
	.dbline 133
	cpi R16,118
	ldi R30,4
	cpc R17,R30
	brlo L38
	.dbline -2
L37:
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
	.dbline 138
;     ;
; }
; //=============================================
; void Delay_nms(uint n)		
; {
	.dbline 139
;  uint i=0;
	clr R20
	clr R21
	xjmp L44
L43:
	.dbline 141
	.dbline 141
	xcall _Delay_1ms
	.dbline 142
	subi R20,255  ; offset = 1
	sbci R21,255
	.dbline 143
L44:
	.dbline 140
;    while(i<n)
	cp R20,R22
	cpc R21,R23
	brlo L43
	.dbline -2
L42:
	xcall pop_gset2
	.dbline 0 ; func end
	ret
	.dbsym r i 20 i
	.dbsym r n 22 i
	.dbend
