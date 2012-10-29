#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <string.h>

#include<iom16v.h>
#include <macros.h>

#include "init.h"
#include "uart.h"
#include "wg26.h"
#include "util.h"
#include "tips.h"

extern unsigned long id_code;

int main(void)
{
 port_init();
 uart0_init();
 init_interrupt();
 tips_port_init();
 //uart0_send_string("uart send...\n");
 PORTB = 0xff;
 while(1)
 {
  //uart0_send_string("uart send testing...\n");
  //PORTB = 0xff;
  //SEI();
  
  delay_ms(500);
  if(id_code)
  {
   //printf("sizeof(long)=%x", sizeof(long));
   id_code &= 0x01fffffe;
   id_code >>= 1;
   printf("id_code=%d", id_code);
  }
  
  if(id_code == 1392618)
  {
   PORTB = 0x0;
  }
 }
 return 0;
}