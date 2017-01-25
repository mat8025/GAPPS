//
//  File = rectnglr.cpp
//

#include <math.h>
#include <iostream.h>
#include "rectnglr.h"
#include "misdefs.h"

RectangularWindow::RectangularWindow( istream& uin,
                                      ostream& uout )
{
 int num_taps;
 uout << "number of taps?" << endl;
 uin >> num_taps;

 Initialize(num_taps);
 GenerateWindow( num_taps );
 return;
}
//========================================================

RectangularWindow::RectangularWindow( int length )
                  :GenericWindow(length)
{
  GenerateWindow( length );
}
//========================================================

void RectangularWindow::GenerateWindow( int length )
{
 if(length%2)   // odd length window centered at zero
   {
    for(int n=0; n<Half_Length; n++)
      {
       Half_Lag_Win[n] = 1.0;
       //cout << n << "  " << Half_Lag_Win[n] << endl;
      }
   }
 else     // even length window centered at -1/2
   {
    for(int n=0; n<Half_Length; n++)
      {
       Half_Lag_Win[n] = 1.0;
      }
   }
 return;
} 


                      