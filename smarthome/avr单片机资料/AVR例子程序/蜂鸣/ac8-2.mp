NOTE: AVR Code addresses are word addresses
All other addresses (including ones in FLASH) are byte addresses

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   0054   01A0 =    416. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       002A  __start
       002A  __text_start
       004A  _exit
       004B  _delay_ms
       0061  _main
       007A  _int0_isr
       0084  _int1_isr
       00AA  pop_gset2
       00AD  push_gset5
       00AF  push_gset4
       00B1  push_gset3
       00B3  push_gset2
       00B5  push_gset1
       00B8  pop_gset1
       00B9  pop
       00CC  push_lset
       00E3  pop_lset
       00FA  __text_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             bss   0060   0002 =      2. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0060  __bss_start
       0060  _cnt
       0062  __bss_end

Area                               Start  End    Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                          vector   0000   000C =     12. bytes (abs,ovr,rom)

Files Linked      [ module(s) ]

C:\icc\lib\crtatmega.o	[ crtatmega.s ]
ac8-2.o	[ ac8 ]
<library>	[ gpop2.s, gpush.s, lpush.s ]

User Global Definitions

ram_end = 0x45f
hwstk_size = 0x10

User Base Address Definitions

func_lit = 0x54
data = 0x60
eeprom:1.512

