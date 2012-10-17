NOTE: AVR Code addresses are word addresses
All other addresses (including ones in FLASH) are byte addresses

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             lit   0054   000E =     14. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0054  __lit_start
       0054  _SEG7
       005E  _ACT
       0062  __lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   0062   033E =    830. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0031  __start
       0031  __text_start
       0051  _exit
       0052  _delay_ms
       0068  _W_EEP
       0070  _R_EEP
       0077  _display
       0130  _port_init
       013B  _main
       0174  mod16s
       0178  div16s
       0192  mod16u
       0194  div16u
       0195  xdiv16u
       01AE  pop_gset2
       01B1  push_gset5
       01B3  push_gset4
       01B5  push_gset3
       01B7  push_gset2
       01B9  push_gset1
       01BC  pop_gset1
       01BD  pop
       01D0  __text_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             bss   0060   0002 =      2. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0060  __bss_start
       0060  _y
       0061  _x
       0062  __bss_end

Area                               Start  End    Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                          vector   0000   0004 =      4. bytes (abs,ovr,rom)

Files Linked      [ module(s) ]

C:\icc\lib\crtatmega.o	[ crtatmega.s ]
ac11-2.o	[ ac11 ]
<library>	[ div16s.s, div16u.s, gpop2.s, gpush.s ]

User Global Definitions

ram_end = 0x45f
hwstk_size = 0x10

User Base Address Definitions

func_lit = 0x54
data = 0x60
eeprom:1.512

