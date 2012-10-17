	.module ac8-2.c
	.area text(rom, con, rel)
	.dbfile d:\MYDOCU~1\ac8-2\ac8-2.c
	.dbfunc e delay_ms _delay_ms fV
;              i -> R20,R21
;              j -> R22,R23
;              k -> R16,R17
	.even
_delay_ms::
	xcall push_gset2
	.dbline -1
	.dbline 9
; #include<iom16v.h>	
; #define uchar unsigned char
; #define uint unsigned int
; #define BZ_0  (PORTD=PORTD&0xdf) 
; #define BZ_1  (PORTD=PORTD|0x20) 
; uint cnt;
; //=============================
; void delay_ms(uint k)
; {
	.dbline 11
; uint i,j;			
;     for(i=0;i<k;i++)
	clr R20
	clr R21
	xjmp L5
L2:
	.dbline 12
;     {
	.dbline 13
;        for(j=0;j<1140;j++)
	clr R22
	clr R23
	xjmp L9
L6:
	.dbline 14
L7:
	.dbline 13
	subi R22,255  ; offset = 1
	sbci R23,255
L9:
	.dbline 13
	cpi R22,116
	ldi R30,4
	cpc R23,R30
	brlo L6
	.dbline 15
L3:
	.dbline 11
	subi R20,255  ; offset = 1
	sbci R21,255
L5:
	.dbline 11
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
	.dbline 19
;        ;
;     }
; }
; //=============================
; void main(void)	
; {				
	.dbline 20
; PORTB=0xff;	
	ldi R24,255
	out 0x18,R24
	.dbline 21
; DDRB=0xff;	
	out 0x17,R24
	.dbline 22
; PORTD=0xff;	
	out 0x12,R24
	.dbline 23
; DDRD  = 0xf3;
	ldi R24,243
	out 0x11,R24
	.dbline 24
; MCUCR = 0x0A; 
	ldi R24,10
	out 0x35,R24
	.dbline 25
; GICR  = 0xC0; 
	ldi R24,192
	out 0x3b,R24
	.dbline 26
; SREG=0x80; 
	ldi R24,128
	out 0x3f,R24
	xjmp L12
L11:
	.dbline 28
	.dbline 29
	clr R2
	out 0x18,R2
	.dbline 30
	ldi R16,500
	ldi R17,1
	xcall _delay_ms
	.dbline 31
	ldi R24,255
	out 0x18,R24
	.dbline 32
	ldi R16,500
	ldi R17,1
	xcall _delay_ms
	.dbline 33
L12:
	.dbline 27
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
	.dbfile d:\MYDOCU~1\ac8-2\ac8-2.c
	.dbfunc e int0_isr _int0_isr fV
	.even
_int0_isr::
	xcall push_lset
	.dbline -1
	.dbline 38
;    while(1)		
;    {	
;    PORTB=0x00;
;    delay_ms(500);
;    PORTB=0xff; 
;    delay_ms(500); 
;    }			
; }			
; //***************************************************
; #pragma interrupt_handler int0_isr:2
; void int0_isr(void)
; {
	.dbline 39
;  PORTB=0x0f;
	ldi R24,15
	out 0x18,R24
	.dbline 40
;   delay_ms(2000);
	ldi R16,2000
	ldi R17,7
	xcall _delay_ms
	.dbline -2
L14:
	xcall pop_lset
	.dbline 0 ; func end
	reti
	.dbend
	.area vector(rom, abs)
	.org 8
	jmp _int1_isr
	.area text(rom, con, rel)
	.dbfile d:\MYDOCU~1\ac8-2\ac8-2.c
	.dbfunc e int1_isr _int1_isr fV
	.even
_int1_isr::
	xcall push_lset
	.dbline -1
	.dbline 45
; }
; //****************************************
; #pragma interrupt_handler int1_isr:3
; void int1_isr(void)
; {
	.dbline 46
; SREG=0x80;				
	ldi R24,128
	out 0x3f,R24
	.dbline 47
;  for(cnt=0;cnt<5000;cnt++)
	clr R2
	clr R3
	sts _cnt+1,R3
	sts _cnt,R2
	xjmp L19
L16:
	.dbline 48
	.dbline 48
	sbi 0x12,5
	.dbline 48
	ldi R16,2
	ldi R17,0
	xcall _delay_ms
	.dbline 48
	in R24,0x12
	andi R24,223
	out 0x12,R24
	.dbline 48
L17:
	.dbline 47
	lds R24,_cnt
	lds R25,_cnt+1
	adiw R24,1
	sts _cnt+1,R25
	sts _cnt,R24
L19:
	.dbline 47
	lds R24,_cnt
	lds R25,_cnt+1
	cpi R24,136
	ldi R30,19
	cpc R25,R30
	brlo L16
	.dbline -2
L15:
	xcall pop_lset
	.dbline 0 ; func end
	reti
	.dbend
	.area bss(ram, con, rel)
	.dbfile d:\MYDOCU~1\ac8-2\ac8-2.c
_cnt::
	.blkb 2
	.dbsym e cnt _cnt i
