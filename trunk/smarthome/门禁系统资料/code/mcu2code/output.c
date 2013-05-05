#include<iom16v.h>
#include <macros.h>

#include "output.h"
#include "util.h"
#include "input.h"
#include "timer.h"

#define KEY_DOWN (PORTB|=0x40)
#define KEY_UP (PORTB&=0xbf)
#define RING_KEY_ON (PORTB|=0x20)
#define RING_KEY_OFF (PORTB&=0xdf)

//pb0-pb7 output.
void output_port_init(void)
{
    //PINB OUTPUT AND pull-up resistors.
    DDRB = 0xff;
    PORTB = 0x0;
    return;
}

void output_screen_off(void)
{
	char loop = 0;

	while(check_screen()&&(loop<5))
	{
		KEY_DOWN;
		delay_ms(50);
		KEY_UP;
		delay_ms(50);
		loop++;
		if(loop>0)
			delay_ms(800);
	}
	return;
}

#define SCREENONTIMEOUTTIMER        0
static void screen_on_time_out(char timer)
{
	output_screen_off();
	return;
}

void output_screen_on(void)
{
	char loop = 0;

	while((!check_screen())&&(loop<5))
	{
		KEY_DOWN;
		delay_ms(50);
		KEY_UP;
		delay_ms(50);
		loop++;
		if(loop>0)
			delay_ms(800);
	}
	
	//400*100ms.
	set_timer(SCREENONTIMEOUTTIMER, 400, screen_on_time_out);
	return;
}

void output_ring_on(void)
{
	RING_KEY_ON;
	delay_ms(50);
	RING_KEY_OFF;
	return;
}

