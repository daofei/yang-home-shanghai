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
                           idata   0060   0015 =     21. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0060  __idata_start
       0075  __idata_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   0076   10E8 =   4328. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       003B  __text_start
       003B  __start
       005A  _exit
       005B  _main
       00AC  _wg26_init_interrupt
       0133  _int0_isr
       0150  _wg26_spank
       0162  _delay_1ms
       016B  _delay_ms
       0178  _gotoSleep
       0179  _tips_port_init
       0180  _tips_led_on
       0184  _tips_led_off
       0186  _tips_beep_on
       018A  _tips_beep_off
       018C  _tips_ok
       0195  _tips_err
       01AF  _tips_id_ok
       01C7  _tips_ring_on
       01D1  _tips_board_led_on
       01D5  _tips_board_led_off
       01D7  _readPasswordItemNum
       01E2  _readPasswordItem
       0216  _insertPasswordItem
       023B  _writePasswordItemNum
       026B  _password_handle
       039D  _timer_init
       03AC  _set_timer
       03CC  _stop_timer
       03E2  _timer0_isr
       043A  _log
       043B  _locker_init
       0453  _locker_unlock
       0469  _doorandscreen_init
       0474  _screen_on
       0483  _check_door
       0485  _rw24c256
       0496  _uart0_init
       04A2  _iicport_init
       04A9  _start
       04BA  _stop
       04CB  _recAck
       04EC  _ack
       04F5  _noAck
       04FA  _sendByte
       0516  _receiveByte
       053D  _rwiic
       05A1  _rwiicInt
       062F  push_arg4
       0631  push_arg2
       0632  empy32u
       0632  empy32s
       065E  pop_gset2
       0660  pop_gset3
       0662  pop_gset5
       0664  push_gset5
       0666  push_gset4
       0668  push_gset3
       066A  push_gset2
       066C  push_gset1
       066F  pop_gset1
       0670  pop
       0683  xicall
       068C  long_prolog
       069A  long_epilog
       06A5  tstzero1
       06AB  tstzero2
       06B1  push_lset
       06C4  pop_lset
       06DB  lsl32
       06E7  lsr32
       06F3  asgncblk
       070C  asgnblk
       0724  <created procedures>
       08AF  __text_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            data   0060   0015 =     21. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0060  __data_start
       0075  __data_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             bss   0075   000C =     12. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0075  __bss_start
       0081  __bss_end

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

