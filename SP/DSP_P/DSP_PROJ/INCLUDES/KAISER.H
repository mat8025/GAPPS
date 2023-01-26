//
//  File = kaiser.h
//

#ifndef _KAISER_H_
#define _KAISER_H_

#include "gen_win.h"

class KaiserWindow : public GenericWindow
{
public:

  // constructors

  KaiserWindow( istream& uin,
                ostream& uout );
  KaiserWindow( int length );
  
  void GenerateWindow( int length );
  
private:

  //int Num_Taps;
  //double *Half_Lag_Window;
  double Alpha_Parm;
};

#endif
  