	.module main.c
	.area text(rom, con, rel)
	.dbfile D:\yang-home-shanghai\smarthome\门禁系统资料\code\main.c
	.dbfunc e main _main fI
	.even
_main::
	.dbline -1
	.dbline 15
; #include <stdio.h>
; #include <string.h>
; #include <stdlib.h>
; #include<iom16v.h>
; #include <macros.h>
; 
; #include "init.h"
; #include "uart.h"
; #include "wg26.h"
; #include "util.h"
; 
; extern unsigned char interr;
; 
; int main(void)
; {
	.dbline 16
;  port_init();
	xcall _port_init
	.dbline 17
;  uart0_init();
	xcall _uart0_init
	.dbline 18
;  init_interrupt1();
	xcall _init_interrupt1
	.dbline 19
;  uart0_send_string("uart send...\n");
	ldi R16,<L2
	ldi R17,>L2
	xcall _uart0_send_string
	.dbline 20
;  PORTB = 0xff;
	ldi R24,255
	out 0x18,R24
	xjmp L4
L3:
	.dbline 22
;  while(1)
;  {
	.dbline 25
;   //uart0_send_string("uart send testing...\n");
;   //PORTB = 0xff;
;   if(interr)
	lds R2,_interr
	tst R2
	breq L6
	.dbline 26
;   {
	.dbline 28
;     //delay_ms(500);
;     PORTB = 0x00;
	clr R2
	out 0x18,R2
	.dbline 29
;   }
L6:
	.dbline 30
	sei
	.dbline 32
L4:
	.dbline 21
	xjmp L3
X0:
	.dbline 33
;   SEI();
;   //delay_ms(500);
;  }
;  return 0;
	clr R16
	clr R17
	.dbline -2
L1:
	.dbline 0 ; func end
	ret
	.dbend
	.area data(ram, con, rel)
	.dbfile D:\yang-home-shanghai\smarthome\门禁系统资料\code\main.c
L2:
	.blkb 14
	.area idata
	.byte 'u,'a,'r,'t,32,'s,'e,'n,'d,46,46,46,10,0
	.area data(ram, con, rel)
	.dbfile D:\yang-home-shanghai\smarthome\门禁系统资料\code\main.c
