	.module ac13-1.c
	.area text(rom, con, rel)
	.dbfile d:\MYDOCU~1\ac13-1\ac13-1.c
	.dbfunc e port_init _port_init fV
	.even
_port_init::
	.dbline -1
	.dbline 5
; #include <iom16v.h>
; #include <macros.h>
; //==================================
; void port_init(void)
; {
	.dbline 6
;  PORTA = 0xFF; 
	ldi R24,255
	out 0x1b,R24
	.dbline 7
;  DDRA  = 0x00; 
	clr R2
	out 0x1a,R2
	.dbline 8
;  PORTB = 0xFF; 
	out 0x18,R24
	.dbline 9
;  DDRB  = 0xFF; 
	out 0x17,R24
	.dbline 10
;  PORTC = 0xFF; 
	out 0x15,R24
	.dbline 11
;  DDRC  = 0x00; 
	out 0x14,R2
	.dbline 12
;  PORTD = 0xFF; 
	out 0x12,R24
	.dbline 13
;  DDRD  = 0x02; 
	ldi R24,2
	out 0x11,R24
	.dbline -2
L1:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e uart0_init _uart0_init fV
	.even
_uart0_init::
	.dbline -1
	.dbline 17
; }
; //**********************************************
; void uart0_init(void)
; {
	.dbline 18
;  UCSRB = 0x00; 
	clr R2
	out 0xa,R2
	.dbline 19
;  UCSRA = 0x02;
	ldi R24,2
	out 0xb,R24
	.dbline 20
;  UCSRC = 0x06;
	ldi R24,6
	out 0x20,R24
	.dbline 21
;  UBRRL = 0x67;
	ldi R24,103
	out 0x9,R24
	.dbline 22
;  UBRRH = 0x00; 
	out 0x20,R2
	.dbline 23
;  UCSRB = 0x18;
	ldi R24,24
	out 0xa,R24
	.dbline -2
L2:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e init_devices _init_devices fV
	.even
_init_devices::
	.dbline -1
	.dbline 27
; }
; //**********************************************
; void init_devices(void) 
; {
	.dbline 28
;  port_init();
	xcall _port_init
	.dbline 29
;  uart0_init();
	xcall _uart0_init
	.dbline -2
L3:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e uart0_send _uart0_send fV
;              i -> R16
	.even
_uart0_send::
	.dbline -1
	.dbline 33
;  }
; //**********************************************
; void uart0_send(unsigned char i)
; {
L5:
	.dbline 34
L6:
	.dbline 34
; while(!(UCSRA&(1<<UDRE)));
	sbis 0xb,5
	rjmp L5
	.dbline 35
; UDR=i;
	out 0xc,R16
	.dbline -2
L4:
	.dbline 0 ; func end
	ret
	.dbsym r i 16 c
	.dbend
	.dbfunc e uart0_receive _uart0_receive fc
	.even
_uart0_receive::
	.dbline -1
	.dbline 39
; }
; //************************************************
; unsigned char uart0_receive(void) 
; {
L9:
	.dbline 40
L10:
	.dbline 40
; while(!(UCSRA&(1<<RXC)));
	sbis 0xb,7
	rjmp L9
	.dbline 41
; return UDR;
	in R16,0xc
	.dbline -2
L8:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e main _main fV
;           temp -> R20
	.even
_main::
	.dbline -1
	.dbline 45
; }
; //---------------------------------------------------------------
; void main(void)
; {
	.dbline 47
; unsigned char temp;
; init_devices();
	xcall _init_devices
	xjmp L14
L13:
	.dbline 49
	.dbline 50
	xcall _uart0_receive
	mov R20,R16
	.dbline 51
	mov R2,R20
	com R2
	out 0x18,R2
	.dbline 52
	xcall _uart0_send
	.dbline 53
L14:
	.dbline 48
	xjmp L13
X0:
	.dbline -2
L12:
	.dbline 0 ; func end
	ret
	.dbsym r temp 20 c
	.dbend
