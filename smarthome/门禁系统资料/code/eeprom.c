#include<iom16v.h>
#include <macros.h>

#include "util.h"
#include "iic.h"
#include "eeprom.h"

/* 一个通用的24C01－24C256共9种EEPROM的字节读写操作程序，   
此程序有五个入口条件，分别为读写数据缓冲区指针,   
进行读写的字节数，EEPROM首址，EEPROM控制字节，   
以及EEPROM类型。此程序结构性良好，具有极好的容错性，程序机器码也不多:   
DataBuff为读写数据输入／输出缓冲区的首址   
Length 为要读写数据的字节数量   
Addr 为EEPROM的片内地址 AT24256为0～32767   
Control 为EEPROM的控制字节，具体形式为(1)(0)(1)(0)(A2)(A1)(A0)(R/W),其中R/W=1,   
表示读操作,R/W=0为写操作,A2,A1,A0为EEPROM的页选或片选地址;   
enumer为枚举变量,需为AT2401至AT24256中的一种,分别对应AT24C01至AT24C256;   
函数返回值为一个位变量，若返回1表示此次操作失效，0表示操作成功;   
ERROR为允许最大次数，若出现ERRORCOUNT次操作失效后，则函数中止操作，并返回1   
SDA和SCL由用户自定义，这里暂定义为P3^0和P3^1; */   
/*对于1K位，2K位，4K位，8K位，16K位芯片采用一个8位长的字节地址码，对于32K位以上   
的采用2个8位长的字节地址码直接寻址，而4K位，8K位，16K位配合页面地址来寻址*/   
   
/* －－－－－  AT24C01～AT24C256 的读写程序 －－－－－－ */

#define AT24C256DEVADDR 0xa0

char rw24c256(unsigned char *data,unsigned char len,unsigned int addr, unsigned char rwFlag)
{
    return rwiic(AT24C256DEVADDR, data, len, addr, rwFlag);
}
