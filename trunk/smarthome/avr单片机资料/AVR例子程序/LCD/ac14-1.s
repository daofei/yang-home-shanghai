	.module ac14-1.c
	.area lit(rom, con, rel)
_str0::
	.byte 45,'T,'h,'i,'s,32,'i,'s,32,'a,32,'L,'C,'D,45,33
	.byte 0
	.dbfile d:\MYDOCU~1\ac14-1\ac14-1.c
	.dbsym e str0 _str0 A[17:17]kc
_str1::
	.byte 45,'D,'e,'s,'i,'g,'n,32,'b,'y,32,'Z,'X,'H,45,33
	.byte 0
	.dbsym e str1 _str1 A[17:17]kc
	.area text(rom, con, rel)
	.dbfile d:\MYDOCU~1\ac14-1\ac14-1.c
	.dbfunc e main _main fV
	.even
_main::
	sbiw R28,2
	.dbline -1
	.dbline 32
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
; //======================================
; #define DataPort PORTA		
; #define Busy 0x80		
; #define xtal 8   		
; //======================================
; const uchar str0[]={"-This is a LCD-!"};
; const uchar str1[]={"-Design by ZXH-!"};
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
; //******************************************
; void main(void)				
; {
	.dbline 33
;     Delay_nms(400);			
	ldi R16,400
	ldi R17,1
	xcall _Delay_nms
	.dbline 34
; 	DDRA=0xff;PORTA=0x00;	
	ldi R24,255
	out 0x1a,R24
	.dbline 34
	clr R2
	out 0x1b,R2
	.dbline 35
; 	DDRB=0xff;PORTB=0x00;
	out 0x17,R24
	.dbline 35
	out 0x18,R2
	.dbline 36
; 	InitLcd();				
	xcall _InitLcd
	xjmp L3
L2:
	.dbline 39
	.dbline 40
	ldi R18,1
	ldi R16,1
	xcall _LcdWriteCommand
	.dbline 41
	ldi R18,1
	ldi R16,12
	xcall _LcdWriteCommand
	.dbline 42
	ldi R24,65
	std y+0,R24
	ldi R18,1
	clr R16
	xcall _DisplayOneChar
	.dbline 43
	ldi R24,<_str0
	ldi R25,>_str0
	std y+1,R25
	std y+0,R24
	clr R18
	clr R16
	xcall _ePutstr
	.dbline 44
	ldi R16,2000
	ldi R17,7
	xcall _Delay_nms
	.dbline 45
	ldi R18,1
	ldi R16,1
	xcall _LcdWriteCommand
	.dbline 46
	ldi R18,1
	ldi R16,12
	xcall _LcdWriteCommand
	.dbline 47
	ldi R24,66
	std y+0,R24
	clr R18
	ldi R16,8
	xcall _DisplayOneChar
	.dbline 48
	ldi R24,<_str1
	ldi R25,>_str1
	std y+1,R25
	std y+0,R24
	ldi R18,1
	clr R16
	xcall _ePutstr
	.dbline 49
	ldi R16,2000
	ldi R17,7
	xcall _Delay_nms
	.dbline 50
L3:
	.dbline 38
	xjmp L2
X0:
	.dbline -2
L1:
	adiw R28,2
	.dbline 0 ; func end
	ret
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
	.dbline 54
; 	/********************************************/
; 		while(1)              
; 		{
; 		   LcdWriteCommand(0x01,1); 
; 		   LcdWriteCommand(0x0c,1);	  
; 		   DisplayOneChar(0,1,0x41); 
; 		   ePutstr(0,0,str0); 
; 		   Delay_nms(2000);	
; 		   LcdWriteCommand(0x01,1);  
; 		   LcdWriteCommand(0x0c,1);  
; 		   DisplayOneChar(8,0,0x42);	
; 		   ePutstr(0,1,str1);  
; 		   Delay_nms(2000); 
; 	   }
; }		   
; //**********************显示指定座标的一串字符子函数**************
; void ePutstr(uchar x,uchar y,uchar const *ptr)
; {
	.dbline 55
; uchar i,l=0;
	clr R20
	xjmp L7
L6:
	.dbline 56
	.dbline 56
	inc R20
	.dbline 56
L7:
	.dbline 56
; 	while(ptr[l]>31){l++;}
	mov R30,R20
	clr R31
	add R30,R10
	adc R31,R11
	lpm R30,Z
	ldi R24,31
	cp R24,R30
	brlo L6
	.dbline 57
	clr R22
	xjmp L12
L9:
	.dbline 57
; 	for(i=0;i<l;i++){
	.dbline 58
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
	.dbline 59
; 	if(x==16){
	mov R24,R14
	cpi R24,16
	brne L13
	.dbline 59
	.dbline 60
; 		x=0;y^=1;
	clr R14
	.dbline 60
	ldi R24,1
	eor R12,R24
	.dbline 61
; 	}
L13:
	.dbline 62
L10:
	.dbline 57
	inc R22
L12:
	.dbline 57
	cp R22,R20
	brlo L9
	.dbline -2
L5:
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
	.dbline 66
;   }
; }
; //*******************显示光标定位子函数******************
; void LocateXY(char posx,char posy)
; {
	.dbline 68
; uchar temp;
; 	temp&=0x7f;
	andi R20,127
	.dbline 69
; 	temp=posx&0x0f;
	mov R20,R10
	andi R20,15
	.dbline 70
; 	posy&=0x01;
	andi R22,1
	.dbline 71
; 	if(posy)temp|=0x40;
	breq L16
	.dbline 71
	ori R20,64
L16:
	.dbline 72
; 	temp|=0x80;
	ori R20,128
	.dbline 73
; 	LcdWriteCommand(temp,0);
	clr R18
	mov R16,R20
	xcall _LcdWriteCommand
	.dbline -2
L15:
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
	.dbline 77
; }
; //*******************显示指定座标的一个字符子函数*******************
; void DisplayOneChar(uchar x,uchar y,uchar Wdata)
; {
	.dbline 78
; LocateXY(x,y);
	mov R18,R22
	mov R16,R20
	xcall _LocateXY
	.dbline 79
; LcdWriteData(Wdata);
	ldd R16,y+4
	xcall _LcdWriteData
	.dbline -2
L18:
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
	.dbline 83
; }
; //*******************LCD初始化子函数*********************
; void InitLcd(void) 
; {
	.dbline 84
; LcdWriteCommand(0x38,0); 
	clr R18
	ldi R16,56
	xcall _LcdWriteCommand
	.dbline 85
; Delay_nms(5);
	ldi R16,5
	ldi R17,0
	xcall _Delay_nms
	.dbline 86
; LcdWriteCommand(0x38,0); 
	clr R18
	ldi R16,56
	xcall _LcdWriteCommand
	.dbline 87
; Delay_nms(5);
	ldi R16,5
	ldi R17,0
	xcall _Delay_nms
	.dbline 88
; LcdWriteCommand(0x38,0); 
	clr R18
	ldi R16,56
	xcall _LcdWriteCommand
	.dbline 89
; Delay_nms(5);
	ldi R16,5
	ldi R17,0
	xcall _Delay_nms
	.dbline 90
; LcdWriteCommand(0x38,1); 
	ldi R18,1
	ldi R16,56
	xcall _LcdWriteCommand
	.dbline 91
; LcdWriteCommand(0x08,1); 
	ldi R18,1
	ldi R16,8
	xcall _LcdWriteCommand
	.dbline 92
; LcdWriteCommand(0x01,1);
	ldi R18,1
	ldi R16,1
	xcall _LcdWriteCommand
	.dbline 93
; LcdWriteCommand(0x06,1); 
	ldi R18,1
	ldi R16,6
	xcall _LcdWriteCommand
	.dbline 94
; LcdWriteCommand(0x0c,1); 
	ldi R18,1
	ldi R16,12
	xcall _LcdWriteCommand
	.dbline -2
L19:
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
	.dbline 98
; }
; //********************写命令到LCM子函数********************
; void LcdWriteCommand(uchar CMD,uchar Attribc)
; {
	.dbline 99
; if(Attribc)WaitForEnable();
	tst R22
	breq L21
	.dbline 99
	xcall _WaitForEnable
L21:
	.dbline 100
; LCM_RS_0;LCM_RW_0;_NOP();
	cbi 0x18,0
	.dbline 100
	cbi 0x18,1
	.dbline 100
	nop
	.dbline 101
; DataPort=CMD;_NOP();
	out 0x1b,R20
	.dbline 101
	nop
	.dbline 102
; LCM_EN_1;_NOP();_NOP();LCM_EN_0;
	sbi 0x18,2
	.dbline 102
	nop
	.dbline 102
	nop
	.dbline 102
	cbi 0x18,2
	.dbline -2
L20:
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
	.dbline 106
; }
; //*******************写数据到LCM子函数********************
; void LcdWriteData(uchar dataW)
; {
	.dbline 107
; WaitForEnable();
	xcall _WaitForEnable
	.dbline 108
; LCM_RS_1;LCM_RW_0;_NOP();
	sbi 0x18,0
	.dbline 108
	cbi 0x18,1
	.dbline 108
	nop
	.dbline 109
; DataPort=dataW;_NOP();
	out 0x1b,R20
	.dbline 109
	nop
	.dbline 110
; LCM_EN_1;_NOP();_NOP();LCM_EN_0;
	sbi 0x18,2
	.dbline 110
	nop
	.dbline 110
	nop
	.dbline 110
	cbi 0x18,2
	.dbline -2
L23:
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
	.dbline 114
; }
; //*******************检测LCD忙信号子函数*********************
; void WaitForEnable(void)
; {
	.dbline 116
; uchar val;
; DataPort=0xff;
	ldi R24,255
	out 0x1b,R24
	.dbline 117
; LCM_RS_0;LCM_RW_1;_NOP();
	cbi 0x18,0
	.dbline 117
	sbi 0x18,1
	.dbline 117
	nop
	.dbline 118
; LCM_EN_1;_NOP();_NOP();
	sbi 0x18,2
	.dbline 118
	nop
	.dbline 118
	nop
	.dbline 119
; DDRA=0x00;
	clr R2
	out 0x1a,R2
	.dbline 120
; val=PINA;
	in R16,0x19
	xjmp L26
L25:
	.dbline 121
	in R16,0x19
L26:
	.dbline 121
; while(val&Busy)val=PINA;
	sbrc R16,7
	rjmp L25
	.dbline 122
; LCM_EN_0;
	cbi 0x18,2
	.dbline 123
; DDRA=0xff;
	ldi R24,255
	out 0x1a,R24
	.dbline -2
L24:
	.dbline 0 ; func end
	ret
	.dbsym r val 16 c
	.dbend
	.dbfunc e Delay_1ms _Delay_1ms fV
;              i -> R16,R17
	.even
_Delay_1ms::
	.dbline -1
	.dbline 127
; }
; //****************************************
; void Delay_1ms(void)		//1mS延时子函数
; { uint i;
	.dbline 128
;  for(i=1;i<(uint)(xtal*143-2);i++)
	ldi R16,1
	ldi R17,0
	xjmp L32
L29:
	.dbline 129
L30:
	.dbline 128
	subi R16,255  ; offset = 1
	sbci R17,255
L32:
	.dbline 128
	cpi R16,118
	ldi R30,4
	cpc R17,R30
	brlo L29
	.dbline -2
L28:
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
	.dbline 133
;     ;
; }
; //====================================
; void Delay_nms(uint n)		//n*1mS延时子函数
; {
	.dbline 134
;  uint i=0;
	clr R20
	clr R21
	xjmp L35
L34:
	.dbline 136
	.dbline 136
	xcall _Delay_1ms
	.dbline 137
	subi R20,255  ; offset = 1
	sbci R21,255
	.dbline 138
L35:
	.dbline 135
;    while(i<n)
	cp R20,R22
	cpc R21,R23
	brlo L34
	.dbline -2
L33:
	xcall pop_gset2
	.dbline 0 ; func end
	ret
	.dbsym r i 20 i
	.dbsym r n 22 i
	.dbend
