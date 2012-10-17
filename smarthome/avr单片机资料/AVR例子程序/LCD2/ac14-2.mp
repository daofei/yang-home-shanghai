NOTE: AVR Code addresses are word addresses
All other addresses (including ones in FLASH) are byte addresses

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             lit   0054   0021 =     33. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0054  __lit_start
       0054  _exampl
       0075  __lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   0076   0282 =    642. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       003B  __start
       003B  __text_start
       005B  _exit
       005C  _main
       0081  _ePutstr
       00AF  _Display
       00C6  _LocateXY
       00D7  _DisplayOneChar
       00E3  _InitLcd
       0105  _LcdWriteCommand
       0118  _LcdWriteData
       0128  _WaitForEnable
       013B  _Delay_1ms
       0145  _Delay_nms
       0154  pop_gset2
       0157  pop_gset3
       015A  pop_gset5
       015D  push_gset5
       015F  push_gset4
       0161  push_gset3
       0163  push_gset2
       0165  push_gset1
       0168  pop_gset1
       0169  pop
       017C  __text_end

Area                               Start  End    Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                          vector   0000   0004 =      4. bytes (abs,ovr,rom)

Files Linked      [ module(s) ]

C:\icc\lib\crtatmega.o	[ crtatmega.s ]
ac14-2.o	[ ac14 ]
<library>	[ gpop2.s, gpop3.s, gpop5.s, gpush.s ]

User Global Definitions

ram_end = 0x45f
hwstk_size = 0x10

User Base Address Definitions

func_lit = 0x54
data = 0x60
eeprom:1.512

