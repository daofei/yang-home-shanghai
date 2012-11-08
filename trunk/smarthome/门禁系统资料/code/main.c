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

int main(void)
{
    unsigned int door_minitor_count = 0;
    unsigned char o[4];
    unsigned char in[4] = {0x12, 0x34, 0x56, 0x78};

	unsigned char i;
	
    uart0_init();
    init_interrupt();
    tips_port_init();
    timer_init();
    at24c256_init();
    printf("running...");

    while(1)
    {
        //door open.
        if(check_door())
        {
            door_minitor_count++;
            if(door_minitor_count>20)
            {
                tips_err();
                door_minitor_count = 0;
            }
        }
        else
        {
            if(door_minitor_count)
                door_minitor_count = 0;
        }
    }
    return 0;
}