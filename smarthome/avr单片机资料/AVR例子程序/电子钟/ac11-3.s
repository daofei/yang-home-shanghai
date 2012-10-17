	.module ac11-3.c
	.area lit(rom, con, rel)
_SEG7::
	.byte 63,6
	.byte 91,'O
	.byte 'f,'m
	.byte 125,7
	.byte 127,'o
	.dbfile d:\MYDOCU~1\ac11-3\ac11-3.c
	.dbsym e SEG7 _SEG7 A[10:10]kc
_ACT::
	.byte 254,253
	.byte 251,247
	.dbsym e ACT _ACT A[4:4]kc
	.area text(rom, con, rel)
	.dbfile d:\MYDOCU~1\ac11-3\ac11-3.c
	.dbfunc e port_init _port_init fV
	.even
_port_init::
	.dbline -1
	.dbline 20
; #include <iom16v.h>			
; #include<eeprom.h>
; #define uchar unsigned char
; #define uint  unsigned int	
; uchar const SEG7[10]={0x3f,0x06,0x5b, 
; 0x4f,0x66,0x6d,0x7d,0x07,0x7f,0x6f};
; uchar const ACT[4]={0xfe,0xfd,0xfb,0xf7};
; #define LED1_0  (PORTB=PORTB&0xfe)	
; #define S1 (PIND&0x10)
; #define S2 (PIND&0x20)
; #define S3 (PIND&0x40)
; #define S4 (PIND&0x80)
; #define SINT0 (PIND&0x04)
; #define SINT1 (PIND&0x08)
; uchar dpw,dpt,write_flag,time_flag,cnt;
; uint key_cnt,ms_cnt;		
; uchar sec,min,set_sec,set_min;		
; /************************************************/
; void port_init(void)	
; {						
	.dbline 21
;  PORTA = 0xFF;			
	ldi R24,255
	out 0x1b,R24
	.dbline 22
;  DDRA  = 0xFF;			
	out 0x1a,R24
	.dbline 23
;  PORTB = 0xFF;			
	out 0x18,R24
	.dbline 24
;  DDRB  = 0xFF;		
	out 0x17,R24
	.dbline 25
;  PORTC = 0xFF; 			
	out 0x15,R24
	.dbline 26
;  DDRC  = 0xFF;			
	out 0x14,R24
	.dbline 27
;  PORTD = 0xFF;			
	out 0x12,R24
	.dbline 28
;  DDRD  = 0x00;		
	clr R2
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
	.dbline 32
; }					
; //***************************
; void timer0_init(void)	
; {							
	.dbline 33
; TCNT0 = 0x83; 			
	ldi R24,131
	out 0x32,R24
	.dbline 34
; TCCR0 = 0x03; 			
	ldi R24,3
	out 0x33,R24
	.dbline 35
; TIMSK = 0x01; 
	ldi R24,1
	out 0x39,R24
	.dbline -2
L2:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e init_devices _init_devices fV
	.even
_init_devices::
	.dbline -1
	.dbline 39
; }							
; /*********************************************/
; void init_devices(void)		
; {							
	.dbline 40
;  port_init();		
	xcall _port_init
	.dbline 41
;  timer0_init();			
	xcall _timer0_init
	.dbline 42
;  SREG=0x80;	
	ldi R24,128
	out 0x3f,R24
	.dbline -2
L3:
	.dbline 0 ; func end
	ret
	.dbend
	.area vector(rom, abs)
	.org 36
	jmp _timer0_ovf_isr
	.area text(rom, con, rel)
	.dbfile d:\MYDOCU~1\ac11-3\ac11-3.c
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
	xcall push_gset1
	.dbline -1
	.dbline 47
; }							
; //***************************
; #pragma interrupt_handler timer0_ovf_isr:10
; void timer0_ovf_isr(void)	
; {							
	.dbline 48
;  TCNT0 = 0x83; 			
	ldi R24,131
	out 0x32,R24
	.dbline 49
;  if(++key_cnt>300)key_cnt=0;
	lds R24,_key_cnt
	lds R25,_key_cnt+1
	adiw R24,1
	movw R2,R24
	sts _key_cnt+1,R3
	sts _key_cnt,R2
	ldi R24,300
	ldi R25,1
	cp R24,R2
	cpc R25,R3
	brsh L5
	.dbline 49
	clr R2
	clr R3
	sts _key_cnt+1,R3
	sts _key_cnt,R2
L5:
	.dbline 50
;  if(++cnt>7)cnt=0;	
	lds R24,_cnt
	subi R24,255    ; addi 1
	mov R2,R24
	sts _cnt,R2
	ldi R24,7
	cp R24,R2
	brsh L7
	.dbline 50
	clr R2
	sts _cnt,R2
L7:
	.dbline 51
;  if(++ms_cnt>999){ms_cnt=0;sec++;}
	lds R24,_ms_cnt
	lds R25,_ms_cnt+1
	adiw R24,1
	movw R2,R24
	sts _ms_cnt+1,R3
	sts _ms_cnt,R2
	ldi R24,999
	ldi R25,3
	cp R24,R2
	cpc R25,R3
	brsh L9
	.dbline 51
	.dbline 51
	clr R2
	clr R3
	sts _ms_cnt+1,R3
	sts _ms_cnt,R2
	.dbline 51
	lds R24,_sec
	subi R24,255    ; addi 1
	sts _sec,R24
	.dbline 51
L9:
	.dbline 52
;  if(sec>59){min++;sec=0;}	
	ldi R24,59
	lds R2,_sec
	cp R24,R2
	brsh L11
	.dbline 52
	.dbline 52
	lds R24,_min
	subi R24,255    ; addi 1
	sts _min,R24
	.dbline 52
	clr R2
	sts _sec,R2
	.dbline 52
L11:
	.dbline 53
;  if(min>59)min=59;		
	ldi R24,59
	lds R2,_min
	cp R24,R2
	brsh L13
	.dbline 53
	sts _min,R24
L13:
	.dbline 54
;  switch(cnt)	
	lds R20,_cnt
	clr R21
	cpi R20,0
	cpc R20,R21
	breq L18
X0:
	cpi R20,1
	ldi R30,0
	cpc R21,R30
	brne X3
	xjmp L19
X3:
	cpi R20,2
	ldi R30,0
	cpc R21,R30
	brne X4
	xjmp L21
X4:
	cpi R20,3
	ldi R30,0
	cpc R21,R30
	brne X5
	xjmp L23
X5:
	cpi R20,4
	ldi R30,0
	cpc R21,R30
	brne X6
	xjmp L25
X6:
	cpi R20,5
	ldi R30,0
	cpc R21,R30
	brne X7
	xjmp L29
X7:
	cpi R20,6
	ldi R30,0
	cpc R21,R30
	brne X8
	xjmp L31
X8:
	cpi R20,7
	ldi R30,0
	cpc R21,R30
	brne X9
	xjmp L33
X9:
	xjmp L16
X1:
	.dbline 55
;  {
L18:
	.dbline 56
;  case 0:PORTA=SEG7[sec%10];PORTC=ACT[0];break;
	ldi R18,10
	ldi R19,0
	lds R16,_sec
	clr R17
	xcall mod16s
	movw R30,R16
	ldi R24,<_SEG7
	ldi R25,>_SEG7
	add R30,R24
	adc R31,R25
	lpm R30,Z
	out 0x1b,R30
	.dbline 56
	ldi R30,<_ACT
	ldi R31,>_ACT
	lpm R30,Z
	out 0x15,R30
	.dbline 56
	xjmp L16
L19:
	.dbline 57
;  case 1:PORTA=SEG7[sec/10];PORTC=ACT[1];break;
	ldi R18,10
	ldi R19,0
	lds R16,_sec
	clr R17
	xcall div16s
	movw R30,R16
	ldi R24,<_SEG7
	ldi R25,>_SEG7
	add R30,R24
	adc R31,R25
	lpm R30,Z
	out 0x1b,R30
	.dbline 57
	ldi R30,<_ACT+1
	ldi R31,>_ACT+1
	lpm R30,Z
	out 0x15,R30
	.dbline 57
	xjmp L16
L21:
	.dbline 58
;  case 2:PORTA=SEG7[min%10];PORTC=ACT[2];break;
	ldi R18,10
	ldi R19,0
	lds R16,_min
	clr R17
	xcall mod16s
	movw R30,R16
	ldi R24,<_SEG7
	ldi R25,>_SEG7
	add R30,R24
	adc R31,R25
	lpm R30,Z
	out 0x1b,R30
	.dbline 58
	ldi R30,<_ACT+2
	ldi R31,>_ACT+2
	lpm R30,Z
	out 0x15,R30
	.dbline 58
	xjmp L16
L23:
	.dbline 59
;  case 3:PORTA=SEG7[min/10];PORTC=ACT[3];break;
	ldi R18,10
	ldi R19,0
	lds R16,_min
	clr R17
	xcall div16s
	movw R30,R16
	ldi R24,<_SEG7
	ldi R25,>_SEG7
	add R30,R24
	adc R31,R25
	lpm R30,Z
	out 0x1b,R30
	.dbline 59
	ldi R30,<_ACT+3
	ldi R31,>_ACT+3
	lpm R30,Z
	out 0x15,R30
	.dbline 59
	xjmp L16
L25:
	.dbline 60
;  case 4:if(dpw==1){PORTA=SEG7[set_sec%10]|0x80;}
	lds R24,_dpw
	cpi R24,1
	brne L26
	.dbline 60
	.dbline 60
	ldi R18,10
	ldi R19,0
	lds R16,_set_sec
	clr R17
	xcall mod16s
	movw R30,R16
	ldi R24,<_SEG7
	ldi R25,>_SEG7
	add R30,R24
	adc R31,R25
	lpm R30,Z
	ori R30,128
	out 0x1b,R30
	.dbline 60
	xjmp L27
L26:
	.dbline 61
;  	    else {PORTA=SEG7[set_sec%10];}
	.dbline 61
	ldi R18,10
	ldi R19,0
	lds R16,_set_sec
	clr R17
	xcall mod16s
	movw R30,R16
	ldi R24,<_SEG7
	ldi R25,>_SEG7
	add R30,R24
	adc R31,R25
	lpm R30,Z
	out 0x1b,R30
	.dbline 61
L27:
	.dbline 62
; 		PORTC=ACT[4];break;
	ldi R30,<_ACT+4
	ldi R31,>_ACT+4
	lpm R30,Z
	out 0x15,R30
	.dbline 62
	xjmp L16
L29:
	.dbline 63
;  case 5:PORTA=SEG7[set_sec/10];PORTC=ACT[5];break;
	ldi R18,10
	ldi R19,0
	lds R16,_set_sec
	clr R17
	xcall div16s
	movw R30,R16
	ldi R24,<_SEG7
	ldi R25,>_SEG7
	add R30,R24
	adc R31,R25
	lpm R30,Z
	out 0x1b,R30
	.dbline 63
	ldi R30,<_ACT+5
	ldi R31,>_ACT+5
	lpm R30,Z
	out 0x15,R30
	.dbline 63
	xjmp L16
L31:
	.dbline 64
;  case 6:PORTA=SEG7[set_min%10];PORTC=ACT[6];break;
	ldi R18,10
	ldi R19,0
	lds R16,_set_min
	clr R17
	xcall mod16s
	movw R30,R16
	ldi R24,<_SEG7
	ldi R25,>_SEG7
	add R30,R24
	adc R31,R25
	lpm R30,Z
	out 0x1b,R30
	.dbline 64
	ldi R30,<_ACT+6
	ldi R31,>_ACT+6
	lpm R30,Z
	out 0x15,R30
	.dbline 64
	xjmp L16
L33:
	.dbline 65
;  case 7:if(dpt==1){PORTA=SEG7[set_min/10]|0x80;}
	lds R24,_dpt
	cpi R24,1
	brne L34
	.dbline 65
	.dbline 65
	ldi R18,10
	ldi R19,0
	lds R16,_set_min
	clr R17
	xcall div16s
	movw R30,R16
	ldi R24,<_SEG7
	ldi R25,>_SEG7
	add R30,R24
	adc R31,R25
	lpm R30,Z
	ori R30,128
	out 0x1b,R30
	.dbline 65
	xjmp L35
L34:
	.dbline 66
;  	    else {PORTA=SEG7[set_min/10];} 
	.dbline 66
	ldi R18,10
	ldi R19,0
	lds R16,_set_min
	clr R17
	xcall div16s
	movw R30,R16
	ldi R24,<_SEG7
	ldi R25,>_SEG7
	add R30,R24
	adc R31,R25
	lpm R30,Z
	out 0x1b,R30
	.dbline 66
L35:
	.dbline 67
; 		PORTC=ACT[7];break;
	ldi R30,<_ACT+7
	ldi R31,>_ACT+7
	lpm R30,Z
	out 0x15,R30
	.dbline 67
	.dbline 68
;  default:break;
L16:
	.dbline 70
;  }
;  if(key_cnt==0)		
	lds R2,_key_cnt
	lds R3,_key_cnt+1
	tst R2
	breq X10
	xjmp L37
X10:
	tst R3
	breq X11
	xjmp L37
X11:
X2:
	.dbline 71
;  {
	.dbline 72
	sbic 0x10,4
	rjmp L39
	.dbline 72
	.dbline 72
	lds R24,_sec
	subi R24,255    ; addi 1
	sts _sec,R24
	.dbline 72
	ldi R24,59
	lds R2,_sec
	cp R24,R2
	brsh L41
	.dbline 72
	clr R2
	sts _sec,R2
L41:
	.dbline 72
;  if(S1==0){sec++;if(sec>59)sec=0;}
L39:
	.dbline 73
	sbic 0x10,5
	rjmp L43
	.dbline 73
	.dbline 73
	lds R24,_min
	subi R24,255    ; addi 1
	sts _min,R24
	.dbline 73
	ldi R24,59
	lds R2,_min
	cp R24,R2
	brsh L45
	.dbline 73
	clr R2
	sts _min,R2
L45:
	.dbline 73
;  if(S2==0){min++;if(min>59)min=0;}
L43:
	.dbline 74
	sbic 0x10,6
	rjmp L47
	.dbline 74
	.dbline 74
	lds R24,_set_sec
	subi R24,255    ; addi 1
	sts _set_sec,R24
	.dbline 74
	ldi R24,59
	lds R2,_set_sec
	cp R24,R2
	brsh L49
	.dbline 74
	clr R2
	sts _set_sec,R2
L49:
	.dbline 74
;  if(S3==0){set_sec++;if(set_sec>59)set_sec=0;} 
L47:
	.dbline 75
	sbic 0x10,7
	rjmp L51
	.dbline 75
	.dbline 75
	lds R24,_set_min
	subi R24,255    ; addi 1
	sts _set_min,R24
	.dbline 75
	ldi R24,59
	lds R2,_set_min
	cp R24,R2
	brsh L53
	.dbline 75
	clr R2
	sts _set_min,R2
L53:
	.dbline 75
;  if(S4==0){set_min++;if(set_min>59)set_min=0;} 
L51:
	.dbline 76
;  if(SINT0==0){time_flag=1;} 
	sbic 0x10,2
	rjmp L55
	.dbline 76
	.dbline 76
	ldi R24,1
	sts _time_flag,R24
	.dbline 76
L55:
	.dbline 77
;  if(SINT1==0){write_flag=1;}
	sbic 0x10,3
	rjmp L57
	.dbline 77
	.dbline 77
	ldi R24,1
	sts _write_flag,R24
	.dbline 77
L57:
	.dbline 78
L37:
	.dbline -2
L4:
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
	ld R3,y+
	ld R2,y+
	.dbline 0 ; func end
	reti
	.dbend
	.dbfunc e delay _delay fV
;              i -> R20,R21
;              j -> R22,R23
;              k -> R16,R17
	.even
_delay::
	xcall push_gset2
	.dbline -1
	.dbline 82
;  }
; }
; /***********************/
; void delay(uint k)	
; {
	.dbline 84
; uint i,j;
; 	 for(i=0;i<k;i++)
	clr R20
	clr R21
	xjmp L63
L60:
	.dbline 85
; 	 {	 
	.dbline 86
	clr R22
	clr R23
	xjmp L67
L64:
	.dbline 86
L65:
	.dbline 86
	subi R22,255  ; offset = 1
	sbci R23,255
L67:
	.dbline 86
	cpi R22,140
	ldi R30,0
	cpc R23,R30
	brlo L64
	.dbline 87
L61:
	.dbline 84
	subi R20,255  ; offset = 1
	sbci R21,255
L63:
	.dbline 84
	cp R20,R16
	cpc R21,R17
	brlo L60
	.dbline -2
L59:
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
	sbiw R28,2
	.dbline -1
	.dbline 91
; 	 for(j=0;j<140;j++); 
; 	 }
; }
; /***********************/
; void main(void)	
; {	 					
	.dbline 92
; init_devices();		
	xcall _init_devices
	xjmp L70
L69:
	.dbline 94
;   while(1)			
;   {						
	.dbline 95
;    		if(write_flag==1) 
	lds R24,_write_flag
	cpi R24,1
	brne L72
	.dbline 96
; 		{SREG=0x00;	
	.dbline 96
	clr R2
	out 0x3f,R2
	.dbline 97
; 		EEPROM_WRITE(200,set_sec);delay(10); 
	ldi R24,1
	ldi R25,0
	std y+1,R25
	std y+0,R24
	ldi R18,<_set_sec
	ldi R19,>_set_sec
	ldi R16,200
	ldi R17,0
	xcall _EEPROMWriteBytes
	.dbline 97
	ldi R16,10
	ldi R17,0
	xcall _delay
	.dbline 98
; 		EEPROM_WRITE(201,set_min);delay(10); 
	ldi R24,1
	ldi R25,0
	std y+1,R25
	std y+0,R24
	ldi R18,<_set_min
	ldi R19,>_set_min
	ldi R16,201
	ldi R17,0
	xcall _EEPROMWriteBytes
	.dbline 98
	ldi R16,10
	ldi R17,0
	xcall _delay
	.dbline 99
; 		write_flag=0;	
	clr R2
	sts _write_flag,R2
	.dbline 100
; 		dpw=1;			
	ldi R24,1
	sts _dpw,R24
	.dbline 101
; 		SREG|=0x80;
	bset 7
	.dbline 102
; 		}
L72:
	.dbline 103
; 		if(time_flag==1)
	lds R24,_time_flag
	cpi R24,1
	brne L74
	.dbline 104
; 		{SREG=0x00;		
	.dbline 104
	clr R2
	out 0x3f,R2
	.dbline 105
; 		EEPROM_READ(200,set_sec);delay(10);
	ldi R24,1
	ldi R25,0
	std y+1,R25
	std y+0,R24
	ldi R18,<_set_sec
	ldi R19,>_set_sec
	ldi R16,200
	ldi R17,0
	xcall _EEPROMReadBytes
	.dbline 105
	ldi R16,10
	ldi R17,0
	xcall _delay
	.dbline 106
; 		EEPROM_READ(201,set_min);delay(10); 
	ldi R24,1
	ldi R25,0
	std y+1,R25
	std y+0,R24
	ldi R18,<_set_min
	ldi R19,>_set_min
	ldi R16,201
	ldi R17,0
	xcall _EEPROMReadBytes
	.dbline 106
	ldi R16,10
	ldi R17,0
	xcall _delay
	.dbline 107
; 		SREG|=0x80;	
	bset 7
	.dbline 108
; 		dpt=1;		
	ldi R24,1
	sts _dpt,R24
	.dbline 109
; 		time_flag=0;
	clr R2
	sts _time_flag,R2
	.dbline 110
; 		}
L74:
	.dbline 111
; 		if(dpt==1)	
	lds R24,_dpt
	cpi R24,1
	brne L76
	.dbline 112
; 		{
	.dbline 113
; 		if((sec==set_sec)&&(min==set_min))LED1_0;
	lds R2,_set_sec
	lds R3,_sec
	cp R3,R2
	brne L78
	lds R2,_set_min
	lds R3,_min
	cp R3,R2
	brne L78
	.dbline 113
	in R24,0x18
	andi R24,254
	out 0x18,R24
L78:
	.dbline 114
; 		}
L76:
	.dbline 115
L70:
	.dbline 93
	xjmp L69
X12:
	.dbline -2
L68:
	adiw R28,2
	.dbline 0 ; func end
	ret
	.dbend
	.area bss(ram, con, rel)
	.dbfile d:\MYDOCU~1\ac11-3\ac11-3.c
_set_min::
	.blkb 1
	.dbsym e set_min _set_min c
_set_sec::
	.blkb 1
	.dbsym e set_sec _set_sec c
_min::
	.blkb 1
	.dbsym e min _min c
_sec::
	.blkb 1
	.dbsym e sec _sec c
_ms_cnt::
	.blkb 2
	.dbsym e ms_cnt _ms_cnt i
_key_cnt::
	.blkb 2
	.dbsym e key_cnt _key_cnt i
_cnt::
	.blkb 1
	.dbsym e cnt _cnt c
_time_flag::
	.blkb 1
	.dbsym e time_flag _time_flag c
_write_flag::
	.blkb 1
	.dbsym e write_flag _write_flag c
_dpt::
	.blkb 1
	.dbsym e dpt _dpt c
_dpw::
	.blkb 1
	.dbsym e dpw _dpw c
