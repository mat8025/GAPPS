//
//  File = kaiser.cpp
//

#include <math.h>
#include <iostream.h>
#include "kaiser.h"
#include "bessel.h"
#include "misdefs.h"

KaiserWindow::KaiserWindow( istream& uin,
                            ostream& uout )
{
 int num_taps;
 uout << "number of taps?" << endl;
 uin >> num_taps;

 uout << "desired value for alpha" << endl;
 uin >> Alpha_Parm;

 Initialize(num_taps);
 GenerateWindow( num_taps );
 return;
}
//========================================================

KaiserWindow::KaiserWindow( int length )
             :GenericWindow(length)
{
  GenerateWindow( length );
}
//========================================================
void KaiserWindow::GenerateWindow( int length )
{
 double denom, x, big_n_sqrd;
 denom = bessel_I_zero(PI * Alpha_Parm);
 big_n_sqrd = double(length * length);

 for(int n=0; n<Half_Length; n++)
   {
    if(length%2) // odd length
      {
      x = PI * Alpha_Parm * sqrt(1.0 - 4*n*n/big_n_sqrd);
      }
    else  // even length
      {
      x = PI * Alpha_Parm * sqrt(1.0 - (2*n+1)*(2*n+1)/big_n_sqrd);
      }
    Half_Lag_Win[n] = bessel_I_zero(x)/denom;
   }

 return;
} 

