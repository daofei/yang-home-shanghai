#include<iom16v.h>

#include "timer.h"
#include "util.h"
#include "locker.h"

#define LOCKERINIT (PORTB&=0xe7)
#define LOCKERUNLOCK (PORTB&=0xf7,PORTB|=0x10)
#define LOCKERLOCK (PORTB&=0xef,PORTB|=0x08)

void locker_init(void)
{
    //pb3 pb4 OUTPUT.
    DDRB |= 0x18;
    //output low
    PORTB &= 0xe7;
    return;
}

//unlock timeout.
static void unlock_time_out(char timer)
{
    if(timer==UNLOCKTIMEOUTTIMER)
    {
		LOCKERLOCK;
		delay_ms(600);
		LOCKERINIT;
	}
    return;
}

void locker_unlock(void)
{
	LOCKERUNLOCK;
    delay_ms(600);
	LOCKERINIT;
	//set time out. 100ms*10*30
	set_timer(UNLOCKTIMEOUTTIMER, 150, unlock_time_out);
	return;
}

