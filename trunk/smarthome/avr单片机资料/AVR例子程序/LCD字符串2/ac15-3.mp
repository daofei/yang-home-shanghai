NOTE: AVR Code addresses are word addresses
All other addresses (including ones in FLASH) are byte addresses

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             lit   0054   0011 =     17. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0054  __lit_start
       0054  _str0
       005D  _str1
       0065  __lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   0066   0500 =   1280. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0033  __text_start
       0033  __start
       0053  _exit
       0054  _ePutstr
       0082  _LocateXY
       0093  _DisplayOneChar
       009F  _InitLcd
       00C1  _LcdWriteCommand
       00D4  _LcdWriteData
       00E4  _WaitForEnable
       00F7  _port_init
       0104  _scan_key
       0106  _i2c_Read
       0156  _i2c_Write
       0193  _main
       025C  _delay_ms
       026B  _delay_us
       0273  mod8u
       0275  div8u
       0276  xdiv8u
       028B  pop_gset2
       028E  pop_gset3
       0291  pop_gset5
       0294  push_gset5
       0296  push_gset4
       0298  push_gset3
       029A  push_gset2
       029C  push_gset1
       029F  pop_gset1
       02A0  pop
       02B3  __text_end

Area                               Start  End    Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                          vector   0000   0004 =      4. bytes (abs,ovr,rom)

Files Linked      [ module(s) ]

C:\icc\lib\crtatmega.o	[ crtatmega.s ]
ac15-3.o	[ ac15 ]
<library>	[ div8u.s, gpop2.s, gpop3.s, gpop5.s, gpush.s ]

User Global Definitions

ram_end = 0x45f
hwstk_size = 0x10

User Base Address Definitions

func_lit = 0x54
data = 0x60
eeprom:1.512

