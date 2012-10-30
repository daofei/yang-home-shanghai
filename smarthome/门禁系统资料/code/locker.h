#ifndef __LOCKER_H__
#define __LOCKER_H__

#ifdef __cplusplus
extern "C" {
#endif

void locker_init(void);
void locker_unlock(void);
void locker_lock(void);

#ifdef __cplusplus
}
#endif

#endif