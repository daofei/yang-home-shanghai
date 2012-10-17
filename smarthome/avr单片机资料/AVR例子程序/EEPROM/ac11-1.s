	.module ac11-1.c
	.area lit(rom, con, rel)
_SEG7::
	.byte 63,6
	.byte 91,'O
	.byte 'f,'m
	.byte 125,7
	.byte 127,'o
	.dbfile d:\MYDOCU~1\ac11-1\ac11-1.c
	.dbsym e SEG7 _SEG7 A[10:10]kc
_ACT::
	.byte 254,253
	.byte 251,247
	.dbsym e ACT _ACT A[4:4]kc
	.area text(rom, con, rel)
	.dbfile d:\MYDOCU~1\ac11-1\ac11-1.c
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
; uchar val,DispBuff[4];		
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
; //***************写EEPROM子函数*****************
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
	.dbfunc e conv _conv fV
;              i -> R20
	.even
_conv::
	xcall push_gset1
	mov R20,R16
	.dbline -1
	.dbline 37
; }
; //****************数据转换子函数*********************
; void conv(uchar i)	
; {
	.dbline 38
; DispBuff[3]=i/1000;
	ldi R18,1000
	ldi R19,3
	mov R16,R20
	clr R17
	xcall div16s
	sts _DispBuff+3,R16
	.dbline 39
; DispBuff[2]=(i%1000)/100;
	ldi R18,1000
	ldi R19,3
	mov R16,R20
	clr R17
	xcall mod16s
	ldi R18,100
	ldi R19,0
	xcall div16s
	sts _DispBuff+2,R16
	.dbline 40
; DispBuff[1]=(i%100)/10;
	ldi R17,100
	mov R16,R20
	xcall mod8u
	ldi R17,10
	xcall div8u
	sts _DispBuff+1,R16
	.dbline 41
; DispBuff[0]=i%10;
	ldi R17,10
	mov R16,R20
	xcall mod8u
	sts _DispBuff,R16
	.dbline -2
L18:
	xcall pop_gset1
	.dbline 0 ; func end
	ret
	.dbsym r i 20 c
	.dbend
	.dbfunc e display _display fV
;              p -> R20,R21
	.even
_display::
	xcall push_gset1
	movw R20,R16
	.dbline -1
	.dbline 45
; }
; //*************************************
; void display(uchar p[4]) 
; {
	.dbline 46
; PORTA=SEG7[p[0]];
	ldi R24,<_SEG7
	ldi R25,>_SEG7
	movw R30,R20
	ldd R30,z+0
	clr R31
	add R30,R24
	adc R31,R25
	lpm R30,Z
	out 0x1b,R30
	.dbline 47
; PORTC=ACT[0];
	ldi R30,<_ACT
	ldi R31,>_ACT
	lpm R30,Z
	out 0x15,R30
	.dbline 48
; delay_ms(1);
	ldi R16,1
	ldi R17,0
	xcall _delay_ms
	.dbline 49
; PORTA=SEG7[p[1]];
	ldi R24,<_SEG7
	ldi R25,>_SEG7
	movw R30,R20
	ldd R30,z+1
	clr R31
	add R30,R24
	adc R31,R25
	lpm R30,Z
	out 0x1b,R30
	.dbline 50
; PORTC=ACT[1];
	ldi R30,<_ACT+1
	ldi R31,>_ACT+1
	lpm R30,Z
	out 0x15,R30
	.dbline 51
; delay_ms(1);
	ldi R16,1
	ldi R17,0
	xcall _delay_ms
	.dbline 52
; PORTA=SEG7[p[2]];
	ldi R24,<_SEG7
	ldi R25,>_SEG7
	movw R30,R20
	ldd R30,z+2
	clr R31
	add R30,R24
	adc R31,R25
	lpm R30,Z
	out 0x1b,R30
	.dbline 53
; PORTC=ACT[2];
	ldi R30,<_ACT+2
	ldi R31,>_ACT+2
	lpm R30,Z
	out 0x15,R30
	.dbline 54
; delay_ms(1);
	ldi R16,1
	ldi R17,0
	xcall _delay_ms
	.dbline 55
; PORTA=SEG7[p[3]];
	ldi R24,<_SEG7
	ldi R25,>_SEG7
	movw R30,R20
	ldd R30,z+3
	clr R31
	add R30,R24
	adc R31,R25
	lpm R30,Z
	out 0x1b,R30
	.dbline 56
; PORTC=ACT[3];
	ldi R30,<_ACT+3
	ldi R31,>_ACT+3
	lpm R30,Z
	out 0x15,R30
	.dbline 57
; delay_ms(1);
	ldi R16,1
	ldi R17,0
	xcall _delay_ms
	.dbline -2
L22:
	xcall pop_gset1
	.dbline 0 ; func end
	ret
	.dbsym r p 20 pc
	.dbend
	.dbfunc e port_init _port_init fV
	.even
_port_init::
	.dbline -1
	.dbline 61
; }
; //*************************************
; void port_init(void)
; {							
	.dbline 62
;  PORTA = 0xFF;			
	ldi R24,255
	out 0x1b,R24
	.dbline 63
;  DDRA  = 0xFF;			
	out 0x1a,R24
	.dbline 64
;  PORTB = 0xFF;			
	out 0x18,R24
	.dbline 65
;  DDRB  = 0xFF;		
	out 0x17,R24
	.dbline 66
;  PORTC = 0xFF; 			
	out 0x15,R24
	.dbline 67
;  DDRC  = 0xFF;	
	out 0x14,R24
	.dbline 68
;  PORTD = 0xFF;			
	out 0x12,R24
	.dbline 69
;  DDRD  = 0xFF;			
	out 0x11,R24
	.dbline -2
L26:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e main _main fV
	.even
_main::
	.dbline -1
	.dbline 73
; }							
; //*************************************
; void main(void)			
; {
	.dbline 74
; port_init();		
	xcall _port_init
	.dbline 75
; W_EEP(488,21);delay_ms(10);	
	ldi R18,21
	ldi R16,488
	ldi R17,1
	xcall _W_EEP
	.dbline 75
	ldi R16,10
	ldi R17,0
	xcall _delay_ms
	.dbline 76
; val=R_EEP(488);delay_ms(10);
	ldi R16,488
	ldi R17,1
	xcall _R_EEP
	sts _val,R16
	.dbline 76
	ldi R16,10
	ldi R17,0
	xcall _delay_ms
	.dbline 77
; conv(val);				
	lds R16,_val
	xcall _conv
	xjmp L29
L28:
	.dbline 79
	.dbline 80
	ldi R16,<_DispBuff
	ldi R17,>_DispBuff
	xcall _display
	.dbline 81
L29:
	.dbline 78
	xjmp L28
X0:
	.dbline -2
L27:
	.dbline 0 ; func end
	ret
	.dbend
	.area bss(ram, con, rel)
	.dbfile d:\MYDOCU~1\ac11-1\ac11-1.c
_DispBuff::
	.blkb 4
	.dbsym e DispBuff _DispBuff A[4:4]c
_val::
	.blkb 1
	.dbsym e val _val c
