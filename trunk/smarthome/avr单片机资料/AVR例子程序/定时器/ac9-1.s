	.module ac9-1.c
	.area text(rom, con, rel)
	.dbfile d:\MYDOCU~1\ac9-1\ac9-1.c
	.dbfunc e main _main fV
;            cnt -> R16
;         status -> R18
	.even
_main::
	.dbline -1
	.dbline 8
; #include<iom16v.h>	
; #define uchar unsigned char	
; /************************************/
; #define FLASH_0  (PORTB=PORTB&0xfe) 
; #define FLASH_1  (PORTB=PORTB|0x01) 
; /************************************/
; void main(void) 
; {			
	.dbline 10
; uchar cnt,status; 
;  PORTB = 0x01; 
	ldi R24,1
	out 0x18,R24
	.dbline 11
;  DDRB  = 0x01; 
	out 0x17,R24
	.dbline 12
;  TCNT1H = 0xCF;
	ldi R24,207
	out 0x2d,R24
	.dbline 13
;  TCNT1L = 0x2C;
	ldi R24,44
	out 0x2c,R24
	.dbline 14
;  TCCR1B = 0x03;
	ldi R24,3
	out 0x2e,R24
	.dbline 15
;    	for(;;)	
L2:
	.dbline 16
;  	{	
L6:
	.dbline 17
	.dbline 17
	in R18,0x38
	andi R18,4
	.dbline 17
L7:
	.dbline 17
; 		do {status=TIFR&0x04;}while(status!=0x04); 
	cpi R18,4
	brne L6
	.dbline 18
; 		TIFR=0x04;
	ldi R24,4
	out 0x38,R24
	.dbline 19
; 		TCNT1H = 0xCF; 
	ldi R24,207
	out 0x2d,R24
	.dbline 20
; 		TCNT1L = 0x2C; 
	ldi R24,44
	out 0x2c,R24
	.dbline 21
; 		cnt++;		
	inc R16
	.dbline 22
; 		if(cnt==9)FLASH_0;
	cpi R16,9
	brne L9
	.dbline 22
	in R24,0x18
	andi R24,254
	out 0x18,R24
L9:
	.dbline 23
	cpi R16,10
	brlo L2
	.dbline 23
	.dbline 23
	clr R16
	.dbline 23
	sbi 0x18,0
	.dbline 23
	.dbline 24
	.dbline 15
	.dbline 15
	xjmp L2
X0:
	.dbline -2
L1:
	.dbline 0 ; func end
	ret
	.dbsym r cnt 16 c
	.dbsym r status 18 c
	.dbend
