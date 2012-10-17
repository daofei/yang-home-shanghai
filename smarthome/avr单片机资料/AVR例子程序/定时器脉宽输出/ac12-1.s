	.module ac12-1.c
	.area text(rom, con, rel)
	.dbfile d:\MYDOCU~1\ac12-1\ac12-1.c
	.dbfunc e delay_1ms _delay_1ms fV
;              i -> R16,R17
	.even
_delay_1ms::
	.dbline -1
	.dbline 7
; #include<iom16v.h>			
; #define uchar unsigned char 
; #define uint unsigned int
; //=============================================
; #define xtal 8   			
; void delay_1ms(void)		
; { uint i;
	.dbline 8
;  for(i=1;i<(uint)(xtal*143-2);i++)
	ldi R16,1
	ldi R17,0
	xjmp L5
L2:
	.dbline 9
L3:
	.dbline 8
	subi R16,255  ; offset = 1
	sbci R17,255
L5:
	.dbline 8
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
	.dbline 13
;     ;
; }
; //=============================================
; void delay_ms(uint n)	
; {
	.dbline 14
;  uint i=0;
	clr R20
	clr R21
	xjmp L8
L7:
	.dbline 16
	.dbline 16
	xcall _delay_1ms
	.dbline 17
	subi R20,255  ; offset = 1
	sbci R21,255
	.dbline 18
L8:
	.dbline 15
;    while(i<n)
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
	.dbfunc e init_IO _init_IO fV
	.even
_init_IO::
	.dbline -1
	.dbline 22
;    {delay_1ms();
;     i++;
;    }
; }
; //================================================
; void init_IO(void)      
; {
	.dbline 23
;  DDRD=0xff;		
	ldi R24,255
	out 0x11,R24
	.dbline 24
;  PORTD=0x00;	
	clr R2
	out 0x12,R2
	.dbline 25
;  TCCR2=0x71;	
	ldi R24,113
	out 0x25,R24
	.dbline -2
L10:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e main _main fV
;           wide -> R20
	.even
_main::
	.dbline -1
	.dbline 29
; }
; /******************Ö÷º¯Êý******************/
; void main(void)	
; {	uchar wide;	
	.dbline 30
; init_IO();		
	xcall _init_IO
	xjmp L13
L12:
	.dbline 32
; 	while(1)	
;     {	
	.dbline 33
; 	delay_ms(20);	
	ldi R16,20
	ldi R17,0
	xcall _delay_ms
	.dbline 34
; 	if(++wide==255)wide=0;
	mov R24,R20
	subi R24,255    ; addi 1
	mov R20,R24
	cpi R20,255
	brne L15
	.dbline 34
	clr R20
L15:
	.dbline 35
	out 0x23,R20
	.dbline 36
L13:
	.dbline 31
	xjmp L12
X0:
	.dbline -2
L11:
	.dbline 0 ; func end
	ret
	.dbsym r wide 20 c
	.dbend
