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

int main(void)
{
    unsigned int door_minitor_count = 0;
    passwordItem_t t;

    uart0_init();
    init_interrupt();
    tips_port_init();
    timer_init();
    at24c256_init();
    //printf("running...");
    t.flags = PASSWORDFLAGS_ID |PASSWORDFLAGS_PASSWORD;
    t.idCard = 1392618;
    t.passwordH = 1;
    t.passwordL = 1007;
    insertPasswordItem(0, t);

    t.flags = PASSWORDFLAGS_PASSWORD;
    t.idCard = 0;
    t.passwordH = 113564240;
    t.passwordL = 1600;
    insertPasswordItem(1, t);

    t.flags = PASSWORDFLAGS_PASSWORD;
    t.idCard = 0;
    t.passwordH = 131415926;
    t.passwordL = 15;
    insertPasswordItem(2, t);

    writePasswordItemNum(3);

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
