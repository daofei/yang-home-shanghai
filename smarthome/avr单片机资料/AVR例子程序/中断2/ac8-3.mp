NOTE: AVR Code addresses are word addresses
All other addresses (including ones in FLASH) are byte addresses

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             lit   0054   000A =     10. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0054  __lit_start
       0054  _SEG7
       005E  __lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   005E   0142 =    322. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       002F  __start
       002F  __text_start
       004F  _exit
       0050  _delay_ms
       0066  _main
       009A  _int0_isr
       00A4  _int1_isr
       00AE  pop_gset2
       00B1  push_gset5
       00B3  push_gset4
       00B5  push_gset3
       00B7  push_gset2
       00B9  push_gset1
       00BC  pop_gset1
       00BD  pop
       00D0  __text_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             bss   0060   0002 =      2. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0060  __bss_start
       0060  _alm_flag2
       0061  _alm_flag1
       0062  __bss_end

Area                               Start  End    Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                          vector   0000   000C =     12. bytes (abs,ovr,rom)

Files Linked      [ module(s) ]

C:\icc\lib\crtatmega.o	[ crtatmega.s ]
ac8-3.o	[ ac8 ]
<library>	[ gpop2.s, gpush.s ]

User Global Definitions

ram_end = 0x45f
hwstk_size = 0x10

User Base Address Definitions

func_lit = 0x54
data = 0x60
eeprom:1.512

