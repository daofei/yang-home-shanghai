	.module ac8-3.c
	.area lit(rom, con, rel)
_SEG7::
	.byte 63,6
	.byte 91,'O
	.byte 'f,'m
	.byte 125,7
	.byte 127,'o
	.dbfile d:\MYDOCU~1\ac8-3\ac8-3.c
	.dbsym e SEG7 _SEG7 A[10:10]kc
	.area text(rom, con, rel)
	.dbfile d:\MYDOCU~1\ac8-3\ac8-3.c
	.dbfunc e delay_ms _delay_ms fV
;              i -> R20,R21
;              j -> R22,R23
;              k -> R16,R17
	.even
_delay_ms::
	xcall push_gset2
	.dbline -1
	.dbline 11
; #include<iom16v.h>		
; #define uchar unsigned char	
; #define uint unsigned int
; 	
; uchar const SEG7[10]={0x3f,0x06,0x5b, 
; 0x4f,0x66,	0x6d,0x7d,0x07,0x7f,0x6f};
; #define ALM_ON  (PORTB=PORTB&0xfe) 
; uchar alm_flag1,alm_flag2;
; //*************************************************
; void delay_ms(uint k) 
; {
	.dbline 13
; uint i,j;			
;     for(i=0;i<k;i++)
	clr R20
	clr R21
	xjmp L5
L2:
	.dbline 14
;     {
	.dbline 15
;        for(j=0;j<1140;j++)
	clr R22
	clr R23
	xjmp L9
L6:
	.dbline 16
L7:
	.dbline 15
	subi R22,255  ; offset = 1
	sbci R23,255
L9:
	.dbline 15
	cpi R22,116
	ldi R30,4
	cpc R23,R30
	brlo L6
	.dbline 17
L3:
	.dbline 13
	subi R20,255  ; offset = 1
	sbci R21,255
L5:
	.dbline 13
	cp R20,R16
	cpc R21,R17
	brlo L2
	.dbline -2
L1:
	xcall pop_gset2
	.dbline 0 ; func end
	ret
	.dbsym r i 20 i
	.dbsym r j 22 i
	.dbsym r k 16 i
	.dbend
	.dbfunc e main _main fV
	.even
_main::
	.dbline -1
	.dbline 21
;        ;
;     }
; }
; //=============================
; void main(void)	
; {				
	.dbline 22
; DDRA=0xff;		
	ldi R24,255
	out 0x1a,R24
	.dbline 23
; DDRC=0xff;		
	out 0x14,R24
	.dbline 24
; PORTA=0x00;		
	clr R2
	out 0x1b,R2
	.dbline 25
; PORTC=0xff;		
	out 0x15,R24
	.dbline 26
; PORTB=0xff;		 
	out 0x18,R24
	.dbline 27
; DDRB=0xff;		
	out 0x17,R24
	.dbline 28
; PORTD=0xff;		 
	out 0x12,R24
	.dbline 29
; DDRD  = 0xf3;	
	ldi R24,243
	out 0x11,R24
	.dbline 30
; MCUCR = 0x0A; 
	ldi R24,10
	out 0x35,R24
	.dbline 31
; GICR  = 0xC0; 
	ldi R24,192
	out 0x3b,R24
	.dbline 32
; SREG=0x80; 
	ldi R24,128
	out 0x3f,R24
	xjmp L12
L11:
	.dbline 34
;    while(1)	
;    {			
	.dbline 35
;      if(alm_flag1==1)
	lds R24,_alm_flag1
	cpi R24,1
	brne L14
	.dbline 36
;      {PORTA=SEG7[1];
	.dbline 36
	ldi R30,<_SEG7+1
	ldi R31,>_SEG7+1
	lpm R30,Z
	out 0x1b,R30
	.dbline 37
;      PORTC=0xfe;
	ldi R24,254
	out 0x15,R24
	.dbline 38
; 	     ALM_ON;
	in R24,0x18
	andi R24,254
	out 0x18,R24
	.dbline 39
;      delay_ms(2000);
	ldi R16,2000
	ldi R17,7
	xcall _delay_ms
	.dbline 40
;      }				
L14:
	.dbline 41
; 	 	if(alm_flag2==1) 
	lds R24,_alm_flag2
	cpi R24,1
	brne L17
	.dbline 42
; 	 	{PORTA=SEG7[2]; 
	.dbline 42
	ldi R30,<_SEG7+2
	ldi R31,>_SEG7+2
	lpm R30,Z
	out 0x1b,R30
	.dbline 43
;      PORTC=0xfe; 
	ldi R24,254
	out 0x15,R24
	.dbline 44
; 	 	ALM_ON; 
	in R24,0x18
	andi R24,254
	out 0x18,R24
	.dbline 45
;      delay_ms(2000);
	ldi R16,2000
	ldi R17,7
	xcall _delay_ms
	.dbline 46
;      }		
L17:
	.dbline 47
L12:
	.dbline 33
	xjmp L11
X0:
	.dbline -2
L10:
	.dbline 0 ; func end
	ret
	.dbend
	.area vector(rom, abs)
	.org 4
	jmp _int0_isr
	.area text(rom, con, rel)
	.dbfile d:\MYDOCU~1\ac8-3\ac8-3.c
	.dbfunc e int0_isr _int0_isr fV
	.even
_int0_isr::
	st -y,R24
	in R24,0x3f
	st -y,R24
	.dbline -1
	.dbline 52
;    } 			
; }				
; //**************************************************
; #pragma interrupt_handler int0_isr:2	
; void int0_isr(void)
; {
	.dbline 53
;  alm_flag1=1;					
	ldi R24,1
	sts _alm_flag1,R24
	.dbline -2
L20:
	ld R24,y+
	out 0x3f,R24
	ld R24,y+
	.dbline 0 ; func end
	reti
	.dbend
	.area vector(rom, abs)
	.org 8
	jmp _int1_isr
	.area text(rom, con, rel)
	.dbfile d:\MYDOCU~1\ac8-3\ac8-3.c
	.dbfunc e int1_isr _int1_isr fV
	.even
_int1_isr::
	st -y,R24
	in R24,0x3f
	st -y,R24
	.dbline -1
	.dbline 58
; }
; //****************************************
; #pragma interrupt_handler int1_isr:3	
; void int1_isr(void)
; {
	.dbline 59
; alm_flag2=1;			
	ldi R24,1
	sts _alm_flag2,R24
	.dbline -2
L21:
	ld R24,y+
	out 0x3f,R24
	ld R24,y+
	.dbline 0 ; func end
	reti
	.dbend
	.area bss(ram, con, rel)
	.dbfile d:\MYDOCU~1\ac8-3\ac8-3.c
_alm_flag2::
	.blkb 1
	.dbsym e alm_flag2 _alm_flag2 c
_alm_flag1::
	.blkb 1
	.dbsym e alm_flag1 _alm_flag1 c
