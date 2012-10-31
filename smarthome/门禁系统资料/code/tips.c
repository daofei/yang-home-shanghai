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
//led on.
void tips_led_on(void)
{
    LED_ON;
    return;
}
//led off.
void tips_led_off(void)
{
    LED_OFF;
    return;
}
//beep on.
void tips_beep_on(void)
{
    BEEP_ON;
    return;
}
//beep off.
void tips_beep_off(void)
{
    BEEP_OFF;
    return;
}
//__------__ 6 pices.pice per 0.4 seconds.
void tips_ok(void)
{
    LED_ON;
    BEEP_ON;
    //2.4 seconds.
    delay_ms(400);
    LED_OFF;
    BEEP_OFF;
    return;
}
//_-_-___-_-_
void tips_err(void)
{
    BEEP_ON;
    delay_ms(100);
    BEEP_OFF;
    delay_ms(100);
    BEEP_ON;
    delay_ms(100);
    BEEP_OFF;
 
    delay_ms(200);
 
    BEEP_ON;
    delay_ms(100);
    BEEP_OFF;
    delay_ms(100);
    BEEP_ON;
    delay_ms(100);
    BEEP_OFF;
    return;
}
//_----_-_-_
void tips_id_ok(void)
{
    BEEP_ON;
    delay_ms(200);
    BEEP_OFF;
    delay_ms(200);

    BEEP_ON;
    delay_ms(100);
    BEEP_OFF;
    delay_ms(100);
    BEEP_ON;
    delay_ms(100);
    BEEP_OFF;
    return;
}
//__------__-----__
void tips_ring_on(void)
{
    BEEP_ON;
    //2.4 seconds.
    delay_ms(400);
    BEEP_OFF;
    delay_ms(400);
    BEEP_ON;
    //2.4 seconds.
    delay_ms(400);
    BEEP_OFF;
    return;
}