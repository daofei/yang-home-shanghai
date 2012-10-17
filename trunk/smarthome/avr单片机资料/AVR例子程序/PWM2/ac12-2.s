	.module ac12-2.c
	.area lit(rom, con, rel)
_SEG7::
	.byte 63,6
	.byte 91,'O
	.byte 'f,'m
	.byte 125,7
	.byte 127,'o
	.dbfile d:\MYDOCU~1\ac12-2\ac12-2.c
	.dbsym e SEG7 _SEG7 A[10:10]kc
_ACT::
	.byte 254,253
	.byte 251,247
	.dbsym e ACT _ACT A[4:4]kc
	.area text(rom, con, rel)
	.dbfile d:\MYDOCU~1\ac12-2\ac12-2.c
	.dbfunc e port_init _port_init fV
	.even
_port_init::
	.dbline -1
	.dbline 14
; #include <iom16v.h>		
; #include<eeprom.h>
; #define uchar unsigned char	
; #define uint  unsigned int	
; uchar const SEG7[10]={0x3f,0x06,0x5b, 
; 0x4f,0x66,0x6d,0x7d,0x07,0x7f,0x6f};
; uchar const ACT[4]={0xfe,0xfd,0xfb,0xf7};
; uint key_cnt,cnt;
; uint Wide,Disval;
; #define SINT0 (PIND&0x04)
; #define SINT1 (PIND&0x08)
; 
; void port_init(void)		
; {							
	.dbline 15
;  PORTA = 0xFF;			
	ldi R24,255
	out 0x1b,R24
	.dbline 16
;  DDRA  = 0xFF;			
	out 0x1a,R24
	.dbline 17
;  PORTB = 0xFF;			
	out 0x18,R24
	.dbline 18
;  DDRB  = 0xFF;			
	out 0x17,R24
	.dbline 19
;  PORTC = 0xFF; 			
	out 0x15,R24
	.dbline 20
;  DDRC  = 0xFF;			
	out 0x14,R24
	.dbline 21
;  PORTD = 0xFF;		
	out 0x12,R24
	.dbline 22
;  DDRD  = 0x20;			
	ldi R24,32
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
	.dbline 26
; }				
; //***************************
; void timer0_init(void)
; {							
	.dbline 27
; TCNT0 = 0x83; 		
	ldi R24,131
	out 0x32,R24
	.dbline 28
; TCCR0 = 0x03; 			
	ldi R24,3
	out 0x33,R24
	.dbline 29
; TIMSK = 0x01; 		
	ldi R24,1
	out 0x39,R24
	.dbline -2
L2:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e timer1_init _timer1_init fV
	.even
_timer1_init::
	.dbline -1
	.dbline 36
; }				
; //TIMER1 initialize - prescale:8
; // WGM: 0) Normal, TOP=0xFFFF
; // desired value: 1000Hz
; // actual value: 1000.000Hz (0.0%)
; void timer1_init(void)		
; {
	.dbline 37
;  TCCR1A = 0x83;			
	ldi R24,131
	out 0x2f,R24
	.dbline 38
;  TCCR1B = 0x02; 		
	ldi R24,2
	out 0x2e,R24
	.dbline -2
L3:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e init_devices _init_devices fV
	.even
_init_devices::
	.dbline -1
	.dbline 42
; }			
; /*********************************************/
; void init_devices(void)	
; {							
	.dbline 43
;  port_init();		
	xcall _port_init
	.dbline 44
;  timer0_init();			
	xcall _timer0_init
	.dbline 45
;  timer1_init();			
	xcall _timer1_init
	.dbline 46
;  SREG=0x80;			
	ldi R24,128
	out 0x3f,R24
	.dbline -2
L4:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e main _main fV
;              x -> y+0
	.even
_main::
	sbiw R28,4
	.dbline -1
	.dbline 51
; }							
; 
; /******************主函数******************/
; void main(void)
; {	long x;					
	.dbline 52
; init_devices();			
	xcall _init_devices
	xjmp L7
L6:
	.dbline 54
	.dbline 55
	lds R2,_Wide
	lds R3,_Wide+1
	clr R4
	clr R5
	movw R30,R28
	std z+0,R2
	std z+1,R3
	std z+2,R4
	std z+3,R5
	.dbline 56
	movw R30,R28
	ldd R2,z+0
	ldd R3,z+1
	ldd R4,z+2
	ldd R5,z+3
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
	.dbline 57
	movw R30,R28
	ldd R2,z+0
	ldd R3,z+1
	sts _Disval+1,R3
	sts _Disval,R2
	.dbline 58
	lds R2,_Wide
	lds R3,_Wide+1
	mov R2,R3
	clr R3
	out 0x2b,R2
	.dbline 59
	lds R24,_Wide
	lds R25,_Wide+1
	andi R25,0
	out 0x2a,R24
	.dbline 60
L7:
	.dbline 53
	xjmp L6
X0:
	.dbline -2
L5:
	adiw R28,4
	.dbline 0 ; func end
	ret
	.dbsym l x 0 L
	.dbend
	.area vector(rom, abs)
	.org 36
	jmp _timer0_ovf_isr
	.area text(rom, con, rel)
	.dbfile d:\MYDOCU~1\ac12-2\ac12-2.c
	.dbfunc e timer0_ovf_isr _timer0_ovf_isr fV
	.even
_timer0_ovf_isr::
	st -y,R2
	st -y,R3
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
	.dbline -1
	.dbline 65
; 	while(1)			
;     {	
; 	x=(long)Wide;		
; 	x=x*5000/1023;
; 	Disval=(uint)x;
; 	OCR1AH=(uchar)(Wide>>8);
; 	OCR1AL=(uchar)(Wide&0x00ff); 
; 	}
; }
; //**************T/C0中断服务子函数*************
; #pragma interrupt_handler timer0_ovf_isr:10
; void timer0_ovf_isr(void)	
; {							
	.dbline 66
;  TCNT0 = 0x83; 			
	ldi R24,131
	out 0x32,R24
	.dbline 67
;  if(++key_cnt>100)key_cnt=0;
	lds R24,_key_cnt
	lds R25,_key_cnt+1
	adiw R24,1
	movw R2,R24
	sts _key_cnt+1,R3
	sts _key_cnt,R2
	ldi R24,100
	ldi R25,0
	cp R24,R2
	cpc R25,R3
	brsh L10
	.dbline 67
	clr R2
	clr R3
	sts _key_cnt+1,R3
	sts _key_cnt,R2
L10:
	.dbline 68
;  if(++cnt>3)cnt=0;	
	lds R24,_cnt
	lds R25,_cnt+1
	adiw R24,1
	movw R2,R24
	sts _cnt+1,R3
	sts _cnt,R2
	ldi R24,3
	ldi R25,0
	cp R24,R2
	cpc R25,R3
	brsh L12
	.dbline 68
	clr R2
	clr R3
	sts _cnt+1,R3
	sts _cnt,R2
L12:
	.dbline 70
;  
;  switch(cnt)
	lds R2,_cnt
	lds R3,_cnt+1
	tst R2
	brne X1
	tst R3
	breq L16
X1:
	lds R24,_cnt
	lds R25,_cnt+1
	cpi R24,1
	ldi R30,0
	cpc R25,R30
	breq L17
	cpi R24,2
	ldi R30,0
	cpc R25,R30
	brne X5
	xjmp L19
X5:
	cpi R24,3
	ldi R30,0
	cpc R25,R30
	brne X6
	xjmp L21
X6:
	xjmp L15
X2:
	.dbline 71
;  {
L16:
	.dbline 72
;  case 0:PORTA=SEG7[Disval%10];PORTC=ACT[0];break;
	ldi R18,10
	ldi R19,0
	lds R16,_Disval
	lds R17,_Disval+1
	xcall mod16u
	movw R30,R16
	ldi R24,<_SEG7
	ldi R25,>_SEG7
	add R30,R24
	adc R31,R25
	lpm R30,Z
	out 0x1b,R30
	.dbline 72
	ldi R30,<_ACT
	ldi R31,>_ACT
	lpm R30,Z
	out 0x15,R30
	.dbline 72
	xjmp L15
L17:
	.dbline 73
;  case 1:PORTA=SEG7[(Disval%100)/10];PORTC=ACT[1];break;
	ldi R18,100
	ldi R19,0
	lds R16,_Disval
	lds R17,_Disval+1
	xcall mod16u
	ldi R18,10
	ldi R19,0
	xcall div16u
	movw R30,R16
	ldi R24,<_SEG7
	ldi R25,>_SEG7
	add R30,R24
	adc R31,R25
	lpm R30,Z
	out 0x1b,R30
	.dbline 73
	ldi R30,<_ACT+1
	ldi R31,>_ACT+1
	lpm R30,Z
	out 0x15,R30
	.dbline 73
	xjmp L15
L19:
	.dbline 74
;  case 2:PORTA=SEG7[(Disval%1000)/100];PORTC=ACT[2];break;
	ldi R18,1000
	ldi R19,3
	lds R16,_Disval
	lds R17,_Disval+1
	xcall mod16u
	ldi R18,100
	ldi R19,0
	xcall div16u
	movw R30,R16
	ldi R24,<_SEG7
	ldi R25,>_SEG7
	add R30,R24
	adc R31,R25
	lpm R30,Z
	out 0x1b,R30
	.dbline 74
	ldi R30,<_ACT+2
	ldi R31,>_ACT+2
	lpm R30,Z
	out 0x15,R30
	.dbline 74
	xjmp L15
L21:
	.dbline 75
;  case 3:PORTA=SEG7[Disval/1000]|0x80;PORTC=ACT[3];break;
	ldi R18,1000
	ldi R19,3
	lds R16,_Disval
	lds R17,_Disval+1
	xcall div16u
	movw R30,R16
	ldi R24,<_SEG7
	ldi R25,>_SEG7
	add R30,R24
	adc R31,R25
	lpm R30,Z
	ori R30,128
	out 0x1b,R30
	.dbline 75
	ldi R30,<_ACT+3
	ldi R31,>_ACT+3
	lpm R30,Z
	out 0x15,R30
	.dbline 75
	.dbline 76
;  default:break;
L15:
	.dbline 78
;  }
;  if(key_cnt==0)	
	lds R2,_key_cnt
	lds R3,_key_cnt+1
	tst R2
	brne L23
	tst R3
	brne L23
X3:
	.dbline 79
;  {
	.dbline 80
	sbic 0x10,2
	rjmp L25
	.dbline 80
	.dbline 80
	lds R24,_Wide
	lds R25,_Wide+1
	cpi R24,255
	ldi R30,3
	cpc R25,R30
	brsh L27
	.dbline 80
	adiw R24,1
	sts _Wide+1,R25
	sts _Wide,R24
L27:
	.dbline 80
;  if(SINT0==0){if(Wide<1023)Wide++;}
L25:
	.dbline 81
	sbic 0x10,3
	rjmp L29
	.dbline 81
	.dbline 81
	lds R2,_Wide
	lds R3,_Wide+1
	tst R2
	brne X4
	tst R3
	breq L31
X4:
	.dbline 81
	lds R24,_Wide
	lds R25,_Wide+1
	sbiw R24,1
	sts _Wide+1,R25
	sts _Wide,R24
L31:
	.dbline 81
;  if(SINT1==0){if(Wide>0)Wide--;}
L29:
	.dbline 82
L23:
	.dbline -2
L9:
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
	ld R3,y+
	ld R2,y+
	.dbline 0 ; func end
	reti
	.dbend
	.area bss(ram, con, rel)
	.dbfile d:\MYDOCU~1\ac12-2\ac12-2.c
_Disval::
	.blkb 2
	.dbsym e Disval _Disval i
_Wide::
	.blkb 2
	.dbsym e Wide _Wide i
_cnt::
	.blkb 2
	.dbsym e cnt _cnt i
_key_cnt::
	.blkb 2
	.dbsym e key_cnt _key_cnt i
