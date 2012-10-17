	.module ac16-1.c
	.area text(rom, con, rel)
	.dbfile d:\MYDOCU~1\ac16-1\ac16-1.c
	.dbfunc e Delay_1ms _Delay_1ms fV
;              i -> R16,R17
	.even
_Delay_1ms::
	.dbline -1
	.dbline 24
; #include <iom16v.h>		
; #include <macros.h>
; //-----------------------------------------------
; #define uchar unsigned char	
; #define uint unsigned int
; //---------------引脚电平的宏定义
; #define RS_1 PORTB|=BIT(PB0)	 
; #define RS_0 PORTB&=~BIT(PB0) 
; #define RW_1 PORTB|=BIT(PB1)	 
; #define RW_0 PORTB&=~BIT(PB1)
; #define EN_1 PORTB|=BIT(PB2)	 
; #define EN_0 PORTB&=~BIT(PB2) 
; #define CS1_1 PORTB|=BIT(PB3)	  
; #define CS1_0 PORTB&=~BIT(PB3) 
; #define CS2_1 PORTB|=BIT(PB4)	 
; #define CS2_0 PORTB&=~BIT(PB4)
; #define RST_1 PORTB|=BIT(PB5)	 
; #define RST_0 PORTB&=~BIT(PB5) 
; //======================================
; #define DataPort PORTA		//端口定义，双向数据总线。
; #define xtal 8   				
; 
; void Delay_1ms(void)		//1mS延时子函数
; { uint i;
	.dbline 25
;  for(i=1;i<(uint)(xtal*143-2);i++)
	ldi R16,1
	ldi R17,0
	xjmp L5
L2:
	.dbline 26
L3:
	.dbline 25
	subi R16,255  ; offset = 1
	sbci R17,255
L5:
	.dbline 25
	cpi R16,118
	ldi R30,4
	cpc R17,R30
	brlo L2
	.dbline -2
L1:
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
	.dbline 30
; ;
; }
; //====================================
; void Delay_nms(uint n)		//n*1mS延时子函数
; {
	.dbline 31
;  uint i=0;
	clr R20
	clr R21
	xjmp L8
L7:
	.dbline 33
	.dbline 33
	xcall _Delay_1ms
	.dbline 34
	subi R20,255  ; offset = 1
	sbci R21,255
	.dbline 35
L8:
	.dbline 32
;    while(i<n)
	cp R20,R22
	cpc R21,R23
	brlo L7
	.dbline -2
L6:
	xcall pop_gset2
	.dbline 0 ; func end
	ret
	.dbsym r i 20 i
	.dbsym r n 22 i
	.dbend
	.dbfunc e main _main fV
;           loop -> R20
	.even
_main::
	sbiw R28,3
	.dbline -1
	.dbline 54
;    {Delay_1ms();
;     i++;
;    }
; }
; /**********函数声明列表*************/
; void Delay_1ms(void);
; void Delay_nms(uint n);		
; void wcode(uchar c,uchar sel_l,uchar sel_r);
; void wdata(uchar c,uchar sel_l,uchar sel_r);
; void set_startline(uchar i);			
; void set_xy(uchar x,uchar y);			
; void dison_off(uchar o);				
; void reset(void);						
; void m16_init(void);
; void lcd_init(void);					
; void lw(uchar x, uchar y, uchar dd);
; void display_hz(uchar x, uchar y, uchar n, uchar fb);
; const uchar hz[];						
; /*************主函数*************/
; 
; void main(void)	
; {								
	.dbline 56
; uchar loop;						
; m16_init();			
	xcall _m16_init
	.dbline 57
; lcd_init();			
	xcall _lcd_init
	.dbline 58
; Delay_nms(1000);		
	ldi R16,1000
	ldi R17,3
	xcall _Delay_nms
	xjmp L12
L11:
	.dbline 60
; while(1)				
; {				
	.dbline 62
; /************************************/
; for(loop=0;loop<8;loop++)			
	clr R20
	xjmp L17
L14:
	.dbline 63
	.dbline 63
	clr R2
	std y+2,R2
	std y+0,R20
	clr R18
	ldi R24,2
	mul R24,R20
	mov R16,R0
	xcall _display_hz
	.dbline 64
	clr R2
	std y+2,R2
	std y+0,R20
	clr R18
	ldi R24,2
	mul R24,R20
	mov R16,R0
	xcall _display_hz
	.dbline 65
	clr R2
	std y+2,R2
	std y+0,R20
	clr R18
	ldi R24,2
	mul R24,R20
	mov R16,R0
	xcall _display_hz
	.dbline 66
	clr R2
	std y+2,R2
	std y+0,R20
	clr R18
	ldi R24,2
	mul R24,R20
	mov R16,R0
	xcall _display_hz
	.dbline 67
	clr R2
	std y+2,R2
	std y+0,R20
	clr R18
	ldi R24,2
	mul R24,R20
	mov R16,R0
	xcall _display_hz
	.dbline 68
	clr R2
	std y+2,R2
	std y+0,R20
	clr R18
	ldi R24,2
	mul R24,R20
	mov R16,R0
	xcall _display_hz
	.dbline 69
	clr R2
	std y+2,R2
	std y+0,R20
	clr R18
	ldi R24,2
	mul R24,R20
	mov R16,R0
	xcall _display_hz
	.dbline 70
	clr R2
	std y+2,R2
	std y+0,R20
	clr R18
	ldi R24,2
	mul R24,R20
	mov R16,R0
	xcall _display_hz
	.dbline 70
L15:
	.dbline 62
	inc R20
L17:
	.dbline 62
	cpi R20,8
	brsh X1
	xjmp L14
X1:
	.dbline 72
; 	{display_hz(2*loop,0,loop,0);	
; 	display_hz(2*loop,0,loop,0);	
; 	display_hz(2*loop,0,loop,0);	
; 	display_hz(2*loop,0,loop,0);	
; 	display_hz(2*loop,0,loop,0);	
; 	display_hz(2*loop,0,loop,0);	
; 	display_hz(2*loop,0,loop,0);	
; 	display_hz(2*loop,0,loop,0);}	
; /******************************************/
; for(loop=0;loop<8;loop++)			
	clr R20
	xjmp L21
L18:
	.dbline 73
	.dbline 73
	clr R2
	std y+2,R2
	mov R24,R20
	subi R24,248    ; addi 8
	std y+0,R24
	ldi R18,2
	ldi R24,2
	mul R24,R20
	mov R16,R0
	xcall _display_hz
	.dbline 74
	clr R2
	std y+2,R2
	mov R24,R20
	subi R24,248    ; addi 8
	std y+0,R24
	ldi R18,2
	ldi R24,2
	mul R24,R20
	mov R16,R0
	xcall _display_hz
	.dbline 75
	clr R2
	std y+2,R2
	mov R24,R20
	subi R24,248    ; addi 8
	std y+0,R24
	ldi R18,2
	ldi R24,2
	mul R24,R20
	mov R16,R0
	xcall _display_hz
	.dbline 76
	clr R2
	std y+2,R2
	mov R24,R20
	subi R24,248    ; addi 8
	std y+0,R24
	ldi R18,2
	ldi R24,2
	mul R24,R20
	mov R16,R0
	xcall _display_hz
	.dbline 77
	clr R2
	std y+2,R2
	mov R24,R20
	subi R24,248    ; addi 8
	std y+0,R24
	ldi R18,2
	ldi R24,2
	mul R24,R20
	mov R16,R0
	xcall _display_hz
	.dbline 78
	clr R2
	std y+2,R2
	mov R24,R20
	subi R24,248    ; addi 8
	std y+0,R24
	ldi R18,2
	ldi R24,2
	mul R24,R20
	mov R16,R0
	xcall _display_hz
	.dbline 79
	clr R2
	std y+2,R2
	mov R24,R20
	subi R24,248    ; addi 8
	std y+0,R24
	ldi R18,2
	ldi R24,2
	mul R24,R20
	mov R16,R0
	xcall _display_hz
	.dbline 80
	clr R2
	std y+2,R2
	mov R24,R20
	subi R24,248    ; addi 8
	std y+0,R24
	ldi R18,2
	ldi R24,2
	mul R24,R20
	mov R16,R0
	xcall _display_hz
	.dbline 80
L19:
	.dbline 72
	inc R20
L21:
	.dbline 72
	cpi R20,8
	brsh X2
	xjmp L18
X2:
	.dbline 82
; 	{display_hz(2*loop,2,loop+8,0);	
; 	display_hz(2*loop,2,loop+8,0);	
; 	display_hz(2*loop,2,loop+8,0);	
; 	display_hz(2*loop,2,loop+8,0);	
; 	display_hz(2*loop,2,loop+8,0);	
; 	display_hz(2*loop,2,loop+8,0);	
; 	display_hz(2*loop,2,loop+8,0);	
; 	display_hz(2*loop,2,loop+8,0);}	
; /*************************************/
; for(loop=0;loop<8;loop++)		
	clr R20
	xjmp L25
L22:
	.dbline 83
	.dbline 83
	ldi R24,1
	std y+2,R24
	mov R24,R20
	subi R24,240    ; addi 16
	std y+0,R24
	ldi R18,4
	ldi R24,2
	mul R24,R20
	mov R16,R0
	xcall _display_hz
	.dbline 84
	ldi R24,1
	std y+2,R24
	mov R24,R20
	subi R24,240    ; addi 16
	std y+0,R24
	ldi R18,4
	ldi R24,2
	mul R24,R20
	mov R16,R0
	xcall _display_hz
	.dbline 85
	ldi R24,1
	std y+2,R24
	mov R24,R20
	subi R24,240    ; addi 16
	std y+0,R24
	ldi R18,4
	ldi R24,2
	mul R24,R20
	mov R16,R0
	xcall _display_hz
	.dbline 86
	ldi R24,1
	std y+2,R24
	mov R24,R20
	subi R24,240    ; addi 16
	std y+0,R24
	ldi R18,4
	ldi R24,2
	mul R24,R20
	mov R16,R0
	xcall _display_hz
	.dbline 87
	ldi R24,1
	std y+2,R24
	mov R24,R20
	subi R24,240    ; addi 16
	std y+0,R24
	ldi R18,4
	ldi R24,2
	mul R24,R20
	mov R16,R0
	xcall _display_hz
	.dbline 88
	ldi R24,1
	std y+2,R24
	mov R24,R20
	subi R24,240    ; addi 16
	std y+0,R24
	ldi R18,4
	ldi R24,2
	mul R24,R20
	mov R16,R0
	xcall _display_hz
	.dbline 89
	ldi R24,1
	std y+2,R24
	mov R24,R20
	subi R24,240    ; addi 16
	std y+0,R24
	ldi R18,4
	ldi R24,2
	mul R24,R20
	mov R16,R0
	xcall _display_hz
	.dbline 90
	ldi R24,1
	std y+2,R24
	mov R24,R20
	subi R24,240    ; addi 16
	std y+0,R24
	ldi R18,4
	ldi R24,2
	mul R24,R20
	mov R16,R0
	xcall _display_hz
	.dbline 90
L23:
	.dbline 82
	inc R20
L25:
	.dbline 82
	cpi R20,8
	brsh X3
	xjmp L22
X3:
	.dbline 93
; 	{display_hz(2*loop,4,loop+16,1);
; 	display_hz(2*loop,4,loop+16,1);	
; 	display_hz(2*loop,4,loop+16,1);
; 	display_hz(2*loop,4,loop+16,1);
; 	display_hz(2*loop,4,loop+16,1);
; 	display_hz(2*loop,4,loop+16,1);
; 	display_hz(2*loop,4,loop+16,1);
; 	display_hz(2*loop,4,loop+16,1);}//60
; 
; /**********************************/
; for(loop=0;loop<8;loop++)
	clr R20
	xjmp L29
L26:
	.dbline 94
	.dbline 94
	ldi R24,1
	std y+2,R24
	mov R24,R20
	subi R24,232    ; addi 24
	std y+0,R24
	ldi R18,6
	ldi R24,2
	mul R24,R20
	mov R16,R0
	xcall _display_hz
	.dbline 95
	ldi R24,1
	std y+2,R24
	mov R24,R20
	subi R24,232    ; addi 24
	std y+0,R24
	ldi R18,6
	ldi R24,2
	mul R24,R20
	mov R16,R0
	xcall _display_hz
	.dbline 96
	ldi R24,1
	std y+2,R24
	mov R24,R20
	subi R24,232    ; addi 24
	std y+0,R24
	ldi R18,6
	ldi R24,2
	mul R24,R20
	mov R16,R0
	xcall _display_hz
	.dbline 97
	ldi R24,1
	std y+2,R24
	mov R24,R20
	subi R24,232    ; addi 24
	std y+0,R24
	ldi R18,6
	ldi R24,2
	mul R24,R20
	mov R16,R0
	xcall _display_hz
	.dbline 98
	ldi R24,1
	std y+2,R24
	mov R24,R20
	subi R24,232    ; addi 24
	std y+0,R24
	ldi R18,6
	ldi R24,2
	mul R24,R20
	mov R16,R0
	xcall _display_hz
	.dbline 99
	ldi R24,1
	std y+2,R24
	mov R24,R20
	subi R24,232    ; addi 24
	std y+0,R24
	ldi R18,6
	ldi R24,2
	mul R24,R20
	mov R16,R0
	xcall _display_hz
	.dbline 100
	ldi R24,1
	std y+2,R24
	mov R24,R20
	subi R24,232    ; addi 24
	std y+0,R24
	ldi R18,6
	ldi R24,2
	mul R24,R20
	mov R16,R0
	xcall _display_hz
	.dbline 101
	ldi R24,1
	std y+2,R24
	mov R24,R20
	subi R24,232    ; addi 24
	std y+0,R24
	ldi R18,6
	ldi R24,2
	mul R24,R20
	mov R16,R0
	xcall _display_hz
	.dbline 101
L27:
	.dbline 93
	inc R20
L29:
	.dbline 93
	cpi R20,8
	brsh X4
	xjmp L26
X4:
	.dbline 103
	ldi R16,3000
	ldi R17,11
	xcall _Delay_nms
	.dbline 104
L12:
	.dbline 59
	xjmp L11
X0:
	.dbline -2
L10:
	adiw R28,3
	.dbline 0 ; func end
	ret
	.dbsym r loop 20 c
	.dbend
	.dbfunc e m16_init _m16_init fV
	.even
_m16_init::
	.dbline -1
	.dbline 108
; 	{display_hz(2*loop,6,loop+24,1);
; 	display_hz(2*loop,6,loop+24,1);
; 	display_hz(2*loop,6,loop+24,1);
; 	display_hz(2*loop,6,loop+24,1);
; 	display_hz(2*loop,6,loop+24,1);
; 	display_hz(2*loop,6,loop+24,1);
; 	display_hz(2*loop,6,loop+24,1);
; 	display_hz(2*loop,6,loop+24,1);}
; /*******************************/
; Delay_nms(3000);				
; }								
; }								
; /*----------------ATMEGA16L初始化子函数。-----------------------*/
; void m16_init(void)
; {
	.dbline 109
; PORTA=0x00;
	clr R2
	out 0x1b,R2
	.dbline 110
; DDRA=0xff;
	ldi R24,255
	out 0x1a,R24
	.dbline 111
; PORTB=0x00;
	out 0x18,R2
	.dbline 112
; DDRB=0xff;
	out 0x17,R24
	.dbline -2
L30:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e lcd_busy _lcd_busy fV
;            val -> R16
	.even
_lcd_busy::
	.dbline -1
	.dbline 116
; }
; /*---------------判LCM忙子函数---------------*/
; void lcd_busy(void)      		
; {
	.dbline 118
; uchar val;                     	
; RS_0;_NOP();
	cbi 0x18,0
	.dbline 118
	nop
	.dbline 119
; RW_1;_NOP();
	sbi 0x18,1
	.dbline 119
	nop
	.dbline 120
; DataPort=0x00;					
	clr R2
	out 0x1b,R2
	xjmp L33
L32:
	.dbline 122
;  	while(1)
; 	{							
	.dbline 123
; 	EN_1;_NOP();
	sbi 0x18,2
	.dbline 123
	nop
	.dbline 124
; 	DDRA=0x00;
	clr R2
	out 0x1a,R2
	.dbline 125
; 	val=PINA;			 		
	in R16,0x19
	.dbline 126
; 	if(val<0x80) break;      	
	cpi R16,128
	brsh L35
	.dbline 126
	xjmp L34
L35:
	.dbline 127
	cbi 0x18,2
	.dbline 127
	nop
	.dbline 128
L33:
	.dbline 121
	xjmp L32
L34:
	.dbline 129
; 	EN_0;_NOP();				
; 	}
; DDRA=0xff;             			
	ldi R24,255
	out 0x1a,R24
	.dbline 130
; EN_0;_NOP();           			
	cbi 0x18,2
	.dbline 130
	nop
	.dbline -2
L31:
	.dbline 0 ; func end
	ret
	.dbsym r val 16 c
	.dbend
	.dbfunc e wcode _wcode fV
;          sel_r -> y+4
;          sel_l -> R22
;              c -> R20
	.even
_wcode::
	xcall push_gset2
	mov R22,R18
	mov R20,R16
	.dbline -1
	.dbline 134
; }                    			
; /*--------------写指令到LCM子函数---------------*/
; void wcode(uchar c,uchar sel_l,uchar sel_r) 
; {	
	.dbline 135
; if(sel_l==1)CS1_1;
	cpi R22,1
	brne L38
	.dbline 135
	sbi 0x18,3
	xjmp L39
L38:
	.dbline 136
; else CS1_0;						
	cbi 0x18,3
L39:
	.dbline 137
; _NOP();                 		
	nop
	.dbline 138
; if(sel_r==1)CS2_1;
	ldd R24,y+4
	cpi R24,1
	brne L40
	.dbline 138
	sbi 0x18,4
	xjmp L41
L40:
	.dbline 139
; else CS2_0;
	cbi 0x18,4
L41:
	.dbline 140
; _NOP();							
	nop
	.dbline 141
; lcd_busy();						
	xcall _lcd_busy
	.dbline 142
; RS_0;_NOP();					
	cbi 0x18,0
	.dbline 142
	nop
	.dbline 143
; RW_0;_NOP();					
	cbi 0x18,1
	.dbline 143
	nop
	.dbline 144
; DataPort=c;						
	out 0x1b,R20
	.dbline 145
; EN_1;_NOP();					
	sbi 0x18,2
	.dbline 145
	nop
	.dbline 146
; EN_0;_NOP();					
	cbi 0x18,2
	.dbline 146
	nop
	.dbline -2
L37:
	xcall pop_gset2
	.dbline 0 ; func end
	ret
	.dbsym l sel_r 4 c
	.dbsym r sel_l 22 c
	.dbsym r c 20 c
	.dbend
	.dbfunc e wdata _wdata fV
;          sel_r -> y+4
;          sel_l -> R22
;              c -> R20
	.even
_wdata::
	xcall push_gset2
	mov R22,R18
	mov R20,R16
	.dbline -1
	.dbline 150
; }								
; /*---------------写数据到LCM子函数-------------*/
; void wdata(uchar c,uchar sel_l,uchar sel_r) 
; {								
	.dbline 151
; if(sel_l==1)CS1_1;
	cpi R22,1
	brne L43
	.dbline 151
	sbi 0x18,3
	xjmp L44
L43:
	.dbline 152
; else CS1_0;		
	cbi 0x18,3
L44:
	.dbline 153
; _NOP();             
	nop
	.dbline 154
; if(sel_r==1)CS2_1;
	ldd R24,y+4
	cpi R24,1
	brne L45
	.dbline 154
	sbi 0x18,4
	xjmp L46
L45:
	.dbline 155
; else CS2_0;                 
	cbi 0x18,4
L46:
	.dbline 156
; _NOP();					
	nop
	.dbline 157
; lcd_busy();						
	xcall _lcd_busy
	.dbline 158
; RS_1;_NOP();					
	sbi 0x18,0
	.dbline 158
	nop
	.dbline 159
; RW_0;_NOP();					
	cbi 0x18,1
	.dbline 159
	nop
	.dbline 160
; DataPort=c;                   
	out 0x1b,R20
	.dbline 161
; EN_1;_NOP();			
	sbi 0x18,2
	.dbline 161
	nop
	.dbline 162
; EN_0;_NOP();			
	cbi 0x18,2
	.dbline 162
	nop
	.dbline -2
L42:
	xcall pop_gset2
	.dbline 0 ; func end
	ret
	.dbsym l sel_r 4 c
	.dbsym r sel_l 22 c
	.dbsym r c 20 c
	.dbend
	.dbfunc e lw _lw fV
;             dd -> y+5
;              y -> R22
;              x -> R20
	.even
_lw::
	xcall push_gset2
	mov R22,R18
	mov R20,R16
	sbiw R28,1
	.dbline -1
	.dbline 166
; }						
; /*根据x、y地址定位，将数据写入LCM左半屏或右半屏的子函数*/
; void lw(uchar x, uchar y, uchar dd)	
; {								
	.dbline 167
; if(x>=64) 						
	cpi R20,64
	brlo L48
	.dbline 168
; {set_xy(x-64,y);				
	.dbline 168
	mov R18,R22
	mov R16,R20
	subi R16,64
	xcall _set_xy
	.dbline 169
; wdata(dd,0,1);}		
	ldi R24,1
	std y+0,R24
	clr R18
	ldd R16,y+5
	xcall _wdata
	.dbline 169
	xjmp L49
L48:
	.dbline 171
	.dbline 171
	mov R18,R22
	mov R16,R20
	xcall _set_xy
	.dbline 172
	clr R2
	std y+0,R2
	ldi R18,1
	ldd R16,y+5
	xcall _wdata
	.dbline 172
L49:
	.dbline -2
L47:
	adiw R28,1
	xcall pop_gset2
	.dbline 0 ; func end
	ret
	.dbsym l dd 5 c
	.dbsym r y 22 c
	.dbsym r x 20 c
	.dbend
	.dbfunc e set_startline _set_startline fV
;              i -> R20
	.even
_set_startline::
	xcall push_gset1
	mov R20,R16
	sbiw R28,1
	.dbline -1
	.dbline 176
; else 						
; {set_xy(x,y);				
; wdata(dd,1,0);}			
; }						
; /*---------------设定起始行子函数--------------*/
; void set_startline(uchar i) 	
; {								
	.dbline 177
; i=0xc0+i;					
	subi R20,64    ; addi 192
	.dbline 178
; wcode(i,1,1);				
	ldi R24,1
	std y+0,R24
	ldi R18,1
	mov R16,R20
	xcall _wcode
	.dbline -2
L50:
	adiw R28,1
	xcall pop_gset1
	.dbline 0 ; func end
	ret
	.dbsym r i 20 c
	.dbend
	.dbfunc e set_xy _set_xy fV
;              y -> R20
;              x -> R22
	.even
_set_xy::
	xcall push_gset2
	mov R20,R18
	mov R22,R16
	sbiw R28,1
	.dbline -1
	.dbline 182
; }						
; /*---------------定位x方向、y方向的子函数--------------*/
; void set_xy(uchar x,uchar y) 	
; {								
	.dbline 183
; x=x+0x40;                      	
	subi R22,192    ; addi 64
	.dbline 184
; y=y+0xb8;                    	
	subi R20,72    ; addi 184
	.dbline 185
; wcode(x,1,1);                  
	ldi R24,1
	std y+0,R24
	ldi R18,1
	mov R16,R22
	xcall _wcode
	.dbline 186
; wcode(y,1,1);                  
	ldi R24,1
	std y+0,R24
	ldi R18,1
	mov R16,R20
	xcall _wcode
	.dbline -2
L51:
	adiw R28,1
	xcall pop_gset2
	.dbline 0 ; func end
	ret
	.dbsym r y 20 c
	.dbsym r x 22 c
	.dbend
	.dbfunc e dison_off _dison_off fV
;              o -> R20
	.even
_dison_off::
	xcall push_gset1
	mov R20,R16
	sbiw R28,1
	.dbline -1
	.dbline 190
; }                             	
; /*---------------屏幕开启、关闭子函数--------------*/
; void dison_off(uchar o) 		
; {                              	
	.dbline 191
; o=o+0x3e;                    	
	subi R20,194    ; addi 62
	.dbline 192
; wcode(o,1,1);                
	ldi R24,1
	std y+0,R24
	ldi R18,1
	mov R16,R20
	xcall _wcode
	.dbline -2
L52:
	adiw R28,1
	xcall pop_gset1
	.dbline 0 ; func end
	ret
	.dbsym r o 20 c
	.dbend
	.dbfunc e reset _reset fV
	.even
_reset::
	.dbline -1
	.dbline 196
; }                              
; /*---------------复位子函数---------------*/
; void reset(void)                
; {                       		
	.dbline 197
; RST_0;                     	
	cbi 0x18,5
	.dbline 198
; Delay_nms(10);				
	ldi R16,10
	ldi R17,0
	xcall _Delay_nms
	.dbline 199
; RST_1;							
	sbi 0x18,5
	.dbline 200
; Delay_nms(10);				
	ldi R16,10
	ldi R17,0
	xcall _Delay_nms
	.dbline -2
L53:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e lcd_init _lcd_init fV
;              y -> R20
;              x -> R22
	.even
_lcd_init::
	xcall push_gset2
	sbiw R28,1
	.dbline -1
	.dbline 204
; }								
; /*--------------LCM初始化子函数-------------*/
; void lcd_init(void) 			
; {uchar x,y;              		
	.dbline 205
; reset();						
	xcall _reset
	.dbline 206
; set_startline(0);				
	clr R16
	xcall _set_startline
	.dbline 207
; dison_off(0);					
	clr R16
	xcall _dison_off
	.dbline 208
; for(y=0;y<8;y++)				
	clr R20
	xjmp L58
L55:
	.dbline 209
; 	{							
	.dbline 210
	clr R22
	xjmp L62
L59:
	.dbline 210
	clr R2
	std y+0,R2
	mov R18,R20
	mov R16,R22
	xcall _lw
L60:
	.dbline 210
	inc R22
L62:
	.dbline 210
	cpi R22,128
	brlo L59
	.dbline 211
L56:
	.dbline 208
	inc R20
L58:
	.dbline 208
	cpi R20,8
	brlo L55
	.dbline 212
; 	for(x=0;x<128;x++)lw(x,y,0);
; 	}							
; dison_off(1);				
	ldi R16,1
	xcall _dison_off
	.dbline -2
L54:
	adiw R28,1
	xcall pop_gset2
	.dbline 0 ; func end
	ret
	.dbsym r y 20 c
	.dbsym r x 22 c
	.dbend
	.dbfunc e display_hz _display_hz fV
;             dx -> R20
;              i -> R22
;             fb -> R10
;              n -> R12
;             yy -> R14
;             xx -> y+11
	.even
_display_hz::
	xcall push_arg4
	xcall push_gset5
	mov R14,R18
	sbiw R28,1
	ldd R12,y+15
	ldd R10,y+17
	.dbline -1
	.dbline 216
; }						
; /*---------------显示汉字子函数--------------*/
; void display_hz(uchar xx, uchar yy, uchar n, uchar fb) 
; {					
	.dbline 218
; uchar i,dx;                     
; for(i=0;i<16;i++)				
	clr R22
	xjmp L67
L64:
	.dbline 219
; {dx=hz[2*i+n*32];				
	.dbline 219
	ldi R24,32
	mul R24,R12
	movw R2,R0
	ldi R24,2
	mul R24,R22
	movw R30,R0
	add R30,R2
	adc R31,R3
	ldi R24,<_hz
	ldi R25,>_hz
	add R30,R24
	adc R31,R25
	lpm R20,Z
	.dbline 220
; if(fb)dx=255-dx;				
	tst R10
	breq L68
	.dbline 220
	mov R2,R20
	clr R3
	ldi R20,255
	sub R20,R2
	sbc R21,R3
L68:
	.dbline 221
; lw(xx*8+i,yy,dx);				
	std y+0,R20
	mov R18,R14
	ldi R24,8
	ldd R0,y+11
	mul R24,R0
	mov R16,R0
	add R16,R22
	xcall _lw
	.dbline 222
; dx=hz[(2*i+1)+n*32];			
	ldi R24,32
	mul R24,R12
	movw R2,R0
	ldi R24,2
	mul R24,R22
	movw R30,R0
	adiw R30,1
	add R30,R2
	adc R31,R3
	ldi R24,<_hz
	ldi R25,>_hz
	add R30,R24
	adc R31,R25
	lpm R20,Z
	.dbline 223
; if(fb)dx=255-dx;			
	tst R10
	breq L70
	.dbline 223
	mov R2,R20
	clr R3
	ldi R20,255
	sub R20,R2
	sbc R21,R3
L70:
	.dbline 224
	std y+0,R20
	mov R18,R14
	subi R18,255    ; addi 1
	ldi R24,8
	ldd R0,y+11
	mul R24,R0
	mov R16,R0
	add R16,R22
	xcall _lw
	.dbline 225
L65:
	.dbline 218
	inc R22
L67:
	.dbline 218
	cpi R22,16
	brsh X5
	xjmp L64
X5:
	.dbline -2
L63:
	adiw R28,1
	xcall pop_gset5
	adiw R28,4
	.dbline 0 ; func end
	ret
	.dbsym r dx 20 c
	.dbsym r i 22 c
	.dbsym r fb 10 c
	.dbsym r n 12 c
	.dbsym r yy 14 c
	.dbsym l xx 11 c
	.dbend
	.area lit(rom, con, rel)
_hz::
	.byte 0,4
	.byte 0,4
	.byte 0,4
	.byte 254,4
	.byte 146,4
	.byte 146,4
	.byte 146,4
	.byte 146,255
	.byte 146,4
	.byte 146,4
	.byte 146,4
	.byte 146,4
	.byte 254,4
	.byte 0,4
	.byte 0,4
	.byte 0,0
	.byte 36,0
	.byte 36,126
	.byte 36,34
	.byte 252,35
	.byte 34,34
	.byte 34,126
	.byte 160,0
	.byte 132,4
	.byte 148,4
	.byte 165,4
	.byte 134,255
	.byte 132,4
	.byte 164,4
	.byte 148,4
	.byte 132,4
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 248,127
	.byte 8,33
	.byte 8,33
	.byte 12,33
	.byte 11,33
	.byte 8,33
	.byte 8,33
	.byte 8,33
	.byte 8,33
	.byte 8,33
	.byte 248,127
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 128,0
	.byte 'd,0
	.byte 36,0
	.byte 36,63
	.byte 44,1
	.byte 52,1
	.byte 37,1
	.byte 230,255
	.byte 36,1
	.byte 36,17
	.byte 52,33
	.byte 44,31
	.byte 164,0
	.byte 'd,0
	.byte 36,0
	.byte 0,0
	.byte 130,32
	.byte 138,16
	.byte 178,8
	.byte 134,6
	.byte 219,255
	.byte 161,2
	.byte 145,4
	.byte 141,'X
	.byte 136,'H
	.byte 32,32
	.byte 16,34
	.byte 8,17
	.byte 134,8
	.byte 'd,7
	.byte 64,2
	.byte 0,0
	.byte 64,0
	.byte 64,32
	.byte 'D,'p
	.byte 'D,56
	.byte 'D,44
	.byte 'D,39
	.byte 196,35
	.byte 196,49
	.byte 'D,16
	.byte 'D,18
	.byte 'F,20
	.byte 'F,24
	.byte 'd,'p
	.byte 96,32
	.byte 64,0
	.byte 0,0
	.byte 0,0
	.byte 248,255
	.byte 1,0
	.byte 6,0
	.byte 0,0
	.byte 240,7
	.byte 146,4
	.byte 146,4
	.byte 146,4
	.byte 146,4
	.byte 242,7
	.byte 2,64
	.byte 2,128
	.byte 254,127
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 0,'X
	.byte 0,56
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 64,0
	.byte 64,0
	.byte 'D,0
	.byte 'D,0
	.byte 'D,0
	.byte 'D,0
	.byte 'D,0
	.byte 252,127
	.byte 'B,0
	.byte 'B,0
	.byte 'B,0
	.byte 'C,0
	.byte 'B,0
	.byte 96,0
	.byte 64,0
	.byte 0,0
	.byte 0,64
	.byte 0,64
	.byte 255,'D
	.byte 145,'D
	.byte 145,'D
	.byte 145,'D
	.byte 145,'D
	.byte 255,127
	.byte 145,'D
	.byte 145,'D
	.byte 145,'D
	.byte 145,'D
	.byte 255,'D
	.byte 0,64
	.byte 0,64
	.byte 0,0
	.byte 16,4
	.byte 96,4
	.byte 1,126
	.byte 198,1
	.byte 48,32
	.byte 0,32
	.byte 4,32
	.byte 4,32
	.byte 4,32
	.byte 252,63
	.byte 4,32
	.byte 4,32
	.byte 4,32
	.byte 4,32
	.byte 0,32
	.byte 0,0
	.byte 0,0
	.byte 254,255
	.byte 34,2
	.byte 'Z,4
	.byte 134,'C
	.byte 16,'H
	.byte 148,36
	.byte 't,34
	.byte 148,21
	.byte 31,9
	.byte 52,21
	.byte 'T,35
	.byte 148,96
	.byte 148,192
	.byte 16,64
	.byte 0,0
	.byte 0,0
	.byte 128,0
	.byte 128,0
	.byte 128,0
	.byte 128,0
	.byte 128,0
	.byte 128,0
	.byte 128,0
	.byte 128,0
	.byte 128,0
	.byte 128,0
	.byte 128,0
	.byte 128,0
	.byte 192,0
	.byte 128,0
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 254,63
	.byte 'B,16
	.byte 'B,16
	.byte 'B,16
	.byte 'B,16
	.byte 'B,16
	.byte 'B,16
	.byte 'B,16
	.byte 254,63
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 64,64
	.byte 'A,32
	.byte 206,31
	.byte 4,32
	.byte 0,'B
	.byte 2,'A
	.byte 130,64
	.byte 'B,64
	.byte 242,95
	.byte 14,64
	.byte 'B,64
	.byte 130,64
	.byte 2,'G
	.byte 2,'B
	.byte 0,64
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 0,'X
	.byte 0,56
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 2,0
	.byte 242,127
	.byte 18,8
	.byte 18,4
	.byte 18,3
	.byte 254,0
	.byte 146,16
	.byte 18,9
	.byte 18,6
	.byte 254,1
	.byte 18,1
	.byte 18,38
	.byte 18,64
	.byte 251,63
	.byte 18,0
	.byte 0,0
	.byte 0,64
	.byte 0,32
	.byte 224,31
	.byte 46,4
	.byte 168,4
	.byte 168,4
	.byte 168,4
	.byte 168,4
	.byte 175,255
	.byte 168,4
	.byte 168,4
	.byte 168,4
	.byte 168,4
	.byte 174,4
	.byte 32,4
	.byte 0,0
	.byte 32,4
	.byte 18,'B
	.byte 12,129
	.byte 156,64
	.byte 227,63
	.byte 16,16
	.byte 20,8
	.byte 212,253
	.byte 'T,'C
	.byte 95,39
	.byte 'T,9
	.byte 'T,17
	.byte 212,'i
	.byte 20,196
	.byte 16,'D
	.byte 0,0
	.byte 2,64
	.byte 18,48
	.byte 210,15
	.byte 'R,2
	.byte 'R,2
	.byte 'R,2
	.byte 'R,2
	.byte 223,3
	.byte 'R,2
	.byte 'R,2
	.byte 'R,2
	.byte 'R,2
	.byte 210,7
	.byte 18,0
	.byte 2,0
	.byte 0,0
	.byte 252,15
	.byte 4,2
	.byte 4,2
	.byte 252,7
	.byte 128,0
	.byte 'd,0
	.byte 36,63
	.byte 44,1
	.byte 53,1
	.byte 230,255
	.byte 36,17
	.byte 52,33
	.byte 172,31
	.byte 'f,0
	.byte 36,0
	.byte 0,0
	.byte 0,0
	.byte 2,8
	.byte 2,4
	.byte 2,2
	.byte 2,1
	.byte 130,0
	.byte 'B,0
	.byte 254,127
	.byte 6,0
	.byte 'B,0
	.byte 194,0
	.byte 130,1
	.byte 2,7
	.byte 3,2
	.byte 2,0
	.byte 0,0
	.byte 64,0
	.byte 32,0
	.byte 240,127
	.byte 12,0
	.byte 3,32
	.byte 8,33
	.byte 8,33
	.byte 9,33
	.byte 10,33
	.byte 252,63
	.byte 8,33
	.byte 8,33
	.byte 140,33
	.byte 8,49
	.byte 0,32
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 0,'X
	.byte 0,56
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 196,8
	.byte 180,8
	.byte 143,8
	.byte 244,255
	.byte 132,4
	.byte 132,'D
	.byte 4,'A
	.byte 130,'A
	.byte 'B,'A
	.byte 34,'A
	.byte 18,127
	.byte 42,'A
	.byte 'F,'A
	.byte 194,'A
	.byte 0,'A
	.byte 0,0
	.byte 128,0
	.byte 128,128
	.byte 128,64
	.byte 128,48
	.byte 252,15
	.byte 132,0
	.byte 134,2
	.byte 149,4
	.byte 164,12
	.byte 132,64
	.byte 132,128
	.byte 252,127
	.byte 128,0
	.byte 128,0
	.byte 128,0
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 226,63
	.byte 'B,32
	.byte 'B,32
	.byte 'B,32
	.byte 'B,32
	.byte 'B,32
	.byte 'B,32
	.byte 'B,32
	.byte 'B,32
	.byte 126,32
	.byte 0,32
	.byte 0,60
	.byte 0,16
	.byte 0,0
	.byte 128,64
	.byte 129,32
	.byte 142,31
	.byte 4,32
	.byte 0,32
	.byte 16,64
	.byte 'P,64
	.byte 144,'C
	.byte 16,'A
	.byte 16,'H
	.byte 16,'P
	.byte 255,'O
	.byte 16,64
	.byte 16,64
	.byte 16,64
	.byte 0,0
	.byte 0,0
	.byte 2,64
	.byte 2,32
	.byte 2,16
	.byte 2,12
	.byte 130,3
	.byte 126,0
	.byte 34,0
	.byte 34,32
	.byte 34,96
	.byte 34,32
	.byte 242,31
	.byte 34,0
	.byte 2,0
	.byte 2,0
	.byte 0,0
	.byte 8,64
	.byte 8,64
	.byte 10,'H
	.byte 234,'K
	.byte 170,'J
	.byte 170,'J
	.byte 170,'J
	.byte 255,127
	.byte 169,'J
	.byte 169,'J
	.byte 169,'J
	.byte 233,'K
	.byte 8,'H
	.byte 8,64
	.byte 8,64
	.byte 0,0
	.byte 0,0
	.byte 0,32
	.byte 224,127
	.byte 0,32
	.byte 0,32
	.byte 0,32
	.byte 0,32
	.byte 255,63
	.byte 0,32
	.byte 0,32
	.byte 0,32
	.byte 0,32
	.byte 0,32
	.byte 224,127
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 0,24
	.byte 0,36
	.byte 0,36
	.byte 0,24
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.dbsym e hz _hz A[1024:1024]kc
