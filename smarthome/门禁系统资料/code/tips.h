#ifndef __TIPS_H__
#define __TIPS_H__

#ifdef __cplusplus
extern "C" {
#endif

//tips port init.
//pd4 beep,pd5 led.
void tips_port_init(void);
void tips_ok(void);
void tips_err(void);
void tips_id_ok(void);

#ifdef __cplusplus
}
#endif

#endif