	.module ac9-2.c
	.area lit(rom, con, rel)
_SEG7::
	.byte 63,6
	.byte 91,'O
	.byte 'f,'m
	.byte 125,7
	.byte 127,'o
	.dbfile d:\MYDOCU~1\ac9-2\ac9-2.c
	.dbsym e SEG7 _SEG7 A[10:10]kc
_ACT::
	.byte 254,253
	.byte 251,247
	.byte 239,223
	.byte 191,127
	.dbsym e ACT _ACT A[8:8]kc
	.area text(rom, con, rel)
	.dbfile d:\MYDOCU~1\ac9-2\ac9-2.c
	.dbfunc e main _main fV
	.even
_main::
	.dbline -1
	.dbline 10
; #include <iom16v.h> 
; #define uchar unsigned char	
; #define uint unsigned int
; uchar const SEG7[10]={0x3f,0x06,0x5b, 
; 0x4f,0x66,	0x6d,0x7d,0x07,0x7f,0x6f};
; uchar const ACT[8]={0xfe,0xfd,0xfb,0xf7, 
; 0xef,0xdf,0xbf,0x7f};
; uchar i;			
; void main(void) 
;  {			
	.dbline 11
;  PORTA = 0x00; 
	clr R2
	out 0x1b,R2
	.dbline 12
;  DDRA  = 0xFF; 
	ldi R24,255
	out 0x1a,R24
	.dbline 13
;  PORTC = 0xFF; 
	out 0x15,R24
	.dbline 14
;  DDRC  = 0xFF; 
	out 0x14,R24
	.dbline 15
;  TCNT0 = 0x83;
	ldi R24,131
	out 0x32,R24
	.dbline 16
;  TCCR0 = 0x03;
	ldi R24,3
	out 0x33,R24
	.dbline 17
;  TIMSK = 0x01;
	ldi R24,1
	out 0x39,R24
	.dbline 18
;  SREG=0x80; 
	ldi R24,128
	out 0x3f,R24
L2:
	.dbline 19
L3:
	.dbline 19
	xjmp L2
X0:
	.dbline -2
L1:
	.dbline 0 ; func end
	ret
	.dbend
	.area vector(rom, abs)
	.org 36
	jmp _timer0_ovf_isr
	.area text(rom, con, rel)
	.dbfile d:\MYDOCU~1\ac9-2\ac9-2.c
	.dbfunc e timer0_ovf_isr _timer0_ovf_isr fV
	.even
_timer0_ovf_isr::
	st -y,R2
	st -y,R24
	st -y,R25
	st -y,R30
	st -y,R31
	in R2,0x3f
	st -y,R2
	.dbline -1
	.dbline 24
; while(1);
;  }
; 
; #pragma interrupt_handler timer0_ovf_isr:10
; void timer0_ovf_isr(void)
; {
	.dbline 25
;  TCNT0 = 0x83; 
	ldi R24,131
	out 0x32,R24
	.dbline 26
;  if(++i>7)i=0;
	lds R24,_i
	subi R24,255    ; addi 1
	mov R2,R24
	sts _i,R2
	ldi R24,7
	cp R24,R2
	brsh L6
	.dbline 26
	clr R2
	sts _i,R2
L6:
	.dbline 27
;  PORTA=SEG7[i];
	ldi R24,<_SEG7
	ldi R25,>_SEG7
	lds R30,_i
	clr R31
	add R30,R24
	adc R31,R25
	lpm R30,Z
	out 0x1b,R30
	.dbline 28
;  PORTC=ACT[i];
	ldi R24,<_ACT
	ldi R25,>_ACT
	lds R30,_i
	clr R31
	add R30,R24
	adc R31,R25
	lpm R30,Z
	out 0x15,R30
	.dbline -2
L5:
	ld R2,y+
	out 0x3f,R2
	ld R31,y+
	ld R30,y+
	ld R25,y+
	ld R24,y+
	ld R2,y+
	.dbline 0 ; func end
	reti
	.dbend
	.area bss(ram, con, rel)
	.dbfile d:\MYDOCU~1\ac9-2\ac9-2.c
_i::
	.blkb 1
	.dbsym e i _i c
