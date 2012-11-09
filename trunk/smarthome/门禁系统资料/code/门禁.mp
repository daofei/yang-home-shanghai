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
                            text   0076   1192 =   4498. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       003B  __text_start
       003B  __start
       005A  _exit
       005B  _main
       00D1  _init_interrupt
       0159  _int0_isr
       0175  _int1_isr
       0191  _delay_1ms
       019A  _delay_ms
       01A7  _tips_port_init
       01AE  _tips_led_on
       01B2  _tips_led_off
       01B4  _tips_beep_on
       01B8  _tips_beep_off
       01BA  _tips_ok
       01C3  _tips_err
       01DD  _tips_id_ok
       01F3  _tips_ring_on
       01FF  _readPasswordItemNum
       020A  _readPasswordItem
       0256  _insertPasswordItem
       028A  _writePasswordItemNum
       02B8  _password_handle
       0400  _timer_init
       040F  _set_timer
       042F  _stop_timer
       0445  _timer0_isr
       049D  _log
       049E  _locker_init
       049F  _locker_unlock
       04A0  _locker_lock
       04A1  _ringandscreen_init
       04AC  _screen_on
       04BF  _screen_off
       04C1  _ring_on
       04CB  _ring_screen_timeout
       04D2  _door_minitor_timeout
       04E3  _input_isr
       0501  _check_door
       0509  _at24c256_init
       0510  _rw24c256
       0571  _rw24c256Int
       066B  _uart0_init
       0677  push_arg4
       0679  push_arg2
       067A  empy32s
       067A  empy32u
       06A6  pop_gset2
       06A8  pop_gset3
       06AA  pop_gset4
       06AC  pop_gset5
       06AE  push_gset5
       06B0  push_gset4
       06B2  push_gset3
       06B4  push_gset2
       06B6  push_gset1
       06B9  pop_gset1
       06BA  pop
       06CD  xicall
       06D6  long_prolog
       06E4  long_epilog
       06EF  tstzero1
       06F5  tstzero2
       06FB  push_lset
       070E  pop_lset
       0725  lsl32
       0731  lsr32
       073D  asgncblk
       0756  asgnblk
       076E  <created procedures>
       0904  __text_end

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
<library>	[ asave.s, emul32.s, gpop2.s, gpop3.s, gpop4.s, gpop5.s, gpush.s, icall.s, longutil.s, lpush.s, lsl32.s ]
[ lsr32.s, pmstruct.s, struct.s ]

User Global Definitions

ram_end = 0x45f
hwstk_size = 0x10

User Base Address Definitions

func_lit = 0x54
data = 0x60
eeprom:1.512

