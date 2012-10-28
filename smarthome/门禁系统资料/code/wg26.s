	.module wg26.c
	.area text(rom, con, rel)
	.dbfile D:\yang-home-shanghai\smarthome\门禁系统资料\code\wg26.c
	.dbfunc e init_interrupt1 _init_interrupt1 fV
	.even
_init_interrupt1::
	.dbline -1
	.dbline 7
; #include<iom16v.h>
; #include <macros.h>
; 
; #include "uart.h"
; 
; void init_interrupt1(void)
; {
	.dbline 9
;  //DDRD = 0x00;
;  SREG = 0x80;
	ldi R24,128
	out 0x3f,R24
	.dbline 10
;  GICR = 0x80;
	out 0x3b,R24
	.dbline 11
;  MCUCR = 0x08; //INT1下降沿触发。
	ldi R24,8
	out 0x35,R24
	.dbline 12
;  return;
	.dbline -2
L1:
	.dbline 0 ; func end
	ret
	.dbend
	.area data(ram, con, rel)
	.dbfile D:\yang-home-shanghai\smarthome\门禁系统资料\code\wg26.c
_interr::
	.blkb 1
	.area idata
	.byte 0
	.area data(ram, con, rel)
	.dbfile D:\yang-home-shanghai\smarthome\门禁系统资料\code\wg26.c
	.dbsym e interr _interr c
	.area text(rom, con, rel)
	.dbfile D:\yang-home-shanghai\smarthome\门禁系统资料\code\wg26.c
	.dbfunc e intsb _intsb fV
	.even
_intsb::
	.dbline -1
	.dbline 19
; }
; 
; unsigned char interr = 0;
; 
; #pragma interrupt_hander intsb:3
; void intsb(void)
; {
	.dbline 21
;  //uart0_send_string("int1 enable.\n");
;  interr = 1;
	ldi R24,1
	sts _interr,R24
	.dbline -2
L2:
	.dbline 0 ; func end
	ret
	.dbend
