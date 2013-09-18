#include<iom16v.h>
#include <macros.h>

#include "log.h"
#include "locker.h"
#include "tips.h"
#include "timer.h"
#include "iic.h"
#include "eeprom.h"
#include "password.h"
#include "ringandscreen.h"

//eeprom 
//addr: 0 number.

// 1: flags
// 2,3,4,5: id Card.
// 6,7,8,9: password H
// 10,11,12,13 :password L

// 14: flags
// 15,16,17,18: id Card.
// 19,20,21,22: password H
// 23,24,25,26 :password L

unsigned char readPasswordItemNum(void)
{
    unsigned char num = 0;

    rw24c256(&num, 1, 0, RWREAD);
    return num;
}

passwordItem_t readPasswordItem(unsigned char index)
{
    passwordItem_t item;
    unsigned char t = 0;

    rw24c256(&t, 1, index*13+1, RWREAD);
    item.flags = t;

    rw24c256((unsigned char*)(&item.idCard), 4, index*13+2, RWREAD);
    
    rw24c256((unsigned char*)(&item.passwordH), 4, index*13+6, RWREAD);
	
    rw24c256((unsigned char*)(&item.passwordL), 4, index*13+10, RWREAD);
    
    return item;
}

void insertPasswordItem(unsigned char index, passwordItem_t item)
{
    rw24c256(&(item.flags), 1, index*13+1, RWWRITE);
	
    rw24c256((unsigned char*)(&item.idCard), 4, index*13+2, RWWRITE);
	
    rw24c256((unsigned char*)(&item.passwordH), 4, index*13+6, RWWRITE);
	
    rw24c256((unsigned char*)(&item.passwordL), 4, index*13+10, RWWRITE);
	
    return;
}

void writePasswordItemNum(unsigned char num)
{
    rw24c256(&num, 1, 0, RWWRITE);
    return;
}

#define PASSWORDREADIDCARDUNKOWN    0
#define PASSWORDREADIDCARDOK                1
#define PASSWORDREADIDANDPSWDOK         2

static unsigned long current_id = 1; //no card id is 1
static unsigned char input_err_count = 0;

//You input xxx then password is 1xxx.
static unsigned long passwordH = 1;
static unsigned long passwordL = 1;

static void clear_pswd_status(void)
{
    //clear last password input.
    passwordH = 1;
    passwordL = 1;
    current_id = 1;
    tips_led_off();
    stop_timer(PASSWORDTIMEOUTTIMER);
    return;
}

//cannot input timeout.
static void cannot_input_time_out(char timer)
{
    if(timer==PASSWORDTIMEOUTTIMER)
        input_err_count = 0;
    return;
}

//input timeout.
static void input_time_out(char timer)
{
    if(timer==PASSWORDTIMEOUTTIMER)
        clear_pswd_status();
    return;
}

void password_handle_err(void)
{
    clear_pswd_status();
    tips_err();
}
void password_handle_ok(void)
{
    //clear pswd statuc.
    clear_pswd_status();
    //tips_ok();
    locker_unlock();
    //error count clear.
    input_err_count = 0;
}
void password_handle(char type, unsigned long code)
{
    unsigned char pswd_item_num = 0;
    unsigned char i;
    passwordItem_t item;

	//on screen
	screen_on_pinLow();
    //if input error count is too large.
    if(input_err_count>5)
    {
        password_handle_err();
        //set time out. 100ms*10*60
        set_timer(PASSWORDTIMEOUTTIMER, 600, cannot_input_time_out);
        return screen_on_pinHigh();
    }
    //deal with keypad input.
    if((type==IDREADEDKEYPAD)&&(code!=0x0000000b))
    {
        code &= 0x0000000f;
        if(code == 0x0000000a)  //*
        {
            //clear password.
            clear_pswd_status();
        }
        else
        {
            tips_led_on();
            //set time out. 100ms*10*30
            set_timer(PASSWORDTIMEOUTTIMER, 300, input_time_out);
            passwordL = passwordL*10 + code;
            //passwordH save password hight 9 num.
            if(passwordL>999999999)
            {
                passwordH = passwordL;
                passwordL = 1;
            }
        }
    }
    else    //deal with key
    {
        //read paswd item num.
        pswd_item_num = readPasswordItemNum();
        //loop find it.
        for(i=0;i<pswd_item_num;++i)
        {
            //read a item.
            item = readPasswordItem(i);
            if((item.flags==PASSWORDFLAGS_ID)&&(type==IDREADEDIDCARD)&&(item.idCard==code))
            {
                //record log
                log(COMMANDIDLOGOK, PASSWORDFLAGS_ID, code, 0, 0);
                password_handle_ok();
                return screen_on_pinHigh();
            }
            else if((item.flags==PASSWORDFLAGS_PASSWORD)&&(type==IDREADEDKEYPAD)&&
                (item.passwordH==passwordH)&&(item.passwordL==passwordL))
            {
                log(COMMANDIDLOGOK, PASSWORDFLAGS_PASSWORD, 0, passwordH, passwordL);
                password_handle_ok();
                return screen_on_pinHigh();
            }
            else if(item.flags==(PASSWORDFLAGS_ID|PASSWORDFLAGS_PASSWORD))
            {
                if((type==IDREADEDIDCARD)&&(item.idCard==code))
                {
                    //id card ok, but need password.
                    //tips_id_ok();
                    //id card ok, but not input password, led on.
                    tips_led_on();
                    current_id = code;
                    //set time out. 100ms*10*30
                    set_timer(PASSWORDTIMEOUTTIMER, 300, input_time_out);
                    return screen_on_pinHigh();
                }
                else if((type==IDREADEDKEYPAD)&&(current_id==item.idCard)&&
                    (item.passwordH==passwordH)&&(item.passwordL==passwordL))
                {
                    log(COMMANDIDLOGOK, PASSWORDFLAGS_ID|PASSWORDFLAGS_PASSWORD, item.idCard, passwordH, passwordL);
                    password_handle_ok();
                    return screen_on_pinHigh();
                }
            }
        }
        ++input_err_count;
        log(COMMANDIDLOGERR, PASSWORDFLAGS_ID|PASSWORDFLAGS_PASSWORD, item.idCard, passwordH, passwordL);
        password_handle_err();
    }
    return screen_on_pinHigh();
}
