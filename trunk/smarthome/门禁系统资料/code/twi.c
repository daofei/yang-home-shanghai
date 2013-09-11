#include<iom16v.h>
#include <macros.h>

#include "twi.h"

#define MAXRETRY    10
#define RWREAD 1
#define RWWRITE   0

void twiInit(void)
{
    //SCL_freq= F_CPU/(16+2*TWBR*4^(TWPS)) 
    //The mega16/32 data sheet says TWBR should be more than 10
    TWBR = 32;
    TWCR = 0;
    //SCL_freq = 8MHz/(16+2*32*1) = 100k
}

char rwiic(unsigned char comAddr, unsigned char *data,unsigned char len,unsigned int addr, unsigned char rwFlag)    
{
    unsigned char i = MAXRETRY;
    char err = 1;

    while(i--)    
    {    
        Start();
    	Wait();
    	if(TestAck()!=TW_START) continue;
    	Write8Bit(comAddr);
        Wait();
    	if(TestAck()!=TW_MT_SLA_ACK) continue;
    	Write8Bit((unsigned char)(addr >> 8));
    	Wait();
    	if(TestAck()!=TW_MT_DATA_ACK) continue;
    	Write8Bit((unsigned char)(addr));
    	Wait();
    	if(TestAck()!=TW_MT_DATA_ACK) continue;
        if(rwFlag == RWWRITE)
        {
            err=0;
            while(len--)    
            {
                Write8Bit(*(data++));
                Wait();
                if(TestAck()==TW_MT_DATA_ACK) continue;
                err=1;    
                break;    
            }    
            if(err==1) continue;    
            break;    
        }
        else
        {
            Start();
            Wait();
            if(TestAck()!=TW_REP_START) continue;
            Write8Bit(comAddr |0x01);
            Wait();
            if(TestAck()!=TW_MR_SLA_ACK) continue;
            len-=1;
            while(len--)
            {
                Twi();
                Wait();
                *(data++) = TWDR;
                SetAck();
            }
            Twi();
            Wait();
            *data = TWDR;
            SetNoAck();
            err = 0;
            break;
        }
    }
    Stop();
    if(rwFlag == RWWRITE) delay_ms(50);

    return err;
}

void iicSlaveInit(unsigned char address)
{
    // load address into TWI address register
    TWAR = address;	// set the TWCR to enable address matching and enable TWI, clear TWINT, enable TWI interrupt
    TWCR = (1<<TWIE) | (1<<TWEA) | (1<<TWINT) | (1<<TWEN);
}

void iicSlaveStop(void)
{
    // clear acknowledge and enable bits	
    TWCR &= ~( (1<<TWEA) | (1<<TWEN) );
}

void twi_isr(void)
{
    // temporary stores the received data	
    uint8_t data;
    // own address has been acknowledged	
    if( (TWSR & 0xF8) == TW_SR_SLA_ACK )
    {       
        buffer_address = 0xFF;
        // clear TWI interrupt flag, prepare to receive next byte and acknowledge      
        TWCR |= (1<<TWIE) | (1<<TWINT) | (1<<TWEA) | (1<<TWEN);     
    }
    else if( (TWSR & 0xF8) == TW_SR_DATA_ACK )
    {
        // data has been received in slave receiver mode               
        // save the received byte inside data 
        data = TWDR;
        // check wether an address has already been transmitted or not 
        if(buffer_address == 0xFF)
        {
            buffer_address = data; 
            // clear TWI interrupt flag, prepare to receive next byte and acknowledge
            TWCR |= (1<<TWIE) | (1<<TWINT) | (1<<TWEA) | (1<<TWEN);
        }
        else
        {
            // if a databyte has already been received                        
            // store the data at the current address            
            rxbuffer[buffer_address] = data;
            // increment the buffer address
            buffer_address++;
            // if there is still enough space inside the buffer
            if(buffer_address < 0xFF)
            {
                // clear TWI interrupt flag, prepare to receive next byte and acknowledge
                TWCR |= (1<<TWIE) | (1<<TWINT) | (1<<TWEA) | (1<<TWEN);
            }
            else
            {
                // clear TWI interrupt flag, prepare to receive last byte and don't acknowledge
                TWCR |= (1<<TWIE) | (1<<TWINT) | (0<<TWEA) | (1<<TWEN);
            }
        }
    }
    else if( (TWSR & 0xF8) == TW_ST_DATA_ACK )
    {
        // device has been addressed to be a transmitter
        // copy data from TWDR to the temporary memory
        data = TWDR;
        // if no buffer read address has been sent yet
        if( buffer_address == 0xFF )
        {
            buffer_address = data;
        }
        // copy the specified buffer address into the TWDR register for transmission
        TWDR = txbuffer[buffer_address];
        // increment buffer read address
        buffer_address++;
        // if there is another buffer address that can be sent
        if(buffer_address < 0xFF)
        {
            // clear TWI interrupt flag, prepare to send next byte and receive acknowledge 
            TWCR |= (1<<TWIE) | (1<<TWINT) | (1<<TWEA) | (1<<TWEN);
        }
        else
        {
            // clear TWI interrupt flag, prepare to send last byte and receive not acknowledge
            TWCR |= (1<<TWIE) | (1<<TWINT) | (0<<TWEA) | (1<<TWEN);
        }
    }
    else
    {
        // if none of the above apply prepare TWI to be addressed again
        TWCR |= (1<<TWIE) | (1<<TWEA) | (1<<TWEN);
    }
}

