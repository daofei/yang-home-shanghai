NOTE: AVR Code addresses are word addresses
All other addresses (including ones in FLASH) are byte addresses

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                        func_lit   0054   000A =     10. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0054  __func_lit_start
       005E  __func_lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             lit   005E   0004 =      4. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       005E  __lit_start
       0062  __lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                           idata   0062   0013 =     19. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0062  __idata_start
       0075  __idata_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   0076   119A =   4506. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       003B  __text_start
       003B  __start
       005A  _exit
       005B  _main
       00E7  _init_interrupt
       016F  _int0_isr
       018D  _int1_isr
       01A9  _delay_1ms
       01B2  _delay_ms
       01BF  _tips_port_init
       01C6  _tips_led_on
       01CA  _tips_led_off
       01CC  _tips_beep_on
       01D0  _tips_beep_off
       01D2  _tips_ok
       01DB  _tips_err
       01F5  _tips_id_ok
       020B  _tips_ring_on
       0217  _readPasswordItemNum
       0222  _readPasswordItem
       0256  _insertPasswordItem
       027B  _writePasswordItemNum
       02AB  _password_handle
       03F5  _timer_init
       0404  _set_timer
       0424  _stop_timer
       043A  _timer0_isr
       0492  _log
       0493  _locker_init
       0494  _locker_unlock
       0495  _locker_lock
       0496  _ringandscreen_init
       04A1  _screen_on
       04B4  _screen_off
       04B6  _ring_on
       04C0  _ring_screen_timeout
       04C7  _door_minitor_timeout
       04D8  _input_isr
       04F6  _check_door
       04FE  _at24c256_init
       0505  _rw24c256
       0568  _rw24c256Int
       067B  _uart0_init
       0687  push_arg4
       0689  push_arg2
       068A  empy32u
       068A  empy32s
       06B6  pop_gset2
       06B8  pop_gset3
       06BA  pop_gset5
       06BC  push_gset5
       06BE  push_gset4
       06C0  push_gset3
       06C2  push_gset2
       06C4  push_gset1
       06C7  pop_gset1
       06C8  pop
       06DB  xicall
       06E4  long_prolog
       06F2  long_epilog
       06FD  tstzero1
       0703  tstzero2
       0709  push_lset
       071C  pop_lset
       0733  lsl32
       073F  lsr32
       074B  asgncblk
       0764  asgnblk
       077C  <created procedures>
       0908  __text_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            data   0060   0013 =     19. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0060  __data_start
       0073  __data_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             bss   0073   0010 =     16. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0073  __bss_start
       0083  __bss_end

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
<library>	[ asave.s, emul32.s, gpop2.s, gpop3.s, gpop5.s, gpush.s, icall.s, longutil.s, lpush.s, lsl32.s, lsr32.s ]
[ pmstruct.s, struct.s ]

User Global Definitions

ram_end = 0x45f
hwstk_size = 0x10

User Base Address Definitions

func_lit = 0x54
data = 0x60
eeprom:1.512

