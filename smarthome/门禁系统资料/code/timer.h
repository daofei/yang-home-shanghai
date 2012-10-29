#ifndef __TIMER_H__
#define __TIMER_H__

#ifdef __cplusplus
extern "C" {
#endif

typedef void (*timerCB)(char); 

void timer_init(void);

typedef struct __timer
{
 unsigned int value;
 timerCB *cb;
}timer_t; 

#ifdef __cplusplus
}
#endif

#endif