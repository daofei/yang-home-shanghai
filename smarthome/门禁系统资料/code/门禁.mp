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
                           idata   015D   00DD =    221. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       015D  __idata_start
       023A  __idata_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   023A   0F84 =   3972. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       011D  __start
       011D  __text_start
       013C  _exit
       013D  _uart0_init
       0149  _port_init
       014A  _main
       015B  _init_interrupt
       01DA  _int0_isr
       01F5  _int1_isr
       0210  _delay_ms
       0223  _tips_port_init
       022A  _tips_led_on
       022E  _tips_led_off
       0230  _tips_beep_on
       0234  _tips_beep_off
       0236  _tips_ok
       0242  _tips_err
       025C  _tips_id_ok
       0272  _readPasswordItemNum
       0274  _readPasswordItem
       029E  _insertPasswordItem
       02A0  _deletePasswordItem
       02C7  _password_handle
       03FE  _timer_init
       040D  _set_timer
       042D  _stop_timer
       0444  _timer0_isr
       04A0  _log
       04A1  _locker_init
       04A2  _locker_unlock
       04A3  _locker_lock
       04A4  __print
       05E5  _strcpy
       05EE  push_arg4
       05F0  push_arg2
       05F1  mod16s
       05F5  div16s
       060A  mod16u
       060C  div16u
       060D  xdiv16u
       0626  empy32u
       0626  empy32s
       0652  pop_gset2
       0654  pop_gset3
       0656  pop_gset4
       0658  pop_gset5
       065A  push_gset5
       065C  push_gset4
       065E  push_gset3
       0660  push_gset2
       0662  push_gset1
       0665  pop_gset1
       0666  pop
       0679  xicall
       0682  long_prolog
       0690  long_epilog
       069B  tstzero1
       06A1  tstzero2
       06A7  push_lset
       06BA  pop_lset
       06D1  asgnblk
       06E9  _putchar
       06FE  __va_start
       0707  _itoa
       0747  _utoa
       0776  _islower
       0784  _toupper
       0798  _printf
       07B1  <created procedures>
       08DF  __text_end

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

