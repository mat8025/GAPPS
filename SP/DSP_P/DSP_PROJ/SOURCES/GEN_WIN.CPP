//
//  File = gen_win.cpp
//

#include <math.h>
#include <stdio.h>
#include <iomanip.h>
#include "gen_win.h"
#include "misdefs.h"

GenericWindow::GenericWindow( void )
{
 Length = 0;
 Half_Length = 0;
 Half_Lag_Win = NULL;
 Data_Win = NULL;
 cout << "in GenericWindow(void)" << endl;
}
//----------------------------------------
GenericWindow::GenericWindow( int length )
{
 Initialize(length);
}
//----------------------------------------
void GenericWindow::Initialize( int length )
{
 Length = length;
 if(length%2)
   { Half_Length = (length+1)/2; }
 else
   { Half_Length = length/2; }
   
 Half_Lag_Win = new double[Half_Length];
 Data_Win = NULL;
 
 return;
}

double GenericWindow::GetDataWinCoeff( int samp_indx)
{
 int middle;
 
 if(Length%2)
   {
    middle = (Length-1)/2;
    if(samp_indx < middle)
      { return(Half_Lag_Win[middle-samp_indx]); }
    else
      { return( Half_Lag_Win[samp_indx-middle]); }
   }
 else
   {
    middle = Length/2;
    if(samp_indx < middle)
      { return(Half_Lag_Win[middle-1-samp_indx]); }
    else
      { return(Half_Lag_Win[samp_indx-middle]); }
   }
}

void GenericWindow::NormalizeWindow( void )
{
 double peak;
 peak = Half_Lag_Win[0];
 for(int n=0; n<Half_Length; n++)
   {
    Half_Lag_Win[n] /= peak;
   }
 return;
}  

void GenericWindow::DumpHalfLagWindow( ofstream *output_stream)
{
 FILE *hex_file;
 unsigned int hex_val[2];
 double* d_ptr;

 hex_file = fopen("wn_hex.out", "w");
 (*output_stream) << setprecision(12);
 d_ptr = (double*)hex_val;
 for(int n=0; n<Half_Length; n++)
   {
    *d_ptr = Half_Lag_Win[n];
    (*output_stream) << n << ", " << Half_Lag_Win[n] << "   "
                     << hex << hex_val[0] << " " << hex_val[1] 
                     << dec << endl;
   }
 fprintf(hex_file, "sizeof(long) = %d\n", sizeof(long));
 fprintf(hex_file, "sizeof(double) = %d\n", sizeof(double));
 *d_ptr = 0.75 + ((double)1.0/8388608.0);
 fprintf(hex_file, "%f,  %lx%lx\n",(*d_ptr), hex_val[0],hex_val[1]);
 *d_ptr = -0.25;
 fprintf(hex_file, "%f,  %lx%lx\n",(*d_ptr), hex_val[0],hex_val[1]);
 *d_ptr = 0.125;
 fprintf(hex_file, "%f,  %lx%lx\n",(*d_ptr), hex_val[0],hex_val[1]);
 *d_ptr = 0.25;
 fprintf(hex_file, "%f,  %lx%lx\n",(*d_ptr), hex_val[0],hex_val[1]);
 *d_ptr = 0.5;
 fprintf(hex_file, "%f,  %lx%lx\n",(*d_ptr), hex_val[0],hex_val[1]);
 *d_ptr = 0.75;
 fprintf(hex_file, "%f,  %lx%lx\n",(*d_ptr), hex_val[0],hex_val[1]);
 *d_ptr = 2.0;
 fprintf(hex_file, "%f,  %lx%lx\n",(*d_ptr), hex_val[0],hex_val[1]);
 *d_ptr = 3.0;
 fprintf(hex_file, "%f,  %lx%lx\n",(*d_ptr), hex_val[0],hex_val[1]);
 *d_ptr = -2.0;
 fprintf(hex_file, "%f,  %lx%lx\n",(*d_ptr), hex_val[0],hex_val[1]);
 *d_ptr = -1.0;
 fprintf(hex_file, "%f,  %lx%lx\n",(*d_ptr), hex_val[0],hex_val[1]);
 *d_ptr = 1.0;
 fprintf(hex_file, "%f,  %lx%lx\n",(*d_ptr), hex_val[0],hex_val[1]);
 *d_ptr = 64.0;
 fprintf(hex_file, "%f,  %lx%lx\n",(*d_ptr), hex_val[0],hex_val[1]);
 *d_ptr = 63.0;
 fprintf(hex_file, "%f,  %lx%lx\n",(*d_ptr), hex_val[0],hex_val[1]);
 (*output_stream) << setprecision(0);
 return;
}  

double* GenericWindow::GetDataWindow( void )
{
 if( Data_Win == NULL )
   {
    Data_Win = new double[Length];
    for(int n=0; n<Length; n++)
     {
      Data_Win[n] = GetDataWinCoeff(n);
     }
   }
 return(Data_Win);
}
  
double* GenericWindow::GetHalfLagWindow( void )
{
 return(Half_Lag_Win);
}
  

int GenericWindow::GetNumTaps( void )
{
  return(Length);
}
 

