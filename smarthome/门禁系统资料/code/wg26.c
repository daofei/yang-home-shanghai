#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include<iom16v.h>
#include <macros.h>

#include "uart.h"

void init_interrupt(void)
{
 //pd2,pd3 input mode.
 DDRD &= 0xf3;
 //…œ¿≠°£
 PORTD |= 0x0c;
 //enable interrupt.
 SREG |= 0x80;
 //int1 int0 enable.
 GICR |= 0xc0;
  //int1 int0 fall edge.
 MCUCR |= 0x0a;
 return;
}

unsigned long id_code = 0;

#pragma interrupt_handler int1_isr:3
void int1_isr(void)
{
 id_code <<= 1;
 id_code |= 1;
}

#pragma interrupt_handler int0_isr:2
void int0_isr(void)
{
 id_code <<= 1;
 //PORTB = 0x00;
}