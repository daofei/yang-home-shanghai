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
                            text   0074   10EA =   4330. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       003A  __start
       003A  __text_start
       0059  _exit
       005A  _main
       00BC  _wg26_init_interrupt
       0145  _int0_isr
       0161  _delay_1ms
       016A  _delay_ms
       0177  _gotoSleep
       0178  _tips_port_init
       017F  _tips_led_on
       0183  _tips_led_off
       0185  _tips_beep_on
       0189  _tips_beep_off
       018B  _tips_ok
       0194  _tips_err
       01AE  _tips_id_ok
       01C6  _tips_ring_on
       01D0  _readPasswordItemNum
       01DB  _readPasswordItem
       020F  _insertPasswordItem
       0234  _writePasswordItemNum
       0264  _password_handle
       0396  _timer_init
       03A5  _set_timer
       03C5  _stop_timer
       03DB  _timer0_isr
       0436  _log
       0437  _locker_init
       044E  _locker_unlock
       0463  _doorandscreen_init
       046E  _screen_on
       047D  _check_door
       047F  _rw24c256
       0490  _uart0_init
       049C  _iicport_init
       04A3  _start
       04B4  _stop
       04C5  _recAck
       04E6  _ack
       04EF  _noAck
       04F4  _sendByte
       0510  _receiveByte
       0537  _rwiic
       059B  _rwiicInt
       0629  push_arg4
       062B  push_arg2
       062C  empy32s
       062C  empy32u
       0658  pop_gset2
       065A  pop_gset3
       065C  pop_gset5
       065E  push_gset5
       0660  push_gset4
       0662  push_gset3
       0664  push_gset2
       0666  push_gset1
       0669  pop_gset1
       066A  pop
       067D  xicall
       0686  long_prolog
       0694  long_epilog
       069F  tstzero1
       06A5  tstzero2
       06AB  push_lset
       06BE  pop_lset
       06D5  lsl32
       06E1  lsr32
       06ED  asgncblk
       0706  asgnblk
       071E  <created procedures>
       08AF  __text_end

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

