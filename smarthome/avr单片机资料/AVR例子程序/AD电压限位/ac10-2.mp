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
                            text   0062   050C =   1292. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0031  __text_start
       0031  __start
       0051  _exit
       0052  _port_init
       005D  _timer0_init
       0064  _timer0_ovf_isr
       00F9  _timer1_init
       0100  _timer1_ovf_isr
       010B  _adc_init
       0112  _adc_isr
       0138  _init_devices
       0141  _delay
       0157  _conv
       0181  _main
       01B0  mod16u
       01B2  div16u
       01B3  xdiv16u
       01CC  div32u
       01CE  mod32u
       01D2  div32s
       01D4  mod32s
       01FF  long_div_prolog
       0212  long_div_epilog
       0221  tst_R16_R19
       0226  tst_R24_R27
       022B  neg_R16_R19
       0234  neg_R24_R27
       023D  empy32s
       023D  empy32u
       026D  pop_gset2
       0270  pop_gset3
       0273  push_gset5
       0275  push_gset4
       0277  push_gset3
       0279  push_gset2
       027B  push_gset1
       027E  pop_gset1
       027F  pop
       0292  long_prolog
       02A0  long_epilog
       02AB  tstzero1
       02B1  tstzero2
       02B7  __text_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             bss   0060   0006 =      6. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0060  __bss_start
       0060  _flag
       0061  _i
       0062  _dis_val
       0064  _value
       0066  __bss_end

Area                               Start  End    Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                          vector   0000   003C =     60. bytes (abs,ovr,rom)

Files Linked      [ module(s) ]

C:\icc\lib\crtatmega.o	[ crtatmega.s ]
ac10-2.o	[ ac10 ]
<library>	[ div16u.s, div32.s, emul32.s, gpop2.s, gpop3.s, gpush.s, longutil.s ]

User Global Definitions

ram_end = 0x45f
hwstk_size = 0x10

User Base Address Definitions

func_lit = 0x54
data = 0x60
eeprom:1.512

