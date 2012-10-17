#include<iom16v.h>
void delay(void)
{
unsigned int i,j;
for(i=0;i<1000;i++)
{
   for(j=0;j<500;j++)
   ;
}
}
//=============================
void main(void)
{
DDRB=0xff;
PORTB=0xff;
while(1)
  {
  PORTB=0x00;
  delay();
  PORTB=0xff;
  delay();
  }
}
