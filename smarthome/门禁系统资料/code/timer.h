#ifndef __TIMER_H__
#define __TIMER_H__

#ifdef __cplusplus
extern "C" {
#endif

#define IDREADERTIMEOUTTIMER        0
#define PASSWORDTIMEOUTTIMER        1
#define RINGANDSCREENINPUTTIMER     2

#define MAXTIMER 4

typedef void (*timerCB)(char); 
typedef struct __timer
{
    unsigned int value;
    timerCB cb;
}timer_t; 
//timer init.
void timer_init(void);
//set timer.
void set_timer(char timer, int value, timerCB cb);
//stop timer.
void stop_timer(char timer);

#ifdef __cplusplus
}
#endif

#endif