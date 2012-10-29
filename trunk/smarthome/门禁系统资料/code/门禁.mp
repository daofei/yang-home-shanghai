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
                           idata   0157   00CE =    206. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0157  __idata_start
       0225  __idata_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   0226   084A =   2122. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0113  __text_start
       0113  __start
       0132  _exit
       0133  _uart0_init
       013F  _port_init
       0142  _main
       017C  _init_interrupt
       018A  _int1_isr
       01AD  _int0_isr
       01C2  _delay_ms
       01D5  _tips_port_init
       01DC  _tips_ok
       01EA  _tips_err
       0202  _tips_id_ok
       0218  _readPasswordItemNum
       021B  _readPasswordItem
       022A  _insertPasswordItem
       022D  _deletePasswordItem
       0230  __print
       0371  _strcpy
       037A  push_arg4
       037C  push_arg2
       037F  mod16s
       0383  div16s
       0398  mod16u
       039A  div16u
       039B  xdiv16u
       03B4  pop_gset2
       03B6  pop_gset4
       03B8  pop_gset5
       03BA  push_gset5
       03BC  push_gset4
       03BE  push_gset3
       03C0  push_gset2
       03C2  push_gset1
       03C5  pop_gset1
       03C6  pop
       03D9  xicall
       03E2  asgnblk
       03FA  _putchar
       040F  __va_start
       0418  _itoa
       0458  _utoa
       0487  _islower
       0495  _toupper
       04A9  _printf
       04C2  <created procedures>
       0538  __text_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            data   0060   00CE =    206. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0060  __data_start
       006B  _id_code
       012E  __data_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             bss   012E   001B =     27. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       012E  __bss_start
       0147  __textmode
       0149  __bss_end

Area                               Start  End    Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                          vector   0000   000C =     12. bytes (abs,ovr,rom)

Files Linked      [ module(s) ]

C:\icc\lib\crtatmega.o	[ crtatmega.s ]
uart.o	[ uart.c ]
init.o	[ init.c ]
main.o	[ main.c ]
wg26.o	[ wg26.c ]
util.o	[ util.c ]
tips.o	[ tips.c ]
password.o	[ password.c ]
<library>	[ _printf.s, strcpy.s, asave.s, div16s.s, div16u.s, gpop2.s, gpop4.s, gpop5.s, gpush.s, icall.s, struct.s ]
[ putchar.s, stdarg.s, itoa.s, utoa.s, islower.s, ctype.s, toupper.s, printf.s, textmode.s ]

User Global Definitions

ram_end = 0x45f
hwstk_size = 0x10

User Base Address Definitions

func_lit = 0x54
data = 0x60
eeprom:1.512

