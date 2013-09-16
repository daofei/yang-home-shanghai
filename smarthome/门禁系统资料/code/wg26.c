#include<iom16v.h>

#include "password.h"
#include "timer.h"

//pc0 input wg26 d0, pc1 input wg26 d1.
//wg26 d0 is 0, d1 is 1.
void wg26_init_interrupt(void)
{
    //pc0,pc1 input mode.
    DDRC &= 0xfc;
    //ÉÏÀ­¡£
    PORTC |= 0x03;
    //enable interrupt.
    //pd2 input mode.
    DDRD &= 0xfb;
	//
	PORTD |= 0x04;
	
    SREG |= 0x80;
    //int0 enable.
    GICR |= 0x40;
    //int0 fall edge.
    MCUCR |= 0x02;
    return;
}
//diable reader.
static void disable_reader(void)
{
    GICR &= 0xbf;
    return;
}
//enable reader.
static void enable_reader(void)
{
    GICR |= 0x40;
    return;
}

static unsigned char havePassword = 0;

static unsigned char type = 0;
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
        if(read_count==26) //id card.
        {
            if(!id_reader_check(id_code))
            {
                id_code &= 0x01fffffe;
                id_code >>= 1;
                type = IDREADEDIDCARD;
                havePassword = 1;
                //password_handle(IDREADEDIDCARD, id_code);
            }
        }
        else if(read_count==4)//keypad input.
        {
            type = IDREADEDKEYPAD;
            havePassword = 1;
            //password_handle(IDREADEDKEYPAD, id_code);
        }
        //enable reader.
        enable_reader();
        id_reader_flags = IDREADERFLAG_WAITING;
        read_count = 0;
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
        //1*100ms.
        set_timer(IDREADERTIMEOUTTIMER, 1, read_time_out);
    }
    return;
}
//pull id card id and keypad input.
#pragma interrupt_handler int0_isr:2
void int0_isr(void)
{
    set_id_reading_status();
    if(!(PINC&0x02))
    {
        id_code <<= 1;
        id_code |= 1;
    }
    else if(!(PINC&0x01))
    {
        id_code <<= 1;
    }
    ++read_count;
    return;
}

void wg26_spank(void)
{
    if(1==havePassword)
    {
        password_handle(type, id_code);
        havePassword = 0;
    }
    return;
}

