#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include<iom16v.h>
#include <macros.h>

#include "init.h"
#include "uart.h"
#include "wg26.h"
#include "util.h"
#include "tips.h"
#include "timer.h"

extern unsigned long id_code;

int main(void)
{
 port_init();
 uart0_init();
 init_interrupt();
 tips_port_init();
 timer_init();
 printf("running...");
 //uart0_send_string("uart send...\n");
 PORTB = 0xff;
 while(1)
 {
  if(id_code)
  {
   printf("sizeof(double)=%d", sizeof(double));
   id_code &= 0x01fffffe;
   id_code >>= 1;
   printf("id_code=%d", id_code);
  }
  delay_ms(200);
  if(id_code == 1392618)
  {
   PORTB = 0x0;
  }
 }
 return 0;
}