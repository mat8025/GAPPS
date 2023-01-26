//
//  File = lin_dsgn.cpp
//

#include "misdefs.h"
#include "typedefs.h"   
#include "fir_dsgn.h"
#include "lin_dsgn.h"


//===========================================
// default constructor
//-------------------------------------------

LinearPhaseFirDesign::LinearPhaseFirDesign( )
                     :FirFilterDesign()
{
}


//=============================================
// constructor that allocates (via base class)
// an array of length num_taps to hold
// filter coefficients
//---------------------------------------------

LinearPhaseFirDesign::LinearPhaseFirDesign( int num_taps )
                     :FirFilterDesign( num_taps )
{
}


//========================================================
//  method to return band configuration 
//  ( lowpass, bandpass, highpass, or bandstop )
//--------------------------------------------------------

BAND_CONFIG_TYPE LinearPhaseFirDesign::GetBandConfig(void)
{ return(Band_Config); }


//===============================================
// method to return type of linear phase filter 
//-----------------------------------------------

int LinearPhaseFirDesign::GetFirType(void)
{ return(Fir_Type); }
 
 