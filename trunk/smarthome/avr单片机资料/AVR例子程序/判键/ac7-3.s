	.module ac7-3.c
	.area text(rom, con, rel)
	.dbfile d:\MYDOCU~1\ac7-3\ac7-3.c
	.dbfunc e main _main fV
	.even
_main::
	.dbline -1
	.dbline 4
; #include<iom16v.h>	
; //=============================
; void main(void)	
; {				
	.dbline 5
; DDRB=0xff;		
	ldi R24,255
	out 0x17,R24
	.dbline 6
; PORTB=0xff;		
	out 0x18,R24
	.dbline 7
; DDRD=0x00;		
	clr R2
	out 0x11,R2
	.dbline 8
; PORTD=0xff;		
	out 0x12,R24
	xjmp L3
L2:
	.dbline 10
;    while(1)		
;    {			
	.dbline 11
;    	if((PIND&0x10)==0)	
	sbic 0x10,4
	rjmp L5
	.dbline 12
;    	PORTB=0xaa;		
	ldi R24,170
	out 0x18,R24
	xjmp L6
L5:
	.dbline 13
; 	else if((PIND&0x20)==0)	
	sbic 0x10,5
	rjmp L7
	.dbline 14
;     PORTB=0x55;		
	ldi R24,85
	out 0x18,R24
	xjmp L8
L7:
	.dbline 16
;    	else 			
; 	PORTB=0xff;		
	ldi R24,255
	out 0x18,R24
L8:
L6:
	.dbline 17
L3:
	.dbline 9
	xjmp L2
X0:
	.dbline -2
L1:
	.dbline 0 ; func end
	ret
	.dbend
