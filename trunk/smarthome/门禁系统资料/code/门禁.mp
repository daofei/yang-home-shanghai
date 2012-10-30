NOTE: AVR Code addresses are word addresses
All other addresses (including ones in FLASH) are byte addresses

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                        func_lit   0054   0004 =      4. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0054  __func_lit_start
       0058  __func_lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             lit   0058   0101 =    257. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0058  __lit_start
       0058  __ctype
       0159  __lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                           idata   0159   0112 =    274. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0159  __idata_start
       026B  __idata_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   026C   0CB6 =   3254. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0136  __text_start
       0136  __start
       0155  _exit
       0156  _uart0_init
       0162  _port_init
       0163  _main
       0175  _init_interrupt
       01F4  _int0_isr
       020F  _int1_isr
       022A  _delay_ms
       023D  _tips_port_init
       0244  _tips_led_on
       0248  _tips_led_off
       024A  _tips_beep_on
       024E  _tips_beep_off
       0250  _tips_ok
       025E  _tips_err
       0276  _tips_id_ok
       028C  _readPasswordItemNum
       028F  _readPasswordItem
       029E  _insertPasswordItem
       02A1  _deletePasswordItem
       02A4  _password_handle
       031D  _timer_init
       032C  _set_timer
       034C  _stop_timer
       0363  _timer0_isr
       03BF  __print
       0500  _strcpy
       0509  push_arg4
       050B  push_arg2
       050C  mod16s
       0510  div16s
       0525  mod16u
       0527  div16u
       0528  xdiv16u
       0541  empy32u
       0541  empy32s
       056D  pop_gset2
       056F  pop_gset3
       0571  pop_gset4
       0573  pop_gset5
       0575  push_gset5
       0577  push_gset4
       0579  push_gset3
       057B  push_gset2
       057D  push_gset1
       0580  pop_gset1
       0581  pop
       0594  xicall
       059D  long_prolog
       05AB  long_epilog
       05B6  tstzero1
       05BC  tstzero2
       05C2  push_lset
       05D5  pop_lset
       05EC  asgnblk
       0604  _putchar
       0619  __va_start
       0622  _itoa
       0661  _utoa
       068F  _islower
       069D  _toupper
       06B1  _printf
       06CA  <created procedures>
       0791  __text_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            data   0060   0112 =    274. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0060  __data_start
       0172  __data_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             bss   0172   002B =     43. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0172  __bss_start
       019B  __textmode
       019D  __bss_end

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
<library>	[ _printf.s, strcpy.s, asave.s, div16s.s, div16u.s, emul32.s, gpop2.s, gpop3.s, gpop4.s, gpop5.s, gpush.s ]
[ icall.s, longutil.s, lpush.s, struct.s, putchar.s, stdarg.s, itoa.s, utoa.s, islower.s, ctype.s, toupper.s ]
[ printf.s, textmode.s ]

User Global Definitions

ram_end = 0x45f
hwstk_size = 0x10

User Base Address Definitions

func_lit = 0x54
data = 0x60
eeprom:1.512

