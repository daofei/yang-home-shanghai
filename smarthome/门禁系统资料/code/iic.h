#ifndef __IIC_H__
#define __IIC_H__

#ifdef __cplusplus
extern "C" {
#endif

//�ܽŶ���
#define pinSCL    0     //PC0 SCL
#define pinSDA    1     //PC1 SDA
//Ϊ�������,�����SCL/SDA����1~10K���ⲿ�������赽VCC��

#define fSCL    1000000    //TWIʱ��Ϊ1000KHz
//Ԥ��Ƶϵ��=1(TWPS=0)
#if F_CPU < fSCL*36
#define TWBR_SET    2;     //TWBR������ڵ���10
#else
#define TWBR_SET    (F_CPU/fSCL-16)/2; //����TWBRֵ
#endif

#define TW_ACT    (1<<TWINT)|(1<<TWEN)|(1<<TWIE)
//TWCRֻ��IN/OUT,ֱ�Ӹ�ֵ���߼�����(|= &=)����ʡ�ռ�

#define SLA_24CXX     0xA0    //24Cxxϵ�еĳ���������ַ(����λ)
#define ADDR_24C256   0x00
// AT24C256�ĵ�ַ��A2/1/0ȫ���ӵأ�SLAW=0xA0+0x00<<1+0x00,SLAR=0xA0+0x00<<1+0x01

//TWI_����״̬
#define TW_BUSY    0
#define TW_OK    1
#define TW_FAIL    2

//TWI_��д����״̬
#define OP_BUSY    0
#define OP_RUN    1


//TWI��д������������
#define ST_FAIL    0 //����״̬
#define ST_START   1 //START״̬���
#define ST_SLAW    2 //SLAW״̬���
#define ST_WADDR_H   3 //ADDR״̬���
#define ST_WADDR_L   4 //ADDR״̬���

//TWI����������
#define ST_RESTART   5 //RESTART״̬���
#define ST_SLAR    6 //SLAR״̬���
#define ST_RDATA   7 //��ȡ����״̬��飬ѭ��n�ֽ�

//TWIд��������
#define ST_WDATA   8 //д����״̬��飬ѭ��n�ֽ�

#define FAIL_MAX   1 //���Դ������ֵ

void EEprom_RW(unsigned RW,unsigned int addr,unsigned char *ptr,unsigned int len);

unsigned char TWI_RW(unsigned char sla,unsigned int addr,unsigned char *ptr,unsigned int len);

typedef struct __strTWI         //TWI���ݽṹ
{
    volatile unsigned char status;    //TWI_����״̬
    unsigned char sladdr;           //���豸��������ַ
    unsigned char sldaddrH;      //���豸�����ݵ�ַ
    unsigned char sldaddrL;      //���豸�����ݵ�ַ
    unsigned char *data;         //���ݻ�����ָ��
    unsigned int dataLen;     //���ݳ���
    unsigned char state;      //TWI��д��������
    unsigned char retry;     //ʧ�����Դ���
}strTWI_t;

#define EEPROM_READ 0
#define EEPROM_WRITE 1

#ifdef __cplusplus
}
#endif

#endif
