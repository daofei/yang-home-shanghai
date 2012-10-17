	.module ac10-1.c
	.area lit(rom, con, rel)
_SEG7::
	.byte 63,6
	.byte 91,'O
	.byte 'f,'m
	.byte 125,7
	.byte 127,'o
	.dbfile d:\MYDOCU~1\ac10-1\ac10-1.c
	.dbsym e SEG7 _SEG7 A[10:10]kc
_ACT::
	.byte 254,253
	.byte 251,247
	.dbsym e ACT _ACT A[4:4]kc
	.area text(rom, con, rel)
	.dbfile d:\MYDOCU~1\ac10-1\ac10-1.c
	.dbfunc e port_init _port_init fV
	.even
_port_init::
	.dbline -1
	.dbline 11
; #include <iom16v.h>			
; #define uchar unsigned char	
; #define uint  unsigned int	
; uchar const SEG7[10]={0x3f,0x06,0x5b, 
; 0x4f,0x66,0x6d,0x7d,0x07,0x7f,0x6f};
; uchar const ACT[4]={0xfe,0xfd,0xfb,0xf7};
; uint adc_val,dis_val;	
; uchar i,cnt;				
; /************************************************/
; void port_init(void)	
; {						
	.dbline 12
;  PORTA = 0x7F;			
	ldi R24,127
	out 0x1b,R24
	.dbline 13
;  DDRA  = 0x7F;			
	out 0x1a,R24
	.dbline 14
;  PORTB = 0xFF;
	ldi R24,255
	out 0x18,R24
	.dbline 15
;  DDRB  = 0xFF;		
	out 0x17,R24
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
;  DDRD  = 0xFF;		
	out 0x11,R24
	.dbline -2
L1:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e adc_init _adc_init fV
	.even
_adc_init::
	.dbline -1
	.dbline 23
; }				
; /************************************************/
; void adc_init(void)	
; {					
	.dbline 24
; ADCSRA = 0xE3; 		
	ldi R24,227
	out 0x6,R24
	.dbline 25
; ADMUX = 0xC7;		
	ldi R24,199
	out 0x7,R24
	.dbline -2
L2:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e timer0_init _timer0_init fV
	.even
_timer0_init::
	.dbline -1
	.dbline 29
; }			
; //***************************
; void timer0_init(void)	
; {					
	.dbline 30
; TCNT0 = 0x83; 		
	ldi R24,131
	out 0x32,R24
	.dbline 31
; TCCR0 = 0x03; 		
	ldi R24,3
	out 0x33,R24
	.dbline 32
; TIMSK = 0x01; 		
	ldi R24,1
	out 0x39,R24
	.dbline -2
L3:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e init_devices _init_devices fV
	.even
_init_devices::
	.dbline -1
	.dbline 36
; }				
; /*********************************************/
; void init_devices(void)	
; {							
	.dbline 37
;  port_init();	
	xcall _port_init
	.dbline 38
;  timer0_init();			
	xcall _timer0_init
	.dbline 39
;  adc_init();			
	xcall _adc_init
	.dbline 40
;  SREG=0x80;	
	ldi R24,128
	out 0x3f,R24
	.dbline -2
L4:
	.dbline 0 ; func end
	ret
	.dbend
	.area vector(rom, abs)
	.org 36
	jmp _timer0_ovf_isr
	.area text(rom, con, rel)
	.dbfile d:\MYDOCU~1\ac10-1\ac10-1.c
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
	.dbline 45
; }							
; //***************************
; #pragma interrupt_handler timer0_ovf_isr:10
; void timer0_ovf_isr(void)	
; {							
	.dbline 46
;  TCNT0 = 0x83; 				
	ldi R24,131
	out 0x32,R24
	.dbline 47
;  cnt++;				
	lds R24,_cnt
	subi R24,255    ; addi 1
	sts _cnt,R24
	.dbline 48
;  if(++i>3)i=0;			
	lds R24,_i
	subi R24,255    ; addi 1
	mov R2,R24
	sts _i,R2
	ldi R24,3
	cp R24,R2
	brsh L6
	.dbline 48
	clr R2
	sts _i,R2
L6:
	.dbline 49
;  switch(i)	
	lds R20,_i
	clr R21
	cpi R20,0
	cpc R20,R21
	breq L11
X0:
	cpi R20,1
	ldi R30,0
	cpc R21,R30
	breq L12
	cpi R20,2
	ldi R30,0
	cpc R21,R30
	brne X2
	xjmp L14
X2:
	cpi R20,3
	ldi R30,0
	cpc R21,R30
	brne X3
	xjmp L16
X3:
	xjmp L9
X1:
	.dbline 50
;  {
L11:
	.dbline 51
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
	.dbline 51
	ldi R30,<_ACT
	ldi R31,>_ACT
	lpm R30,Z
	out 0x15,R30
	.dbline 51
	xjmp L9
L12:
	.dbline 52
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
	.dbline 52
	ldi R30,<_ACT+1
	ldi R31,>_ACT+1
	lpm R30,Z
	out 0x15,R30
	.dbline 52
	xjmp L9
L14:
	.dbline 53
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
	.dbline 53
	ldi R30,<_ACT+2
	ldi R31,>_ACT+2
	lpm R30,Z
	out 0x15,R30
	.dbline 53
	xjmp L9
L16:
	.dbline 54
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
	.dbline 54
	ldi R30,<_ACT+3
	ldi R31,>_ACT+3
	lpm R30,Z
	out 0x15,R30
	.dbline 54
	.dbline 55
L9:
	.dbline -2
L5:
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
	.dbfunc e ADC_Convert _ADC_Convert fi
;          temp1 -> R18,R19
;          temp2 -> R16,R17
	.even
_ADC_Convert::
	.dbline -1
	.dbline 60
;  case 3:PORTA=SEG7[dis_val/1000];PORTC=ACT[3];break;
;  default:break;
;  }
; }
; //=========================
; uint ADC_Convert(void)		
; {uint temp1,temp2;		
	.dbline 61
;  temp1=(uint)ADCL;			
	in R18,0x4
	clr R19
	.dbline 62
;  temp2=(uint)ADCH;
	in R16,0x5
	clr R17
	.dbline 63
;  temp2=(temp2<<8)+temp1;	
	movw R2,R16
	mov R3,R2
	clr R2
	add R2,R18
	adc R3,R19
	movw R16,R2
	.dbline 64
;  return(temp2);			
	.dbline -2
L18:
	.dbline 0 ; func end
	ret
	.dbsym r temp1 18 i
	.dbsym r temp2 16 i
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
	.dbline 68
; }
; /**************************/
; uint conv(uint i)		
; {
	.dbline 71
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
	.dbline 72
; y=(uint)x;	
	movw R30,R28
	ldd R10,z+0
	ldd R11,z+1
	.dbline 73
; return y;	
	movw R16,R10
	.dbline -2
L19:
	adiw R28,4
	xcall pop_gset3
	.dbline 0 ; func end
	ret
	.dbsym r y 10 i
	.dbsym l x 0 L
	.dbsym r i 10 i
	.dbend
	.dbfunc e delay _delay fV
;              i -> R20,R21
;              j -> R22,R23
;              k -> R16,R17
	.even
_delay::
	xcall push_gset2
	.dbline -1
	.dbline 77
; } 
; /***********************/
; void delay(uint k)	
; {
	.dbline 79
; uint i,j;
; 	 for(i=0;i<k;i++)
	clr R20
	clr R21
	xjmp L24
L21:
	.dbline 80
; 	 {	 
	.dbline 81
	clr R22
	clr R23
	xjmp L28
L25:
	.dbline 81
L26:
	.dbline 81
	subi R22,255  ; offset = 1
	sbci R23,255
L28:
	.dbline 81
	cpi R22,140
	ldi R30,0
	cpc R23,R30
	brlo L25
	.dbline 82
L22:
	.dbline 79
	subi R20,255  ; offset = 1
	sbci R21,255
L24:
	.dbline 79
	cp R20,R16
	cpc R21,R17
	brlo L21
	.dbline -2
L20:
	xcall pop_gset2
	.dbline 0 ; func end
	ret
	.dbsym r i 20 i
	.dbsym r j 22 i
	.dbsym r k 16 i
	.dbend
	.dbfunc e main _main fV
	.even
_main::
	.dbline -1
	.dbline 86
; 	 for(j=0;j<140;j++); 
; 	 }
; }
; /***********************/
; void main(void)				
; {	 						
	.dbline 87
; init_devices();			
	xcall _init_devices
	xjmp L31
L30:
	.dbline 89
;   while(1)					
;   {							
	.dbline 90
;    		if(cnt>100)		
	ldi R24,100
	lds R2,_cnt
	cp R24,R2
	brsh L33
	.dbline 91
; 		{
	.dbline 92
; 		adc_val=ADC_Convert();
	xcall _ADC_Convert
	sts _adc_val+1,R17
	sts _adc_val,R16
	.dbline 93
; 		dis_val=conv(adc_val);
	xcall _conv
	sts _dis_val+1,R17
	sts _dis_val,R16
	.dbline 94
; 		cnt=0;				
	clr R2
	sts _cnt,R2
	.dbline 95
; 		}
L33:
	.dbline 96
	ldi R16,10
	ldi R17,0
	xcall _delay
	.dbline 97
L31:
	.dbline 88
	xjmp L30
X4:
	.dbline -2
L29:
	.dbline 0 ; func end
	ret
	.dbend
	.area bss(ram, con, rel)
	.dbfile d:\MYDOCU~1\ac10-1\ac10-1.c
_cnt::
	.blkb 1
	.dbsym e cnt _cnt c
_i::
	.blkb 1
	.dbsym e i _i c
_dis_val::
	.blkb 2
	.dbsym e dis_val _dis_val i
_adc_val::
	.blkb 2
	.dbsym e adc_val _adc_val i
