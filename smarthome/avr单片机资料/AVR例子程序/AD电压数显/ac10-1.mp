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
                            text   0062   0486 =   1158. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0031  __start
       0031  __text_start
       0051  _exit
       0052  _port_init
       005D  _adc_init
       0062  _timer0_init
       0069  _init_devices
       006F  _timer0_ovf_isr
       0109  _ADC_Convert
       0114  _conv
       013E  _delay
       0154  _main
       016D  mod16u
       016F  div16u
       0170  xdiv16u
       0189  div32u
       018B  mod32u
       018F  div32s
       0191  mod32s
       01BC  long_div_prolog
       01CF  long_div_epilog
       01DE  tst_R16_R19
       01E3  tst_R24_R27
       01E8  neg_R16_R19
       01F1  neg_R24_R27
       01FA  empy32s
       01FA  empy32u
       022A  pop_gset2
       022D  pop_gset3
       0230  push_gset5
       0232  push_gset4
       0234  push_gset3
       0236  push_gset2
       0238  push_gset1
       023B  pop_gset1
       023C  pop
       024F  long_prolog
       025D  long_epilog
       0268  tstzero1
       026E  tstzero2
       0274  __text_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             bss   0060   0006 =      6. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0060  __bss_start
       0060  _cnt
       0061  _i
       0062  _dis_val
       0064  _adc_val
       0066  __bss_end

Area                               Start  End    Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                          vector   0000   0028 =     40. bytes (abs,ovr,rom)

Files Linked      [ module(s) ]

C:\icc\lib\crtatmega.o	[ crtatmega.s ]
ac10-1.o	[ ac10 ]
<library>	[ div16u.s, div32.s, emul32.s, gpop2.s, gpop3.s, gpush.s, longutil.s ]

User Global Definitions

ram_end = 0x45f
hwstk_size = 0x10

User Base Address Definitions

func_lit = 0x54
data = 0x60
eeprom:1.512

