NOTE: AVR Code addresses are word addresses
All other addresses (including ones in FLASH) are byte addresses

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                        func_lit   0054   0004 =      4. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0054  __func_lit_start
       0058  __func_lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             lit   0058   0101 =    257. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0058  __lit_start
       0058  __ctype
       0159  __lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                           idata   0159   010F =    271. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0159  __idata_start
       0268  __idata_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   0268   0E6A =   3690. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0134  __start
       0134  __text_start
       0153  _exit
       0154  _uart0_init
       0160  _port_init
       0161  _main
       0174  _init_interrupt
       01F1  _int0_isr
       020C  _int1_isr
       0227  _delay_ms
       023A  _tips_port_init
       0241  _tips_led_on
       0245  _tips_led_off
       0247  _tips_beep_on
       024B  _tips_beep_off
       024D  _tips_ok
       0259  _tips_err
       0273  _tips_id_ok
       0289  _readPasswordItemNum
       028B  _readPasswordItem
       029A  _insertPasswordItem
       029C  _deletePasswordItem
       02B0  _password_handle
       03BD  _timer_init
       03CC  _set_timer
       03EC  _stop_timer
       0403  _timer0_isr
       045F  _log
       0460  _locker_init
       0461  _locker_unlock
       0462  _locker_lock
       0463  __print
       05A4  _strcpy
       05AD  push_arg4
       05AF  push_arg2
       05B0  mod16s
       05B4  div16s
       05C9  mod16u
       05CB  div16u
       05CC  xdiv16u
       05E5  empy32u
       05E5  empy32s
       0611  pop_gset2
       0613  pop_gset3
       0615  pop_gset4
       0617  pop_gset5
       0619  push_gset5
       061B  push_gset4
       061D  push_gset3
       061F  push_gset2
       0621  push_gset1
       0624  pop_gset1
       0625  pop
       0638  xicall
       0641  long_prolog
       064F  long_epilog
       065A  tstzero1
       0660  tstzero2
       0666  push_lset
       0679  pop_lset
       0690  asgnblk
       06A8  _putchar
       06BD  __va_start
       06C6  _itoa
       0705  _utoa
       0733  _islower
       0741  _toupper
       0755  _printf
       076E  <created procedures>
       0869  __text_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            data   0060   010F =    271. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0060  __data_start
       016F  __data_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             bss   016F   0034 =     52. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       016F  __bss_start
       01A1  __textmode
       01A3  __bss_end

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

