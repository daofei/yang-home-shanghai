#include <stdio.h>
#include <stdlib.h>

#include<iom16v.h>
#include <macros.h>

#include "password.h"

int readPasswordItemNum(void)
{

 return 0;
}
passwordItem_t readPasswordItem(int index)
{
 passwordItem_t item;
 return item;
}

int insertPasswordItem(passwordItem_t item)
{
 return 0;
}
//maybe change the index.
int deletePasswordItem(int index)
{
 return 0;
}

static unsigned char password_read_flags = 0;

//You input xxx then password is 1xxx.
static unsigned long passwordH = 1;
static unsigned long passwordL = 1;

void password_handle(char type, unsigned long code)
{
 if(type==IDREADEDIDCARD)
 {
  printf("ID Card:%d", code);
 }
 else if(type==IDREADEDKEYPAD)
 {
  code &= 0x0000000f;
  if(code == 0x0000000a)  //*
  {
   printf("Press *");
   //clear password.
   passwordL = 1;
  }
  else if(code == 0x0000000b) //#
  {
   printf("Press #");
   //handle password.
   printf("Ok.pswd:%d", passwordL);
  }
  else
  {
   printf("Press %d", code);
   passwordL = passwordL*10 + code;
   printf("pswd:%d", passwordL);
  }
 }
 return;
}
