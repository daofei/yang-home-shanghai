#ifndef __UART_H__
#define __UART_H__

#ifdef __cplusplus
extern "C" {
#endif

//uart0 init.
void uart0_init(void);
#ifdef NO_PRINTF
//uart0 send char.
void uart0_send(unsigned char i);
//uart0 receive.
unsigned char uart0_receive(void);
//uart0 send string
void uart0_send_string(char* string);
#endif

#ifdef __cplusplus
}
#endif

#endif
