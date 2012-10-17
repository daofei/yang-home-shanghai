CC = iccavr
CFLAGS =  -ID:\icc\include\ -IF:\AVRSYS~1 -e -DATMEGA -DATMega16  -l -g -Mavr_enhanced 
ASFLAGS = $(CFLAGS)  -Wa-g
LFLAGS =  -LD:\icc\lib\ -g -ucrtatmega.o -bfunc_lit:0x54.0x4000 -dram_end:0x45f -bdata:0x60.0x45f -dhwstk_size:16 -beeprom:1.512 -fihx_coff -S2
FILES = AVRSYS~1.o 

AVR:	$(FILES)
	$(CC) -o AVR $(LFLAGS) @AVR.lk   -lcatmega
AVRSYS~1.o: D:/icc/include/iom16v.h D:/icc/include/macros.h D:/icc/include/eeprom.h F:\AVRSYS~1/timee.h
AVRSYS~1.o:	F:\AVRSYS~1\AVRSYS~1.C
	$(CC) -c $(CFLAGS) F:\AVRSYS~1\AVRSYS~1.C
