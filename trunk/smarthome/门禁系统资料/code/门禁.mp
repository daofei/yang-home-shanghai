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
                            text   0076   118A =   4490. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       003B  __text_start
       003B  __start
       005A  _exit
       005B  _main
       00F3  _init_interrupt
       017B  _int0_isr
       0199  _int1_isr
       01B5  _delay_1ms
       01BE  _delay_ms
       01CB  _tips_port_init
       01D2  _tips_led_on
       01D6  _tips_led_off
       01D8  _tips_beep_on
       01DC  _tips_beep_off
       01DE  _tips_ok
       01E7  _tips_err
       0201  _tips_id_ok
       0217  _tips_ring_on
       0223  _readPasswordItemNum
       022E  _readPasswordItem
       0262  _insertPasswordItem
       0287  _writePasswordItemNum
       02B7  _password_handle
       03E8  _timer_init
       03F7  _set_timer
       0417  _stop_timer
       042D  _timer0_isr
       0485  _log
       0486  _locker_init
       0487  _locker_unlock
       0488  _locker_lock
       0489  _ringandscreen_init
       0494  _screen_on
       04A7  _screen_off
       04A9  _ring_on
       04B3  _ring_screen_timeout
       04BA  _door_minitor_timeout
       04CB  _input_isr
       04E9  _check_door
       04F1  _at24c256_init
       04F8  _rw24c256
       055B  _rw24c256Int
       066E  _uart0_init
       067A  push_arg4
       067C  push_arg2
       067D  empy32u
       067D  empy32s
       06A9  pop_gset2
       06AB  pop_gset3
       06AD  pop_gset5
       06AF  push_gset5
       06B1  push_gset4
       06B3  push_gset3
       06B5  push_gset2
       06B7  push_gset1
       06BA  pop_gset1
       06BB  pop
       06CE  xicall
       06D7  long_prolog
       06E5  long_epilog
       06F0  tstzero1
       06F6  tstzero2
       06FC  push_lset
       070F  pop_lset
       0726  lsl32
       0732  lsr32
       073E  asgncblk
       0757  asgnblk
       076F  <created procedures>
       0900  __text_end

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

