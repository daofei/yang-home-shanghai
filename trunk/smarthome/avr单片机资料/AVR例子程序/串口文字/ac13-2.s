	.module ac13-2.c
	.area text(rom, con, rel)
	.dbfile d:\MYDOCU~1\ac13-2\ac13-2.c
	.dbfunc e port_init _port_init fV
	.even
_port_init::
	.dbline -1
	.dbline 5
; #include <iom16v.h>
; #include <macros.h>
; /*************************************************/
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
; /**************************************************/
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
; /********************************************************/
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
	.dbfunc e str_send _str_send fV
;              s -> R20,R21
	.even
_str_send::
	xcall push_gset1
	movw R20,R16
	.dbline -1
	.dbline 39
; }
; /*******************************************/
; void str_send(char *s) 
; {
	xjmp L10
L9:
	.dbline 41
	.dbline 42
	movw R30,R20
	ldd R16,z+0
	xcall _uart0_send
	.dbline 43
	subi R20,255  ; offset = 1
	sbci R21,255
	.dbline 44
L10:
	.dbline 40
;  while(*s)
	movw R30,R20
	ldd R2,z+0
	tst R2
	brne L9
	.dbline -2
L8:
	xcall pop_gset1
	.dbline 0 ; func end
	ret
	.dbsym r s 20 pc
	.dbend
	.dbfunc e uart0_receive _uart0_receive fc
	.even
_uart0_receive::
	.dbline -1
	.dbline 48
;  {
;  uart0_send(*s); 
;  s++;
;  }
; }
; /*********************************************/
; unsigned char uart0_receive(void) 
; {
L13:
	.dbline 49
L14:
	.dbline 49
; while(!(UCSRA&(1<<RXC)));
	sbis 0xb,7
	rjmp L13
	.dbline 50
; return UDR;
	in R16,0xc
	.dbline -2
L12:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e main _main fV
;           temp -> R20
	.even
_main::
	.dbline -1
	.dbline 54
; }
; /********************************************/
; void main(void)
; {
	.dbline 56
; unsigned char temp; 
; init_devices();
	xcall _init_devices
	.dbline 57
; str_send("上海红棱电子有限公司  ");
	ldi R16,<L17
	ldi R17,>L17
	xcall _str_send
	.dbline 58
; str_send("AVR单片机RS232通信测试程序  ");
	ldi R16,<L18
	ldi R17,>L18
	xcall _str_send
	.dbline 59
; str_send("http://www.hlelectron.com  ");
	ldi R16,<L19
	ldi R17,>L19
	xcall _str_send
	xjmp L21
L20:
	.dbline 61
	.dbline 62
	xcall _uart0_receive
	mov R20,R16
	.dbline 63
	ldi R16,<L23
	ldi R17,>L23
	xcall _str_send
	.dbline 64
	mov R16,R20
	xcall _uart0_send
	.dbline 65
	ldi R16,<L24
	ldi R17,>L24
	xcall _str_send
	.dbline 66
L21:
	.dbline 60
	xjmp L20
X0:
	.dbline -2
L16:
	.dbline 0 ; func end
	ret
	.dbsym r temp 20 c
	.dbend
	.area data(ram, con, rel)
	.dbfile d:\MYDOCU~1\ac13-2\ac13-2.c
L24:
	.blkb 3
	.area idata
	.byte 32,32,0
	.area data(ram, con, rel)
	.dbfile d:\MYDOCU~1\ac13-2\ac13-2.c
L23:
	.blkb 13
	.area idata
	.byte 181,177,199,176,176,180,188,252,202,199,163,186,0
	.area data(ram, con, rel)
	.dbfile d:\MYDOCU~1\ac13-2\ac13-2.c
L19:
	.blkb 28
	.area idata
	.byte 'h,'t,'t,'p,58,47,47,'w,'w,'w,46,'h,'l,'e,'l,'e
	.byte 'c,'t,'r,'o,'n,46,'c,'o,'m,32,32,0
	.area data(ram, con, rel)
	.dbfile d:\MYDOCU~1\ac13-2\ac13-2.c
L18:
	.blkb 29
	.area idata
	.byte 'A,'V,'R,181,165,198,172,187,250,'R,'S,50,51,50,205,168
	.byte 208,197,178,226,202,212,179,204,208,242,32,32,0
	.area data(ram, con, rel)
	.dbfile d:\MYDOCU~1\ac13-2\ac13-2.c
L17:
	.blkb 23
	.area idata
	.byte 201,207,186,163,186,236,192,226,181,231,215,211,211,208,207,222
	.byte 185,171,203,190,32,32,0
	.area data(ram, con, rel)
	.dbfile d:\MYDOCU~1\ac13-2\ac13-2.c
