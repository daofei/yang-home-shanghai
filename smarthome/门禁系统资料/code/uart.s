	.module uart.c
	.area text(rom, con, rel)
	.dbfile D:\yang-home-shanghai\smarthome\门禁系统资料\code\uart.c
	.dbfunc e uart0_init _uart0_init fV
	.even
_uart0_init::
	.dbline -1
	.dbline 8
; #include<iom16v.h>
; #include <macros.h>
; 
; #include "uart.h"
; 
; //uart0 init. for printf.
; void uart0_init(void)
; {
	.dbline 9
;  UCSRB = 0x00;                //禁止UART发送和接收
	clr R2
	out 0xa,R2
	.dbline 10
;  UCSRA = 0x02;				  //倍速
	ldi R24,2
	out 0xb,R24
	.dbline 11
;  UCSRC = 0x06;				  //8位数据
	ldi R24,6
	out 0x20,R24
	.dbline 12
;  UBRRL = 0x67;				  //9600bps
	ldi R24,103
	out 0x9,R24
	.dbline 13
;  UBRRH = 0x00;
	out 0x20,R2
	.dbline 14
;  UCSRB = 0x18;
	ldi R24,24
	out 0xa,R24
	.dbline -2
L1:
	.dbline 0 ; func end
	ret
	.dbend
