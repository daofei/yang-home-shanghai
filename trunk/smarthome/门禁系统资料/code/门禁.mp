NOTE: AVR Code addresses are word addresses
All other addresses (including ones in FLASH) are byte addresses

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                        func_lit   0054   0008 =      8. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0054  __func_lit_start
       005C  __func_lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             lit   005C   0101 =    257. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       005C  __lit_start
       005C  __ctype
       015D  __lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                           idata   015D   0110 =    272. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       015D  __idata_start
       026D  __idata_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   026E   0EE2 =   3810. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0137  __start
       0137  __text_start
       0156  _exit
       0157  _uart0_init
       0163  _port_init
       0164  _main
       0177  _init_interrupt
       01F4  _int0_isr
       020F  _int1_isr
       022A  _delay_ms
       023D  _tips_port_init
       0244  _tips_led_on
       0248  _tips_led_off
       024A  _tips_beep_on
       024E  _tips_beep_off
       0250  _tips_ok
       025C  _tips_err
       0276  _tips_id_ok
       028C  _readPasswordItemNum
       028E  _readPasswordItem
       029D  _insertPasswordItem
       029F  _deletePasswordItem
       02C2  _password_handle
       03F4  _timer_init
       0403  _set_timer
       0423  _stop_timer
       043A  _timer0_isr
       0496  _log
       0497  _locker_init
       0498  _locker_unlock
       0499  _locker_lock
       049A  __print
       05DB  _strcpy
       05E4  push_arg4
       05E6  push_arg2
       05E7  mod16s
       05EB  div16s
       0600  mod16u
       0602  div16u
       0603  xdiv16u
       061C  empy32u
       061C  empy32s
       0648  pop_gset2
       064A  pop_gset3
       064C  pop_gset4
       064E  pop_gset5
       0650  push_gset5
       0652  push_gset4
       0654  push_gset3
       0656  push_gset2
       0658  push_gset1
       065B  pop_gset1
       065C  pop
       066F  xicall
       0678  long_prolog
       0686  long_epilog
       0691  tstzero1
       0697  tstzero2
       069D  push_lset
       06B0  pop_lset
       06C7  asgnblk
       06DF  _putchar
       06F4  __va_start
       06FD  _itoa
       073C  _utoa
       076A  _islower
       0778  _toupper
       078C  _printf
       07A5  <created procedures>
       08A8  __text_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            data   0060   0110 =    272. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0060  __data_start
       0170  __data_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             bss   0170   002B =     43. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0170  __bss_start
       0199  __textmode
       019B  __bss_end

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

