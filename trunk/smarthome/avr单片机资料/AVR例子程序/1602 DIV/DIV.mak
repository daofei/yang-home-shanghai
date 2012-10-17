CC = iccavr
CFLAGS =  -IF:\AVR例子程序\1602DI~1 -IE:\icc\include -e -DATMEGA -DATMega16  -l -g -Mavr_enhanced 
ASFLAGS = $(CFLAGS)  -Wa-g
LFLAGS =  -LE:\icc\lib -g -ucrtatmega.o -bfunc_lit:0x54.0x4000 -dram_end:0x45f -bdata:0x60.0x45f -dhwstk_size:16 -beeprom:1.512 -fihx_coff -S2
FILES = DIV.o 

DIV:	$(FILES)
	$(CC) -o DIV $(LFLAGS) @DIV.lk   -lcatmega
DIV.o: E:/icc/include/iom16v.h E:/icc/include/macros.h E:/icc/include/eeprom.h
DIV.o:	F:\AVR例子程序\1602DI~1\DIV.c
	$(CC) -c $(CFLAGS) F:\AVR例子程序\1602DI~1\DIV.c
