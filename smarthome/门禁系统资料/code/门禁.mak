CC = iccavr
CFLAGS =  -IC:\icc\include\ -e -DATMEGA -DATMega16  -l -g -Mavr_enhanced 
ASFLAGS = $(CFLAGS)  -Wa-g
LFLAGS =  -O -LC:\icc\lib\ -g -ucrtatmega.o -bfunc_lit:0x54.0x4000 -dram_end:0x45f -bdata:0x60.0x45f -dhwstk_size:16 -beeprom:1.512 -fihx_coff -S2
FILES = uart.o init.o main.o wg26.o util.o tips.o password.o timer.o log.o locker.o 

门禁:	$(FILES)
	$(CC) -o 门禁 $(LFLAGS) @门禁.lk   -lcatmega
uart.o: C:/icc/include/iom16v.h C:/icc/include/macros.h Z:\yang-home-shanghai\smarthome\门禁系统资料\code/uart.h
uart.o:	Z:\yang-home-shanghai\smarthome\门禁系统资料\code\uart.c
	$(CC) -c $(CFLAGS) Z:\yang-home-shanghai\smarthome\门禁系统资料\code\uart.c
init.o: C:/icc/include/iom16v.h C:/icc/include/macros.h
init.o:	Z:\yang-home-shanghai\smarthome\门禁系统资料\code\init.c
	$(CC) -c $(CFLAGS) Z:\yang-home-shanghai\smarthome\门禁系统资料\code\init.c
main.o: C:/icc/include/stdio.h C:/icc/include/stdarg.h C:/icc/include/_const.h C:/icc/include/stdlib.h C:/icc/include/_const.h C:/icc/include/limits.h C:/icc/include/string.h C:/icc/include/_const.h C:/icc/include/iom16v.h C:/icc/include/macros.h\
 Z:\yang-home-shanghai\smarthome\门禁系统资料\code/init.h Z:\yang-home-shanghai\smarthome\门禁系统资料\code/uart.h Z:\yang-home-shanghai\smarthome\门禁系统资料\code/wg26.h Z:\yang-home-shanghai\smarthome\门禁系统资料\code/util.h\
 Z:\yang-home-shanghai\smarthome\门禁系统资料\code/tips.h Z:\yang-home-shanghai\smarthome\门禁系统资料\code/timer.h
main.o:	Z:\yang-home-shanghai\smarthome\门禁系统资料\code\main.c
	$(CC) -c $(CFLAGS) Z:\yang-home-shanghai\smarthome\门禁系统资料\code\main.c
wg26.o: C:/icc/include/iom16v.h Z:\yang-home-shanghai\smarthome\门禁系统资料\code/password.h Z:\yang-home-shanghai\smarthome\门禁系统资料\code/timer.h
wg26.o:	Z:\yang-home-shanghai\smarthome\门禁系统资料\code\wg26.c
	$(CC) -c $(CFLAGS) Z:\yang-home-shanghai\smarthome\门禁系统资料\code\wg26.c
util.o: C:/icc/include/stdio.h C:/icc/include/stdarg.h C:/icc/include/_const.h C:/icc/include/string.h C:/icc/include/_const.h C:/icc/include/stdlib.h C:/icc/include/_const.h C:/icc/include/limits.h\
 Z:\yang-home-shanghai\smarthome\门禁系统资料\code/util.h
util.o:	Z:\yang-home-shanghai\smarthome\门禁系统资料\code\util.c
	$(CC) -c $(CFLAGS) Z:\yang-home-shanghai\smarthome\门禁系统资料\code\util.c
tips.o: C:/icc/include/iom16v.h C:/icc/include/macros.h Z:\yang-home-shanghai\smarthome\门禁系统资料\code/tips.h Z:\yang-home-shanghai\smarthome\门禁系统资料\code/util.h
tips.o:	Z:\yang-home-shanghai\smarthome\门禁系统资料\code\tips.c
	$(CC) -c $(CFLAGS) Z:\yang-home-shanghai\smarthome\门禁系统资料\code\tips.c
password.o: C:/icc/include/stdio.h C:/icc/include/stdarg.h C:/icc/include/_const.h C:/icc/include/stdlib.h C:/icc/include/_const.h C:/icc/include/limits.h C:/icc/include/iom16v.h C:/icc/include/macros.h\
 Z:\yang-home-shanghai\smarthome\门禁系统资料\code/log.h Z:\yang-home-shanghai\smarthome\门禁系统资料\code/locker.h Z:\yang-home-shanghai\smarthome\门禁系统资料\code/tips.h Z:\yang-home-shanghai\smarthome\门禁系统资料\code/timer.h\
 Z:\yang-home-shanghai\smarthome\门禁系统资料\code/password.h
password.o:	Z:\yang-home-shanghai\smarthome\门禁系统资料\code\password.c
	$(CC) -c $(CFLAGS) Z:\yang-home-shanghai\smarthome\门禁系统资料\code\password.c
timer.o: C:/icc/include/stdio.h C:/icc/include/stdarg.h C:/icc/include/_const.h C:/icc/include/stdlib.h C:/icc/include/_const.h C:/icc/include/limits.h C:/icc/include/string.h C:/icc/include/_const.h C:/icc/include/iom16v.h C:/icc/include/macros.h\
 Z:\yang-home-shanghai\smarthome\门禁系统资料\code/timer.h
timer.o:	Z:\yang-home-shanghai\smarthome\门禁系统资料\code\timer.c
	$(CC) -c $(CFLAGS) Z:\yang-home-shanghai\smarthome\门禁系统资料\code\timer.c
log.o: C:/icc/include/iom16v.h Z:\yang-home-shanghai\smarthome\门禁系统资料\code/log.h
log.o:	Z:\yang-home-shanghai\smarthome\门禁系统资料\code\log.c
	$(CC) -c $(CFLAGS) Z:\yang-home-shanghai\smarthome\门禁系统资料\code\log.c
locker.o: C:/icc/include/iom16v.h Z:\yang-home-shanghai\smarthome\门禁系统资料\code/locker.h
locker.o:	Z:\yang-home-shanghai\smarthome\门禁系统资料\code\locker.c
	$(CC) -c $(CFLAGS) Z:\yang-home-shanghai\smarthome\门禁系统资料\code\locker.c
