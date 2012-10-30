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

int main(void)
{
    port_init();
    uart0_init();
    init_interrupt();
    tips_port_init();
    timer_init();
    printf("running...");
    while(1)
    {
        delay_ms(200);
    }
    return 0;
}