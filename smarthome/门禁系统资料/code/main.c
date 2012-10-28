#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include<iom16v.h>
#include <macros.h>

#include "init.h"
#include "uart.h"
#include "wg26.h"
#include "util.h"

extern unsigned char interr;

int main(void)
{
 port_init();
 uart0_init();
 init_interrupt1();
 uart0_send_string("uart send...\n");
 PORTB = 0xff;
 while(1)
 {
  //uart0_send_string("uart send testing...\n");
  //PORTB = 0xff;
  if(interr)
  {
    //delay_ms(500);
    PORTB = 0x00;
  }
  SEI();
  //delay_ms(500);
 }
 return 0;
}