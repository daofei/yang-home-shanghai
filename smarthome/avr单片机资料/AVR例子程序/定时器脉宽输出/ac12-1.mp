NOTE: AVR Code addresses are word addresses
All other addresses (including ones in FLASH) are byte addresses

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   0054   00E2 =    226. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       002A  __start
       002A  __text_start
       004A  _exit
       004B  _delay_1ms
       0055  _delay_ms
       0064  _init_IO
       006B  _main
       0079  pop_gset2
       007C  push_gset5
       007E  push_gset4
       0080  push_gset3
       0082  push_gset2
       0084  push_gset1
       0087  pop_gset1
       0088  pop
       009B  __text_end

Area                               Start  End    Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                          vector   0000   0004 =      4. bytes (abs,ovr,rom)

Files Linked      [ module(s) ]

C:\icc\lib\crtatmega.o	[ crtatmega.s ]
ac12-1.o	[ ac12 ]
<library>	[ gpop2.s, gpush.s ]

User Global Definitions

ram_end = 0x45f
hwstk_size = 0x10

User Base Address Definitions

func_lit = 0x54
data = 0x60
eeprom:1.512

