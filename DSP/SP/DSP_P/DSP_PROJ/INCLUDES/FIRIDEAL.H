//
//  File = firideal.h
//

#ifndef _FIRIDEAL_H_
#define _FIRIDEAL_H_ 

#include <fstream.h>
#include "typedefs.h"
#include "gen_win.h"
#include "fir_dsgn.h"
#include "lin_dsgn.h"

class FirIdealFilter : public LinearPhaseFirDesign
{
 public:

  // constructors
  
  FirIdealFilter( );
  FirIdealFilter( istream& uin,
                  ostream& uout);
  FirIdealFilter( int num_taps,
                  istream& uin,
                  ostream& uout);
                  
  void DefineFilter( int num_taps,
                     istream& uin,
                     ostream& uout);
 private:
  void Ideal_Lowpass(void);
  void Ideal_Highpass(void);
  void Ideal_Bandpass(void);
  void Ideal_Bandstop(void);
  
 protected:
  double Lambda_1;
  double Lambda_2;

};

#endif
