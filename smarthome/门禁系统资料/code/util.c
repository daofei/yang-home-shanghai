#include "util.h"

#define XTAL    8
void delay_1ms(void)
{
    int i;
    //XTAL*143-2 = 1142
    for(i=1;i<1142;i++);
}
//=========================================
void delay_ms(int ms)
{
    int i=0;
    while(i<ms)
    {
        delay_1ms();
        i++;
    }
}

