NOTE: AVR Code addresses are word addresses
All other addresses (including ones in FLASH) are byte addresses

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                        func_lit   0054   0002 =      2. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0054  __func_lit_start
       0056  __func_lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             lit   0056   0101 =    257. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0056  __lit_start
       0056  __ctype
       0157  __lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                           idata   0157   00EC =    236. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0157  __idata_start
       0243  __idata_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   0244   0AC0 =   2752. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0122  __text_start
       0122  __start
       0141  _exit
       0142  _uart0_init
       014E  _port_init
       0151  _main
       0196  _init_interrupt
       01A4  _int1_isr
       01C1  _int0_isr
       01D0  _delay_ms
       01E3  _tips_port_init
       01EA  _tips_led_on
       01EE  _tips_led_off
       01F0  _tips_beep_on
       01F4  _tips_beep_off
       01F6  _tips_ok
       0204  _tips_err
       021C  _tips_id_ok
       0232  _readPasswordItemNum
       0235  _readPasswordItem
       0244  _insertPasswordItem
       0247  _deletePasswordItem
       024A  _timer_init
       0259  _get_timer
       0273  _set_timer
       0284  _set_timer_cb
       0298  _start_timer
       02A7  _stop_timer
       02D0  _timer0_isr
       0331  __print
       0472  _strcpy
       047B  push_arg4
       047D  push_arg2
       047E  mod16s
       0482  div16s
       0497  mod16u
       0499  div16u
       049A  xdiv16u
       04B3  pop_gset2
       04B5  pop_gset4
       04B7  pop_gset5
       04B9  push_gset5
       04BB  push_gset4
       04BD  push_gset3
       04BF  push_gset2
       04C1  push_gset1
       04C4  pop_gset1
       04C5  pop
       04D8  xicall
       04E1  push_lset
       04F6  pop_lset
       050D  asgnblk
       0525  _putchar
       053A  __va_start
       0543  _itoa
       0582  _utoa
       05B0  _islower
       05BE  _toupper
       05D2  _printf
       05EB  <created procedures>
       0682  __text_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            data   0060   00EC =    236. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0060  __data_start
       0088  _id_code
       014C  __data_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             bss   014C   002B =     43. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       014C  __bss_start
       0175  __textmode
       0177  __bss_end

Area                               Start  End    Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                          vector   0000   0028 =     40. bytes (abs,ovr,rom)

Files Linked      [ module(s) ]

C:\icc\lib\crtatmega.o	[ crtatmega.s ]
uart.o	[ uart.c ]
init.o	[ init.c ]
main.o	[ main.c ]
wg26.o	[ wg26.c ]
util.o	[ util.c ]
tips.o	[ tips.c ]
password.o	[ password.c ]
timer.o	[ timer.c ]
<library>	[ _printf.s, strcpy.s, asave.s, div16s.s, div16u.s, gpop2.s, gpop4.s, gpop5.s, gpush.s, icall.s, lpush.s ]
[ struct.s, putchar.s, stdarg.s, itoa.s, utoa.s, islower.s, ctype.s, toupper.s, printf.s, textmode.s ]


User Global Definitions

ram_end = 0x45f
hwstk_size = 0x10

User Base Address Definitions

func_lit = 0x54
data = 0x60
eeprom:1.512

