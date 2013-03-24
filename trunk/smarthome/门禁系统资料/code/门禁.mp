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
                             lit   005C   0004 =      4. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       005C  __lit_start
       0060  __lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                           idata   0060   0013 =     19. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0060  __idata_start
       0073  __idata_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   0074   10D2 =   4306. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       003A  __text_start
       003A  __start
       0059  _exit
       005A  _main
       00E3  _wg26_init_interrupt
       016B  _int0_isr
       0192  _delay_1ms
       019B  _delay_ms
       01A8  _tips_port_init
       01AF  _tips_led_on
       01B3  _tips_led_off
       01B5  _tips_beep_on
       01B9  _tips_beep_off
       01BB  _tips_ok
       01C4  _tips_err
       01DE  _tips_id_ok
       01F6  _tips_ring_on
       0200  _readPasswordItemNum
       020B  _readPasswordItem
       023F  _insertPasswordItem
       0264  _writePasswordItemNum
       0294  _password_handle
       03C9  _timer_init
       03D8  _set_timer
       03F8  _stop_timer
       040E  _timer0_isr
       0469  _log
       046A  _locker_init
       0481  _locker_unlock
       0496  _doorandscreen_init
       049D  _screen_on
       04A5  _check_door
       04A8  _at24c256_init
       04AF  _rw24c256
       0512  _rw24c256Int
       0625  _uart0_init
       0631  push_arg4
       0633  push_arg2
       0634  empy32u
       0634  empy32s
       0660  pop_gset2
       0662  pop_gset3
       0664  pop_gset5
       0666  push_gset5
       0668  push_gset4
       066A  push_gset3
       066C  push_gset2
       066E  push_gset1
       0671  pop_gset1
       0672  pop
       0685  xicall
       068E  long_prolog
       069C  long_epilog
       06A7  tstzero1
       06AD  tstzero2
       06B3  push_lset
       06C6  pop_lset
       06DD  lsl32
       06E9  lsr32
       06F5  asgncblk
       070E  asgnblk
       0726  <created procedures>
       08A3  __text_end

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

