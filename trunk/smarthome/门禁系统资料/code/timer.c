#include<iom16v.h>
#include <macros.h>

#include "timer.h"

void timer_init(void)
{
    //enable interrupt.
    SREG |= 0x80;
    //timer0 normal mode.ck/1024.
    TCCR0 |= 0x05;
    //init TCNT0.
    TCNT0 = 0;
    //TIMSK
    //TIMSK |= 0x01;
    return; 
}
//cpu timer0 start
static void t0_start(void)
{
    TIMSK |= 0x01;
    return;
}
//cpu timer0 stop
static void t0_stop(void)
{
    TIMSK &= 0xfe;
    return;
}
//
static timer_t g_timer[MAXTIMER];
//set timer and start timer. set value 0, need wait a cpu timer pice.
void set_timer(char timer, int value, timerCB cb)
{
    //value=0, stoped timer.
    g_timer[timer].value = value+1;
    g_timer[timer].cb = cb;
    if(g_timer[timer].value)
        t0_start();
    return;
}
//stop timer and clean timer.
void stop_timer(char timer)
{
    if(g_timer[timer].value)
    {
        //stop this timer.
        g_timer[timer].value = 0;
        g_timer[timer].cb = 0;
    }
    return;
}
//timer spank.
#pragma interrupt_handler timer0_isr:10
void timer0_isr(void)
{
    static char time_pices = 0;
    ++time_pices;
    //200ms.
    if(time_pices == 2)
    {
        char running_timer_count = 0;
        char i;
        for(i=0;i<MAXTIMER;i++)
        {
            if(g_timer[i].value>1)
            {
                --g_timer[i].value;
                ++running_timer_count;
            }
            //timer call back.
            else if(g_timer[i].value==1)
            {
                g_timer[i].value = 0;
                if(g_timer[i].cb)
                {
                    //disable cpu timer.
                    t0_stop();
                    (g_timer[i].cb)(i);
                    //enable cpu timer.
                    t0_start();
                }
            }
        }
        time_pices = 0;
        //if no timer running, stop cpu timer.
        if(!running_timer_count) t0_stop();
    }
    return;
}