#include<iom16v.h>

#include "uart.h"
#include "log.h"

/**
ok log                             0                             id&card                     x                            x                          x
err log                            1                             id&card                     x                            x                          x
*/

void log(unsigned char comId, unsigned char msgType, unsigned long id_code, unsigned long pswdH, unsigned long pswdL)
{
    uart0_send(comId);
    uart0_send(msgType);
    uart0_send_buffer((unsigned char*)(&id_code), 4);
    uart0_send_buffer((unsigned char*)(&pswdH), 4);
    uart0_send_buffer((unsigned char*)(&pswdL), 4);
    return;
}
