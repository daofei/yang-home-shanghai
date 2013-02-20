#include<iom16v.h>
#include <macros.h>

#include "output.h"
#include "util.h"
#include "input.h"

void input_port_init(void)
{
    //pa input mode.
    DDRA = 0x0;
    //上拉。
    PORTA = 0xff;
	//pc0 input screen status.
	DDRC &= 0xfe;
    //上拉。
	PORTC &= 0xfe;
	
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

char check_screen(void)
{
    return (PINC&0x01);
}

//diable reader.
static void disable_input(void)
{
    GICR &= 0xbf;
    return;
}
//enable reader.
static void enable_input(void)
{
    GICR |= 0x40;
    return;
}


//pull id card id and keypad input.
#pragma interrupt_handler int0_isr:2
void int0_isr(void)
{
	disable_input();
	delay_ms(10);
	if(!(PINA&0x80)) //id reader ring.
	{
		output_ring_on();
		output_screen_on();
	}
	else if(!(PINA&0x40))
	{
		output_ring_on();
		output_screen_on();
	}
	else if(!(PINA&0x01))
	{
		output_screen_on();
	}
	else
	{
		;
	}
	enable_input();
    return;
}



