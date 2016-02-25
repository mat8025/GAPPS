//*******************************************************************************
//  IOP Demo --- 
//
//  Description;
//
//  SYSCLK = MCLK = ACLK = 8 x 7.3728MHz = 58.9824MHz
//  ICLK = SYSCLK / 2 = 29.4912MHz
//
//  Baud rate divider with 29.4912MHz ICLK @19200 =
//  29.4912MHz/(8*19200)-1 = 0xbf
//
//  //*An external 7.3728MHz XTAL with proper load caps is required*//	
//
//              TMS-FET470B1M
//             -----------------
//            |            OSCIN|-
//            |                 | 7.3728MHz
//         +--|PLLDIS     OSCOUT|-
//         |  |                 |
//        -+- |           SCI1TX|------------>
//            |                 | 19200 - 8N1
//            |           SCI1RX|<------------
//
//  A.Dannenberg / J.Mangino
//  Texas Instruments, Inc
//  July 29th 2005
//  Built with IAR Embedded Workbench Version: 4.30A
//******************************************************************************

#include <intrinsic.h>
#include "iotms470r1b1m.h"
#include "tms470r1b1m_bit_definitions.h"
#include "wdog.h"
#include "system.h"
#include "IopTypes.h"

// IOP Example
int t_c = 0;
int r_c = 0;
int i_val = 0;
int d_i = 0;
int wc = 0;
int cntDown = 14;
int i = 0;
int adc_val = 0;  // sample ADDR0 - 0-1023

const char stringa[] = { "Hello board! \r\n" };
const char stringb[] = { "Hello world! \r\n" };
const char stringc[] = { "Test the Iop Board! \r\n" };

const char *strp;



int ncw = 0;
Bool done_string = FALSE;


// need But struct
Bool but4 = 0;
Bool but4_latch = 0;
Bool but5 = 0;
Bool but5_latch = 0;
Bool but6 = 0;
Bool but6_latch = 0;
Bool but7 = 0;
Bool but7_latch = 0;


void SetUpStr(const char *str)
{

      done_string = 0;
      wc = 0;
      i = 0;
      cntDown = 15;
      strp = str;

      SCI1TXBUF = *strp++;
      SCI1CTL3 |= CLOCK + TX_ACTION_ENA;  
}

void CheckButtons()
{
  ncw++;

  if(GIODINA_bit.GIODIN4 == 0 )
    but4 =1;
  else {
    but4 = 0;
    but4_latch = 0;
  }

  if(GIODINA_bit.GIODIN5 == 0 )
    but5 =1;
  else {
    but5 = 0;
    but5_latch = 0;
  }

  if(GIODINA_bit.GIODIN6 == 0 )
    but6 =1;
  else {
    but6 = 0;
    but6_latch = 0;
  }

  if(GIODINA_bit.GIODIN7 == 0 )
    but7 =1;
  else {
    but7 = 0;
    but7_latch = 0;
  }

}

void ButtonTask()
{

   if(but4 && !but4_latch) { 
       LedSet(0x00ff);
    if (done_string) {
      SetUpStr(stringa);    
      but4_latch =1;
    }
   }


   if(but5 && !but5_latch) { 
       LedSet(0x00f0);
    if (done_string) {
      SetUpStr(stringb);    
      but5_latch =1;
    }
   
   }

   if(but6 && !but6_latch) { 
       LedSet(0x0003);
    if (done_string) {
      SetUpStr(stringc);    
      but6_latch =1;
    }
   
   }

   if(but7 && !but7_latch) { 
       LedSet(0x0003);
    if (done_string) {
      SetUpStr("button7\r");    
      but7_latch =1;
    }
   
   }
}


// LED moving pattern codes.
static int led_table[] = {
  0xCAFE, 0xDEAD, 0xBEEF, 0xBABE, 0xFEED, 0xDEAF, 0xFACE,0xACED, -1
};

int* ip;

#define C1LED 0x0001
#define C2LED 0x0002
#define HBLED 0x0004

Uint32 c1offset= 1050;
Uint32 c2offset= 620;


int c1_led = C1LED;

void COMP1_irq_handler()
{
  RTICMP1 += c1offset;                 // Add offset
  RTICINT &= ~CMP1FLAG;   // interrupt control, clear CMP1
#if 0
  if (*ip != -1)
  {
   // LedSet(*ip);
    ip++;
  }
  else
  {
    ip = led_table;
   // LedSet(*ip);
    ip++;
  }
#endif
      HETDOUT ^= (C1LED << 5);                    // Toggle using exclusive-OR
      //    c1_led ^= C1LED;
      //LedSet(c1_led);
   // toggle GIO1
 
    GIODOUTD_bit.GIODOUT1 ^= 1;
   
}



int c2_led = C2LED;

void COMP2_irq_handler()
{
   RTICMP2 += c2offset;                  // Add offset
   RTICINT &= ~CMP2FLAG;   // interrupt control, clear CMP2
   HETDOUT ^= ( C2LED << 5);                    // Toggle using exclusive-OR
      //    c2_led ^= C2LED;
      //LedSet(c2_led);
   // toggle GIO2
   GIODOUTD_bit.GIODOUT2 ^= 1;

}



int hb_led = HBLED;


void  TAP_irq_handler()
{
  //    hb_led ^= HBLED;
  //  LedSet(hb_led);
    RTICNTL &= ~0x80;                   // Clear TAP flag
 //   HETDOUT ^= 0x01;                    // Toggle using exclusive-OR
      HETDOUT ^= (HBLED << 5);                    // Toggle using exclusive-OR
     pet_watchdog();
}

