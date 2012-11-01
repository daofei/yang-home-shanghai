NOTE: AVR Code addresses are word addresses
All other addresses (including ones in FLASH) are byte addresses

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                        func_lit   0054   000C =     12. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0054  __func_lit_start
       0060  __func_lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             lit   0060   0101 =    257. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0060  __lit_start
       0060  __ctype
       0161  __lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                           idata   0161   00DD =    221. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0161  __idata_start
       023E  __idata_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   023E   109A =   4250. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       011F  __start
       011F  __text_start
       013E  _exit
       013F  _uart0_init
       014B  _port_init
       014C  _main
       0172  _init_interrupt
       01F1  _int0_isr
       020C  _int1_isr
       0227  _delay_ms
       023A  _tips_port_init
       0241  _tips_led_on
       0245  _tips_led_off
       0247  _tips_beep_on
       024B  _tips_beep_off
       024D  _tips_ok
       0256  _tips_err
       0270  _tips_id_ok
       0286  _tips_ring_on
       0292  _readPasswordItemNum
       0294  _readPasswordItem
       02BE  _insertPasswordItem
       02C0  _deletePasswordItem
       02E5  _password_handle
       0417  _timer_init
       0426  _set_timer
       0446  _stop_timer
       045C  _timer0_isr
       04B4  _log
       04B5  _locker_init
       04B6  _locker_unlock
       04B7  _locker_lock
       04B8  _ringandscreen_init
       04C3  _screen_on
       04D6  _screen_off
       04D8  _ring_on
       04E2  _ring_screen_timeout
       04E9  _door_minitor_timeout
       04FA  _input_isr
       0518  _check_door
       0520  __print
       0661  _strcpy
       066A  push_arg4
       066C  push_arg2
       066D  mod16s
       0671  div16s
       0686  mod16u
       0688  div16u
       0689  xdiv16u
       06A2  empy32s
       06A2  empy32u
       06CE  pop_gset2
       06D0  pop_gset3
       06D2  pop_gset4
       06D4  pop_gset5
       06D6  push_gset5
       06D8  push_gset4
       06DA  push_gset3
       06DC  push_gset2
       06DE  push_gset1
       06E1  pop_gset1
       06E2  pop
       06F5  xicall
       06FE  long_prolog
       070C  long_epilog
       0717  tstzero1
       071D  tstzero2
       0723  push_lset
       0736  pop_lset
       074D  asgnblk
       0765  _putchar
       077A  __va_start
       0783  _itoa
       07C3  _utoa
       07F2  _islower
       0800  _toupper
       0814  _printf
       082D  <created procedures>
       096C  __text_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            data   0060   00DD =    221. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0060  __data_start
       013D  __data_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             bss   013D   002B =     43. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       013D  __bss_start
       0166  __textmode
       0168  __bss_end

Area                               Start  End    Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                          vector   0000   0028 =     40. bytes (abs,ovr,rom)

Files Linked      [ module(s) ]

C:\icc\lib\crtatmega.o	[ crtatmega.s ]
uart.o	[ uart.c ]
init.o	[ init.c ]
main.o	[ main.c ]
wg26.o	[ wg26.c ]
util.o	[ util.c ]
tips.o	[ tips.c ]
password.o	[ password.c ]
timer.o	[ timer.c ]
log.o	[ log.c ]
locker.o	[ locker.c ]
ringandscreen.o	[ ringandscreen.c ]
iic.o	[ iic.c ]
<library>	[ _printf.s, strcpy.s, asave.s, div16s.s, div16u.s, emul32.s, gpop2.s, gpop3.s, gpop4.s, gpop5.s, gpush.s ]
[ icall.s, longutil.s, lpush.s, struct.s, putchar.s, stdarg.s, itoa.s, utoa.s, islower.s, ctype.s, toupper.s ]
[ printf.s, textmode.s ]

User Global Definitions

ram_end = 0x45f
hwstk_size = 0x10

User Base Address Definitions

func_lit = 0x54
data = 0x60
eeprom:1.512

