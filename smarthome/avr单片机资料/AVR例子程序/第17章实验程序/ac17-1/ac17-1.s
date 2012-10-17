	.module ac17-1.c
	.area text(rom, con, rel)
	.dbfile d:\MYDOCU~1\ac17-1\ac17-1.c
	.dbfunc e delay_1ms _delay_1ms fV
;              i -> R16,R17
	.even
_delay_1ms::
	.dbline -1
	.dbline 8
; #include <iom16v.h>	
; #include <macros.h>
; #define  uchar unsigned char	
; #define  uint unsigned int
; //----------------------------------------
; #define xtal 8	
; void delay_1ms(void)	
; {
	.dbline 10
; uint i;
; for(i=1;i<(uint)(xtal*143-2);i++)
	ldi R16,1
	ldi R17,0
	xjmp L5
L2:
	.dbline 11
L3:
	.dbline 10
	subi R16,255  ; offset = 1
	sbci R17,255
L5:
	.dbline 10
	cpi R16,118
	ldi R30,4
	cpc R17,R30
	brlo L2
	.dbline -2
L1:
	.dbline 0 ; func end
	ret
	.dbsym r i 16 i
	.dbend
	.dbfunc e delay_ms _delay_ms fV
;              i -> R20,R21
;              n -> R22,R23
	.even
_delay_ms::
	xcall push_gset2
	movw R22,R16
	.dbline -1
	.dbline 15
; 	;
; }
; //=========================================
; void delay_ms(uint n)
; {
	.dbline 16
; uint i=0;
	clr R20
	clr R21
	xjmp L8
L7:
	.dbline 18
	.dbline 19
	xcall _delay_1ms
	.dbline 20
	subi R20,255  ; offset = 1
	sbci R21,255
	.dbline 21
L8:
	.dbline 17
;  while(i<n)
	cp R20,R22
	cpc R21,R23
	brlo L7
	.dbline -2
L6:
	xcall pop_gset2
	.dbline 0 ; func end
	ret
	.dbsym r i 20 i
	.dbsym r n 22 i
	.dbend
	.dbfunc e port_init _port_init fV
	.even
_port_init::
	.dbline -1
	.dbline 25
;  {
;  delay_1ms();
;  i++;
;  }
; }
; //-------------------------------------------
; void port_init(void)
; {
	.dbline 26
;  PORTA = 0x00;
	clr R2
	out 0x1b,R2
	.dbline 27
;  DDRA  = 0x00;
	out 0x1a,R2
	.dbline 28
;  PORTB = 0xFF;	
	ldi R24,255
	out 0x18,R24
	.dbline 29
;  DDRB  = 0xFF;
	out 0x17,R24
	.dbline 30
;  PORTC = 0x00; 
	out 0x15,R2
	.dbline 31
;  DDRC  = 0x00;
	out 0x14,R2
	.dbline 32
;  PORTD = 0x00;
	out 0x12,R2
	.dbline 33
;  DDRD  = 0x00;
	out 0x11,R2
	.dbline -2
L10:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e watchdog_init _watchdog_init fV
	.even
_watchdog_init::
	.dbline -1
	.dbline 37
; }
; //**************
; void watchdog_init(void)
; {
	.dbline 38
;  WDR(); 
	wdr
	.dbline 39
;  WDTCR = 0x08; 
	ldi R24,8
	out 0x21,R24
	.dbline -2
L11:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e init_devices _init_devices fV
	.even
_init_devices::
	.dbline -1
	.dbline 43
; }
; //=========================================
; void init_devices(void)
; {
	.dbline 44
;  port_init();
	xcall _port_init
	.dbline 45
;  watchdog_init();
	xcall _watchdog_init
	.dbline -2
L12:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e main _main fV
	.even
_main::
	.dbline -1
	.dbline 49
;  }
; //*****************************************
; void main(void) 
; {
	.dbline 50
;  init_devices();	
	xcall _init_devices
	xjmp L15
L14:
	.dbline 52
	.dbline 53
	ldi R24,254
	out 0x18,R24
	.dbline 54
	ldi R16,3
	ldi R17,0
	xcall _delay_ms
	.dbline 55
	ldi R24,253
	out 0x18,R24
	.dbline 56
	ldi R16,3
	ldi R17,0
	xcall _delay_ms
	.dbline 57
	ldi R24,251
	out 0x18,R24
	.dbline 58
	ldi R16,3
	ldi R17,0
	xcall _delay_ms
	.dbline 59
	ldi R24,247
	out 0x18,R24
	.dbline 60
	ldi R16,3
	ldi R17,0
	xcall _delay_ms
	.dbline 61
	wdr
	.dbline 62
	ldi R24,239
	out 0x18,R24
	.dbline 63
	ldi R16,3
	ldi R17,0
	xcall _delay_ms
	.dbline 64
	ldi R24,223
	out 0x18,R24
	.dbline 65
	ldi R16,3
	ldi R17,0
	xcall _delay_ms
	.dbline 66
	ldi R24,191
	out 0x18,R24
	.dbline 67
	ldi R16,3
	ldi R17,0
	xcall _delay_ms
	.dbline 68
	ldi R24,127
	out 0x18,R24
	.dbline 69
	ldi R16,3
	ldi R17,0
	xcall _delay_ms
	.dbline 70
	ldi R24,255
	out 0x18,R24
	.dbline 71
	ldi R16,3
	ldi R17,0
	xcall _delay_ms
	.dbline 72
	wdr
	.dbline 73
L15:
	.dbline 51
	xjmp L14
X0:
	.dbline -2
L13:
	.dbline 0 ; func end
	ret
	.dbend
