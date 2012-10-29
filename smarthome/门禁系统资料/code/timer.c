#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include<iom16v.h>
#include <macros.h>

#include "timer.h"

void timer_init(void)
{
 //enable interrupt.
 SREG |= 0x80;
 //timer0 normal mode.ck/1024.
 TCCR0 |= 0x05;
 //init TCNT0.
 TCNT0 = 0;
 //TIMSK
 //TIMSK |= 0x01;
 return; 
}

static void t0_start(void)
{
 TIMSK |= 0x01;
 return;
}

static void t0_stop(void)
{
 TIMSK &= 0xfe;
 return;
}

#define MAXTIMER 4
static timer_t g_timer[MAXTIMER];

char get_timer(void)
{
 char i;
 for(i=0;i<MAXTIMER;i++)
 {
  if(g_timer[i].value)
  {
   g_timer[i].value = 1;
   return i;
  }
 }
 return -1;
}

void set_timer(char timer, int value)
{
 if(g_timer[timer].value)
  g_timer[timer].value = value;
 return;
}

void set_timer_cb(char timer, timerCB *cb)
{
 if(g_timer[timer].value)
  g_timer[timer].cb = cb;
 return;
}

void start_timer(char timer)
{
 if(g_timer[timer].value)
 {
  t0_start();
 }
 return;
}

void stop_timer(char timer)
{
 if(g_timer[timer].value)
 {
  char i;
  g_timer[timer].value = 0;
  for(i=0;i<MAXTIMER;i++)
  {
   if(g_timer[i].value)
   	break;
  }
  if(i==MAXTIMER)
   t0_stop();
 }
 return;
}

#pragma interrupt_handler timer0_isr:10
void timer0_isr(void)
{
 static char i = 0;
 i++;
 //200ms.
 if(i==5)
 {
  char j;
  for(j=0;j<MAXTIMER;j++)
  {
   if(g_timer[j].value>1)
   	--g_timer[j].value;
   //timer call back.
   if(g_timer[j].value==1)
   {
   	if(g_timer[j].cb)
	 ;//g_timer[j].cb(j);
	g_timer[j].value = 0;
	{
	 char k;
	 for(k=0;k<MAXTIMER;k++)
  	 {
   	  if(g_timer[k].value)
   	   break;
  	 }
  	 if(k==MAXTIMER)
   	  t0_stop();
	}
   }
  }
  i = 0;
 }
 return;
}