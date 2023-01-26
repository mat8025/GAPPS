//
//  File = fir_dsgn.cpp
//

#include <math.h>
#include <stdlib.h>
#include <iomanip.h>
#include "misdefs.h"   
#include "fir_dsgn.h"
#include "fir_resp.h"

//=========================================
// default constructor
//-----------------------------------------

FirFilterDesign::FirFilterDesign( void )
{
 return;
} 

//===============================================
//  constructor that allocates array of
//  length num_taps to hold coefficients
//-----------------------------------------------

FirFilterDesign::FirFilterDesign( int num_taps )
{
 Num_Taps = num_taps;
 Imp_Resp_Coeff = new double[num_taps];
 Original_Coeff = new double[num_taps];
}


//==========================================================
// constructor that allocates array of length num_taps 
// and initializes this array to values contained in 
// input array *imp_resp_coeff 
//----------------------------------------------------------

FirFilterDesign::FirFilterDesign( int num_taps,
                                  double *imp_resp_coeff)
{
 Num_Taps = num_taps;
 Imp_Resp_Coeff = new double[num_taps];
 Original_Coeff = new double[num_taps];
 
 for(int n=0; n<num_taps; n++)
   {
    Imp_Resp_Coeff[n] = imp_resp_coeff[n];
    Original_Coeff[n] = imp_resp_coeff[n];
   }
 return;
} 

//==========================================================
// constructor that allocates array of length num_taps 
// and initializes this array to values contained in 
// input array *imp_resp_coeff.  It is assumed that only
// half of the needed values are provided in the array.
// The remaining values are obtained from the given values
// in accordance with the type of symmetry indicated by the
// second argument. 
//----------------------------------------------------------
FirFilterDesign::FirFilterDesign( int num_taps,
                                  FIR_SYM_T symmetry,
                                  double *input_coeff)
{
 int last_left, first_right, n;
 Num_Taps = num_taps;
 Coeff_Symmetry = symmetry;

 Original_Coeff = new double[num_taps];
 Imp_Resp_Coeff = new double[num_taps];
 Quant_Coeff = new long[num_taps];
 if(num_taps%2)
   {  // odd length
   last_left = (num_taps-1)/2;
   first_right = last_left;
   }
 else
   {  // even length
   last_left = (num_taps-2)/2;
   first_right = last_left+1;
   }
 
 switch (symmetry) {
   case FIR_SYM_EVEN_LEFT:
     for(n=0; n<=last_left; n++)
       {
        Original_Coeff[n] = input_coeff[n];
        Imp_Resp_Coeff[n] = input_coeff[n];
        Quant_Coeff[n] = long(Original_Coeff[n]);
       }
     for(n=first_right; n<num_taps; n++)
       {
        Original_Coeff[n] = input_coeff[num_taps-n-1];
        Imp_Resp_Coeff[n] = input_coeff[num_taps-n-1];
        Quant_Coeff[n] = long(Original_Coeff[n]);
       }
    } // end of switch on symmetry
 return;
} 

//============================================== 
// method to allocate coefficient array 
// after default constructor has been used 
//----------------------------------------------

void FirFilterDesign::Initialize( int num_taps )
{
 Num_Taps = num_taps;
 Imp_Resp_Coeff = new double[num_taps];
 Original_Coeff = new double[num_taps];
}

//============================================================
//  method to quantize coefficients
//------------------------------------------------------------

void FirFilterDesign::QuantizeCoefficients( long quant_factor,
                                            logical rounding_enabled )
{
 int n;
 long work_long;
 
 //-----------------------------------
 // if quant_factor == 0, then restore
 // coefficients to their original,
 // unquantized values
 
 if( quant_factor == 0)
   {
    for( n=0; n<Num_Taps; n++)
      {
       Imp_Resp_Coeff[n] = Original_Coeff[n];
      }
    return;
   }

 //-------------------------------------------
 // quantize the original coefficient values
    
 for( n=0; n< Num_Taps; n++)
  {
   if(rounding_enabled)
     {work_long = long((quant_factor * Original_Coeff[n])+0.5);}
   else
     {work_long = long(quant_factor * Original_Coeff[n]);}
     
   Imp_Resp_Coeff[n] = double(work_long)/double(quant_factor);
  }
 return;
}       


//============================================================
//  method to scale coefficients
//------------------------------------------------------------

void FirFilterDesign::ScaleCoefficients( double scale_factor )
{
 int n;
 for( n=0; n< Num_Taps; n++)
  {
   Original_Coeff[n] = scale_factor * Original_Coeff[n];
   Imp_Resp_Coeff[n] = Original_Coeff[n];
  }
 return;
}       

//======================================================
//  scale coefficients so that magnitude response
//  has unity gain at passband peak
//------------------------------------------------------

void FirFilterDesign::NormalizeFilter( void )
{
  int n;
  double passband_peak;
  FirFilterResponse *temp_response;

  temp_response = new FirFilterResponse( this, 500, 0, 0, NULL);
  passband_peak = temp_response->GetIntervalPeak( 0, 499);
  delete temp_response;
  for( n=0; n< Num_Taps; n++)
  {
   Imp_Resp_Coeff[n] = Original_Coeff[n]/passband_peak;
  }
  return;
}

//======================================================
// copy coefficient values from array *Imp_Resp_Coeff
// to output array *coeff
//------------------------------------------------------
 
void FirFilterDesign::CopyCoefficients( double *coeff)
{
 for(int n=0; n<Num_Taps; n++)
   {
    coeff[n] = Imp_Resp_Coeff[n];
   }
 return;
}


//===================================
//  get number of filter taps
//-----------------------------------
 
int FirFilterDesign::GetNumTaps(void)
{
 return(Num_Taps);
}


//==============================================================
// dump complete set of coefficients to output_stream
//--------------------------------------------------------------

void FirFilterDesign::DumpCoefficients( ofstream* output_stream)
{ 
 //output_stream->setf(ios::scientific, ios::doublefield);
 output_stream->precision(8);
 for(int n=0; n<Num_Taps; n++)
   {
    //(*output_stream) << "h[" << n << "] = " 
    //                 << Imp_Resp_Coeff[n] << endl;
    (*output_stream) << n << ", " 
                     << Imp_Resp_Coeff[n] << endl;
   }
 output_stream->precision(0);
 output_stream->setf(0, ios::floatfield);
 return;
}


//==============================================
//  get pointer to coefficient array
//----------------------------------------------
double* FirFilterDesign::GetCoefficients(void)
{
 cout << "in fs_dsgn, Imp_Resp_Coeff = " << (void*)Imp_Resp_Coeff << endl;
 return(Imp_Resp_Coeff);
}

//========================================================
// apply discrete-time window to filter coefficients
//--------------------------------------------------------

void FirFilterDesign::ApplyWindow( GenericWindow *window)
{
 for(int n=0; n<Num_Taps; n++)
   {
    Imp_Resp_Coeff[n] *= window->GetDataWinCoeff(n);
    Original_Coeff[n] = Imp_Resp_Coeff[n];
   }
} 
//======================================================
// extract a subset of coefficient values for defining
// a polyphase filter 
//------------------------------------------------------
 
void FirFilterDesign::ExtractPolyphaseSet( double *coeff,
                                           int decim_rate,
                                           int rho)
{
 double *local_coeff;
 local_coeff = coeff;

 for(int n=rho; n<Num_Taps; n+=decim_rate)
   {
    *local_coeff++ = Imp_Resp_Coeff[n];
   }
 return;
}


