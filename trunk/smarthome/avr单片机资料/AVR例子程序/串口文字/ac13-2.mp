NOTE: AVR Code addresses are word addresses
All other addresses (including ones in FLASH) are byte addresses

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                           idata   0054   0060 =     96. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0054  __idata_start
       00B4  __idata_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   00B4   0114 =    276. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       005A  __text_start
       005A  __start
       007A  _exit
       007B  _port_init
       0087  _uart0_init
       0093  _init_devices
       0096  _uart0_send
       009A  _str_send
       00AA  _uart0_receive
       00AE  _main
       00C5  push_gset5
       00C7  push_gset4
       00C9  push_gset3
       00CB  push_gset2
       00CD  push_gset1
       00D0  pop_gset1
       00D1  pop
       00E4  __text_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            data   0060   0060 =     96. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0060  __data_start
       00C0  __data_end

Area                               Start  End    Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                          vector   0000   0004 =      4. bytes (abs,ovr,rom)

Files Linked      [ module(s) ]

C:\icc\lib\crtatmega.o	[ crtatmega.s ]
ac13-2.o	[ ac13 ]
<library>	[ gpush.s ]

User Global Definitions

ram_end = 0x45f
hwstk_size = 0x10

User Base Address Definitions

func_lit = 0x54
data = 0x60
eeprom:1.512

