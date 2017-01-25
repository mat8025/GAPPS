//
//  File = dolph.h
//

#ifndef _DOLPH_H_
#define _DOLPH_H_

#include "gen_win.h"

class DolphChebyWindow : public GenericWindow
{
public:

  // constructors
  
  DolphChebyWindow( istream& uin, ostream& uout);
  DolphChebyWindow( int length );

  void GenerateWindow( int length );
  
private:
  double Alpha_Parm;
  int Interp_Rate;
  //int Num_Taps;
  //double *Half_Lag_Window;
};

#endif
  