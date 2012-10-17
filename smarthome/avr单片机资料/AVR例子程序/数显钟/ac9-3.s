	.module ac9-3.c
	.area lit(rom, con, rel)
_SEG7::
	.byte 63,6
	.byte 91,'O
	.byte 'f,'m
	.byte 125,7
	.byte 127,'o
	.dbfile d:\MYDOCU~1\ac9-3\ac9-3.c
	.dbsym e SEG7 _SEG7 A[10:10]kc
_ACT::
	.byte 254,253
	.byte 251,247
	.dbsym e ACT _ACT A[4:4]kc
	.area text(rom, con, rel)
	.dbfile d:\MYDOCU~1\ac9-3\ac9-3.c
	.dbfunc e port_init _port_init fV
	.even
_port_init::
	.dbline -1
	.dbline 13
; #include <iom16v.h>	
; #define uchar unsigned char
; #define uint unsigned int
; uchar const SEG7[10]={0x3f,0x06,0x5b, 
; 	  0x4f,0x66,0x6d,0x7d,0x07,0x7f,0x6f};
; uchar const ACT[4]={0xfe,0xfd,0xfb,0xf7}; 
; uint cnt; 
; uchar start_flag; 
; uchar i; 
; #define S1 (PIND&0x10)	
; 
; void port_init(void)
; {
	.dbline 14
;  PORTA = 0x00; 
	clr R2
	out 0x1b,R2
	.dbline 15
;  DDRA  = 0xFF; 
	ldi R24,255
	out 0x1a,R24
	.dbline 16
;  PORTC = 0xFF; 
	out 0x15,R24
	.dbline 17
;  DDRC  = 0xFF; 
	out 0x14,R24
	.dbline 18
;  PORTD = 0xFF; 
	out 0x12,R24
	.dbline 19
;  DDRD  = 0x00; 
	out 0x11,R2
	.dbline -2
L1:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e timer0_init _timer0_init fV
	.even
_timer0_init::
	.dbline -1
	.dbline 23
; }
; 
; void timer0_init(void)
; {
	.dbline 24
;  TCNT0 = 0x83; 
	ldi R24,131
	out 0x32,R24
	.dbline 25
;  TCCR0 = 0x03; 
	ldi R24,3
	out 0x33,R24
	.dbline -2
L2:
	.dbline 0 ; func end
	ret
	.dbend
	.area vector(rom, abs)
	.org 36
	jmp _timer0_ovf_isr
	.area text(rom, con, rel)
	.dbfile d:\MYDOCU~1\ac9-3\ac9-3.c
	.dbfunc e timer0_ovf_isr _timer0_ovf_isr fV
	.even
_timer0_ovf_isr::
	st -y,R2
	st -y,R16
	st -y,R17
	st -y,R18
	st -y,R19
	st -y,R24
	st -y,R25
	st -y,R30
	st -y,R31
	in R2,0x3f
	st -y,R2
	xcall push_gset1
	.dbline -1
	.dbline 30
; }
; 
; #pragma interrupt_handler timer0_ovf_isr:10
; void timer0_ovf_isr(void)
; {
	.dbline 31
;  SREG=0x80;
	ldi R24,128
	out 0x3f,R24
	.dbline 32
;  TCNT0 = 0x83; 
	ldi R24,131
	out 0x32,R24
	.dbline 33
;  if(++i>3)i=0; 
	lds R24,_i
	subi R24,255    ; addi 1
	mov R2,R24
	sts _i,R2
	ldi R24,3
	cp R24,R2
	brsh L4
	.dbline 33
	clr R2
	sts _i,R2
L4:
	.dbline 34
;  switch(i)
	lds R20,_i
	clr R21
	cpi R20,0
	cpc R20,R21
	breq L9
X0:
	cpi R20,1
	ldi R30,0
	cpc R21,R30
	breq L10
	cpi R20,2
	ldi R30,0
	cpc R21,R30
	brne X2
	xjmp L11
X2:
	cpi R20,3
	ldi R30,0
	cpc R21,R30
	brne X3
	xjmp L12
X3:
	xjmp L7
X1:
	.dbline 35
;  {
L9:
	.dbline 36
;  case 0: PORTA=SEG7[cnt%10]; PORTC=ACT[i];break;
	ldi R18,10
	ldi R19,0
	lds R16,_cnt
	lds R17,_cnt+1
	xcall mod16u
	movw R30,R16
	ldi R24,<_SEG7
	ldi R25,>_SEG7
	add R30,R24
	adc R31,R25
	lpm R30,Z
	out 0x1b,R30
	.dbline 36
	ldi R24,<_ACT
	ldi R25,>_ACT
	lds R30,_i
	clr R31
	add R30,R24
	adc R31,R25
	lpm R30,Z
	out 0x15,R30
	.dbline 36
	xjmp L7
L10:
	.dbline 37
;  case 1: PORTA=SEG7[(cnt/10)%10]; PORTC=ACT[i];break;
	ldi R18,10
	ldi R19,0
	lds R16,_cnt
	lds R17,_cnt+1
	xcall div16u
	ldi R18,10
	ldi R19,0
	xcall mod16u
	movw R30,R16
	ldi R24,<_SEG7
	ldi R25,>_SEG7
	add R30,R24
	adc R31,R25
	lpm R30,Z
	out 0x1b,R30
	.dbline 37
	ldi R24,<_ACT
	ldi R25,>_ACT
	lds R30,_i
	clr R31
	add R30,R24
	adc R31,R25
	lpm R30,Z
	out 0x15,R30
	.dbline 37
	xjmp L7
L11:
	.dbline 38
;  case 2: PORTA=SEG7[(cnt/100)%10]|0x80; PORTC=ACT[i];break;
	ldi R18,100
	ldi R19,0
	lds R16,_cnt
	lds R17,_cnt+1
	xcall div16u
	ldi R18,10
	ldi R19,0
	xcall mod16u
	movw R30,R16
	ldi R24,<_SEG7
	ldi R25,>_SEG7
	add R30,R24
	adc R31,R25
	lpm R30,Z
	ori R30,128
	out 0x1b,R30
	.dbline 38
	ldi R24,<_ACT
	ldi R25,>_ACT
	lds R30,_i
	clr R31
	add R30,R24
	adc R31,R25
	lpm R30,Z
	out 0x15,R30
	.dbline 38
	xjmp L7
L12:
	.dbline 39
	ldi R18,1000
	ldi R19,3
	lds R16,_cnt
	lds R17,_cnt+1
	xcall div16u
	movw R30,R16
	ldi R24,<_SEG7
	ldi R25,>_SEG7
	add R30,R24
	adc R31,R25
	lpm R30,Z
	out 0x1b,R30
	.dbline 39
	ldi R24,<_ACT
	ldi R25,>_ACT
	lds R30,_i
	clr R31
	add R30,R24
	adc R31,R25
	lpm R30,Z
	out 0x15,R30
	.dbline 39
	.dbline 40
L7:
	.dbline -2
L3:
	xcall pop_gset1
	ld R2,y+
	out 0x3f,R2
	ld R31,y+
	ld R30,y+
	ld R25,y+
	ld R24,y+
	ld R19,y+
	ld R18,y+
	ld R17,y+
	ld R16,y+
	ld R2,y+
	.dbline 0 ; func end
	reti
	.dbend
	.dbfunc e timer1_init _timer1_init fV
	.even
_timer1_init::
	.dbline -1
	.dbline 45
;  case 3: PORTA=SEG7[cnt/1000]; PORTC=ACT[i];break;
;  default:break;
;  }
; }
; 
; void timer1_init(void) 
; {
	.dbline 46
;  TCNT1H = 0xD8; 
	ldi R24,216
	out 0x2d,R24
	.dbline 47
;  TCNT1L = 0xF0;
	ldi R24,240
	out 0x2c,R24
	.dbline -2
L13:
	.dbline 0 ; func end
	ret
	.dbend
	.area vector(rom, abs)
	.org 32
	jmp _timer1_ovf_isr
	.area text(rom, con, rel)
	.dbfile d:\MYDOCU~1\ac9-3\ac9-3.c
	.dbfunc e timer1_ovf_isr _timer1_ovf_isr fV
	.even
_timer1_ovf_isr::
	st -y,R2
	st -y,R3
	st -y,R24
	st -y,R25
	in R2,0x3f
	st -y,R2
	.dbline -1
	.dbline 52
	.dbline 53
	ldi R24,216
	out 0x2d,R24
	.dbline 54
	ldi R24,240
	out 0x2c,R24
	.dbline 55
	lds R24,_cnt
	lds R25,_cnt+1
	adiw R24,1
	movw R2,R24
	sts _cnt+1,R3
	sts _cnt,R2
	ldi R24,9999
	ldi R25,39
	cp R24,R2
	cpc R25,R3
	brsh L15
	.dbline 55
	clr R2
	clr R3
	sts _cnt+1,R3
	sts _cnt,R2
L15:
	.dbline -2
L14:
	ld R2,y+
	out 0x3f,R2
	ld R25,y+
	ld R24,y+
	ld R3,y+
	ld R2,y+
	.dbline 0 ; func end
	reti
	.dbend
	.area vector(rom, abs)
	.org 4
	jmp _int0_isr
	.area text(rom, con, rel)
	.dbfile d:\MYDOCU~1\ac9-3\ac9-3.c
	.dbfunc e int0_isr _int0_isr fV
	.even
_int0_isr::
	st -y,R2
	st -y,R24
	st -y,R25
	st -y,R30
	in R2,0x3f
	st -y,R2
	.dbline -1
	.dbline 60
; }
; 
; #pragma interrupt_handler timer1_ovf_isr:9
; void timer1_ovf_isr(void)
; {
;  TCNT1H = 0xD8; 
;  TCNT1L = 0xF0; 
;  if(++cnt>9999)cnt=0;
; }
; 
; #pragma interrupt_handler int0_isr:2
; void int0_isr(void)
; {
	.dbline 61
; if(cnt<10)start_flag=0xff;
	lds R24,_cnt
	lds R25,_cnt+1
	cpi R24,10
	ldi R30,0
	cpc R25,R30
	brsh L18
	.dbline 61
	ldi R24,255
	sts _start_flag,R24
	xjmp L19
L18:
	.dbline 62
	clr R2
	sts _start_flag,R2
L19:
	.dbline -2
L17:
	ld R2,y+
	out 0x3f,R2
	ld R30,y+
	ld R25,y+
	ld R24,y+
	ld R2,y+
	.dbline 0 ; func end
	reti
	.dbend
	.dbfunc e init_devices _init_devices fV
	.even
_init_devices::
	.dbline -1
	.dbline 66
; else start_flag=0x00;
; }
; 
; void init_devices(void)
; {
	.dbline 67
;  port_init();
	xcall _port_init
	.dbline 68
;  timer0_init();
	xcall _timer0_init
	.dbline 69
;  timer1_init();
	xcall _timer1_init
	.dbline 70
;  MCUCR = 0x02; 
	ldi R24,2
	out 0x35,R24
	.dbline 71
;  GICR  = 0x40; 
	ldi R24,64
	out 0x3b,R24
	.dbline 72
;  TIMSK = 0x05; 
	ldi R24,5
	out 0x39,R24
	.dbline 73
;  SREG=0x80; 
	ldi R24,128
	out 0x3f,R24
	.dbline -2
L20:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e scan_s1 _scan_s1 fV
	.even
_scan_s1::
	.dbline -1
	.dbline 77
	.dbline 78
	sbic 0x10,4
	rjmp L22
	.dbline 78
	clr R2
	clr R3
	sts _cnt+1,R3
	sts _cnt,R2
L22:
	.dbline -2
L21:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e main _main fV
	.even
_main::
	.dbline -1
	.dbline 82
; }
; 
; void scan_s1(void)
; {
; if(S1==0)cnt=0;
; }
; 
; void main(void) 
; {
	.dbline 83
; init_devices();
	xcall _init_devices
	xjmp L26
L25:
	.dbline 85
;   while(1) 
;   {
	.dbline 86
;   if(start_flag==0xff)TCCR1B = 0x02; 
	lds R24,_start_flag
	cpi R24,255
	brne L28
	.dbline 86
	ldi R24,2
	out 0x2e,R24
L28:
	.dbline 87
; if(start_flag==0x00){TCCR1B = 0x00;scan_s1();}
	lds R2,_start_flag
	tst R2
	brne L30
	.dbline 87
	.dbline 87
	clr R2
	out 0x2e,R2
	.dbline 87
	xcall _scan_s1
	.dbline 87
L30:
	.dbline 89
L26:
	.dbline 84
	xjmp L25
X4:
	.dbline -2
L24:
	.dbline 0 ; func end
	ret
	.dbend
	.area bss(ram, con, rel)
	.dbfile d:\MYDOCU~1\ac9-3\ac9-3.c
_i::
	.blkb 1
	.dbsym e i _i c
_start_flag::
	.blkb 1
	.dbsym e start_flag _start_flag c
_cnt::
	.blkb 2
	.dbsym e cnt _cnt i
