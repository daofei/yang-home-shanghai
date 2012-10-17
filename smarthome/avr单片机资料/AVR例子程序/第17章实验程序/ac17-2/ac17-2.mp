NOTE: AVR Code addresses are word addresses
All other addresses (including ones in FLASH) are byte addresses

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   0054   013E =    318. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       002A  __start
       002A  __text_start
       004A  _exit
       004B  _delay_1ms
       0055  _delay_ms
       0064  _port_init
       006F  _watchdog_init
       0073  _init_devices
       0076  _main
       00A7  pop_gset2
       00AA  push_gset5
       00AC  push_gset4
       00AE  push_gset3
       00B0  push_gset2
       00B2  push_gset1
       00B5  pop_gset1
       00B6  pop
       00C9  __text_end

Area                               Start  End    Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                          vector   0000   0004 =      4. bytes (abs,ovr,rom)

Files Linked      [ module(s) ]

C:\icc\lib\crtatmega.o	[ crtatmega.s ]
ac17-2.o	[ ac17 ]
<library>	[ gpop2.s, gpush.s ]

User Global Definitions

ram_end = 0x45f
hwstk_size = 0x10

User Base Address Definitions

func_lit = 0x54
data = 0x60
eeprom:1.512

