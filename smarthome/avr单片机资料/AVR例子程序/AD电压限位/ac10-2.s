	.module ac10-2.c
	.area lit(rom, con, rel)
_SEG7::
	.byte 63,6
	.byte 91,'O
	.byte 'f,'m
	.byte 125,7
	.byte 127,'o
	.dbfile d:\MYDOCU~1\ac10-2\ac10-2.c
	.dbsym e SEG7 _SEG7 A[10:10]kc
_ACT::
	.byte 254,253
	.byte 251,247
	.dbsym e ACT _ACT A[4:4]kc
	.area text(rom, con, rel)
	.dbfile d:\MYDOCU~1\ac10-2\ac10-2.c
	.dbfunc e port_init _port_init fV
	.even
_port_init::
	.dbline -1
	.dbline 15
; #include <iom16v.h>			
; #define uchar unsigned char	
; #define uint  unsigned int
; #define OUT1_0  (PORTB=PORTB&0xfe) 
; #define OUT1_1  (PORTB=PORTB|0x01) 
; #define OUT2_0  (PORTB=PORTB&0xfd) 
; #define OUT2_1  (PORTB=PORTB|0x02) 
; uchar const SEG7[10]={0x3f,0x06,0x5b,
; 0x4f,0x66,0x6d,0x7d,0x07,0x7f,0x6f};
; uchar const ACT[4]={0xfe,0xfd,0xfb,0xf7};
; uint value,dis_val; 
; uchar i,flag; 
; /****************************************/
; void port_init(void)	
; {						
	.dbline 16
;  PORTA = 0x7F;	
	ldi R24,127
	out 0x1b,R24
	.dbline 17
;  DDRA  = 0x7F;		
	out 0x1a,R24
	.dbline 18
;  PORTB = 0xFF;		
	ldi R24,255
	out 0x18,R24
	.dbline 19
;  DDRB  = 0xFF;
	out 0x17,R24
	.dbline 20
;  PORTC = 0xFF; 			
	out 0x15,R24
	.dbline 21
;  DDRC  = 0xFF;		
	out 0x14,R24
	.dbline 22
;  PORTD = 0xFF;			
	out 0x12,R24
	.dbline 23
;  DDRD  = 0xFF;			
	out 0x11,R24
	.dbline -2
L1:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e timer0_init _timer0_init fV
	.even
_timer0_init::
	.dbline -1
	.dbline 27
; }				
; /************************************/
; void timer0_init(void) 
; {
	.dbline 28
;  TCNT0 = 0x83; 	
	ldi R24,131
	out 0x32,R24
	.dbline 29
;  OCR0  = 0x7D;
	ldi R24,125
	out 0x3c,R24
	.dbline 30
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
	.dbfile d:\MYDOCU~1\ac10-2\ac10-2.c
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
	.dbline 35
; }
; /*************************************/
; #pragma interrupt_handler timer0_ovf_isr:10 
; void timer0_ovf_isr(void)
; {
	.dbline 36
;  TCNT0 = 0x83; 	
	ldi R24,131
	out 0x32,R24
	.dbline 37
;  if(++i>3)i=0;	
	lds R24,_i
	subi R24,255    ; addi 1
	mov R2,R24
	sts _i,R2
	ldi R24,3
	cp R24,R2
	brsh L4
	.dbline 37
	clr R2
	sts _i,R2
L4:
	.dbline 38
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
	xjmp L12
X2:
	cpi R20,3
	ldi R30,0
	cpc R21,R30
	brne X3
	xjmp L14
X3:
	xjmp L7
X1:
	.dbline 39
;  {
L9:
	.dbline 40
;  case 0:PORTA=SEG7[dis_val%10];PORTC=ACT[0];break;
	ldi R18,10
	ldi R19,0
	lds R16,_dis_val
	lds R17,_dis_val+1
	xcall mod16u
	movw R30,R16
	ldi R24,<_SEG7
	ldi R25,>_SEG7
	add R30,R24
	adc R31,R25
	lpm R30,Z
	out 0x1b,R30
	.dbline 40
	ldi R30,<_ACT
	ldi R31,>_ACT
	lpm R30,Z
	out 0x15,R30
	.dbline 40
	xjmp L7
L10:
	.dbline 41
;  case 1:PORTA=SEG7[(dis_val/10)%10];PORTC=ACT[1];break;
	ldi R18,10
	ldi R19,0
	lds R16,_dis_val
	lds R17,_dis_val+1
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
	.dbline 41
	ldi R30,<_ACT+1
	ldi R31,>_ACT+1
	lpm R30,Z
	out 0x15,R30
	.dbline 41
	xjmp L7
L12:
	.dbline 42
;  case 2:PORTA=SEG7[(dis_val/100)%10];PORTC=ACT[2];break;
	ldi R18,100
	ldi R19,0
	lds R16,_dis_val
	lds R17,_dis_val+1
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
	.dbline 42
	ldi R30,<_ACT+2
	ldi R31,>_ACT+2
	lpm R30,Z
	out 0x15,R30
	.dbline 42
	xjmp L7
L14:
	.dbline 43
	ldi R18,1000
	ldi R19,3
	lds R16,_dis_val
	lds R17,_dis_val+1
	xcall div16u
	movw R30,R16
	ldi R24,<_SEG7
	ldi R25,>_SEG7
	add R30,R24
	adc R31,R25
	lpm R30,Z
	out 0x1b,R30
	.dbline 43
	ldi R30,<_ACT+3
	ldi R31,>_ACT+3
	lpm R30,Z
	out 0x15,R30
	.dbline 43
	.dbline 44
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
	.dbline 49
;  case 3:PORTA=SEG7[dis_val/1000];PORTC=ACT[3];break;
;  default:break;
;  }
; }
; /************************************/
; void timer1_init(void) 	
; {
	.dbline 50
;  TCNT1H = 0xE7; 	
	ldi R24,231
	out 0x2d,R24
	.dbline 51
;  TCNT1L = 0x96;
	ldi R24,150
	out 0x2c,R24
	.dbline 52
;  TCCR1B = 0x03; 	
	ldi R24,3
	out 0x2e,R24
	.dbline -2
L16:
	.dbline 0 ; func end
	ret
	.dbend
	.area vector(rom, abs)
	.org 32
	jmp _timer1_ovf_isr
	.area text(rom, con, rel)
	.dbfile d:\MYDOCU~1\ac10-2\ac10-2.c
	.dbfunc e timer1_ovf_isr _timer1_ovf_isr fV
	.even
_timer1_ovf_isr::
	st -y,R24
	in R24,0x3f
	st -y,R24
	.dbline -1
	.dbline 57
; }
; /***************************************************/
; #pragma interrupt_handler timer1_ovf_isr:9 
; void timer1_ovf_isr(void)
; {
	.dbline 58
;  TCNT1H = 0xE7; 		
	ldi R24,231
	out 0x2d,R24
	.dbline 59
;  TCNT1L = 0x96; 
	ldi R24,150
	out 0x2c,R24
	.dbline -2
L17:
	ld R24,y+
	out 0x3f,R24
	ld R24,y+
	.dbline 0 ; func end
	reti
	.dbend
	.dbfunc e adc_init _adc_init fV
	.even
_adc_init::
	.dbline -1
	.dbline 63
;  }
; /****************************************************/
; void adc_init(void) 
; {
	.dbline 64
;  ADMUX = 0x07; 
	ldi R24,7
	out 0x7,R24
	.dbline 65
;  ACSR  = 0x80; 
	ldi R24,128
	out 0x8,R24
	.dbline 66
;  ADCSR = 0xE9; 
	ldi R24,233
	out 0x6,R24
	.dbline -2
L18:
	.dbline 0 ; func end
	ret
	.dbend
	.area vector(rom, abs)
	.org 56
	jmp _adc_isr
	.area text(rom, con, rel)
	.dbfile d:\MYDOCU~1\ac10-2\ac10-2.c
	.dbfunc e adc_isr _adc_isr fV
	.even
_adc_isr::
	st -y,R2
	st -y,R3
	st -y,R4
	st -y,R5
	st -y,R24
	in R2,0x3f
	st -y,R2
	.dbline -1
	.dbline 71
; }
; /****************************************************/
; #pragma interrupt_handler adc_isr:15 
; void adc_isr(void)
; {
	.dbline 73
;  //conversion complete, read value (int) using...
;   value=ADCL;            
	in R2,0x4
	clr R3
	sts _value+1,R3
	sts _value,R2
	.dbline 74
;   value|=(int)ADCH << 8; 
	in R2,0x5
	clr R3
	mov R3,R2
	clr R2
	lds R4,_value
	lds R5,_value+1
	or R4,R2
	or R5,R3
	sts _value+1,R5
	sts _value,R4
	.dbline 75
;   flag=1;	
	ldi R24,1
	sts _flag,R24
	.dbline -2
L19:
	ld R2,y+
	out 0x3f,R2
	ld R24,y+
	ld R5,y+
	ld R4,y+
	ld R3,y+
	ld R2,y+
	.dbline 0 ; func end
	reti
	.dbend
	.dbfunc e init_devices _init_devices fV
	.even
_init_devices::
	.dbline -1
	.dbline 79
; }
; /***************************************/
; void init_devices(void) 
; {
	.dbline 80
;  port_init();	
	xcall _port_init
	.dbline 81
;  timer0_init();	
	xcall _timer0_init
	.dbline 82
;  timer1_init();	
	xcall _timer1_init
	.dbline 83
;  adc_init();	
	xcall _adc_init
	.dbline 84
;  TIMSK = 0x05; 
	ldi R24,5
	out 0x39,R24
	.dbline 85
;  SREG=0x80; 
	ldi R24,128
	out 0x3f,R24
	.dbline -2
L20:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e delay _delay fV
;              i -> R20,R21
;              j -> R22,R23
;              k -> R16,R17
	.even
_delay::
	xcall push_gset2
	.dbline -1
	.dbline 89
; }
; /***************************************/
; void delay(uint k) 
; {
	.dbline 91
; uint i,j;
; 	 for(i=0;i<k;i++)
	clr R20
	clr R21
	xjmp L25
L22:
	.dbline 92
; 	 {	 
	.dbline 93
	clr R22
	clr R23
	xjmp L29
L26:
	.dbline 93
L27:
	.dbline 93
	subi R22,255  ; offset = 1
	sbci R23,255
L29:
	.dbline 93
	cpi R22,140
	ldi R30,0
	cpc R23,R30
	brlo L26
	.dbline 94
L23:
	.dbline 91
	subi R20,255  ; offset = 1
	sbci R21,255
L25:
	.dbline 91
	cp R20,R16
	cpc R21,R17
	brlo L22
	.dbline -2
L21:
	xcall pop_gset2
	.dbline 0 ; func end
	ret
	.dbsym r i 20 i
	.dbsym r j 22 i
	.dbsym r k 16 i
	.dbend
	.dbfunc e conv _conv fi
;              y -> R10,R11
;              x -> y+0
;              i -> R10,R11
	.even
_conv::
	xcall push_gset3
	movw R10,R16
	sbiw R28,4
	.dbline -1
	.dbline 98
; 	 for(j=0;j<140;j++); 
; 	 }
; }
; /******************************************/
; uint conv(uint i) 
; {
	.dbline 101
; long x; 	
; uint y; 
; x=(5000*(long)i)/1023; 
	movw R2,R10
	clr R4
	clr R5
	ldi R20,136
	ldi R21,19
	ldi R22,0
	ldi R23,0
	st -y,R5
	st -y,R4
	st -y,R3
	st -y,R2
	movw R16,R20
	movw R18,R22
	xcall empy32s
	ldi R20,255
	ldi R21,3
	ldi R22,0
	ldi R23,0
	st -y,R23
	st -y,R22
	st -y,R21
	st -y,R20
	xcall div32s
	movw R30,R28
	std z+0,R16
	std z+1,R17
	std z+2,R18
	std z+3,R19
	.dbline 102
; y=(uint)x; 	
	movw R30,R28
	ldd R10,z+0
	ldd R11,z+1
	.dbline 103
; return y; 	
	movw R16,R10
	.dbline -2
L30:
	adiw R28,4
	xcall pop_gset3
	.dbline 0 ; func end
	ret
	.dbsym r y 10 i
	.dbsym l x 0 L
	.dbsym r i 10 i
	.dbend
	.dbfunc e main _main fV
	.even
_main::
	.dbline -1
	.dbline 107
; } 
; /******************************************/
; void main(void) 	
; {	 				
	.dbline 108
; init_devices();		
	xcall _init_devices
	xjmp L33
L32:
	.dbline 110
;   while(1) 	
;   {
	.dbline 111
;    		if(flag==1) 
	lds R24,_flag
	cpi R24,1
	brne L35
	.dbline 112
; 		{
	.dbline 113
; 		dis_val=conv(value); 
	lds R16,_value
	lds R17,_value+1
	xcall _conv
	sts _dis_val+1,R17
	sts _dis_val,R16
	.dbline 114
; 		  if(dis_val<2000){OUT2_1;OUT1_0;} 
	cpi R16,208
	ldi R30,7
	cpc R17,R30
	brsh L37
	.dbline 114
	.dbline 114
	sbi 0x18,1
	.dbline 114
	in R24,0x18
	andi R24,254
	out 0x18,R24
	.dbline 114
	xjmp L38
L37:
	.dbline 115
; 		  else if(dis_val<3000){OUT1_1;OUT2_1;} 
	lds R24,_dis_val
	lds R25,_dis_val+1
	cpi R24,184
	ldi R30,11
	cpc R25,R30
	brsh L39
	.dbline 115
	.dbline 115
	sbi 0x18,0
	.dbline 115
	sbi 0x18,1
	.dbline 115
	xjmp L40
L39:
	.dbline 116
; 		  else {OUT2_0;OUT1_1;} 
	.dbline 116
	in R24,0x18
	andi R24,253
	out 0x18,R24
	.dbline 116
	sbi 0x18,0
	.dbline 116
L40:
L38:
	.dbline 117
; 		flag=0;			
	clr R2
	sts _flag,R2
	.dbline 118
; 		}
L35:
	.dbline 119
	ldi R16,10
	ldi R17,0
	xcall _delay
	.dbline 120
L33:
	.dbline 109
	xjmp L32
X4:
	.dbline -2
L31:
	.dbline 0 ; func end
	ret
	.dbend
	.area bss(ram, con, rel)
	.dbfile d:\MYDOCU~1\ac10-2\ac10-2.c
_flag::
	.blkb 1
	.dbsym e flag _flag c
_i::
	.blkb 1
	.dbsym e i _i c
_dis_val::
	.blkb 2
	.dbsym e dis_val _dis_val i
_value::
	.blkb 2
	.dbsym e value _value i
