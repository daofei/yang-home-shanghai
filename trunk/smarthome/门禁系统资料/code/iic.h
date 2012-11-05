#ifndef __IIC_H__
#define __IIC_H__

#ifdef __cplusplus
extern "C" {
#endif

//管脚定义
#define pinSCL    0     //PC0 SCL
#define pinSDA    1     //PC1 SDA
//为保险起见,最好在SCL/SDA接上1~10K的外部上拉电阻到VCC。

#define fSCL    1000000    //TWI时钟为1000KHz
//预分频系数=1(TWPS=0)
#if F_CPU < fSCL*36
#define TWBR_SET    2;     //TWBR必须大于等于10
#else
#define TWBR_SET    (F_CPU/fSCL-16)/2; //计算TWBR值
#endif

#define TW_ACT    (1<<TWINT)|(1<<TWEN)|(1<<TWIE)
//TWCR只能IN/OUT,直接赋值比逻辑运算(|= &=)更节省空间

#define SLA_24CXX     0xA0    //24Cxx系列的厂商器件地址(高四位)
#define ADDR_24C256   0x00
// AT24C256的地址线A2/1/0全部接地，SLAW=0xA0+0x00<<1+0x00,SLAR=0xA0+0x00<<1+0x01

//TWI_操作状态
#define TW_BUSY    0
#define TW_OK    1
#define TW_FAIL    2

//TWI_读写命令状态
#define OP_BUSY    0
#define OP_RUN    1


//TWI读写操作公共步骤
#define ST_FAIL    0 //出错状态
#define ST_START   1 //START状态检查
#define ST_SLAW    2 //SLAW状态检查
#define ST_WADDR_H   3 //ADDR状态检查
#define ST_WADDR_L   4 //ADDR状态检查

//TWI读操作步骤
#define ST_RESTART   5 //RESTART状态检查
#define ST_SLAR    6 //SLAR状态检查
#define ST_RDATA   7 //读取数据状态检查，循环n字节

//TWI写操作步骤
#define ST_WDATA   8 //写数据状态检查，循环n字节

#define FAIL_MAX   1 //重试次数最大值

void EEprom_RW(unsigned RW,unsigned int addr,unsigned char *ptr,unsigned int len);

unsigned char TWI_RW(unsigned char sla,unsigned int addr,unsigned char *ptr,unsigned int len);

typedef struct __strTWI         //TWI数据结构
{
    volatile unsigned char status;    //TWI_操作状态
    unsigned char sladdr;           //从设备的器件地址
    unsigned char sldaddrH;      //从设备的数据地址
    unsigned char sldaddrL;      //从设备的数据地址
    unsigned char *data;         //数据缓冲区指针
    unsigned int dataLen;     //数据长度
    unsigned char state;      //TWI读写操作步骤
    unsigned char retry;     //失败重试次数
}strTWI_t;

#define EEPROM_READ 0
#define EEPROM_WRITE 1

#ifdef __cplusplus
}
#endif

#endif
