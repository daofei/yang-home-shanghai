#ifndef __PASSWORD_H__
#define __PASSWORD_H__

#ifdef __cplusplus
extern "C" {
#endif

#define PASSWORDFLAGS_UNKOWN    0x00
#define PASSWORDFLAGS_ID                0x01
#define PASSWORDFLAGS_PASSWORD  0x02

#define IDREADEDIDCARD          0
#define IDREADEDKEYPAD          1

void password_handle(char type, unsigned long code);

typedef struct __passwordItem
{
    unsigned char flags;
    unsigned long idCard;
    unsigned long passwordH;
    unsigned long passwordL;
}passwordItem_t;

//read password numbers.
unsigned char readPasswordItemNum(void);

//read a password struct by index.
passwordItem_t readPasswordItem(unsigned char index);

//insert a password item.
unsigned char insertPasswordItem(passwordItem_t item);

//delete a password by index. 
//maybe change the index.
void deletePasswordItem(unsigned char index);

#ifdef __cplusplus
}
#endif

#endif