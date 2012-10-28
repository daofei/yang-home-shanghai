	.module main.c
	.area text(rom, con, rel)
	.dbfile D:\yang-home-shanghai\smarthome\门禁系统资料\code\main.c
	.dbfunc e main _main fI
;            buf -> y+2
	.even
_main::
	sbiw R28,12
	.dbline -1
	.dbline 17
; #include <stdio.h>
; #include <string.h>
; #include <stdlib.h>
; #include <string.h>
; 
; #include<iom16v.h>
; #include <macros.h>
; 
; #include "init.h"
; #include "uart.h"
; #include "wg26.h"
; #include "util.h"
; 
; extern unsigned long id_code;
; 
; int main(void)
; {
	.dbline 19
;  char buf[10];
;  port_init();
	xcall _port_init
	.dbline 20
;  uart0_init();
	xcall _uart0_init
	.dbline 21
;  init_interrupt();
	xcall _init_interrupt
	.dbline 23
;  //uart0_send_string("uart send...\n");
;  PORTB = 0xff;
	ldi R24,255
	out 0x18,R24
	xjmp L3
L2:
	.dbline 25
;  while(1)
;  {
	.dbline 30
;   //uart0_send_string("uart send testing...\n");
;   //PORTB = 0xff;
;   //SEI();
;   
;   delay_ms(500);
	ldi R16,500
	ldi R17,1
	xcall _delay_ms
	.dbline 31
;   if(id_code)
	ldi R20,0
	ldi R21,0
	ldi R22,0
	ldi R23,0
	lds R4,_id_code+2
	lds R5,_id_code+2+1
	lds R2,_id_code
	lds R3,_id_code+1
	cp R2,R20
	cpc R3,R21
	cpc R4,R22
	cpc R5,R23
	breq L5
	.dbline 32
;   {
	.dbline 33
;    printf("sizeof(long)=%x", sizeof(long));
	ldi R18,4
	ldi R19,0
	ldi R16,<L7
	ldi R17,>L7
	xcall _printf
	.dbline 34
;    id_code &= 0x01fffffe;
	ldi R20,254
	ldi R21,255
	ldi R22,255
	ldi R23,1
	lds R4,_id_code+2
	lds R5,_id_code+2+1
	lds R2,_id_code
	lds R3,_id_code+1
	and R2,R20
	and R3,R21
	and R4,R22
	and R5,R23
	sts _id_code+1,R3
	sts _id_code,R2
	sts _id_code+2+1,R5
	sts _id_code+2,R4
	.dbline 35
;    id_code >>= 1;
	lsr R5
	ror R4
	ror R3
	ror R2
	sts _id_code+1,R3
	sts _id_code,R2
	sts _id_code+2+1,R5
	sts _id_code+2,R4
	.dbline 36
;    printf("id_code=%d", id_code);
	std y+0,R4
	std y+1,R5
	movw R18,R2
	ldi R16,<L8
	ldi R17,>L8
	xcall _printf
	.dbline 37
;   }
L5:
	.dbline 39
;   
;   if(id_code == 1392618)
	ldi R20,234
	ldi R21,63
	ldi R22,21
	ldi R23,0
	lds R4,_id_code+2
	lds R5,_id_code+2+1
	lds R2,_id_code
	lds R3,_id_code+1
	cp R2,R20
	cpc R3,R21
	cpc R4,R22
	cpc R5,R23
	brne L9
	.dbline 40
;   {
	.dbline 41
;    PORTB = 0x0;
	clr R2
	out 0x18,R2
	.dbline 42
;   }
L9:
	.dbline 43
L3:
	.dbline 24
	xjmp L2
X0:
	.dbline 44
;  }
;  return 0;
	clr R16
	clr R17
	.dbline -2
L1:
	adiw R28,12
	.dbline 0 ; func end
	ret
	.dbsym l buf 2 A[10:10]c
	.dbend
	.area data(ram, con, rel)
	.dbfile D:\yang-home-shanghai\smarthome\门禁系统资料\code\main.c
L8:
	.blkb 11
	.area idata
	.byte 'i,'d,95,'c,'o,'d,'e,61,37,'d,0
	.area data(ram, con, rel)
	.dbfile D:\yang-home-shanghai\smarthome\门禁系统资料\code\main.c
L7:
	.blkb 16
	.area idata
	.byte 's,'i,'z,'e,'o,'f,40,'l,'o,'n,'g,41,61,37,'x,0
	.area data(ram, con, rel)
	.dbfile D:\yang-home-shanghai\smarthome\门禁系统资料\code\main.c
