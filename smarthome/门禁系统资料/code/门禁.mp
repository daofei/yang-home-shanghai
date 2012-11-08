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
                             lit   0060   0105 =    261. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0060  __lit_start
       0064  __ctype
       0165  __lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                           idata   0165   00ED =    237. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0165  __idata_start
       0252  __idata_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   0252   14AC =   5292. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0129  __text_start
       0129  __start
       0148  _exit
       0149  _main
       01A8  _init_interrupt
       0230  _int0_isr
       024D  _int1_isr
       026A  _delay_1ms
       0273  _delay_ms
       0282  _tips_port_init
       0289  _tips_led_on
       028D  _tips_led_off
       028F  _tips_beep_on
       0293  _tips_beep_off
       0295  _tips_ok
       029E  _tips_err
       02B8  _tips_id_ok
       02CE  _tips_ring_on
       02DA  _readPasswordItemNum
       02E5  _readPasswordItem
       0327  _insertPasswordItem
       035F  _writePasswordItemNum
       038D  _password_handle
       04BC  _timer_init
       04CB  _set_timer
       04EB  _stop_timer
       0501  _timer0_isr
       0559  _log
       055A  _locker_init
       055B  _locker_unlock
       055C  _locker_lock
       055D  _ringandscreen_init
       0568  _screen_on
       057B  _screen_off
       057D  _ring_on
       0587  _ring_screen_timeout
       058E  _door_minitor_timeout
       059F  _input_isr
       05BD  _check_door
       05C5  _at24c256_init
       05CC  _rw24c256
       06B4  _uart0_init
       06C0  __print
       0801  _strcpy
       080A  push_arg4
       080C  push_arg2
       080D  mod16s
       0811  div16s
       0826  mod16u
       0828  div16u
       0829  xdiv16u
       0842  empy32s
       0842  empy32u
       086E  pop_gset2
       0870  pop_gset3
       0872  pop_gset4
       0874  pop_gset5
       0876  push_gset5
       0878  push_gset4
       087A  push_gset3
       087C  push_gset2
       087E  push_gset1
       0881  pop_gset1
       0882  pop
       0895  xicall
       089E  long_prolog
       08AC  long_epilog
       08B7  tstzero1
       08BD  tstzero2
       08C3  push_lset
       08D6  pop_lset
       08ED  asgncblk
       0906  asgnblk
       091E  _putchar
       0933  __va_start
       093C  _itoa
       097B  _utoa
       09A9  _islower
       09B7  _toupper
       09CB  _printf
       09E4  <created procedures>
       0B7F  __text_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            data   0060   00ED =    237. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0060  __data_start
       014D  __data_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             bss   014D   002B =     43. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       014D  __bss_start
       0176  __textmode
       0178  __bss_end

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
[ icall.s, longutil.s, lpush.s, pmstruct.s, struct.s, putchar.s, stdarg.s, itoa.s, utoa.s, islower.s ]
[ ctype.s, toupper.s, printf.s, textmode.s ]

User Global Definitions

ram_end = 0x45f
hwstk_size = 0x10

User Base Address Definitions

func_lit = 0x54
data = 0x60
eeprom:1.512

