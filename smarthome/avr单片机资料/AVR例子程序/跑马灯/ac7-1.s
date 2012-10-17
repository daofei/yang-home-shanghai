	.module ac7-1.c
	.area text(rom, con, rel)
	.dbfile d:\MYDOCU~1\ac7-1\ac7-1.c
	.dbfunc e delay_ms _delay_ms fV
;              i -> R20,R21
;              j -> R22,R23
;              k -> R16,R17
	.even
_delay_ms::
	xcall push_gset2
	.dbline -1
	.dbline 6
; #include<iom16v.h>
; #define uchar unsigned char
; #define uint unsigned int
; //=============================
; void delay_ms(uint k)
; {
	.dbline 8
;     uint i,j;			
;     for(i=0;i<k;i++)
	clr R20
	clr R21
	xjmp L5
L2:
	.dbline 9
;     {
	.dbline 10
;        for(j=0;j<570;j++)
	clr R22
	clr R23
	xjmp L9
L6:
	.dbline 11
L7:
	.dbline 10
	subi R22,255  ; offset = 1
	sbci R23,255
L9:
	.dbline 10
	cpi R22,58
	ldi R30,2
	cpc R23,R30
	brlo L6
	.dbline 12
L3:
	.dbline 8
	subi R20,255  ; offset = 1
	sbci R21,255
L5:
	.dbline 8
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
	.dbline 16
;        ;
;     }
; }
; //=============================
; void main(void)	
; {				
	.dbline 17
; DDRB=0xff;		
	ldi R24,255
	out 0x17,R24
	.dbline 18
; PORTB=0xff;		
	out 0x18,R24
	xjmp L12
L11:
	.dbline 20
	.dbline 21
	ldi R24,170
	out 0x18,R24
	.dbline 22
	ldi R16,500
	ldi R17,1
	xcall _delay_ms
	.dbline 23
	ldi R24,85
	out 0x18,R24
	.dbline 24
	ldi R16,500
	ldi R17,1
	xcall _delay_ms
	.dbline 25
L12:
	.dbline 19
	xjmp L11
X0:
	.dbline -2
L10:
	.dbline 0 ; func end
	ret
	.dbend
