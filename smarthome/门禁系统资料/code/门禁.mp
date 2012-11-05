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
                            text   023E   12B0 =   4784. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       011F  __text_start
       011F  __start
       013E  _exit
       013F  _uart0_init
       014B  _port_init
       014C  _main
       0172  _init_interrupt
       01FA  _int0_isr
       0216  _int1_isr
       0232  _delay_1ms
       023B  _delay_ms
       0248  _tips_port_init
       024F  _tips_led_on
       0253  _tips_led_off
       0255  _tips_beep_on
       0259  _tips_beep_off
       025B  _tips_ok
       0264  _tips_err
       027E  _tips_id_ok
       0294  _tips_ring_on
       02A0  _readPasswordItemNum
       02A2  _readPasswordItem
       02CC  _insertPasswordItem
       02CE  _deletePasswordItem
       02F3  _password_handle
       041E  _timer_init
       042D  _set_timer
       044D  _stop_timer
       0463  _timer0_isr
       04BE  _log
       04BF  _locker_init
       04C0  _locker_unlock
       04C1  _locker_lock
       04C2  _ringandscreen_init
       04CD  _screen_on
       04E0  _screen_off
       04E2  _ring_on
       04EC  _ring_screen_timeout
       04F3  _door_minitor_timeout
       0504  _input_isr
       0522  _check_door
       052A  _at24c256_init
       0531  _rw24c256
       0617  __print
       0758  _strcpy
       0761  push_arg4
       0763  push_arg2
       0764  mod16s
       0768  div16s
       077D  mod16u
       077F  div16u
       0780  xdiv16u
       0799  empy32u
       0799  empy32s
       07C5  pop_gset2
       07C7  pop_gset3
       07C9  pop_gset4
       07CB  pop_gset5
       07CD  push_gset5
       07CF  push_gset4
       07D1  push_gset3
       07D3  push_gset2
       07D5  push_gset1
       07D8  pop_gset1
       07D9  pop
       07EC  xicall
       07F5  long_prolog
       0803  long_epilog
       080E  tstzero1
       0814  tstzero2
       081A  push_lset
       082D  pop_lset
       0844  asgnblk
       085C  _putchar
       0871  __va_start
       087A  _itoa
       08BA  _utoa
       08E9  _islower
       08F7  _toupper
       090B  _printf
       0924  <created procedures>
       0A77  __text_end

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
eeprom.o	[ eeprom.c ]
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

