	.module ac11-2.c
	.area lit(rom, con, rel)
_SEG7::
	.byte 63,6
	.byte 91,'O
	.byte 'f,'m
	.byte 125,7
	.byte 127,'o
	.dbfile d:\MYDOCU~1\ac11-2\ac11-2.c
	.dbsym e SEG7 _SEG7 A[10:10]kc
_ACT::
	.byte 254,253
	.byte 251,247
	.dbsym e ACT _ACT A[4:4]kc
	.area text(rom, con, rel)
	.dbfile d:\MYDOCU~1\ac11-2\ac11-2.c
	.dbfunc e delay_ms _delay_ms fV
;              i -> R20,R21
;              j -> R22,R23
;              k -> R16,R17
	.even
_delay_ms::
	xcall push_gset2
	.dbline -1
	.dbline 10
; #include <iom16v.h>			
; #define uchar unsigned char	
; #define uint  unsigned int	
; uchar const SEG7[10]={0x3f,0x06,0x5b, 
; 0x4f,0x66,0x6d,0x7d,0x07,0x7f,0x6f};
; uchar const ACT[4]={0xfe,0xfd,0xfb,0xf7};
; uchar x,y;				
; //*************************************
; void delay_ms(uint k) 
; {
	.dbline 12
; uint i,j;			
;     for(i=0;i<k;i++)
	clr R20
	clr R21
	xjmp L5
L2:
	.dbline 13
;     {
	.dbline 14
;        for(j=0;j<1140;j++)
	clr R22
	clr R23
	xjmp L9
L6:
	.dbline 15
L7:
	.dbline 14
	subi R22,255  ; offset = 1
	sbci R23,255
L9:
	.dbline 14
	cpi R22,116
	ldi R30,4
	cpc R23,R30
	brlo L6
	.dbline 16
L3:
	.dbline 12
	subi R20,255  ; offset = 1
	sbci R21,255
L5:
	.dbline 12
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
	.dbfunc e W_EEP _W_EEP fV
;            dat -> R18
;            add -> R16,R17
	.even
_W_EEP::
	.dbline -1
	.dbline 20
;        ;
;     }
; }
; //************写EEPROM子函数**************
; void W_EEP(uint add,uchar dat) 
; {
L11:
	.dbline 21
L12:
	.dbline 21
; while(EECR&(1<<EEWE));	
	sbic 0x1c,1
	rjmp L11
	.dbline 22
; EEAR=add;			
	out 0x1f,R17
	out 0x1e,R16
	.dbline 23
; EEDR=dat;			
	out 0x1d,R18
	.dbline 24
; EECR|=(1<<EEMWE);
	sbi 0x1c,2
	.dbline 25
; EECR|=(1<<EEWE);	
	sbi 0x1c,1
	.dbline -2
L10:
	.dbline 0 ; func end
	ret
	.dbsym r dat 18 c
	.dbsym r add 16 i
	.dbend
	.dbfunc e R_EEP _R_EEP fc
;            add -> R16,R17
	.even
_R_EEP::
	.dbline -1
	.dbline 29
; }
; //****************读EEPROM子函数*******************
; uchar R_EEP(uint add)
; {
L15:
	.dbline 30
L16:
	.dbline 30
; while(EECR&(1<<EEWE));
	sbic 0x1c,1
	rjmp L15
	.dbline 31
; EEAR=add;			
	out 0x1f,R17
	out 0x1e,R16
	.dbline 32
; EECR|=(1<<EERE);
	sbi 0x1c,0
	.dbline 33
; return EEDR;
	in R16,0x1d
	.dbline -2
L14:
	.dbline 0 ; func end
	ret
	.dbsym r add 16 i
	.dbend
	.dbfunc e display _display fV
	.even
_display::
	.dbline -1
	.dbline 37
; }
; //*************************************
; void display(void)	
; {
	.dbline 38
; PORTA=SEG7[y%10];
	ldi R18,10
	ldi R19,0
	lds R16,_y
	clr R17
	xcall mod16s
	movw R30,R16
	ldi R24,<_SEG7
	ldi R25,>_SEG7
	add R30,R24
	adc R31,R25
	lpm R30,Z
	out 0x1b,R30
	.dbline 39
; PORTC=ACT[0];
	ldi R30,<_ACT
	ldi R31,>_ACT
	lpm R30,Z
	out 0x15,R30
	.dbline 40
; delay_ms(1);
	ldi R16,1
	ldi R17,0
	xcall _delay_ms
	.dbline 41
; PORTA=SEG7[(y%100)/10];
	ldi R18,100
	ldi R19,0
	lds R16,_y
	clr R17
	xcall mod16s
	ldi R18,10
	ldi R19,0
	xcall div16s
	movw R30,R16
	ldi R24,<_SEG7
	ldi R25,>_SEG7
	add R30,R24
	adc R31,R25
	lpm R30,Z
	out 0x1b,R30
	.dbline 42
; PORTC=ACT[1];
	ldi R30,<_ACT+1
	ldi R31,>_ACT+1
	lpm R30,Z
	out 0x15,R30
	.dbline 43
; delay_ms(1);
	ldi R16,1
	ldi R17,0
	xcall _delay_ms
	.dbline 44
; PORTA=SEG7[(y%1000)/100];
	ldi R18,1000
	ldi R19,3
	lds R16,_y
	clr R17
	xcall mod16s
	ldi R18,100
	ldi R19,0
	xcall div16s
	movw R30,R16
	ldi R24,<_SEG7
	ldi R25,>_SEG7
	add R30,R24
	adc R31,R25
	lpm R30,Z
	out 0x1b,R30
	.dbline 45
; PORTC=ACT[2];
	ldi R30,<_ACT+2
	ldi R31,>_ACT+2
	lpm R30,Z
	out 0x15,R30
	.dbline 46
; delay_ms(1);
	ldi R16,1
	ldi R17,0
	xcall _delay_ms
	.dbline 47
; PORTA=SEG7[y/1000];
	ldi R18,1000
	ldi R19,3
	lds R16,_y
	clr R17
	xcall div16s
	movw R30,R16
	ldi R24,<_SEG7
	ldi R25,>_SEG7
	add R30,R24
	adc R31,R25
	lpm R30,Z
	out 0x1b,R30
	.dbline 48
; PORTC=ACT[3];
	ldi R30,<_ACT+3
	ldi R31,>_ACT+3
	lpm R30,Z
	out 0x15,R30
	.dbline 49
; delay_ms(1);
	ldi R16,1
	ldi R17,0
	xcall _delay_ms
	.dbline 51
; //----------------------
; PORTA=SEG7[x%10];
	ldi R18,10
	ldi R19,0
	lds R16,_x
	clr R17
	xcall mod16s
	movw R30,R16
	ldi R24,<_SEG7
	ldi R25,>_SEG7
	add R30,R24
	adc R31,R25
	lpm R30,Z
	out 0x1b,R30
	.dbline 52
; PORTC=ACT[4];
	ldi R30,<_ACT+4
	ldi R31,>_ACT+4
	lpm R30,Z
	out 0x15,R30
	.dbline 53
; delay_ms(1);
	ldi R16,1
	ldi R17,0
	xcall _delay_ms
	.dbline 54
; PORTA=SEG7[(x%100)/10];
	ldi R18,100
	ldi R19,0
	lds R16,_x
	clr R17
	xcall mod16s
	ldi R18,10
	ldi R19,0
	xcall div16s
	movw R30,R16
	ldi R24,<_SEG7
	ldi R25,>_SEG7
	add R30,R24
	adc R31,R25
	lpm R30,Z
	out 0x1b,R30
	.dbline 55
; PORTC=ACT[5];
	ldi R30,<_ACT+5
	ldi R31,>_ACT+5
	lpm R30,Z
	out 0x15,R30
	.dbline 56
; delay_ms(1);
	ldi R16,1
	ldi R17,0
	xcall _delay_ms
	.dbline 57
; PORTA=SEG7[(x%1000)/100];
	ldi R18,1000
	ldi R19,3
	lds R16,_x
	clr R17
	xcall mod16s
	ldi R18,100
	ldi R19,0
	xcall div16s
	movw R30,R16
	ldi R24,<_SEG7
	ldi R25,>_SEG7
	add R30,R24
	adc R31,R25
	lpm R30,Z
	out 0x1b,R30
	.dbline 58
; PORTC=ACT[6];
	ldi R30,<_ACT+6
	ldi R31,>_ACT+6
	lpm R30,Z
	out 0x15,R30
	.dbline 59
; delay_ms(1);
	ldi R16,1
	ldi R17,0
	xcall _delay_ms
	.dbline 60
; PORTA=SEG7[x/1000];
	ldi R18,1000
	ldi R19,3
	lds R16,_x
	clr R17
	xcall div16s
	movw R30,R16
	ldi R24,<_SEG7
	ldi R25,>_SEG7
	add R30,R24
	adc R31,R25
	lpm R30,Z
	out 0x1b,R30
	.dbline 61
; PORTC=ACT[7];
	ldi R30,<_ACT+7
	ldi R31,>_ACT+7
	lpm R30,Z
	out 0x15,R30
	.dbline 62
; delay_ms(1);
	ldi R16,1
	ldi R17,0
	xcall _delay_ms
	.dbline -2
L18:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e port_init _port_init fV
	.even
_port_init::
	.dbline -1
	.dbline 66
; }
; //*************************************
; void port_init(void)
; {							
	.dbline 67
;  PORTA = 0xFF;			
	ldi R24,255
	out 0x1b,R24
	.dbline 68
;  DDRA  = 0xFF;		
	out 0x1a,R24
	.dbline 69
;  PORTB = 0xFF;			
	out 0x18,R24
	.dbline 70
;  DDRB  = 0xFF;			
	out 0x17,R24
	.dbline 71
;  PORTC = 0xFF; 			
	out 0x15,R24
	.dbline 72
;  DDRC  = 0xFF;		
	out 0x14,R24
	.dbline 73
;  PORTD = 0xFF;		
	out 0x12,R24
	.dbline 74
;  DDRD  = 0x00;		
	clr R2
	out 0x11,R2
	.dbline -2
L26:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e main _main fV
;              i -> R20
	.even
_main::
	.dbline -1
	.dbline 78
; }
; //*************************************
; void main(void)		
; {uchar i;			
	.dbline 79
; port_init();		
	xcall _port_init
	xjmp L29
L28:
	.dbline 81
; while(1)
; 		{
	.dbline 82
; 		if((PIND&0x10)==0)	
	sbic 0x10,4
	rjmp L31
	.dbline 83
; 		{
	.dbline 84
; 		if(x<255)x++;		
	lds R24,_x
	cpi R24,255
	brsh L33
	.dbline 84
	subi R24,255    ; addi 1
	sts _x,R24
L33:
	.dbline 85
; 		for(i=0;i<25;i++)	
	clr R20
	xjmp L38
L35:
	.dbline 86
	xcall _display
L36:
	.dbline 85
	inc R20
L38:
	.dbline 85
	cpi R20,25
	brlo L35
	.dbline 87
; 		display();			
; 		}
L31:
	.dbline 89
; //---------------
; 		if((PIND&0x20)==0)	
	sbic 0x10,5
	rjmp L39
	.dbline 90
; 		{
	.dbline 91
; 		if(x>0)x--;			
	clr R2
	lds R3,_x
	cp R2,R3
	brsh L41
	.dbline 91
	mov R24,R3
	subi R24,1
	sts _x,R24
L41:
	.dbline 92
; 		for(i=0;i<50;i++)	
	clr R20
	xjmp L46
L43:
	.dbline 93
	xcall _display
L44:
	.dbline 92
	inc R20
L46:
	.dbline 92
	cpi R20,50
	brlo L43
	.dbline 94
; 		display();		
; 		}
L39:
	.dbline 96
; //***************
; 		if((PIND&0x40)==0){W_EEP(200,x);delay_ms(10);} 
	sbic 0x10,6
	rjmp L47
	.dbline 96
	.dbline 96
	lds R18,_x
	ldi R16,200
	ldi R17,0
	xcall _W_EEP
	.dbline 96
	ldi R16,10
	ldi R17,0
	xcall _delay_ms
	.dbline 96
L47:
	.dbline 97
; 		if((PIND&0x80)==0){y=R_EEP(200);delay_ms(10);} 
	sbic 0x10,7
	rjmp L49
	.dbline 97
	.dbline 97
	ldi R16,200
	ldi R17,0
	xcall _R_EEP
	sts _y,R16
	.dbline 97
	ldi R16,10
	ldi R17,0
	xcall _delay_ms
	.dbline 97
L49:
	.dbline 98
	xcall _display
	.dbline 99
L29:
	.dbline 80
	xjmp L28
X0:
	.dbline -2
L27:
	.dbline 0 ; func end
	ret
	.dbsym r i 20 c
	.dbend
	.area bss(ram, con, rel)
	.dbfile d:\MYDOCU~1\ac11-2\ac11-2.c
_y::
	.blkb 1
	.dbsym e y _y c
_x::
	.blkb 1
	.dbsym e x _x c
