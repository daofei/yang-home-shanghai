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
                            text   0074   10A4 =   4260. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       003A  __text_start
       003A  __start
       0059  _exit
       005A  _main
       00CD  _wg26_init_interrupt
       0155  _int0_isr
       0170  _delay_1ms
       0179  _delay_ms
       0186  _tips_port_init
       018D  _tips_led_on
       0191  _tips_led_off
       0193  _tips_beep_on
       0197  _tips_beep_off
       0199  _tips_ok
       01A2  _tips_err
       01BC  _tips_id_ok
       01D4  _tips_ring_on
       01DE  _readPasswordItemNum
       01E9  _readPasswordItem
       021D  _insertPasswordItem
       0242  _writePasswordItemNum
       0272  _password_handle
       03A4  _timer_init
       03B3  _set_timer
       03D3  _stop_timer
       03E9  _timer0_isr
       0441  _log
       0442  _locker_init
       0459  _locker_unlock
       046E  _doorandscreen_init
       0475  _screen_on
       047D  _check_door
       047F  _at24c256_init
       0486  _rw24c256
       04E9  _rw24c256Int
       05FC  _uart0_init
       0608  push_arg4
       060A  push_arg2
       060B  empy32u
       060B  empy32s
       0637  pop_gset2
       0639  pop_gset3
       063B  pop_gset5
       063D  push_gset5
       063F  push_gset4
       0641  push_gset3
       0643  push_gset2
       0645  push_gset1
       0648  pop_gset1
       0649  pop
       065C  xicall
       0665  long_prolog
       0673  long_epilog
       067E  tstzero1
       0684  tstzero2
       068A  push_lset
       069D  pop_lset
       06B4  lsl32
       06C0  lsr32
       06CC  asgncblk
       06E5  asgnblk
       06FD  <created procedures>
       088C  __text_end

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

