NOTE: AVR Code addresses are word addresses
All other addresses (including ones in FLASH) are byte addresses

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             lit   0054   0022 =     34. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0054  __lit_start
       0054  _str0
       0065  _str1
       0076  __lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   0076   027C =    636. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       003B  __start
       003B  __text_start
       005B  _exit
       005C  _main
       0095  _ePutstr
       00C3  _LocateXY
       00D4  _DisplayOneChar
       00E0  _InitLcd
       0102  _LcdWriteCommand
       0115  _LcdWriteData
       0125  _WaitForEnable
       0138  _Delay_1ms
       0142  _Delay_nms
       0151  pop_gset2
       0154  pop_gset3
       0157  pop_gset5
       015A  push_gset5
       015C  push_gset4
       015E  push_gset3
       0160  push_gset2
       0162  push_gset1
       0165  pop_gset1
       0166  pop
       0179  __text_end

Area                               Start  End    Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                          vector   0000   0004 =      4. bytes (abs,ovr,rom)

Files Linked      [ module(s) ]

C:\icc\lib\crtatmega.o	[ crtatmega.s ]
ac14-1.o	[ ac14 ]
<library>	[ gpop2.s, gpop3.s, gpop5.s, gpush.s ]

User Global Definitions

ram_end = 0x45f
hwstk_size = 0x10

User Base Address Definitions

func_lit = 0x54
data = 0x60
eeprom:1.512

