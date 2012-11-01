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
#include "ringandscreen.h"

int main(void)
{
    unsigned int door_minitor_count = 0;
    
    port_init();
    uart0_init();
    init_interrupt();
    tips_port_init();
    timer_init();
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
        delay_ms(500);
    }
    return 0;
}