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
                            text   0062   0306 =    774. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0031  __text_start
       0031  __start
       0051  _exit
       0052  _port_init
       005B  _timer0_init
       0060  _timer0_ovf_isr
       010C  _timer1_init
       0111  _timer1_ovf_isr
       0137  _int0_isr
       0153  _init_devices
       015F  _scan_s1
       0168  _main
       0179  mod16u
       017B  div16u
       017C  xdiv16u
       0195  push_gset5
       0197  push_gset4
       0199  push_gset3
       019B  push_gset2
       019D  push_gset1
       01A0  pop_gset1
       01A1  pop
       01B4  __text_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             bss   0060   0004 =      4. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0060  __bss_start
       0060  _i
       0061  _start_flag
       0062  _cnt
       0064  __bss_end

Area                               Start  End    Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                          vector   0000   0028 =     40. bytes (abs,ovr,rom)

Files Linked      [ module(s) ]

C:\icc\lib\crtatmega.o	[ crtatmega.s ]
ac9-3.o	[ ac9 ]
<library>	[ div16u.s, gpush.s ]

User Global Definitions

ram_end = 0x45f
hwstk_size = 0x10

User Base Address Definitions

func_lit = 0x54
data = 0x60
eeprom:1.512

