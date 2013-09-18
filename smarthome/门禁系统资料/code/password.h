#ifndef __PASSWORD_H__
#define __PASSWORD_H__

#ifdef __cplusplus
extern "C" {
#endif

#define PASSWORDFLAGS_UNKOWN    0x00
#define PASSWORDFLAGS_ID                0x01
#define PASSWORDFLAGS_PASSWORD  0x02

#define IDREADEDUNKOWN          0
#define IDREADEDIDCARD          1
#define IDREADEDKEYPAD          2

void password_handle_err(void);

void password_handle_ok(void);

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
void insertPasswordItem(unsigned char index, passwordItem_t item);

void writePasswordItemNum(unsigned char num);

#ifdef __cplusplus
}
#endif

#endif
