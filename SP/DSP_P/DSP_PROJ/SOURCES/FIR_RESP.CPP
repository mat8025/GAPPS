//
//  File = fir_resp.cpp
//
//  Member functions for class FirFilterResponse
//

#include <math.h>
#include <stdlib.h>
#include "complex.h"
#include "fir_resp.h"
#include "typedefs.h"
#include "misdefs.h"

//==================================================
//  constructor with all configuration parameters
//  passed in as arguments
//--------------------------------------------------

FirFilterResponse::FirFilterResponse( FirFilterDesign *filter_design,
                                      int num_resp_pts,
                                      int db_scale_enabled,
                                      int normalize_enabled,
                                      char* resp_file_name )
{
 Filter_Design = filter_design;
 Num_Resp_Pts = num_resp_pts;
 Db_Scale_Enabled = db_scale_enabled;
 Normalize_Enabled = normalize_enabled;
 
 if( resp_file_name == NULL)
   { Response_File = new ofstream("win_resp.txt", ios::out);}
 else
   { Response_File = new ofstream(resp_file_name, ios::out);}
   
 Num_Taps = Filter_Design->GetNumTaps();
 Mag_Resp = new double[Num_Resp_Pts];

 return;
}

//===================================================================
// alternate constructor with interactive setting of
// configuration parameters
//-------------------------------------------------------------------
FirFilterResponse::FirFilterResponse( FirFilterDesign *filter_design,
                                      istream& uin,
                                      ostream& uout )
{
 logical default_file_ok;
 Filter_Design = filter_design;
 
 uout << "number of points in plot of frequency response?" << endl;
 uin >> Num_Resp_Pts;
 
 uout << "scaling?\n"
      << "  0 = linear, 1 = dB"  << endl;
 uin >> Db_Scale_Enabled;
  
 if( Db_Scale_Enabled != 0) Db_Scale_Enabled = 1;
 Normalize_Enabled = 1;
  
 uout << "default name for magnitude response output\n"
      << "file is win_resp.txt\n\n"
      << "is this okay?"
      << "  0 = NO, 1 = YES"
      << endl;
 uin >> default_file_ok;
  
 if( default_file_ok)
    {
     Response_File = new ofstream("win_resp.txt", ios::out);
    }
  else
    {
     char *file_name;
     file_name = new char[31];
     
     uout << "enter complete name for output file (30 chars max)"
          << endl;
     uin >> file_name;
     Response_File = new ofstream(file_name, ios::out);
     delete []file_name;
    } 

 Num_Taps = Filter_Design->GetNumTaps();
 Mag_Resp = new double[Num_Resp_Pts];

 return;
} 


//==================================================
//  method to compute magnitude response
//--------------------------------------------------
void FirFilterResponse::ComputeMagResp( void )
{
 int resp_indx, tap_indx;
 double lambda;
 complex work;
 
 cout << " in FirFilterResponse::ComputeMagResp" << endl;
 double* coeff = Filter_Design->GetCoefficients();

 for( resp_indx=0; resp_indx<Num_Resp_Pts; resp_indx++)
   {
   lambda = resp_indx * PI / (double) Num_Resp_Pts; 
   work = complex(0.0, 0.0);
  
   for( tap_indx=0; tap_indx<Num_Taps; tap_indx++)
     {
      work = work + (coeff[tap_indx] * 
             complex( cos(tap_indx*lambda), 
                            -sin(tap_indx*lambda)));
     }
      
   if(Db_Scale_Enabled)
     {Mag_Resp[resp_indx] = 20.0 * log10(norm(work));}
   else
     {Mag_Resp[resp_indx] = norm(work);}
   }
 if(Normalize_Enabled) NormalizeResponse();

 return;
}

//=======================================================
//  method to normalize magnitude response
//-------------------------------------------------------

void FirFilterResponse::NormalizeResponse( void )
{
 int n;
 double biggest;
 
 if(Db_Scale_Enabled)
   {
    biggest = -100.0; 
    
    for( n=0; n < Num_Resp_Pts; n++)
      {if(Mag_Resp[n]>biggest) biggest = Mag_Resp[n];}
    for( n=0; n < Num_Resp_Pts; n++)
      {Mag_Resp[n] = Mag_Resp[n] - biggest;}
   }
 else
   {
    biggest = 0.0;
    
    for( n=0; n < Num_Resp_Pts; n++)
      {if(Mag_Resp[n]>biggest) biggest = Mag_Resp[n];}
    for( n=0; n < Num_Resp_Pts; n++)
      {Mag_Resp[n] = Mag_Resp[n] / biggest;}
   }
 return;
}
//===============================================
//  method to return a pointer to the magnitude
//  response that is stored inside this class
//-----------------------------------------------

double* FirFilterResponse::GetMagResp( void)
{
 return(Mag_Resp);
}

//===========================================================
//  method to dump magnitude response to the stream
//  designated by Response_File
//-----------------------------------------------------------

void FirFilterResponse::DumpMagResp( void )
{
 double freq;
 
 Response_File->setf(ios::fixed, ios::floatfield);
 for(int n=0; n<Num_Resp_Pts; n++)
   {
    freq = (n*PI)/double(Num_Resp_Pts);
    (*Response_File) << freq << ", " 
                     << Mag_Resp[n] << endl;
   }
 Response_File->setf(0, ios::floatfield);
 return;
}
//=====================================================
//  searches the magnitude response over the interval
//  from sample intrvl_beg thru the sample intrvl_end
//  and then returns the largest value found in this
//  interval.
//-----------------------------------------------------
double FirFilterResponse::GetIntervalPeak( int nBeg,
                                           int nEnd)
{
 double peak;
 int n, indexOfPeak;

 peak = -9999.0;
 for(n=nBeg; n<nEnd; n++)
   {
    if(Mag_Resp[n]>peak)
      {
       peak=Mag_Resp[n];
       indexOfPeak = n;
      }
   }
 return(peak);
}

