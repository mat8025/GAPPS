//
//  File = firideal.cpp
//

#include <math.h>
#include <stdlib.h>
#include "misdefs.h"
#include "typedefs.h"   
#include "fir_dsgn.h"
#include "firideal.h"

FirIdealFilter::FirIdealFilter( )
{
}
FirIdealFilter::FirIdealFilter( istream& uin,
                                ostream& uout)
               :LinearPhaseFirDesign()
{
  int num_taps;
  
  num_taps = 0;  
  while( !(num_taps%2) )
    {
     uout << "number of taps in ideal FIR filter?\n"
          << "  ( must be odd because\n" 
          << "    ideal FIRs are all type 1)"
          << endl;
     uin >> num_taps;
    }
  num_taps = 22;
  Initialize( num_taps );
  DefineFilter( num_taps, uin, uout );
  return;
} 
//==============================================

FirIdealFilter::FirIdealFilter( int num_taps,
                                istream& uin,
                                ostream& uout )
               :LinearPhaseFirDesign( num_taps )
{
 if( num_taps%2 )
   { 
    DefineFilter(num_taps, uin, uout );
   }
 else
   {
    uout << "Error -- even number of taps requested\n"
         << "  for type 1 'ideal' linear phase FIR"
         << endl;
    exit(-1);
   }
}
//==============================================

void FirIdealFilter::DefineFilter( int num_taps,
                                   istream& uin,
                                   ostream& uout )
{
 int band_config;
 
 Fir_Type = 1;
 uout << "band configuration?\n"
      << (int)_LOWPASS_RESP_ << " = lowpass\n"
      << (int)_HIGHPASS_RESP_ << " = highpass\n"
      << (int)_BANDPASS_RESP_ << " = bandpass\n"
      << (int)_BANDSTOP_RESP_ << " = bandstop\n"
      << endl;
 uin >> band_config;
 Band_Config = (BAND_CONFIG_TYPE)band_config;
 
 if ((Band_Config == _LOWPASS_RESP_) ||
     (Band_Config == _HIGHPASS_RESP_) )
   {
   uout << "cutoff frequency as a fraction of PI?"
        << endl;
   uin >> Lambda_1;
   Lambda_1 *= PI;
   }
 else
   {
   uout << "lower cutoff frequency as a fraction of PI?"
        << endl;
   uin >> Lambda_1;
   Lambda_1 *= PI;
   uout << "upper cutoff frequency as a fraction of PI?" 
        << endl;
   uin >> Lambda_2;
   Lambda_2 *= PI;
   }
 
 switch (Band_Config)
   {
   case _LOWPASS_RESP_:
     Ideal_Lowpass();
     break;
     
   case _BANDPASS_RESP_:
     Ideal_Bandpass();
     break;
     
   case _HIGHPASS_RESP_:
     Ideal_Highpass();
     break;
     
   case _BANDSTOP_RESP_:
     Ideal_Bandstop();
     break; 
   }  // end of switch on Band_Config
}
//=====================================================

void FirIdealFilter::Ideal_Lowpass(void)
{
 int n,n_max;
 double m;

 if(Num_Taps%2)
   {
    n_max = (Num_Taps-1)/2;
    Imp_Resp_Coeff[n_max] = Lambda_1/PI;
   }
 else
   {
    n_max = Num_Taps/2;
   }
   
 for(n=0; n<n_max; n++)
   {
    m = n - (double)(Num_Taps-1.0)/2.0;
    Imp_Resp_Coeff[n] = sin(m*Lambda_1) / (m*PI);
    Imp_Resp_Coeff[Num_Taps-1-n] = Imp_Resp_Coeff[n];
   }
}
//==============================================================
void FirIdealFilter::Ideal_Highpass( void )
{
 int n,n_max;
 double m;

 if(Num_Taps%2)
   {
    n_max = (Num_Taps-1)/2;
    Imp_Resp_Coeff[n_max] = 1.0 - Lambda_1/PI;
   }
 else
   {
    n_max = Num_Taps/2;
   }
   
 for(n=0; n<n_max; n++)
   {
    m = n - (double)(Num_Taps-1.0)/2.0;
    Imp_Resp_Coeff[n] = -sin(m*Lambda_1) / (m*PI);
    Imp_Resp_Coeff[Num_Taps-1-n] = Imp_Resp_Coeff[n];
   }
}
//=========================================================
//
void FirIdealFilter::Ideal_Bandpass( void )
{
 int n,n_max;
 double m;

 if(Num_Taps%2)
   {
    n_max = (Num_Taps-1)/2;
    Imp_Resp_Coeff[n_max] = (Lambda_2 - Lambda_1)/PI;
   }
 else
   {
    n_max = Num_Taps/2;
   }
   
 for(n=0; n<n_max; n++)
   {
    m = n - (double)(Num_Taps-1.0)/2.0;
    Imp_Resp_Coeff[n] = (sin(m*Lambda_2) - sin(m*Lambda_1)) / (m*PI);
    Imp_Resp_Coeff[Num_Taps-1-n] = Imp_Resp_Coeff[n];
   }
 return;
}
//=================================================================
//
void FirIdealFilter::Ideal_Bandstop( void )
{
 int n,n_max;
 double m;

 if(Num_Taps%2)
   {
    n_max = (Num_Taps-1)/2;
    Imp_Resp_Coeff[n_max] = 1.0 + (Lambda_1 - Lambda_2)/PI;
   }
 else
   {
    n_max = Num_Taps/2;
   }
   
 for(n=0; n<n_max; n++)
   {
    m = n - (double)(Num_Taps-1.0)/2.0;
    Imp_Resp_Coeff[n] = (sin(m*Lambda_1) - sin(m*Lambda_2)) / (m*PI);
    Imp_Resp_Coeff[Num_Taps-1-n] = Imp_Resp_Coeff[n];
   }
 return;
}


 