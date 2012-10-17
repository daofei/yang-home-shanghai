	.module ac7-2.c
	.area lit(rom, con, rel)
_SEG7::
	.byte 63,6
	.byte 91,'O
	.byte 'f,'m
	.byte 125,7
	.byte 127,'o
	.dbfile d:\MYDOCU~1\ac7-2\ac7-2.c
	.dbsym e SEG7 _SEG7 A[10:10]kc
_ACT::
	.byte 254,253
	.dbsym e ACT _ACT A[2:2]kc
	.area text(rom, con, rel)
	.dbfile d:\MYDOCU~1\ac7-2\ac7-2.c
	.dbfunc e delay_ms _delay_ms fV
;              i -> R20,R21
;              j -> R22,R23
;              k -> R16,R17
	.even
_delay_ms::
	xcall push_gset2
	.dbline -1
	.dbline 9
; #include<iom16v.h>			
; #define uchar unsigned char	
; #define uint unsigned int
; uchar const SEG7[10]={0x3f,0x06,0x5b,0x4f,0x66,	
;                 0x6d,0x7d,0x07,0x7f,0x6f};
; uchar const ACT[2]={0xfe,0xfd};				
; //=============================
; void delay_ms(uint k)			
; {
	.dbline 11
;     uint i,j;
;     for(i=0;i<k;i++)
	clr R20
	clr R21
	xjmp L5
L2:
	.dbline 12
;     {
	.dbline 13
	clr R22
	clr R23
	xjmp L9
L6:
	.dbline 13
L7:
	.dbline 13
	subi R22,255  ; offset = 1
	sbci R23,255
L9:
	.dbline 13
	cpi R22,58
	ldi R30,2
	cpc R23,R30
	brlo L6
	.dbline 14
L3:
	.dbline 11
	subi R20,255  ; offset = 1
	sbci R21,255
L5:
	.dbline 11
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
	.dbsym r k 16 i
	.dbend
	.dbfunc e main _main fV
;              i -> R20
;        counter -> R22
	.even
_main::
	.dbline -1
	.dbline 18
;        for(j=0;j<570;j++);
;     }
; }
; //=============================
; void main(void)	
; {				
	.dbline 20
; uchar i,counter;	
; DDRA=0xff;			
	ldi R24,255
	out 0x1a,R24
	.dbline 21
; DDRC=0xff;		
	out 0x14,R24
	.dbline 22
; PORTA=0x00;		
	clr R2
	out 0x1b,R2
	.dbline 23
; PORTC=0xff;		
	out 0x15,R24
	xjmp L12
L11:
	.dbline 25
;    while(1)		
;    {			
	.dbline 26
;    		   for(i=0;i<100;i++)	
	clr R20
	xjmp L17
L14:
	.dbline 27
	.dbline 28
	ldi R18,10
	ldi R19,0
	mov R16,R22
	clr R17
	xcall mod16s
	movw R30,R16
	ldi R24,<_SEG7
	ldi R25,>_SEG7
	add R30,R24
	adc R31,R25
	lpm R30,Z
	out 0x1b,R30
	.dbline 29
	ldi R30,<_ACT
	ldi R31,>_ACT
	lpm R30,Z
	out 0x15,R30
	.dbline 30
	ldi R16,1
	ldi R17,0
	xcall _delay_ms
	.dbline 31
	ldi R18,10
	ldi R19,0
	mov R16,R22
	clr R17
	xcall div16s
	movw R30,R16
	ldi R24,<_SEG7
	ldi R25,>_SEG7
	add R30,R24
	adc R31,R25
	lpm R30,Z
	out 0x1b,R30
	.dbline 32
	ldi R30,<_ACT+1
	ldi R31,>_ACT+1
	lpm R30,Z
	out 0x15,R30
	.dbline 33
	ldi R16,1
	ldi R17,0
	xcall _delay_ms
	.dbline 34
L15:
	.dbline 26
	inc R20
L17:
	.dbline 26
	cpi R20,100
	brlo L14
	.dbline 35
;    		   {					
; 		   PORTA=SEG7[counter%10];	
;    		   PORTC=ACT[0];			
;    		   delay_ms(1);				
;    		   PORTA=SEG7[counter/10];	
;    		   PORTC=ACT[1];			
;    		   delay_ms(1);			
; 		   }					
; 		   counter++;		
	inc R22
	.dbline 36
; 		   if(counter>99)counter=0;	
	ldi R24,99
	cp R24,R22
	brsh L19
	.dbline 36
	clr R22
L19:
	.dbline 37
L12:
	.dbline 24
	xjmp L11
X0:
	.dbline -2
L10:
	.dbline 0 ; func end
	ret
	.dbsym r i 20 c
	.dbsym r counter 22 c
	.dbend
