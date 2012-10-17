NOTE: AVR Code addresses are word addresses
All other addresses (including ones in FLASH) are byte addresses

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             lit   0054   0400 =   1024. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0054  __lit_start
       0054  _hz
       0454  __lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   0454   05A8 =   1448. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       022A  __text_start
       022A  __start
       024A  _exit
       024B  _Delay_1ms
       0255  _Delay_nms
       0264  _main
       03B9  _m16_init
       03C0  _lcd_busy
       03D7  _wcode
       03F5  _wdata
       0413  _lw
       0430  _set_startline
       043E  _set_xy
       0453  _dison_off
       0461  _reset
       046A  _lcd_init
       0487  _display_hz
       04D4  push_arg4
       04D6  push_arg2
       04D9  pop_gset2
       04DC  pop_gset5
       04DF  push_gset5
       04E1  push_gset4
       04E3  push_gset3
       04E5  push_gset2
       04E7  push_gset1
       04EA  pop_gset1
       04EB  pop
       04FE  __text_end

Area                               Start  End    Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                          vector   0000   0004 =      4. bytes (abs,ovr,rom)

Files Linked      [ module(s) ]

C:\icc\lib\crtatmega.o	[ crtatmega.s ]
ac16-1.o	[ ac16 ]
<library>	[ asave.s, gpop2.s, gpop5.s, gpush.s ]

User Global Definitions

ram_end = 0x45f
hwstk_size = 0x10

User Base Address Definitions

func_lit = 0x54
data = 0x60
eeprom:1.512

