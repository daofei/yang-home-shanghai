#include<iom16v.h>
#include <macros.h>

#include "output.h"
#include "input.h"
#include "timer.h"
#include "util.h"

int main(void)
{
	output_port_init();
	input_port_init();
	timer_init();
	
    while(1)
    {
		delay_ms(500);
    }
    return 0;
}
