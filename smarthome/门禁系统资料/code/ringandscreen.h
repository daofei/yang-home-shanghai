#ifndef __RINGANDSCREEN_H__
#define __RINGANDSCREEN_H__

#ifdef __cplusplus
extern "C" {
#endif

void doorandscreen_init(void);

void screen_on_pinLow(void);

void screen_on_pinHigh(void);

/*
char check_door(void);
*/

#ifdef __cplusplus
}
#endif

#endif
