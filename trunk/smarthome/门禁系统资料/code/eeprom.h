#ifndef __EEPROM_H_
#define __EEPROM_H_

#define RW24C256READ 1
#define RW24C256WRITE   0

void at24c256_init(void);
char rw24c256(unsigned char *data,unsigned char len,unsigned int addr, unsigned char rwFlag);

#endif

