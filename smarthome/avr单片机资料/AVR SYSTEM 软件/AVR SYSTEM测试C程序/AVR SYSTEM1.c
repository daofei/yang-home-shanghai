/*********************************************************/
/* Target : ATmage16/32                                  */
/* Crystal: 8.00MHz                                      */
/* PCB��AVR SYSTEM                                       */
/*********************************************************/
//********************************************************/
 #include <iom16v.h>
 #include <macros.h>
 #include <eeprom.h>
 
 #define  uchar unsigned char 
 #define  uint unsigned int  
//================LED(PB7)==============
 #define CLED_0  PORTB&=~BIT(PB7)   
 #define CLED_1  PORTB|=BIT(PB7)     
//======================================
 #include "timee.h" 
//======================================
//*************I/O init*****************
 void port_init(void)
  { 
   DDRA  = 0x00;   
   _NOP();  
   PORTA = 0x00;   
   _NOP();    
   DDRB  = 0x80;   
   _NOP();  
   PORTB = 0x80;   
   _NOP();       
   DDRC  = 0x00;   
   _NOP();
   PORTC = 0x00;   
   _NOP();    
   DDRD  = 0x00;   
   _NOP();
   PORTD = 0x00;   
  }
 //**********************main**************************
  void main(void)
  {  
    port_init();             //I/O init
	delaym(10);
	port_init();             //I/O init again
    delaym(10);
 
   while(1)
   {
    CLED_0;
	delaym(100);
	CLED_1;
	delaym(100);
   } 
   
 }  
  //===================END============================
