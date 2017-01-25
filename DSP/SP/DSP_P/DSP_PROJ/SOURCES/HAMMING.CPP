//
//  File = hamming.cpp
//

#include <math.h>
#include <iostream.h>
#include "hamming.h"
#include "misdefs.h"

HammingWindow::HammingWindow( istream& uin,
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

HammingWindow::HammingWindow( int length )
              :GenericWindow(length)
{
  GenerateWindow( length );
}
//========================================================
void HammingWindow::GenerateWindow( int length )
{
 for(int n=0; n<Half_Length; n++)
   {
    if(length%2) // odd length
      { 
      Half_Lag_Win[n] = 0.54 + 0.46 * cos( double(TWO_PI)*n/(length-1));}
    else
      { Half_Lag_Win[n] = 0.54 + 0.46 * cos( (2*n+1)*PI/(length-1));}
   }

 return;
} 

