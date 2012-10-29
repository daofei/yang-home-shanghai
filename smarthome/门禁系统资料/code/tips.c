#include<iom16v.h>
#include <macros.h>

#include "tips.h"
#include "util.h"

#define BEEP_ON (PORTD&=0xef)
#define BEEP_OFF (PORTD|=0x10)
#define LED_ON (PORTD&=0xdf)
#define LED_OFF (PORTD|=0x20)

//pd4 beep,pd5 led.
void tips_port_init(void)
{
 //PIND4 & PIND5 OUTPUT AND pull-up resistors.
 PORTD |= 0x30;
 DDRD |= 0x30;
 return;
}

//__------__ 6 pices.pice per 0.4 seconds.
void tips_ok(void)
{
 LED_ON;
 BEEP_ON;
 //2.4 seconds.
 delay_ms(2400);
 LED_OFF;
 BEEP_OFF;
 return;
}
//_-_-___-_-_
void tips_err(void)
{
 BEEP_ON;
 delay_ms(400);
 BEEP_OFF;
 delay_ms(400);
 BEEP_ON;
 delay_ms(400);
 BEEP_OFF;
 
 delay_ms(800);
 
 BEEP_ON;
 delay_ms(400);
 BEEP_OFF;
 delay_ms(400);
 BEEP_ON;
 delay_ms(400);
 BEEP_OFF;
 return;
}
//_----_-_-_
void tips_id_ok(void)
{
 BEEP_ON;
 delay_ms(800);
 BEEP_OFF;
 delay_ms(800);
  
 BEEP_ON;
 delay_ms(400);
 BEEP_OFF;
 delay_ms(400);
 BEEP_ON;
 delay_ms(400);
 BEEP_OFF;
 return;
}
