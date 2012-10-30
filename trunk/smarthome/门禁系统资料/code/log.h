#ifndef __LOG_H__
#define __LOG_H__

#ifdef __cplusplus
extern "C" {
#endif

#define LOGTYPEIDOK     1
#define LOGTYPEIDERR    2
#define LOGTYPEIDANDPSWDOK      3
#define LOGTYPEIDANDPSWDERR     4
#define LOGTYPEPSWDOK               5
#define LOGTYPEPSWDERR              6

void log(char type, unsigned char index, unsigned long id_code, unsigned long pswd);

#ifdef __cplusplus
}
#endif

#endif