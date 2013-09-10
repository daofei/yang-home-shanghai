#ifndef __EEPROM_H_
#define __EEPROM_H_

char rw24c256(unsigned char *data,unsigned char len,unsigned int addr, unsigned char rwFlag);

#endif