int adc_i = 0;
void main(void)
{


  __disable_interrupt();



  PCR = CLKDIV_2;                         // ICLK = SYSCLK / 2
  GCR = ZPLL_CLK_DIV_PRE_1;               // SYSCLK = 8 x fOSC
  PCR |= PENABLE;                         // Enable peripherals

  SCI1CTL3 &= ~SW_NRESET;                 // Reset SCI state machine
  SCI1CCR = TIMING_MODE_ASYNC + CHAR_8;   // Async, 8-bit Char
  SCI1CTL1 |= RXENA;                      // RX enabled
  SCI1CTL2 |= TXENA;                      // TX enabled
  SCI1CTL3 |= CLOCK + TX_ACTION_ENA;      // Internal clock. enable TX interrrupt

  // 19200 BAUD
  SCI1LBAUD = 0xbf;                       // 29.4912MHz/(8*19200)-1
 // SCI1PC2 |= RX_FUNC;                     // SCIRX is the SCI receive pin
  SCI1PC3 |= TX_FUNC;                     // SCITX is the SCI transmit pin
  SCI1CTL3 |= SW_NRESET;                  // Configure SCI1 state machine
  //REQMASK = (1 << CIM_SCI1RX);            // Enable SCI1RX channel

  REQMASK |= (1 << CIM_SCI1TX); 
 
  ///////////////////////////////////////////////////////////////////
  // setup for ADC

  HETDIR  = 0xFFFFFFFF;                   // HETx Output direction
  HETDOUT = 0x00000000;

  GIODIRD = 0xFF;                         // GIO[D] set as outputs
  GIODOUTE = 0x00;

  ADCR1 |= PS_8;                          // ADCLK prescaler = 8
  ADSAMPEV |= SEN;                        // ADCSAMP1 controls SW
  ADSAMP1 = 62;                           // SW = 62+2

  ADCR1 |= ADC_EN;                        // Enable ADC
  ADCR2 |= G1_MODE;                       // Continuous Conversion
  ADISR1 = 0x00ff;                        // Convert group 1 = channel 0,1,2,3

  REQMASK |= (1<<27);                     // enable channel 27 (AD1)
  ADCR2 |= ENA_GP1_INT;                   // enable group 1 interrupt




  ///////////////////////////////////////////////////////////////////////
    // RTI setup --- use for heartbeat
    // check compatibilty of HET/GIO settings



  // Setup periodic interrupt using RTI with RTICMP1
  RTICNTEN = CNTEN_NOCNT;                       // Stop counting
  RTICNTR = 0x00;                           // clear 21-bits CNTR

  // Setup periodic interrupt timer
  // CMP1 used to generate  interrupt.
  RTIPCTL = 0xf;                         // preload 11-bits MOD
  RTICMP1 = 0x00fff;                     //
  RTICNTL = 0x00;                        // clear and disable tap

  // interrupt control, clear CMP1 and enable CMP1 interrupt
  RTICINT = 0x00;
  RTICINT |= CMP1ENA;

  //  REQMASK |= (1 << CIM_COMP1);        

  RTICMP2 = 0x00fff;                     //
  RTICINT |= CMP2ENA;

   REQMASK |= (1 << CIM_COMP2);        

 // PRELD = 0;

  RTICNTL |= TAPENA;                      // Enable TAP interrupt
  RTIPCTL &= 0xc7ff; // TAP bit 000 2097152
  REQMASK |= (1 << CIM_TAP);       
 
 // Start count, CNTR and MOD will count in both USER and SYSTEM mode
  RTICNTEN = CNTEN_UP;


  HETDIR  = 0xff;                        // Set HET as GIO outputs
  HETDOUT = 0xff;                        // Output on
  HETDOUT = 0x00;                        // Output off
  HETDOUT = 0xff;                        // Output on
  GIODIRE = 0xff;                        // Set GIO outputs
  GIODOUTE =0xff;                        // Output on
  GIODOUTE = 0x00;
  HETDOUT = 0x0000;

  ip = led_table;  

  ////////////////////////////////////////////////////////////

  InitButtons();

  enable_watchdog();

  __enable_interrupt();                   // Enable interrupts



  // necessary prime TXBUF??  
   strp = stringa;  
   SCI1TXBUF = *strp; // push out string
  

  for (;;){
  

    CheckButtons();
    
    pet_watchdog();
 
    ButtonTask();

    idle_task();

    pet_watchdog();


  }                              // Wait in endless loop




}



//------------------------------------------------------------------------------
// TMS470R1B1M Standard Interrupt Handler
//------------------------------------------------------------------------------
//#pragma vector = IRQV



__irq __arm void irq_handler(void)
{

  i_val = (0xff & IRQIVEC) - 1;

  switch (i_val)
  {
    case CIM_SCI1RX :
      SCI1TXBUF = SCI1RXBUF;
      r_c++;
      break;
    case CIM_SCI1TX :

      cntDown--;
      if (!*strp) {
       SCI1CTL3 &= ~TX_ACTION_ENA;   
       i = 0;
       done_string =1;
      }
      else {
        SCI1TXBUF = *strp++; // stuff char into TXBUF 
        wc++;
        i++;
       t_c++;
      }

      break;

      
   case CIM_MIBADCE1  :                   // channel 27 (AD1) interrupt?
//      LedSet(ADDR0 >> 8);
      adc_val = ADDR0;
 //     c1offset = (adc_val << 9);
  //    c2offset = (adc_val << 8);
      adc_i++;
      break;

   case CIM_COMP1  : 
       COMP1_irq_handler(); 
   break;

   case CIM_COMP2  : 
       COMP2_irq_handler(); 
   break;

   case CIM_TAP:
     TAP_irq_handler();
      break;

  default:
      d_i++;
      break;
  
  
  }
  
  

}

