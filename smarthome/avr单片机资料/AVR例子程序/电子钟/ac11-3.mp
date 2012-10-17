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
                            text   0062   0632 =   1586. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0031  __text_start
       0031  __start
       0051  _exit
       0052  _port_init
       005D  _timer0_init
       0064  _init_devices
       0069  _timer0_ovf_isr
       0210  _delay
       0226  _main
       028D  mod16s
       0291  div16s
       02AB  mod16u
       02AD  div16u
       02AE  xdiv16u
       02C7  pop_gset2
       02CA  pop_gset4
       02CD  push_gset5
       02CF  push_gset4
       02D1  push_gset3
       02D3  push_gset2
       02D5  push_gset1
       02D8  pop_gset1
       02D9  pop
       02EC  _EEPROMread
       02F1  _EEPROMwrite
       0302  _EEPROMReadBytes
       0326  _EEPROMWriteBytes
       034A  __text_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             bss   0060   000D =     13. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0060  _set_min
       0060  __bss_start
       0061  _set_sec
       0062  _min
       0063  _sec
       0064  _ms_cnt
       0066  _key_cnt
       0068  _cnt
       0069  _time_flag
       006A  _write_flag
       006B  _dpt
       006C  _dpw
       006D  __bss_end

Area                               Start  End    Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                          vector   0000   0028 =     40. bytes (abs,ovr,rom)

Files Linked      [ module(s) ]

C:\icc\lib\crtatmega.o	[ crtatmega.s ]
ac11-3.o	[ ac11 ]
<library>	[ div16s.s, div16u.s, gpop2.s, gpop4.s, gpush.s, eepromr.s, eepromw.s, eepromrbytes.s, eepromwbytes.s ]


User Global Definitions

ram_end = 0x45f
hwstk_size = 0x10

User Base Address Definitions

func_lit = 0x54
data = 0x60
eeprom:1.512

