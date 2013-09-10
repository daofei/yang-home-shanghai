CC = iccavr
CFLAGS =  -IC:\icc\include\ -e -DATMEGA -DATMega16  -l -g -Mavr_enhanced 
ASFLAGS = $(CFLAGS)  -Wa-g
LFLAGS =  -O -LC:\icc\lib\ -g -ucrtatmega.o -bfunc_lit:0x54.0x4000 -dram_end:0x45f -bdata:0x60.0x45f -dhwstk_size:16 -beeprom:1.512 -fihx_coff -S2
FILES = util.o input.o log.o main.o output.o timer.o 

mcu2code:	$(FILES)
	$(CC) -o mcu2code $(LFLAGS) @mcu2code.lk   -lcatmega
util.o: D:\smarthome\smarthome\门禁系统资料\code\mcu2code/util.h
util.o:	D:\smarthome\smarthome\门禁系统资料\code\mcu2code\util.c
	$(CC) -c $(CFLAGS) D:\smarthome\smarthome\门禁系统资料\code\mcu2code\util.c
input.o: C:/icc/include/iom16v.h C:/icc/include/macros.h D:\smarthome\smarthome\门禁系统资料\code\mcu2code/output.h D:\smarthome\smarthome\门禁系统资料\code\mcu2code/util.h D:\smarthome\smarthome\门禁系统资料\code\mcu2code/input.h
input.o:	D:\smarthome\smarthome\门禁系统资料\code\mcu2code\input.c
	$(CC) -c $(CFLAGS) D:\smarthome\smarthome\门禁系统资料\code\mcu2code\input.c
log.o: C:/icc/include/iom16v.h D:\smarthome\smarthome\门禁系统资料\code\mcu2code/log.h
log.o:	D:\smarthome\smarthome\门禁系统资料\code\mcu2code\log.c
	$(CC) -c $(CFLAGS) D:\smarthome\smarthome\门禁系统资料\code\mcu2code\log.c
main.o: C:/icc/include/iom16v.h C:/icc/include/macros.h D:\smarthome\smarthome\门禁系统资料\code\mcu2code/output.h D:\smarthome\smarthome\门禁系统资料\code\mcu2code/input.h D:\smarthome\smarthome\门禁系统资料\code\mcu2code/timer.h\
 D:\smarthome\smarthome\门禁系统资料\code\mcu2code/util.h
main.o:	D:\smarthome\smarthome\门禁系统资料\code\mcu2code\main.c
	$(CC) -c $(CFLAGS) D:\smarthome\smarthome\门禁系统资料\code\mcu2code\main.c
output.o: C:/icc/include/iom16v.h C:/icc/include/macros.h D:\smarthome\smarthome\门禁系统资料\code\mcu2code/output.h D:\smarthome\smarthome\门禁系统资料\code\mcu2code/util.h D:\smarthome\smarthome\门禁系统资料\code\mcu2code/input.h\
 D:\smarthome\smarthome\门禁系统资料\code\mcu2code/timer.h
output.o:	D:\smarthome\smarthome\门禁系统资料\code\mcu2code\output.c
	$(CC) -c $(CFLAGS) D:\smarthome\smarthome\门禁系统资料\code\mcu2code\output.c
timer.o: C:/icc/include/iom16v.h C:/icc/include/macros.h D:\smarthome\smarthome\门禁系统资料\code\mcu2code/timer.h
timer.o:	D:\smarthome\smarthome\门禁系统资料\code\mcu2code\timer.c
	$(CC) -c $(CFLAGS) D:\smarthome\smarthome\门禁系统资料\code\mcu2code\timer.c
