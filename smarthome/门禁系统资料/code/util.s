	.module util.c
	.area text(rom, con, rel)
	.dbfile Z:\yang-home-shanghai\smarthome\门禁系统资料\code\util.c
	.dbfunc e delay_ms _delay_ms fV
;              i -> R20,R21
;              j -> R22,R23
;             ms -> R16,R17
	.even
_delay_ms::
	xcall push_gset2
	.dbline -1
	.dbline 8
; #include <stdio.h>
; #include <string.h>
; #include <stdlib.h>
; 
; #include "util.h"
; 
; void delay_ms(int ms)
; {
	.dbline 10
;     int i,j;			
;     for(i=0;i<ms;i++)
	clr R20
	clr R21
	xjmp L5
L2:
	.dbline 11
;     {
	.dbline 12
;        for(j=0;j<1140;j++)
	clr R22
	clr R23
L6:
	.dbline 13
L7:
	.dbline 12
	subi R22,255  ; offset = 1
	sbci R23,255
	.dbline 12
	cpi R22,116
	ldi R30,4
	cpc R23,R30
	brlt L6
	.dbline 14
L3:
	.dbline 10
	subi R20,255  ; offset = 1
	sbci R21,255
L5:
	.dbline 10
	cp R20,R16
	cpc R21,R17
	brlt L2
	.dbline -2
L1:
	xcall pop_gset2
	.dbline 0 ; func end
	ret
	.dbsym r i 20 I
	.dbsym r j 22 I
	.dbsym r ms 16 I
	.dbend
