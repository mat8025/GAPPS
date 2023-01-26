//
//  File = dolph.cpp
//

#include <math.h>
#include <iostream.h>
#include <stdlib.h>
#include "dolph.h"
#include "misdefs.h"
#include "acosh.h"

//=================================================

DolphChebyWindow::DolphChebyWindow( istream& uin,
                                    ostream& uout )
{
  int num_taps;
  double atten;

  uout << "number of taps?" << endl;
  uin >> num_taps;

  uout << "desired value of sidelobe attenuation?" << endl;
  uin >> atten;
  Alpha_Parm = cosh(acosh(pow(10.0,atten/20.0))/num_taps);
  uout << "alpha = " << Alpha_Parm << endl;

  uout << "number of freq samps per time tap?" << endl;
  uin >> Interp_Rate;

  Initialize( num_taps );
  GenerateWindow( num_taps );
  return;
}
//=================================================

DolphChebyWindow::DolphChebyWindow( int length )
                 :GenericWindow(length)
{
  GenerateWindow( length );
}
//=================================================

void DolphChebyWindow::GenerateWindow( int length )
{
 double denom, numer, x;
 double sum_re, sum_im;
 int n, k;
 int num_freq_samps, beg_freq_idx, end_freq_idx;
 double* freq_resp;

 ofstream RespFile("dolph_resp.txt", ios::out);
 ofstream CoefFile("dolph_coef.txt", ios::out);

 freq_resp = new double[length * Interp_Rate];
 
 beg_freq_idx = ((1-length)*Interp_Rate)/2;
 end_freq_idx = ((length-1)*Interp_Rate)/2;
 num_freq_samps = Interp_Rate * (length-1) + 1;

 denom = cosh( length*acosh(Alpha_Parm));
 cout << "denom = " << denom << endl;
 
 for( n=beg_freq_idx; n<=end_freq_idx; n++)
   {
    x = Alpha_Parm * cos( (PI * n) / double(Interp_Rate*length) );
    if(x < 1.0)
      {
       numer = cos( length * acos(x) );
      }
    else
      {
       numer = cosh( length * acosh(x) );
      }
    if(n<0)
      {
      freq_resp[n + num_freq_samps] = numer/denom;
      RespFile << n << ", " << 20.0*log10(fabs(numer/denom)) 
               << endl;
      }
    else
      {
      freq_resp[n] = numer/denom;
      RespFile << n << ", " << 20.0*log10(fabs(numer/denom)) 
               << ", " << x << endl;
      }
   }
   
 //------------------------------------------
 //  now do inverse DFT
 
 for( n=0; n<=(length-1)/2; n++)
   {
    sum_re = 0.0;
    sum_im = 0.0;
    
    for( k=0; k<num_freq_samps; k++)
      {
       sum_re += (freq_resp[k] * cos( (TWO_PI * k * n)/ (double)num_freq_samps));
       sum_im += (freq_resp[k] * sin( (TWO_PI * k * n)/ (double)num_freq_samps));
      }
    Half_Lag_Win[n] = sum_re/(double)num_freq_samps;
   }
  #ifdef _NOT_DEFINED
 int new_length;
 cout << "new value for half length?" << endl;
 cin >> new_length;
 Half_Length = new_length;
 Length = 2 * new_length - 1;
 #endif
 NormalizeWindow();
 delete freq_resp;
 return;
}
