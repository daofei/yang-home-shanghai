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
                            text   0074   10CA =   4298. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       003A  __text_start
       003A  __start
       0059  _exit
       005A  _main
       00BD  _wg26_init_interrupt
       0146  _int0_isr
       016E  _delay_1ms
       0177  _delay_ms
       0184  _gotoSleep
       0185  _tips_port_init
       018C  _tips_led_on
       0190  _tips_led_off
       0192  _tips_beep_on
       0196  _tips_beep_off
       0198  _tips_ok
       01A1  _tips_err
       01BB  _tips_id_ok
       01D3  _tips_ring_on
       01DD  _tips_board_led_on
       01E1  _tips_board_led_off
       01E3  _readPasswordItemNum
       01EE  _readPasswordItem
       0222  _insertPasswordItem
       0247  _writePasswordItemNum
       0277  _password_handle
       03A9  _timer_init
       03B8  _set_timer
       03D8  _stop_timer
       03EE  _timer0_isr
       0446  _log
       0447  _locker_init
       045F  _locker_unlock
       0475  _doorandscreen_init
       0480  _screen_on
       048F  _check_door
       0491  _rw24c256
       04A2  _uart0_init
       04AE  _iicport_init
       04B5  _start
       04C6  _stop
       04D7  _recAck
       04F8  _ack
       0501  _noAck
       0506  _sendByte
       0522  _receiveByte
       0549  _rwiic
       05AD  _rwiicInt
       063B  push_arg4
       063D  push_arg2
       063E  empy32u
       063E  empy32s
       066A  pop_gset2
       066C  pop_gset3
       066E  pop_gset5
       0670  push_gset5
       0672  push_gset4
       0674  push_gset3
       0676  push_gset2
       0678  push_gset1
       067B  pop_gset1
       067C  pop
       068F  xicall
       0698  long_prolog
       06A6  long_epilog
       06B1  tstzero1
       06B7  tstzero2
       06BD  push_lset
       06D0  pop_lset
       06E7  lsl32
       06F3  lsr32
       06FF  asgncblk
       0718  asgnblk
       0730  <created procedures>
       089F  __text_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            data   0060   0013 =     19. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0060  __data_start
       0073  __data_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             bss   0073   000C =     12. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0073  __bss_start
       007F  __bss_end

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
iic.o	[ iic.c ]
<library>	[ asave.s, emul32.s, gpop2.s, gpop3.s, gpop5.s, gpush.s, icall.s, longutil.s, lpush.s, lsl32.s, lsr32.s ]
[ pmstruct.s, struct.s ]

User Global Definitions

ram_end = 0x45f
hwstk_size = 0x10

User Base Address Definitions

func_lit = 0x54
data = 0x60
eeprom:1.512

