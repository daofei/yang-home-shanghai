#ifndef __EEPROM_H_
#define __EEPROM_H_

#define RW24C256READ 1
#define RW24C256WRITE   0

char rw24c256(unsigned char *data,unsigned char len,unsigned int addr, unsigned char rwFlag);
unsigned long rw24c256Int(unsigned long data, unsigned int addr, unsigned char rwFlag);

#endif

