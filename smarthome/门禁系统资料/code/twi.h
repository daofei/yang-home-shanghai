#ifndef __TWI_H__
#define __TWI_H__

#ifdef __cplusplus
extern "C" {
#endif

// TWSR values (not bits)
// (taken from avr-libc twi.h - thank you Marek Michalkiewicz)
// Master
#define TW_START					0x08
#define TW_REP_START				0x10
// Master Transmitter
#define TW_MT_SLA_ACK				0x18
#define TW_MT_SLA_NACK				0x20
#define TW_MT_DATA_ACK				0x28
#define TW_MT_DATA_NACK				0x30
#define TW_MT_ARB_LOST				0x38
// Master Receiver
#define TW_MR_ARB_LOST				0x38
#define TW_MR_SLA_ACK				0x40
#define TW_MR_SLA_NACK				0x48
#define TW_MR_DATA_ACK				0x50
#define TW_MR_DATA_NACK				0x58
// Slave Transmitter
#define TW_ST_SLA_ACK				0xA8
#define TW_ST_ARB_LOST_SLA_ACK		0xB0
#define TW_ST_DATA_ACK				0xB8
#define TW_ST_DATA_NACK				0xC0
#define TW_ST_LAST_DATA				0xC8
// Slave Receiver
#define TW_SR_SLA_ACK				0x60
#define TW_SR_ARB_LOST_SLA_ACK		0x68
#define TW_SR_GCALL_ACK				0x70
#define TW_SR_ARB_LOST_GCALL_ACK	0x78
#define TW_SR_DATA_ACK				0x80
#define TW_SR_DATA_NACK				0x88
#define TW_SR_GCALL_DATA_ACK		0x90
#define TW_SR_GCALL_DATA_NACK		0x98
#define TW_SR_STOP					0xA0
// Misc
#define TW_NO_INFO					0xF8
#define TW_BUS_ERROR				0x00

// defines and constants
#define TWCR_CMD_MASK		0x0F
#define TWSR_STATUS_MASK	0xF8

// return values
#define I2C_OK				0x00
#define I2C_ERROR_NODEV		0x01

//option function
#define Start() (TWCR=(1<<TWINT)|(1<<TWSTA)|(1<<TWEN))
#define Stop()  (TWCR=(1<<TWINT)|(1<<TWSTO)|(1<<TWEN))
#define Wait()  {while(!(TWCR&(1<<TWINT)));}
#define TestAck()   (TWSR&0xf8)
#define SetAck  (TWCR|=(1<<TWEA))
#define SetNoAck    (TWCR&=~(1<<TWEA))
#define Twi()   (TWCR=(1<<TWINT)|(1<<TWEN))
#define Write8Bit(x)    {TWDR=(x);TWCR=(1<<TWINT)|(1<<TWEN);}

char rwiic(unsigned char comAddr, unsigned char *data,unsigned char len,unsigned int addr, unsigned char rwFlag);

void iicSlaveInit(unsigned char address);

void iicSlaveStop(void);


#ifdef __cplusplus
}
#endif

#endif

