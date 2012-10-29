CC = iccavr
CFLAGS =  -IC:\icc\include\ -e -DATMEGA -DATMega16  -l -g -Mavr_enhanced 
ASFLAGS = $(CFLAGS)  -Wa-g
LFLAGS =  -LC:\icc\lib\ -g -ucrtatmega.o -bfunc_lit:0x54.0x4000 -dram_end:0x45f -bdata:0x60.0x45f -dhwstk_size:16 -beeprom:1.512 -fihx_coff -S2
FILES = uart.o init.o main.o wg26.o util.o tips.o 

�Ž�:	$(FILES)
	$(CC) -o �Ž� $(LFLAGS) @�Ž�.lk   -lcatmega
uart.o: C:/icc/include/iom16v.h C:/icc/include/macros.h Z:\yang-home-shanghai\smarthome\�Ž�ϵͳ����\code/uart.h
uart.o:	Z:\yang-home-shanghai\smarthome\�Ž�ϵͳ����\code\uart.c
	$(CC) -c $(CFLAGS) Z:\yang-home-shanghai\smarthome\�Ž�ϵͳ����\code\uart.c
init.o: C:/icc/include/iom16v.h C:/icc/include/macros.h
init.o:	Z:\yang-home-shanghai\smarthome\�Ž�ϵͳ����\code\init.c
	$(CC) -c $(CFLAGS) Z:\yang-home-shanghai\smarthome\�Ž�ϵͳ����\code\init.c
main.o: C:/icc/include/stdio.h C:/icc/include/stdarg.h C:/icc/include/_const.h C:/icc/include/string.h C:/icc/include/_const.h C:/icc/include/stdlib.h C:/icc/include/_const.h C:/icc/include/limits.h C:/icc/include/string.h C:/icc/include/iom16v.h\
 C:/icc/include/macros.h Z:\yang-home-shanghai\smarthome\�Ž�ϵͳ����\code/init.h Z:\yang-home-shanghai\smarthome\�Ž�ϵͳ����\code/uart.h Z:\yang-home-shanghai\smarthome\�Ž�ϵͳ����\code/wg26.h\
 Z:\yang-home-shanghai\smarthome\�Ž�ϵͳ����\code/util.h Z:\yang-home-shanghai\smarthome\�Ž�ϵͳ����\code/tips.h
main.o:	Z:\yang-home-shanghai\smarthome\�Ž�ϵͳ����\code\main.c
	$(CC) -c $(CFLAGS) Z:\yang-home-shanghai\smarthome\�Ž�ϵͳ����\code\main.c
wg26.o: C:/icc/include/stdio.h C:/icc/include/stdarg.h C:/icc/include/_const.h C:/icc/include/stdlib.h C:/icc/include/_const.h C:/icc/include/limits.h C:/icc/include/string.h C:/icc/include/_const.h C:/icc/include/iom16v.h C:/icc/include/macros.h\
 Z:\yang-home-shanghai\smarthome\�Ž�ϵͳ����\code/uart.h
wg26.o:	Z:\yang-home-shanghai\smarthome\�Ž�ϵͳ����\code\wg26.c
	$(CC) -c $(CFLAGS) Z:\yang-home-shanghai\smarthome\�Ž�ϵͳ����\code\wg26.c
util.o: C:/icc/include/stdio.h C:/icc/include/stdarg.h C:/icc/include/_const.h C:/icc/include/string.h C:/icc/include/_const.h C:/icc/include/stdlib.h C:/icc/include/_const.h C:/icc/include/limits.h\
 Z:\yang-home-shanghai\smarthome\�Ž�ϵͳ����\code/util.h
util.o:	Z:\yang-home-shanghai\smarthome\�Ž�ϵͳ����\code\util.c
	$(CC) -c $(CFLAGS) Z:\yang-home-shanghai\smarthome\�Ž�ϵͳ����\code\util.c
tips.o: C:/icc/include/iom16v.h C:/icc/include/macros.h Z:\yang-home-shanghai\smarthome\�Ž�ϵͳ����\code/tips.h Z:\yang-home-shanghai\smarthome\�Ž�ϵͳ����\code/util.h
tips.o:	Z:\yang-home-shanghai\smarthome\�Ž�ϵͳ����\code\tips.c
	$(CC) -c $(CFLAGS) Z:\yang-home-shanghai\smarthome\�Ž�ϵͳ����\code\tips.c
