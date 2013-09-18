#ifndef __LOG_H__
#define __LOG_H__

#ifdef __cplusplus
extern "C" {
#endif

void log(unsigned char comId, unsigned char msgType, unsigned long id_code, unsigned long pswdH, unsigned long pswdL);

#ifdef __cplusplus
}
#endif

#endif
