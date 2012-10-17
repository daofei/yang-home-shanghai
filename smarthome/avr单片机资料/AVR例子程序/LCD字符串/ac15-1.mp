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
                            text   0066   0662 =   1634. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0033  __start
       0033  __text_start
       0053  _exit
       0054  _ePutstr
       0082  _LocateXY
       0093  _DisplayOneChar
       009F  _InitLcd
       00C1  _LcdWriteCommand
       00D4  _LcdWriteData
       00E4  _WaitForEnable
       00F7  _Delay_1ms
       0101  _Delay_nms
       0110  _port_init
       011D  _scan_key
       011F  _delay
       0135  _start
       015C  _stop
       017A  _ack
       018F  _shift8
       01BB  _rd_24c01
       0218  _wr_24c01
       0248  _delay_iic
       0255  _main
       0324  mod8u
       0326  div8u
       0327  xdiv8u
       033C  pop_gset2
       033F  pop_gset3
       0342  pop_gset5
       0345  push_gset5
       0347  push_gset4
       0349  push_gset3
       034B  push_gset2
       034D  push_gset1
       0350  pop_gset1
       0351  pop
       0364  __text_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             bss   0060   0002 =      2. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0060  __bss_start
       0060  _cnt
       0061  _com_data
       0062  __bss_end

Area                               Start  End    Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                          vector   0000   0004 =      4. bytes (abs,ovr,rom)

Files Linked      [ module(s) ]

C:\icc\lib\crtatmega.o	[ crtatmega.s ]
ac15-1.o	[ ac15 ]
<library>	[ div8u.s, gpop2.s, gpop3.s, gpop5.s, gpush.s ]

User Global Definitions

ram_end = 0x45f
hwstk_size = 0x10

User Base Address Definitions

func_lit = 0x54
data = 0x60
eeprom:1.512

