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
                            text   0062   048E =   1166. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0031  __text_start
       0031  __start
       0051  _exit
       0052  _port_init
       005D  _timer0_init
       0064  _timer1_init
       0069  _init_devices
       006F  _main
       00B4  _timer0_ovf_isr
       0196  mod16u
       0198  div16u
       0199  xdiv16u
       01B2  div32u
       01B4  mod32u
       01B8  div32s
       01BA  mod32s
       01E5  long_div_prolog
       01F8  long_div_epilog
       0207  tst_R16_R19
       020C  tst_R24_R27
       0211  neg_R16_R19
       021A  neg_R24_R27
       0223  empy32s
       0223  empy32u
       0253  long_prolog
       0261  long_epilog
       026C  tstzero1
       0272  tstzero2
       0278  __text_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             bss   0060   0008 =      8. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0060  __bss_start
       0060  _Disval
       0062  _Wide
       0064  _cnt
       0066  _key_cnt
       0068  __bss_end

Area                               Start  End    Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                          vector   0000   0028 =     40. bytes (abs,ovr,rom)

Files Linked      [ module(s) ]

C:\icc\lib\crtatmega.o	[ crtatmega.s ]
ac12-2.o	[ ac12 ]
<library>	[ div16u.s, div32.s, emul32.s, longutil.s ]

User Global Definitions

ram_end = 0x45f
hwstk_size = 0x10

User Base Address Definitions

func_lit = 0x54
data = 0x60
eeprom:1.512

