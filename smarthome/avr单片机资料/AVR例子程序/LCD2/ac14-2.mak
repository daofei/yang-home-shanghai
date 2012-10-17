CC = iccavr
CFLAGS =  -IC:\icc\include\ -e -DATMEGA -DATMega16  -l -A -A -g -Mavr_enhanced 
ASFLAGS = $(CFLAGS)  -Wa-g
LFLAGS =  -LC:\icc\lib\ -g -ucrtatmega.o -bfunc_lit:0x54.0x4000 -dram_end:0x45f -bdata:0x60.0x45f -dhwstk_size:16 -beeprom:1.512 -fihx_coff -S2
FILES = ac14-2.o 

ac14-2:	$(FILES)
	$(CC) -o ac14-2 $(LFLAGS) @ac14-2.lk   -lcatmega
ac14-2.o: C:/icc/include/iom16v.h C:/icc/include/macros.h
ac14-2.o:	d:\MYDOCU~1\ac14-2\ac14-2.c
	$(CC) -c $(CFLAGS) d:\MYDOCU~1\ac14-2\ac14-2.c
