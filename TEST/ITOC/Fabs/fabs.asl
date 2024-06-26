/* 
 *  @script fabs.asl                                                    
 * 
 *  @comment test fabs function                                         
 *  @release 6.37 : C Rb                                                
 *  @vers 1.2                                                           
 *  @date 06/26/2024 15:28:29                                           
 *  @cdate 1/1/2001                                                     
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2024 -->                               
 * 
 */ 


#define __CPP__ 0

#if __ASL__
Str Use_= " Demo  of test fabs function      ";

#include "debug" 

  if (_dblevel >0) { 
   debugON() 
   <<"$Use_ \n" 
} 

   allowErrors(-1); // set number of errors allowed -1 keep going 

#endif       

// CPP main statement goes after all procs
#if __CPP__
#include <iostream>
#include <ostream>
using namespace std;
#include "vargs.h"
#include "cpp_head.h"
#define PXS  cout<<

#define CPP_DB 0

  int main( int argc, char *argv[] ) {  
    init_cpp() ; 

#endif       


  chkIn(1) ;

  chkT(1);

 



///
///
///




// bug in arg passing??

  double y = 1234.123456

  x= fabs(y)

<<"%V $x  $y\n"

  z = y * -1.0;

  x= fabs(z)

<<"%V $x  $y\n"


   chkR(x,y,6)

  y = 123456.123456

  z = y * -1.0;

  x= fabs(z)

<<"%V $x  $y\n"

  chkN(x,y)


  y = 123456789.123456

  z = y * -1.0;

  x= fabs(z)

<<"%V $x  $y\n"

  chkN(x,y)



///

  chkOut(1);


#if __CPP__           
  exit(-1); 
  }  // end of C++ main 
#endif     

 

//==============\_(^-^)_/==================//
