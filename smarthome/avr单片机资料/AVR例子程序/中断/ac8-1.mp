NOTE: AVR Code addresses are word addresses
All other addresses (including ones in FLASH) are byte addresses

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   0054   0188 =    392. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       002A  __start
       002A  __text_start
       004A  _exit
       004B  _delay_ms
       0061  _main
       007A  _int1_isr
       009E  pop_gset2
       00A1  push_gset5
       00A3  push_gset4
       00A5  push_gset3
       00A7  push_gset2
       00A9  push_gset1
       00AC  pop_gset1
       00AD  pop
       00C0  push_lset
       00D7  pop_lset
       00EE  __text_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             bss   0060   0002 =      2. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0060  __bss_start
       0060  _cnt
       0062  __bss_end

Area                               Start  End    Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                          vector   0000   000C =     12. bytes (abs,ovr,rom)

Files Linked      [ module(s) ]

C:\icc\lib\crtatmega.o	[ crtatmega.s ]
ac8-1.o	[ ac8 ]
<library>	[ gpop2.s, gpush.s, lpush.s ]

User Global Definitions

ram_end = 0x45f
hwstk_size = 0x10

User Base Address Definitions

func_lit = 0x54
data = 0x60
eeprom:1.512

