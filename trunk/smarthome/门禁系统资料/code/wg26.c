#include<iom16v.h>
#include <macros.h>

#include "uart.h"

void init_interrupt1(void)
{
 //DDRD = 0x00;
 SREG = 0x80;
 GICR = 0x80;
 MCUCR = 0x08; //INT1ÏÂ½µÑØ´¥·¢¡£
 return;
}

unsigned char interr = 0;

#pragma interrupt_hander intsb:3
void intsb(void)
{
 //uart0_send_string("int1 enable.\n");
 interr = 1;
 //PORTB = 0x00;
}
