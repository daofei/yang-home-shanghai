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
                            text   0076   0850 =   2128. bytes (rel,con,rom)

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
       00FF  _Delay_1ms
       0109  _Delay_nms
       0118  _port_init
       0125  _scan_key
       0127  _delay
       013D  _start
       0164  _stop
       0182  _ack
       0197  _shift8
       01C3  _rd_24c01
       0220  _wr_24c01
       0250  _delay_iic
       025D  _timer1_init
       0264  _main
       03CA  _timer1_ovf_isr
       0419  _init_devices
       0423  mod8u
       0425  div8u
       0426  xdiv8u
       043B  pop_gset2
       043E  pop_gset3
       0441  pop_gset5
       0444  push_gset5
       0446  push_gset4
       0448  push_gset3
       044A  push_gset2
       044C  push_gset1
       044F  pop_gset1
       0450  pop
       0463  __text_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             bss   0060   000A =     10. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0060  __bss_start
       0060  _cnt
       0061  _com_data
       0062  _time2
       0066  _time1
       006A  __bss_end

Area                               Start  End    Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                          vector   0000   0024 =     36. bytes (abs,ovr,rom)

Files Linked      [ module(s) ]

C:\icc\lib\crtatmega.o	[ crtatmega.s ]
ac15-2.o	[ ac15 ]
<library>	[ div8u.s, gpop2.s, gpop3.s, gpop5.s, gpush.s ]

User Global Definitions

ram_end = 0x45f
hwstk_size = 0x10

User Base Address Definitions

func_lit = 0x54
data = 0x60
eeprom:1.512

