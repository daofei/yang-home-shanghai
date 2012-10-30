#include<iom16v.h>

#include "password.h"
#include "timer.h"

//pd2 input wg26 d0, pd3 input wg26 pd3.
//wg26 d0 is 0, d1 is 1.
void init_interrupt(void)
{
    //pd2,pd3 input mode.
    DDRD &= 0xf3;
    //ÉÏÀ­¡£
    PORTD |= 0x0c;
    //enable interrupt.
    SREG |= 0x80;
    //int1 int0 enable.
    GICR |= 0xc0;
    //int1 int0 fall edge.
    MCUCR |= 0x0a;
    return;
}
//diable reader.
static void disable_reader(void)
{
    GICR &= 0x3f;
    return;
}
//enable reader.
static void enable_reader(void)
{
    GICR |= 0xc0;
    return;
}

//id card id.
static unsigned long id_code = 0;
//read flags.
static unsigned int id_reader_flags = 0;
//read count.
static char read_count = 0;
//define reader flags.
#define IDREADERFLAG_WAITING 0x0000
#define IDREADERFLAG_READING 0x0001
#define IDREADERFLAG_READED 0x0002
//id code check.
static char id_reader_check(unsigned long id_code)
{
    return 0;
}

//read timeout.
static void read_time_out(char timer)
{
    if(timer == IDREADERTIMEOUTTIMER)
    {
        //disable reader.
        disable_reader();
        id_reader_flags = IDREADERFLAG_READED;
        //read ok.
        if(read_count>5) //id card.
        {
            if(!id_reader_check(id_code))
            {
                id_code &= 0x01fffffe;
                id_code >>= 1;
                password_handle(IDREADEDIDCARD, id_code);
            }
        }
        else //keypad input.
            password_handle(IDREADEDKEYPAD, id_code);
        //enable reader.
        enable_reader();
        id_reader_flags = IDREADERFLAG_WAITING;
    }
    return;
}
//set status.
static void set_id_reading_status(void)
{
    if(id_reader_flags!=IDREADERFLAG_READING)
    {
        id_reader_flags = IDREADERFLAG_READING;
        id_code = 0;
        //1*200ms.
        set_timer(IDREADERTIMEOUTTIMER, 1, read_time_out);
    }
    return;
}
//pull id card id and keypad input.
#pragma interrupt_handler int0_isr:2
void int0_isr(void)
{
    set_id_reading_status();
    if(!(PIND&0x08))
    {
        id_code <<= 1;
        id_code |= 1;
        ++read_count;
    }
    else if(!(PIND&0x04))
    {
        id_code <<= 1;
        ++read_count;
    }
    return;
}
#pragma interrupt_handler int1_isr:2
void int1_isr(void)
{
    set_id_reading_status();
    if(!(PIND&0x08))
    {
        id_code <<= 1;
        id_code |= 1;
        ++read_count;
    }
    else if(!(PIND&0x04))
    {
        id_code <<= 1;
        ++read_count;
    }
    return;
}

