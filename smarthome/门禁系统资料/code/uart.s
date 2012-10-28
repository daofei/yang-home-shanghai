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
; //uart0 init.
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
	.dbfunc e uart0_send _uart0_send fV
;              i -> R16
	.even
_uart0_send::
	.dbline -1
	.dbline 18
; }
; //uart0 send char.
; void uart0_send(unsigned char i)
; {
L3:
	.dbline 19
L4:
	.dbline 19
;  while(!(UCSRA&(1<<UDRE)));
	sbis 0xb,5
	rjmp L3
	.dbline 20
;  UDR = i;
	out 0xc,R16
	.dbline -2
L2:
	.dbline 0 ; func end
	ret
	.dbsym r i 16 c
	.dbend
	.dbfunc e uart0_receive _uart0_receive fc
	.even
_uart0_receive::
	.dbline -1
	.dbline 24
; }
; //uart0 receive.
; unsigned char uart0_receive(void)
; {
L7:
	.dbline 25
L8:
	.dbline 25
;  while(!(UCSRA&(1<<RXC)));
	sbis 0xb,7
	rjmp L7
	.dbline 26
;  return UDR;
	in R16,0xc
	.dbline -2
L6:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e uart0_send_string _uart0_send_string fV
;         string -> R20,R21
	.even
_uart0_send_string::
	xcall push_gset1
	movw R20,R16
	.dbline -1
	.dbline 30
; }
; //uart0 send string
; void uart0_send_string(char* string)
; {
	xjmp L12
L11:
	.dbline 32
	.dbline 33
	movw R30,R20
	ldd R16,z+0
	xcall _uart0_send
	.dbline 34
	subi R20,255  ; offset = 1
	sbci R21,255
	.dbline 35
L12:
	.dbline 31
;  while(*string)
	movw R30,R20
	ldd R2,z+0
	tst R2
	brne L11
	.dbline -2
L10:
	xcall pop_gset1
	.dbline 0 ; func end
	ret
	.dbsym r string 20 pc
	.dbend
