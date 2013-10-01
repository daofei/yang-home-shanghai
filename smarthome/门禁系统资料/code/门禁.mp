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
                           idata   005E   0018 =     24. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       005E  __idata_start
       0076  __idata_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   0076   12E4 =   4836. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       003B  __start
       003B  __text_start
       005A  _exit
       005B  _main
       006B  _wg26_init_interrupt
       00ED  _int0_isr
       010D  _wg26_spank
       0129  _delay_1ms
       0132  _delay_ms
       0141  _tips_port_init
       0148  _tips_led_on
       014C  _tips_led_off
       014E  _tips_beep_on
       0152  _tips_beep_off
       0154  _tips_err
       016E  _tips_board_led_on
       0172  _tips_board_led_off
       0174  _readPasswordItemNum
       017F  _readPasswordItem
       01B6  _insertPasswordItem
       01DD  _writePasswordItemNum
       0211  _password_handle_err
       0214  _password_handle_ok
       021A  _password_handle
       0359  _timer_init
       036D  _set_timer
       0387  _stop_timer
       03A0  _set_timer2
       03C2  _timer0_isr
       0414  _log
       0426  _locker_init
       043E  _locker_unlock
       0454  _doorandscreen_init
       045F  _screen_on_pinLow
       0464  _screen_on_pinHigh
       046C  _rw24c256
       047D  _uart0_init
       048B  _uart0_port_hiz
       048E  _uart0_send
       0492  _uart0_receive
       0496  _uart0_send_buffer
       04A5  _uart0_read_buffer
       04D4  _uart0_handleCommand_isr
       0650  _iicport_init
       0657  _start
       0668  _stop
       0679  _recAck
       069A  _ack
       06A3  _noAck
       06A8  _sendByte
       06C4  _receiveByte
       06EB  _rwiic
       0750  push_arg4
       0752  push_arg2
       0753  empy32u
       0753  empy32s
       077F  pop_gset2
       0781  pop_gset3
       0783  pop_gset4
       0785  pop_gset5
       0787  push_gset5
       0789  push_gset4
       078B  push_gset3
       078D  push_gset2
       078F  push_gset1
       0792  pop_gset1
       0793  pop
       07A6  xicall
       07AF  long_prolog
       07BD  long_epilog
       07C8  tstzero1
       07CE  tstzero2
       07D4  push_lset
       07E7  pop_lset
       07FE  lsl32
       080A  asgnblk
       0822  <created procedures>
       09AD  __text_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            data   0060   0018 =     24. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0060  __data_start
       0078  __data_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             bss   0078   001E =     30. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0078  __bss_start
       0096  __bss_end

Area                               Start  End    Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                          vector   0000   0030 =     48. bytes (abs,ovr,rom)

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
<library>	[ asave.s, emul32.s, gpop2.s, gpop3.s, gpop4.s, gpop5.s, gpush.s, icall.s, longutil.s, lpush.s, lsl32.s ]
[ struct.s ]

User Global Definitions

ram_end = 0x45f
hwstk_size = 0x10

User Base Address Definitions

func_lit = 0x54
data = 0x60
eeprom:1.512

