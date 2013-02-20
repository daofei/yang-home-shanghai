NOTE: AVR Code addresses are word addresses
All other addresses (including ones in FLASH) are byte addresses

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                        func_lit   0054   0002 =      2. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0054  __func_lit_start
       0056  __func_lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                           idata   0056   0001 =      1. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0056  __idata_start
       0057  __idata_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   0058   03A2 =    930. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       002C  __start
       002C  __text_start
       004B  _exit
       004C  _delay_1ms
       0055  _delay_ms
       0062  _input_port_init
       0078  _check_screen
       0083  _int0_isr
       0098  _main
       00A3  _output_port_init
       00A8  _output_screen_off
       00C5  _output_screen_on
       00E8  _output_ring_on
       00F0  _timer_init
       00FF  _set_timer
       011F  _stop_timer
       0135  _timer0_isr
       018D  pop_gset2
       018F  push_gset5
       0191  push_gset4
       0193  push_gset3
       0195  push_gset2
       0197  push_gset1
       019A  pop_gset1
       019B  pop
       01AE  xicall
       01B7  push_lset
       01CE  pop_lset
       01E5  <created procedures>
       01FD  __text_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            data   0060   0001 =      1. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0060  __data_start
       0061  __data_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             bss   0061   0010 =     16. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0061  __bss_start
       0071  __bss_end

Area                               Start  End    Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                          vector   0000   0028 =     40. bytes (abs,ovr,rom)

Files Linked      [ module(s) ]

C:\icc\lib\crtatmega.o	[ crtatmega.s ]
util.o	[ util.c ]
input.o	[ input.c ]
log.o	[ log.c ]
main.o	[ main.c ]
output.o	[ output.c ]
timer.o	[ timer.c ]
<library>	[ gpop2.s, gpush.s, icall.s, lpush.s ]

User Global Definitions

ram_end = 0x45f
hwstk_size = 0x10

User Base Address Definitions

func_lit = 0x54
data = 0x60
eeprom:1.512

