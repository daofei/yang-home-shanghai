#ifndef __IIC_H__
#define __IIC_H__

#ifdef __cplusplus
extern "C" {
#endif

void start(void);
void stop(void);
unsigned char recAck(void);
void ack(void);
void noAck(void);
void sendByte(unsigned char byte);
unsigned char receiveByte(void);

#ifdef __cplusplus
}
#endif

#endif
