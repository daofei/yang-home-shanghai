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
                            text   0062   0298 =    664. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0031  __text_start
       0031  __start
       0051  _exit
       0052  _delay_ms
       0068  _W_EEP
       0070  _R_EEP
       0077  _conv
       00A0  _display
       00E6  _port_init
       00F0  _main
       0109  mod16s
       010D  div16s
       0127  mod16u
       0129  div16u
       012A  xdiv16u
       0143  mod8u
       0145  div8u
       0146  xdiv8u
       015B  pop_gset2
       015E  push_gset5
       0160  push_gset4
       0162  push_gset3
       0164  push_gset2
       0166  push_gset1
       0169  pop_gset1
       016A  pop
       017D  __text_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             bss   0060   0005 =      5. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0060  __bss_start
       0060  _DispBuff
       0064  _val
       0065  __bss_end

Area                               Start  End    Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                          vector   0000   0004 =      4. bytes (abs,ovr,rom)

Files Linked      [ module(s) ]

C:\icc\lib\crtatmega.o	[ crtatmega.s ]
ac11-1.o	[ ac11 ]
<library>	[ div16s.s, div16u.s, div8u.s, gpop2.s, gpush.s ]

User Global Definitions

ram_end = 0x45f
hwstk_size = 0x10

User Base Address Definitions

func_lit = 0x54
data = 0x60
eeprom:1.512

