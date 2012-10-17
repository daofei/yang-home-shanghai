NOTE: AVR Code addresses are word addresses
All other addresses (including ones in FLASH) are byte addresses

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                           idata   0054   0025 =     37. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0054  __idata_start
       0079  __idata_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   007A   04FE =   1278. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       003D  __start
       003D  __text_start
       005D  _exit
       005E  _port_init
       006B  _ys1ms
       0074  _delaym
       0083  _EEPROM_W
       0099  _timer1_init
       00A1  _t0_start
       00A9  _rxd_init
       00B5  _send
       00B9  _send3
       00D0  _delay_us
       00D8  _delay_ms
       00E7  _LCD_write_com
       00F5  _LCD_write_data
       0103  _LCD_clear
       0109  _LCD_write_str
       0125  _LCD_write_char
       0137  _LCD_init
       015C  _main
       01A3  _timer1_in
       0286  _int0
       0287  _int1
       0288  _t2_comp
       0289  _t2_ovf
       028A  _t1_compa
       028B  _t1_compb
       028C  _t1_ovf
       028D  _t0_ovf
       028E  _spi_end
       028F  _rx_end
       0290  _usart_nop
       0291  _tx_end
       0292  _adc_end
       0293  _eep_rdy
       0294  _ana_comp
       0295  _twi
       0296  _spm_rdy
       0297  pop_gset2
       029A  pop_gset3
       029D  push_gset5
       029F  push_gset4
       02A1  push_gset3
       02A3  push_gset2
       02A5  push_gset1
       02A8  pop_gset1
       02A9  pop
       02BC  __text_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            data   0060   0025 =     37. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0060  _shukk
       0060  __data_start
       006A  _addr
       006E  _llbit
       006F  _irsign
       0085  __data_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             bss   0085   000B =     11. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0085  __bss_start
       0087  _data3
       0088  _data2
       0089  _data1
       008A  _data0
       008B  _bitnum
       008C  _head
       008D  _unin
       008E  _j
       008F  _i
       0090  __bss_end

Area                               Start  End    Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                          vector   0000   004C =     76. bytes (abs,ovr,rom)

Files Linked      [ module(s) ]

E:\icc\lib\crtatmega.o	[ crtatmega.s ]
DIV.o	[ DIV.c ]
<library>	[ gpop2.s, gpop3.s, gpush.s ]

User Global Definitions

ram_end = 0x45f
hwstk_size = 0x10

User Base Address Definitions

func_lit = 0x54
data = 0x60
eeprom:1.512

