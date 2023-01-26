//
//  File = gen_win.h
//

#ifndef _GEN_WIN_H_
#define _GEN_WIN_H_ 

#include <fstream.h>

class GenericWindow
{
public:

  // constructors
  
  GenericWindow( void );
  GenericWindow( int length );
  
  void Initialize( int length );
  
  double GetDataWinCoeff( int samp_indx);
  
  void DumpHalfLagWindow( ofstream* output_stream);

  void NormalizeWindow( void );
  
  double* GetDataWindow( void );
  
  double* GetHalfLagWindow( void );
  
  //double* GetLagWindow( void );
  
  int GetNumTaps( void );
  
protected:

  int Length;
  int Half_Length;
  double *Half_Lag_Win;
  double *Lag_Win;
  double *Data_Win;
};

#endif
  