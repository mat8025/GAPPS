//
//  File = hann.cpp
//

#include <math.h>
#include <iostream.h>
#include "hann.h"
#include "misdefs.h"

HannWindow::HannWindow( istream& uin,
                        ostream& uout )
{
 int num_taps, zero_ends;

 uout << "number of taps?" << endl;
 uin >> num_taps;

 uout << "include zero end-points in total tap count?\n"
      << "  0 = no, 1 = yes" << endl;
 uin >> zero_ends;
 
 Initialize(num_taps);
 GenerateWindow( num_taps, zero_ends );
 return;
}
//======================================================

HannWindow::HannWindow( int length,
                        int zero_ends )
           :GenericWindow(length)
{
  GenerateWindow( length, zero_ends );
}
//=======================================================

void HannWindow::GenerateWindow( int length, int zero_ends )
{
 for(int n=0; n<Half_Length; n++)
   {
    if(length%2) // odd length
      {
       if(zero_ends)
         {Half_Lag_Win[n] = 0.5 + 0.5 * cos( TWO_PI*n/(length-1));}
       else
         {Half_Lag_Win[n] = 0.5 + 0.5 * cos( TWO_PI*n/(length+1));}
      }
    else
      {
       if(zero_ends)
         {Half_Lag_Win[n] = 0.5 + 0.5 * cos( (2*n+1)*PI/(length-1));}
       else
         {Half_Lag_Win[n] = 0.5 + 0.5 * cos( (2*n+1)*PI/(length+1));}
      }
    cout << n << "  " << Half_Lag_Win[n] << endl;
   }
 return;
} 

