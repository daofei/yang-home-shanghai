#ifndef __TIPS_H__
#define __TIPS_H__

#ifdef __cplusplus
extern "C" {
#endif

//tips port init.
//pd4 beep,pd5 led.
void tips_port_init(void);
void tips_led_on(void);
void tips_led_off(void);
void tips_beep_on(void);
void tips_beep_off(void);
void tips_ok(void);
void tips_err(void);
void tips_id_ok(void);
void tips_ring_on(void);

#ifdef __cplusplus
}
#endif

#endif