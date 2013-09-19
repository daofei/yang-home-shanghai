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
                            text   0076   12C0 =   4800. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       003B  __text_start
       003B  __start
       005A  _exit
       005B  _main
       006B  _wg26_init_interrupt
       00ED  _int0_isr
       0119  _wg26_spank
       0135  _delay_1ms
       013E  _delay_ms
       014D  _tips_port_init
       0154  _tips_led_on
       0158  _tips_led_off
       015A  _tips_beep_on
       015E  _tips_beep_off
       0160  _tips_err
       017A  _tips_board_led_on
       017E  _tips_board_led_off
       0180  _readPasswordItemNum
       018B  _readPasswordItem
       01C2  _insertPasswordItem
       01E9  _writePasswordItemNum
       021D  _password_handle_err
       0220  _password_handle_ok
       0226  _password_handle
       0365  _timer_init
       0379  _set_timer
       0393  _stop_timer
       03AC  _set_timer2
       03CE  _timer0_isr
       0420  _log
       0432  _locker_init
       044A  _locker_unlock
       0460  _doorandscreen_init
       046B  _screen_on_pinLow
       0470  _screen_on_pinHigh
       0478  _rw24c256
       0489  _uart0_init
       049B  _uart0_send
       049F  _uart0_receive
       04A3  _uart0_send_buffer
       04B1  _uart0_read_buffer
       04E0  _uart0_handleCommand_isr
       065B  _iicport_init
       0662  _start
       0673  _stop
       0684  _recAck
       06A5  _ack
       06AE  _noAck
       06B3  _sendByte
       06CF  _receiveByte
       06F6  _rwiic
       075B  push_arg4
       075D  push_arg2
       075E  empy32u
       075E  empy32s
       078A  pop_gset2
       078C  pop_gset3
       078E  pop_gset4
       0790  pop_gset5
       0792  push_gset5
       0794  push_gset4
       0796  push_gset3
       0798  push_gset2
       079A  push_gset1
       079D  pop_gset1
       079E  pop
       07B1  xicall
       07BA  long_prolog
       07C8  long_epilog
       07D3  tstzero1
       07D9  tstzero2
       07DF  push_lset
       07F2  pop_lset
       0809  lsl32
       0815  asgnblk
       082D  <created procedures>
       099B  __text_end

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

