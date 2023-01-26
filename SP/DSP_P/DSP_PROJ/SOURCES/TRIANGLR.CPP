//
//  File = trianglr.cpp
//

#include <math.h>
#include <iostream.h>
#include "trianglr.h"
#include "misdefs.h"


TriangularWindow::TriangularWindow( istream& uin,
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

TriangularWindow::TriangularWindow( int length,
                                    int zero_ends )
                 :GenericWindow(length)
{
  GenerateWindow( length, zero_ends );
}
//=======================================================

void TriangularWindow::GenerateWindow( int length,
                                       int zero_ends )
{
 if( zero_ends)
   {
    if(length%2)   // odd length window centered at zero
      {
       for(int n=0; n<Half_Length; n++)
         {
          Half_Lag_Win[n] = 1.0 - (2.0*n)/((double)(Length-1));
         }
      }
    else     // even length window centered at -1/2
      {
       for(int n=0; n<Half_Length; n++)
         {
          Half_Lag_Win[n] = 1.0 - (2.0*n + 1.0)/((double)(Length-1));
         }
      }
   }
 else
   {
    if(length%2)   // odd length window centered at zero
      {
       for(int n=0; n<Half_Length; n++)
         {
          Half_Lag_Win[n] = 1.0 - (2.0*n)/((double)(Length+1));
         }
      }
    else     // even length window centered at -1/2
      {
       for(int n=0; n<Half_Length; n++)
         {
          Half_Lag_Win[n] = 1.0 - (2.0*n + 1.0)/((double)(Length+1));
         }
      }
   }
 return;
}

