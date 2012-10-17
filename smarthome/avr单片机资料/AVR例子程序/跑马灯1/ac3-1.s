	.module ac3-1.c
	.area text(rom, con, rel)
	.dbfile C:\DOCUME~1\Administrator\MYDOCU~1\ac3-1\ac3-1.c
	.dbfunc e delay _delay fV
;              i -> R16,R17
;              j -> R18,R19
	.even
_delay::
	.dbline -1
	.dbline 4
; 
; #include<iom16v.h>
; void delay(void)
; {
	.dbline 6
; unsigned int i,j;
; for(i=0;i<1000;i++)
	clr R16
	clr R17
	xjmp L5
L2:
	.dbline 7
; {
	.dbline 8
;    for(j=0;j<500;j++)
	clr R18
	clr R19
	xjmp L9
L6:
	.dbline 9
L7:
	.dbline 8
	subi R18,255  ; offset = 1
	sbci R19,255
L9:
	.dbline 8
	cpi R18,244
	ldi R30,1
	cpc R19,R30
	brlo L6
	.dbline 10
L3:
	.dbline 6
	subi R16,255  ; offset = 1
	sbci R17,255
L5:
	.dbline 6
	cpi R16,232
	ldi R30,3
	cpc R17,R30
	brlo L2
	.dbline -2
L1:
	.dbline 0 ; func end
	ret
	.dbsym r i 16 i
	.dbsym r j 18 i
	.dbend
	.dbfunc e main _main fV
	.even
_main::
	.dbline -1
	.dbline 14
;    ;
; }
; }
; //=============================
; void main(void)
; {
	.dbline 15
; DDRB=0xff;
	ldi R24,255
	out 0x17,R24
	.dbline 16
; PORTB=0xff;
	out 0x18,R24
	xjmp L12
L11:
	.dbline 18
	.dbline 19
	clr R2
	out 0x18,R2
	.dbline 20
	xcall _delay
	.dbline 21
	ldi R24,255
	out 0x18,R24
	.dbline 22
	xcall _delay
	.dbline 23
L12:
	.dbline 17
	xjmp L11
X0:
	.dbline -2
L10:
	.dbline 0 ; func end
	ret
	.dbend
