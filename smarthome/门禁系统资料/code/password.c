#include <stdio.h>
#include <stdlib.h>

#include<iom16v.h>
#include <macros.h>

#include "log.h"
#include "locker.h"
#include "tips.h"
#include "timer.h"
#include "password.h"


unsigned char readPasswordItemNum(void)
{

    return 0;
}
passwordItem_t readPasswordItem(unsigned char index)
{
    passwordItem_t item;
    return item;
}
unsigned char insertPasswordItem(passwordItem_t item)
{
    return 0;
}
//maybe change the index.
void deletePasswordItem(unsigned char index)
{
    return;
}

#define PASSWORDREADIDCARDUNKOWN    0
#define PASSWORDREADIDCARDOK                1
#define PASSWORDREADIDANDPSWDOK         2

static unsigned char password_read_flags = 0;
static unsigned char current_index = 0;
static unsigned char input_err_count = 0;

//You input xxx then password is 1xxx.
static unsigned long password = 1;

static void clear_pswd_status(void)
{
    //clear last password input.
    password = 1;
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
        printf("ID Card:%d", code);
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
                    tips_id_ok();
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
                    log(LOGTYPEIDOK, i, code, 0);
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
        log(LOGTYPEIDERR, 0, code, 0);
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
            printf("Press *");
            //clear password.
            clear_pswd_status();
        }
        else if(code == 0x0000000b) //#
        {
            printf("Press #");
            //handle password.
            printf("Ok.pswd:%d", password);
            //need id card password.
            if(password_read_flags==PASSWORDREADIDCARDOK)
            {
                passwordItem_t current_item = readPasswordItem(current_index);
                //password is ok.
                if(current_item.password==password)
                {
                    log(LOGTYPEIDANDPSWDOK, current_index, current_item.idCard, password);
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
                    log(LOGTYPEIDANDPSWDERR, current_index, current_item.idCard, password);
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
                    if((item.flags==PASSWORDFLAGS_PASSWORD)&&(item.password==password))
                    {
                        log(LOGTYPEPSWDOK, i, 0, password);
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
                log(LOGTYPEPSWDERR, 0, 0, password);
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
            printf("Press %d", code);
            tips_led_on();
            //set time out. 200ms*5*30
            set_timer(PASSWORDTIMEOUTTIMER, 30000, input_time_out);
            password = password*10 + code;
            printf("pswd:%d", password);
        }
    }
    return;
}

