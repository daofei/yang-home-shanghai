NOTE: AVR Code addresses are word addresses
All other addresses (including ones in FLASH) are byte addresses

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             lit   0054   000C =     12. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0054  __lit_start
       0054  _SEG7
       005E  _ACT
       0060  __lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   0060   019C =    412. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0030  __start
       0030  __text_start
       0050  _exit
       0051  _delay_ms
       0067  _main
       00A2  mod16s
       00A6  div16s
       00C0  mod16u
       00C2  div16u
       00C3  xdiv16u
       00DC  pop_gset2
       00DF  push_gset5
       00E1  push_gset4
       00E3  push_gset3
       00E5  push_gset2
       00E7  push_gset1
       00EA  pop_gset1
       00EB  pop
       00FE  __text_end

Area                               Start  End    Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                          vector   0000   0004 =      4. bytes (abs,ovr,rom)

Files Linked      [ module(s) ]

C:\icc\lib\crtatmega.o	[ crtatmega.s ]
ac7-2.o	[ ac7 ]
<library>	[ div16s.s, div16u.s, gpop2.s, gpush.s ]

User Global Definitions

ram_end = 0x45f
hwstk_size = 0x10

User Base Address Definitions

func_lit = 0x54
data = 0x60
eeprom:1.512

