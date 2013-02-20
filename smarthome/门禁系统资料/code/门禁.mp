NOTE: AVR Code addresses are word addresses
All other addresses (including ones in FLASH) are byte addresses

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                        func_lit   0054   0006 =      6. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0054  __func_lit_start
       005A  __func_lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             lit   005A   0004 =      4. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       005A  __lit_start
       005E  __lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                           idata   005E   0013 =     19. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       005E  __idata_start
       0071  __idata_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   0072   10A0 =   4256. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0039  __text_start
       0039  __start
       0058  _exit
       0059  _main
       00EA  _wg26_init_interrupt
       0172  _int0_isr
       018D  _delay_1ms
       0196  _delay_ms
       01A3  _tips_port_init
       01AA  _tips_led_on
       01AE  _tips_led_off
       01B0  _tips_beep_on
       01B4  _tips_beep_off
       01B6  _tips_ok
       01BF  _tips_err
       01D9  _tips_id_ok
       01F1  _tips_ring_on
       01FB  _readPasswordItemNum
       0206  _readPasswordItem
       023A  _insertPasswordItem
       025F  _writePasswordItemNum
       028F  _password_handle
       03C4  _timer_init
       03D3  _set_timer
       03F3  _stop_timer
       0409  _timer0_isr
       0464  _log
       0465  _locker_init
       0466  _locker_unlock
       0467  _locker_lock
       0468  _doorandscreen_init
       0471  _screen_on
       0478  _check_door
       047B  _at24c256_init
       0482  _rw24c256
       04E5  _rw24c256Int
       05F8  _uart0_init
       0604  push_arg4
       0606  push_arg2
       0607  empy32s
       0607  empy32u
       0633  pop_gset2
       0635  pop_gset3
       0637  pop_gset5
       0639  push_gset5
       063B  push_gset4
       063D  push_gset3
       063F  push_gset2
       0641  push_gset1
       0644  pop_gset1
       0645  pop
       0658  xicall
       0661  long_prolog
       066F  long_epilog
       067A  tstzero1
       0680  tstzero2
       0686  push_lset
       0699  pop_lset
       06B0  lsl32
       06BC  lsr32
       06C8  asgncblk
       06E1  asgnblk
       06F9  <created procedures>
       0889  __text_end

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

