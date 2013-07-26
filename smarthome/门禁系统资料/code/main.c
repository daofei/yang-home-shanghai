#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include<iom16v.h>
#include <macros.h>

#include "uart.h"
#include "wg26.h"
#include "util.h"
#include "tips.h"
#include "timer.h"
#include "ringandscreen.h"
#include "eeprom.h"
#include "password.h"
#include "locker.h"

int main(void)
{
    unsigned int door_minitor_count = 0;
    passwordItem_t t, ot;
	
    uart0_init();
    wg26_init_interrupt();
    tips_port_init();
    timer_init();
    iicport_init();
	locker_init();
	doorandscreen_init();

    t.flags = PASSWORDFLAGS_ID;
    t.idCard = 1163690;
    t.passwordH = 1;
    t.passwordL = 1;
    insertPasswordItem(0, t);

    t.flags = PASSWORDFLAGS_PASSWORD;
    t.idCard = 0;
    t.passwordH = 1135642406;
    t.passwordL = 100;
    insertPasswordItem(1, t);

    t.flags = PASSWORDFLAGS_ID;
    t.idCard = 9512827;
    t.passwordH = 1;
    t.passwordL = 1;
    insertPasswordItem(2, t);

    t.flags = PASSWORDFLAGS_ID;
    t.idCard = 1392618;
    t.passwordH = 1;
    t.passwordL = 1;
    insertPasswordItem(3, t);

	writePasswordItemNum(4);

    while(1)
    {
		door_minitor_count++;
		if(door_minitor_count>20)
		{
			//door open.
			if(check_door())
			{
				tips_err();
			}
			door_minitor_count = 0;
		}
		delay_ms(500);
    }
    return 0;
}
