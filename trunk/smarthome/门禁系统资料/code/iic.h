#ifndef __IIC_H__
#define __IIC_H__

#ifdef __cplusplus
extern "C" {
#endif

#define RWREAD 1
#define RWWRITE   0

void iicport_init(void);
void start(void);
void stop(void);
unsigned char recAck(void);
void ack(void);
void noAck(void);
void sendByte(unsigned char byte);
unsigned char receiveByte(void);
char rwiic(unsigned char comAddr, unsigned char *data,unsigned char len,unsigned int addr, unsigned char rwFlag);

/*
unsigned long rwiicInt(unsigned char comAddr, unsigned long data, unsigned int addr, unsigned char rwFlag);
*/

#ifdef __cplusplus
}
#endif

#endif
