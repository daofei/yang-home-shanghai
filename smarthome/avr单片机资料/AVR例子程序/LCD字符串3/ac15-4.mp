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
                            text   0076   06FA =   1786. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       003B  __text_start
       003B  __start
       005B  _exit
       005C  _ePutstr
       008A  _LocateXY
       009B  _DisplayOneChar
       00A7  _InitLcd
       00C9  _LcdWriteCommand
       00DC  _LcdWriteData
       00EC  _WaitForEnable
       00FF  _port_init
       010C  _scan_key
       010E  _i2c_Read
       015E  _i2c_Write
       019B  _timer1_init
       01A2  _main
       0308  _timer1_ovf_isr
       0357  _init_devices
       0361  _delay_ms
       0370  _delay_us
       0378  mod8u
       037A  div8u
       037B  xdiv8u
       0390  pop_gset2
       0393  pop_gset3
       0396  pop_gset5
       0399  push_gset5
       039B  push_gset4
       039D  push_gset3
       039F  push_gset2
       03A1  push_gset1
       03A4  pop_gset1
       03A5  pop
       03B8  __text_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             bss   0060   0008 =      8. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0060  _time2
       0060  __bss_start
       0064  _time1
       0068  __bss_end

Area                               Start  End    Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                          vector   0000   0024 =     36. bytes (abs,ovr,rom)

Files Linked      [ module(s) ]

C:\icc\lib\crtatmega.o	[ crtatmega.s ]
ac15-4.o	[ ac15 ]
<library>	[ div8u.s, gpop2.s, gpop3.s, gpop5.s, gpush.s ]

User Global Definitions

ram_end = 0x45f
hwstk_size = 0x10

User Base Address Definitions

func_lit = 0x54
data = 0x60
eeprom:1.512

