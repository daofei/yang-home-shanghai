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
                            text   0226   0918 =   2328. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0113  __start
       0113  __text_start
       0133  _exit
       0134  _uart0_init
       0140  _port_init
       0143  _main
       019F  _init_interrupt
       01AD  _int1_isr
       01EC  _int0_isr
       0211  _delay_ms
       0226  _tips_port_init
       022D  _tips_ok
       023A  _tips_err
       0267  _tips_id_ok
       0288  __print
       042E  _strcpy
       0437  push_arg4
       0439  push_arg2
       043C  mod16s
       0440  div16s
       045A  mod16u
       045C  div16u
       045D  xdiv16u
       0476  pop_gset2
       0479  pop_gset4
       047C  pop_gset5
       047F  push_gset5
       0481  push_gset4
       0483  push_gset3
       0485  push_gset2
       0487  push_gset1
       048A  pop_gset1
       048B  pop
       049E  xicall
       04A7  _putchar
       04BE  __va_start
       04C7  _itoa
       0520  _utoa
       055C  _islower
       056A  _toupper
       0581  _printf
       059F  __text_end

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
<library>	[ _printf.s, strcpy.s, asave.s, div16s.s, div16u.s, gpop2.s, gpop4.s, gpop5.s, gpush.s, icall.s, putchar.s ]
[ stdarg.s, itoa.s, utoa.s, islower.s, ctype.s, toupper.s, printf.s, textmode.s ]

User Global Definitions

ram_end = 0x45f
hwstk_size = 0x10

User Base Address Definitions

func_lit = 0x54
data = 0x60
eeprom:1.512

