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
                            text   023E   145E =   5214. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       011F  __text_start
       011F  __start
       013E  _exit
       013F  _main
       0182  _init_interrupt
       020A  _int0_isr
       0227  _int1_isr
       0244  _delay_1ms
       024D  _delay_ms
       025C  _tips_port_init
       0263  _tips_led_on
       0267  _tips_led_off
       0269  _tips_beep_on
       026D  _tips_beep_off
       026F  _tips_ok
       0278  _tips_err
       0292  _tips_id_ok
       02A8  _tips_ring_on
       02B4  _readPasswordItemNum
       02BF  _readPasswordItem
       0301  _insertPasswordItem
       033B  _writePasswordItemNum
       0369  _password_handle
       0498  _timer_init
       04A7  _set_timer
       04C7  _stop_timer
       04DD  _timer0_isr
       0535  _log
       0536  _locker_init
       0537  _locker_unlock
       0538  _locker_lock
       0539  _ringandscreen_init
       0544  _screen_on
       0557  _screen_off
       0559  _ring_on
       0563  _ring_screen_timeout
       056A  _door_minitor_timeout
       057B  _input_isr
       0599  _check_door
       05A1  _at24c256_init
       05BD  _rw24c256
       06A0  _uart0_init
       06AC  __print
       07ED  _strcpy
       07F6  push_arg4
       07F8  push_arg2
       07F9  mod16s
       07FD  div16s
       0812  mod16u
       0814  div16u
       0815  xdiv16u
       082E  empy32s
       082E  empy32u
       085A  pop_gset2
       085C  pop_gset3
       085E  pop_gset4
       0860  pop_gset5
       0862  push_gset5
       0864  push_gset4
       0866  push_gset3
       0868  push_gset2
       086A  push_gset1
       086D  pop_gset1
       086E  pop
       0881  xicall
       088A  long_prolog
       0898  long_epilog
       08A3  tstzero1
       08A9  tstzero2
       08AF  push_lset
       08C2  pop_lset
       08D9  asgnblk
       08F1  _putchar
       0906  __va_start
       090F  _itoa
       094F  _utoa
       097E  _islower
       098C  _toupper
       09A0  _printf
       09B9  <created procedures>
       0B4E  __text_end

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
main.o	[ main.c ]
wg26.o	[ wg26.c ]
util.o	[ util.c ]
tips.o	[ tips.c ]
password.o	[ password.c ]
timer.o	[ timer.c ]
log.o	[ log.c ]
locker.o	[ locker.c ]
ringandscreen.o	[ ringandscreen.c ]
eeprom.o	[ eeprom.c ]
uart.o	[ uart.c ]
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

