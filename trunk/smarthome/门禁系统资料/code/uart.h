#ifndef __UART_H__
#define __UART_H__

#ifdef __cplusplus
extern "C" {
#endif

//uart0 init.
void uart0_init(void);
//uart0 send char.
void uart0_send(unsigned char i);
//uart0 receive.
unsigned char uart0_receive(void);
//uart0 send buffer
void uart0_send_buffer(unsigned char* buffer, unsigned char len);
//uart0 send buffer
unsigned char uart0_read_buffer(unsigned char* buffer, unsigned char len);

/**
-----------------------------------------------------------------------------------------------------
command context    |command type(1byte)|msg type(1byte)|id card(4bytes)|password H(4bytes)|password L(4bytes)|
   ok log                             0                             pswd&card                     x                            x                          x
   err log                            1                             pswd&card                     x                            x                          x
   read item num                2                              0                               0                           0                           0
   return item num              3                              item num                 0                           0                           0
   read item by index           4                               item index              0                           0                           0
   return item                      5                              pswd&card                   x                            x                           x 
   delete all item                  6                              item num                 0                           0                           0
   insert a item                    7                                pswd&card                  x                             x                           x
   unlock by id or password  8                                pswd&card                  x                           x                           x
   return commd ok             9                            0                               0                           0                           0
 ----------------------------------------------------------------------------------------------------
*/

#define COMMANDIDLOGOK          0
#define COMMANDIDLOGERR         1
#define COMMANDIDREADITEMNUM    2
#define COMMANDIDRETURNITEMNUM  3
#define COMMANDIDREADITEM       4
#define COMMANDIDRETURNITEM     5
#define COMMANDIDDELETEITEMS    6
#define COMMANDIDINSERTITEM     7
#define COMMANDIDUNLOCK         8
#define COMMANDRETURNOK         9

#ifdef __cplusplus
}
#endif

#endif
