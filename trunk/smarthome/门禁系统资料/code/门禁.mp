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
                           idata   0157   00DE =    222. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0157  __idata_start
       0235  __idata_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   0236   086C =   2156. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       011B  __start
       011B  __text_start
       013B  _exit
       013C  _uart0_init
       0148  _port_init
       014B  _main
       01B3  _init_interrupt
       01C1  _int1_isr
       0200  _int0_isr
       0225  _delay_ms
       023A  __print
       03E0  _strcpy
       03E9  push_arg4
       03EB  push_arg2
       03EE  mod16s
       03F2  div16s
       040C  mod16u
       040E  div16u
       040F  xdiv16u
       0428  pop_gset2
       042B  pop_gset4
       042E  pop_gset5
       0431  push_gset5
       0433  push_gset4
       0435  push_gset3
       0437  push_gset2
       0439  push_gset1
       043C  pop_gset1
       043D  pop
       0450  xicall
       0459  _putchar
       0470  __va_start
       0479  _itoa
       04D2  _utoa
       050E  _islower
       051C  _toupper
       0533  _printf
       0551  __text_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            data   0060   00DE =    222. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0060  __data_start
       007B  _id_code
       013E  __data_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             bss   013E   001B =     27. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       013E  __bss_start
       0157  __textmode
       0159  __bss_end

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
<library>	[ _printf.s, strcpy.s, asave.s, div16s.s, div16u.s, gpop2.s, gpop4.s, gpop5.s, gpush.s, icall.s, putchar.s ]
[ stdarg.s, itoa.s, utoa.s, islower.s, ctype.s, toupper.s, printf.s, textmode.s ]

User Global Definitions

ram_end = 0x45f
hwstk_size = 0x10

User Base Address Definitions

func_lit = 0x54
data = 0x60
eeprom:1.512

