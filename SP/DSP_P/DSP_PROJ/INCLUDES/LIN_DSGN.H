//
//  File = lin_dsgn.h
//

#ifndef _LIN_DSGN_H_
#define _LIN_DSGN_H_ 

#include "typedefs.h"

class LinearPhaseFirDesign : public FirFilterDesign
{
 public:
  
  //---------------------
  // default constructor
  
  LinearPhaseFirDesign( );
  
  //---------------------------------------------
  // constructor that allocates (via base class)
  // an array of length num_taps to hold
  // filter coefficients

  LinearPhaseFirDesign::LinearPhaseFirDesign( int num_taps );

  //-------------------------------------------------
  //  method to return band configuration 
  //  ( lowpass, bandpass, highpass, or bandstop )

  BAND_CONFIG_TYPE GetBandConfig(void);

  //----------------------------------------------
  // method to return type of linear phase filter
  
  int GetFirType(void);
  
 protected:
  
  BAND_CONFIG_TYPE Band_Config;
  
  int Fir_Type;
};

#endif
