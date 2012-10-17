	.module AVRSYS~1.C
	.area text(rom, con, rel)
	.dbfile F:\AVRSYS~1/timee.h
	.dbfunc e delaym _delaym fV
;              i -> R20,R21
;              j -> R22,R23
;              n -> R16,R17
	.even
_delaym::
	xcall push_gset2
	.dbline -1
	.dbline 5
; /*********************************************************/
; /* Target : ATmage16/32                                  */
; /* Crystal: 8.00MHz                                      */
; /* PCB£ºAVR SYSTEM                                       */
; /*********************************************************/
	.dbline 7
; //********************************************************/
;  #include <iom16v.h>
	clr R20
	clr R21
	xjmp L5
L2:
	.dbline 8
;  #include <macros.h>
	ldi R22,1324
	ldi R23,5
	xjmp L9
L6:
	.dbline 9
L7:
	.dbline 8
	subi R22,1
	sbci R23,0
L9:
	.dbline 8
	cpi R22,0
	cpc R22,R23
	brne L6
X0:
L3:
	.dbline 7
	subi R20,255  ; offset = 1
	sbci R21,255
L5:
	.dbline 7
	cp R20,R16
	cpc R21,R17
	brlo L2
	.dbline -2
L1:
	xcall pop_gset2
	.dbline 0 ; func end
	ret
	.dbsym r i 20 i
	.dbsym r j 22 i
	.dbsym r n 16 i
	.dbend
	.dbfile F:\AVRSYS~1\AVRSYS~1.C
	.dbfunc e port_init _port_init fV
	.even
_port_init::
	.dbline -1
	.dbline 22
;  #include <eeprom.h>
;  
;  #define  uchar unsigned char 
;  #define  uint unsigned int  
; //================LED(PB7)==============
;  #define CLED_0  PORTB&=~BIT(PB7)   
;  #define CLED_1  PORTB|=BIT(PB7)     
; //======================================
;  #include "timee.h" 
; //======================================
; //======================================
; //*************I/O init*****************
;  void port_init(void)
;   { 
	.dbline 23
;    DDRA  = 0x00;   
	clr R2
	out 0x1a,R2
	.dbline 24
;    _NOP();  
	nop
	.dbline 25
;    PORTA = 0x00;   
	out 0x1b,R2
	.dbline 26
;    _NOP();    
	nop
	.dbline 27
;    DDRB  = 0x80;   
	ldi R24,128
	out 0x17,R24
	.dbline 28
;    _NOP();  
	nop
	.dbline 29
;    PORTB = 0x80;   
	out 0x18,R24
	.dbline 30
;    _NOP();       
	nop
	.dbline 31
;    DDRC  = 0x00;   
	out 0x14,R2
	.dbline 32
;    _NOP();
	nop
	.dbline 33
;    PORTC = 0x00;   
	out 0x15,R2
	.dbline 34
;    _NOP();    
	nop
	.dbline 35
;    DDRD  = 0x00;   
	out 0x11,R2
	.dbline 36
;    _NOP();
	nop
	.dbline 37
;    PORTD = 0x00;   
	out 0x12,R2
	.dbline -2
L10:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e main _main fV
	.even
_main::
	.dbline -1
	.dbline 41
;   }
;  //**********************main**************************
;   void main(void)
;   {  
	.dbline 42
;     port_init();             //I/O init
	xcall _port_init
	.dbline 43
; 	delaym(10);
	ldi R16,10
	ldi R17,0
	xcall _delaym
	.dbline 44
; 	port_init();             //I/O init again
	xcall _port_init
	.dbline 45
;     delaym(10);
	ldi R16,10
	ldi R17,0
	xcall _delaym
	xjmp L13
L12:
	.dbline 48
	.dbline 49
	cbi 0x18,7
	.dbline 50
	ldi R16,100
	ldi R17,0
	xcall _delaym
	.dbline 51
	sbi 0x18,7
	.dbline 52
	ldi R16,100
	ldi R17,0
	xcall _delaym
	.dbline 53
L13:
	.dbline 47
	xjmp L12
X1:
	.dbline -2
L11:
	.dbline 0 ; func end
	ret
	.dbend
