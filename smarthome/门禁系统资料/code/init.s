	.module init.c
	.area text(rom, con, rel)
	.dbfile D:\yang-home-shanghai\smarthome\门禁系统资料\code\init.c
	.dbfunc e port_init _port_init fV
	.even
_port_init::
	.dbline -1
	.dbline 5
; #include<iom16v.h>
; #include <macros.h>
; 
; void port_init(void)
; {
	.dbline 9
;  //PORTA = 0xff;
;  //DDRA = 0x00;
;  //PORTB = 0xff;
;  DDRB = 0xff;
	ldi R24,255
	out 0x17,R24
	.dbline -2
L1:
	.dbline 0 ; func end
	ret
	.dbend
