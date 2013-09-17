#include<iom16v.h>
#include <macros.h>

#include "util.h"
#include "tips.h"
#include "timer.h"
#include "ringandscreen.h"

//door monitor input is pa0.
//screen power output pb2.

#define SCREEN_ON (PORTB &= 0xfb)
#define SCREEN_OFF (PORTB |= 0x04)

void doorandscreen_init(void)
{
    //PA0 INPUT.
    DDRA &= 0xfe;
	PORTA |= 0x01;
    //pb2 hi-z
    DDRB &= 0xfb;
    PORTB &= 0xfb;
    //init interrput.
    return;
}

/**
#define SCREEN_RESET_START (PORTC&=0xef)
#define SCREEN_RESET_STOP (PORTC|=0x10)
#define RING_ON (PORTC&=0xdf)
#define RING_OFF (PORTC&=0x20)

void ringandscreen_init(void)
{
    //PC0,PC1,PC2 INPUT.
    DDRC &= 0xf8;
    //PC3,PC4,PC5 OUTPUT.
    DDRC |= 0x38;
    //
    PORTC = 0xff;
    //init interrput.
    return;
}

static void disable_input(void)
{

}

static void enable_input(void)
{

}

void screen_on(void)
{
    if((PORTC&=0x04))
    {
        SCREEN_ON;
        delay_ms(500);
        SCREEN_RESET_START;
        delay_ms(100);
        SCREEN_RESET_STOP;
    }
    return;
}

void screen_off(void)
{
    SCREEN_OFF;
    return;
}

void ring_on(void)
{
    RING_ON;
    delay_ms(20);
    RING_OFF;
    return;
}

void ring_screen_timeout(char timer)
{
    if(timer==RINGANDSCREENINPUTTIMER)
    {
        screen_off();
    }
}

void door_minitor_timeout(char timer)
{
    if(timer==RINGANDSCREENINPUTTIMER)
    {
        tips_err();
        //start timer. 10s.
        set_timer(RINGANDSCREENINPUTTIMER, 140, door_minitor_timeout); 
    }
}

void input_isr(void)
{
    disable_input();
    //
    delay_ms(100);
    if(!(PINC&0x01)) //ring input.
    {
        screen_on();
        ring_on();
        tips_ring_on();
        //start timer. 50s.
        set_timer(RINGANDSCREENINPUTTIMER, 600, ring_screen_timeout);
    }
    else if(!(PIND&0x02)) //screen key input.
    {
        screen_on();
        delay_ms(800);
        //start timer. 50s.
        set_timer(RINGANDSCREENINPUTTIMER, 600, ring_screen_timeout);
    }
    enable_input();
    return;
}
**/

void screen_on(void)
{
    //pb2 OUTPUT.
    DDRB |= 0x04;
    
    SCREEN_ON;
	delay_ms(20);
	SCREEN_OFF;

    //pb2 hi-z
    DDRB &= 0xfb;
    PORTB &= 0xfb;
    return;
}

//when door open, return 1.
char check_door(void)
{
    return 0;//(PINA&0x01);
}

