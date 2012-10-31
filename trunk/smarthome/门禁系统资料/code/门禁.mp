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
                            text   023E   1072 =   4210. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       011F  __start
       011F  __text_start
       013E  _exit
       013F  _uart0_init
       014B  _port_init
       014C  _main
       015D  _init_interrupt
       01DC  _int0_isr
       01F7  _int1_isr
       0212  _delay_ms
       0225  _tips_port_init
       022C  _tips_led_on
       0230  _tips_led_off
       0232  _tips_beep_on
       0236  _tips_beep_off
       0238  _tips_ok
       0241  _tips_err
       025B  _tips_id_ok
       0271  _tips_ring_on
       027D  _readPasswordItemNum
       027F  _readPasswordItem
       02A9  _insertPasswordItem
       02AB  _deletePasswordItem
       02D2  _password_handle
       0406  _timer_init
       0415  _set_timer
       0435  _stop_timer
       044B  _timer0_isr
       04A3  _log
       04A4  _locker_init
       04A5  _locker_unlock
       04A6  _locker_lock
       04A7  _ringandscreen_init
       04B2  _screen_on
       04C5  _screen_off
       04C7  _ring_on
       04D1  _ring_screen_timeout
       04D8  _door_minitor_timeout
       04E4  _input_isr
       0508  __print
       0649  _strcpy
       0652  push_arg4
       0654  push_arg2
       0655  mod16s
       0659  div16s
       066E  mod16u
       0670  div16u
       0671  xdiv16u
       068A  empy32s
       068A  empy32u
       06B6  pop_gset2
       06B8  pop_gset3
       06BA  pop_gset4
       06BC  pop_gset5
       06BE  push_gset5
       06C0  push_gset4
       06C2  push_gset3
       06C4  push_gset2
       06C6  push_gset1
       06C9  pop_gset1
       06CA  pop
       06DD  xicall
       06E6  long_prolog
       06F4  long_epilog
       06FF  tstzero1
       0705  tstzero2
       070B  push_lset
       071E  pop_lset
       0735  asgnblk
       074D  _putchar
       0762  __va_start
       076B  _itoa
       07AB  _utoa
       07DA  _islower
       07E8  _toupper
       07FC  _printf
       0815  <created procedures>
       0958  __text_end

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

