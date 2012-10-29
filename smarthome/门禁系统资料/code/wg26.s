	.module wg26.c
	.area text(rom, con, rel)
	.dbfile Z:\yang-home-shanghai\smarthome\门禁系统资料\code\wg26.c
	.dbfunc e init_interrupt _init_interrupt fV
	.even
_init_interrupt::
	.dbline -1
	.dbline 11
; #include <stdio.h>
; #include <stdlib.h>
; #include <string.h>
; 
; #include<iom16v.h>
; #include <macros.h>
; 
; #include "uart.h"
; 
; void init_interrupt(void)
; {
	.dbline 13
;  //pd2,pd3 input mode.
;  DDRD &= 0xf3;
	in R24,0x11
	andi R24,243
	out 0x11,R24
	.dbline 15
;  //上拉。
;  PORTD |= 0x0c;
	in R24,0x12
	ori R24,12
	out 0x12,R24
	.dbline 17
;  //enable interrupt.
;  SREG |= 0x80;
	bset 7
	.dbline 19
;  //int1 int0 enable.
;  GICR |= 0xc0;
	in R24,0x3b
	ori R24,192
	out 0x3b,R24
	.dbline 21
;   //int1 int0 fall edge.
;  MCUCR |= 0x0a;
	in R24,0x35
	ori R24,10
	out 0x35,R24
	.dbline 22
;  return;
	.dbline -2
L1:
	.dbline 0 ; func end
	ret
	.dbend
	.area data(ram, con, rel)
	.dbfile Z:\yang-home-shanghai\smarthome\门禁系统资料\code\wg26.c
_id_code::
	.blkb 4
	.area idata
	.word 0,0
	.area data(ram, con, rel)
	.dbfile Z:\yang-home-shanghai\smarthome\门禁系统资料\code\wg26.c
	.dbsym e id_code _id_code l
	.area vector(rom, abs)
	.org 8
	jmp _int1_isr
	.area data(ram, con, rel)
	.dbfile Z:\yang-home-shanghai\smarthome\门禁系统资料\code\wg26.c
	.area text(rom, con, rel)
	.dbfile Z:\yang-home-shanghai\smarthome\门禁系统资料\code\wg26.c
	.dbfunc e int1_isr _int1_isr fV
	.even
_int1_isr::
	st -y,R2
	st -y,R3
	st -y,R4
	st -y,R5
	st -y,R8
	st -y,R9
	st -y,R30
	in R2,0x3f
	st -y,R2
	xcall push_gset2
	.dbline -1
	.dbline 29
; }
; 
; unsigned long id_code = 0;
; 
; #pragma interrupt_handler int1_isr:3
; void int1_isr(void)
; {
	.dbline 30
;  id_code <<= 1;
	lds R4,_id_code+2
	lds R5,_id_code+2+1
	lds R2,_id_code
	lds R3,_id_code+1
	lsl R2
	rol R3
	rol R4
	rol R5
	sts _id_code+1,R3
	sts _id_code,R2
	sts _id_code+2+1,R5
	sts _id_code+2,R4
	.dbline 31
;  id_code |= 1;
	ldi R20,1
	ldi R21,0
	ldi R22,0
	ldi R23,0
	or R2,R20
	or R3,R21
	or R4,R22
	or R5,R23
	sts _id_code+1,R3
	sts _id_code,R2
	sts _id_code+2+1,R5
	sts _id_code+2,R4
	.dbline -2
L2:
	xcall pop_gset2
	ld R2,y+
	out 0x3f,R2
	ld R30,y+
	ld R9,y+
	ld R8,y+
	ld R5,y+
	ld R4,y+
	ld R3,y+
	ld R2,y+
	.dbline 0 ; func end
	reti
	.dbend
	.area vector(rom, abs)
	.org 4
	jmp _int0_isr
	.area text(rom, con, rel)
	.dbfile Z:\yang-home-shanghai\smarthome\门禁系统资料\code\wg26.c
	.dbfunc e int0_isr _int0_isr fV
	.even
_int0_isr::
	st -y,R0
	st -y,R1
	st -y,R2
	st -y,R3
	st -y,R4
	st -y,R5
	in R0,0x3f
	st -y,R0
	.dbline -1
	.dbline 36
; }
; 
; #pragma interrupt_handler int0_isr:2
; void int0_isr(void)
; {
	.dbline 37
;  id_code <<= 1;
	lds R4,_id_code+2
	lds R5,_id_code+2+1
	lds R2,_id_code
	lds R3,_id_code+1
	lsl R2
	rol R3
	rol R4
	rol R5
	sts _id_code+1,R3
	sts _id_code,R2
	sts _id_code+2+1,R5
	sts _id_code+2,R4
	.dbline -2
L3:
	ld R0,y+
	out 0x3f,R0
	ld R5,y+
	ld R4,y+
	ld R3,y+
	ld R2,y+
	ld R1,y+
	ld R0,y+
	.dbline 0 ; func end
	reti
	.dbend
