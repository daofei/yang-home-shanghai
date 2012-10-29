#ifndef __PASSWORD_H__
#define __PASSWORD_H__

#ifdef __cplusplus
extern "C" {
#endif

#define PASSWORTFLAGS_UNKOWN	0x00
#define PASSWORTFLAGS_ID		0x01
#define PASSWORTFLAGS_PASSWORD	0x02
#define PASSWORTFLAGS_IDANDPWD  0x04

typedef struct __passwordItem
{
 unsigned char flags;
 unsigned long idCard;
 unsigned long long password;  
}passwordItem_t;

//read password numbers.
int readPasswordItemNum(void);

//read a password struct by index.
passwordItem_t readPasswordItem(int index);

//insert a password item.
int insertPasswordItem(passwordItem_t item);

//delete a password by index. 
//maybe change the index.
int deletePasswordItem(int index);

#ifdef __cplusplus
}
#endif

#endif