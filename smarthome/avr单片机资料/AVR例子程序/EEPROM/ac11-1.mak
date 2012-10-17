CC = iccavr
CFLAGS =  -IC:\icc\include\ -e -DATMEGA -DATMega16  -l -A -A -g -Mavr_enhanced 
ASFLAGS = $(CFLAGS)  -Wa-g
LFLAGS =  -LC:\icc\lib\ -g -ucrtatmega.o -bfunc_lit:0x54.0x4000 -dram_end:0x45f -bdata:0x60.0x45f -dhwstk_size:16 -beeprom:1.512 -fihx_coff -S2
FILES = ac11-1.o 

ac11-1:	$(FILES)
	$(CC) -o ac11-1 $(LFLAGS) @ac11-1.lk   -lcatmega
ac11-1.o: C:/icc/include/iom16v.h
ac11-1.o:	d:\MYDOCU~1\ac11-1\ac11-1.c
	$(CC) -c $(CFLAGS) d:\MYDOCU~1\ac11-1\ac11-1.c
