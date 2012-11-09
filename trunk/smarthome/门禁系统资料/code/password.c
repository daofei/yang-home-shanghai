#include<iom16v.h>
#include <macros.h>

#include "log.h"
#include "locker.h"
#include "tips.h"
#include "timer.h"
#include "eeprom.h"
#include "password.h"

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

    rw24c256(&num, 1, 0, RW24C256READ);
    return num;
}

passwordItem_t readPasswordItem(unsigned char index)
{
    passwordItem_t item;
    unsigned char t = 0;
    unsigned long tmp = 0;

    rw24c256(&t, 1, index*13+1, RW24C256READ);
    item.flags = t;

    tmp = 0;
    rw24c256Int(&tmp, index*13+2, RW24C256READ);
    item.idCard = tmp;
    
    tmp = 0;
    rw24c256Int(&tmp, index*13+6, RW24C256READ);
    item.passwordH = tmp;
    
    tmp = 0;
    rw24c256Int(&tmp, index*13+10, RW24C256READ);
    item.passwordL = tmp;
    
    return item;
}

void insertPasswordItem(unsigned char index, passwordItem_t item)
{
    unsigned long tmp = 0;

    rw24c256(&(item.flags), 1, index*13+1, RW24C256WRITE);

    tmp = item.idCard;
    rw24c256Int(&tmp, index*13+2, RW24C256WRITE);
    
    tmp = item.passwordH;
    rw24c256Int(&tmp, index*13+6, RW24C256WRITE);
    
    tmp = item.passwordL;
    rw24c256Int(&tmp, index*13+10, RW24C256WRITE);

    return;
}

void writePasswordItemNum(unsigned char num)
{
    rw24c256(&num, 1, 0, RW24C256WRITE);
    return;
}

#define PASSWORDREADIDCARDUNKOWN    0
#define PASSWORDREADIDCARDOK                1
#define PASSWORDREADIDANDPSWDOK         2

static unsigned char password_read_flags = 0;
static unsigned char current_index = 0;
static unsigned char input_err_count = 0;

//You input xxx then password is 1xxx.
static unsigned long passwordH = 1;
static unsigned long passwordL = 1;

static void clear_pswd_status(void)
{
    //clear last password input.
    passwordH = 1;
    passwordL = 1;
    tips_led_off();
    password_read_flags = PASSWORDREADIDCARDUNKOWN;
    current_index = 0;
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

void password_handle(char type, unsigned long code)
{
    unsigned char pswd_item_num = 0;
    unsigned char i;
    passwordItem_t item;

    //if input error count is too large.
    if(input_err_count>5)
    {
        clear_pswd_status();
        tips_err();
        //set time out. 200ms*5*60
        set_timer(PASSWORDTIMEOUTTIMER, 300, cannot_input_time_out);
        return;
    }
 
    //read a card.
    if(type==IDREADEDIDCARD)
    {
        clear_pswd_status();
        //read paswd item num.
        pswd_item_num = readPasswordItemNum();
        //loop find it.
        for(i=0;i<pswd_item_num;++i)
        {
            //read a item.
            item = readPasswordItem(i);
            //if item need id card, and is this id card.
            if((item.flags&PASSWORDFLAGS_ID)&&(item.idCard==code))
            {
                //need paswd.
                if(item.flags&PASSWORDFLAGS_PASSWORD)
                {
                    //id card ok, but need password.
                    //tips_id_ok();
                    //id card ok, but not input password, led on.
                    tips_led_on();
                    current_index = i;
                    password_read_flags = PASSWORDREADIDCARDOK;
                    //set time out. 200ms*5*30
                    set_timer(PASSWORDTIMEOUTTIMER, 150, input_time_out);
                }
                else //only id card.
                {
                    //record log
                    log(LOGTYPEIDOK, i, code, 0, 0);
                    //clear pswd statuc.
                    clear_pswd_status();
                    tips_ok();
                    locker_unlock();
                    //error count clear.
                    input_err_count = 0;
                } //else
                return;
            }  //if((item.flags&PASSWORDFLAGS_ID)&&(item.idCard==code))
        }	  //for(i=0;i<pswd_item_num;++i)
        //unkown id card.
        log(LOGTYPEIDERR, 0, code, 0, 0);
        //clear password.
        clear_pswd_status();
        //error password and log.
        tips_err();
        //error count ++
        ++input_err_count;
        return;
    }	  //if(type==IDREADEDIDCARD)
    else if(type==IDREADEDKEYPAD) // read a keypad input.
    {
        code &= 0x0000000f;
        if(code == 0x0000000a)  //*
        {
            //clear password.
            clear_pswd_status();
        }
        else if(code == 0x0000000b) //#
        {
            //need id card password.
            if(password_read_flags==PASSWORDREADIDCARDOK)
            {
                passwordItem_t current_item = readPasswordItem(current_index);
                //password is ok.
                if((current_item.passwordH==passwordH)&&(current_item.passwordL==passwordL))
                {
                    log(LOGTYPEIDANDPSWDOK, current_index, current_item.idCard, passwordH, passwordL);
                    //clear password status.
                    clear_pswd_status();
                    //unlock and write log.
                    tips_ok();
                    locker_unlock();
                    //error count clear.
                    input_err_count = 0;
                }
                else //password is error.
                {
                    log(LOGTYPEIDANDPSWDERR, current_index, current_item.idCard, passwordH, passwordL);
                    //clear password.
                    clear_pswd_status();
                    //error password and log.
                    tips_err();
                    //error count ++.
                    ++input_err_count;
                }
            }
            else //only password.
            {
                //read paswd item num.
                pswd_item_num = readPasswordItemNum();
                //loop find it.
                for(i=0;i<pswd_item_num;++i)
                {
                    //read a item.
                    item = readPasswordItem(i);
                    //if item need id card, and is this id card.
                    if((item.flags==PASSWORDFLAGS_PASSWORD)&&(item.passwordH==passwordH)
                        &&(item.passwordL==passwordL))
                    {
                        log(LOGTYPEPSWDOK, i, 0, passwordH, passwordL);
                        //clear password.
                        clear_pswd_status();
                        //password is right. unlock and log.
                        tips_ok();
                        locker_unlock();
                        //error count clear.
                        input_err_count = 0;
                        return;
                    }
                }
                //password is error.
                log(LOGTYPEPSWDERR, 0, 0, passwordH, passwordL);
                //clear password.
                clear_pswd_status();
                //password is error, and log.
                tips_err();
                //error count++.
                ++input_err_count;
                return;
            }
        }
        else
        {
            tips_led_on();
            //set time out. 200ms*5*30
            set_timer(PASSWORDTIMEOUTTIMER, 150, input_time_out);
            passwordL = passwordL*10 + code;
            //passwordH save password hight 9 num.
            if(passwordL>999999999)
            {
                passwordH = passwordL;
                passwordL = 1;
            }
        }
    }
    return;
}

