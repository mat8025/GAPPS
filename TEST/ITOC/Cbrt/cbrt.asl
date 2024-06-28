/* 
 *  @script cbrt.asl                                                    
 * 
 *  @comment test cbrt cube root SF                                     
 *  @release 6.38 : C Sr                                                
 *  @vers 1.3 H Hydrogen [asl 6.38 : C Sr]                              
 *  @date 06/26/2024 18:12:09                                           
 *  @cdate 1/1/2005                                                     
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2024 -->                               
 * 
 */ 

#define __CPP__ 0
#if __ASL__

   Str Use_= " Demo  of test cbrt cube root SF    ";
#include "debug"

   if (_dblevel >0) {

        debugON();

        <<"$Use_ \n";

   }

   allowErrors(-1); // set number of errors allowed -1 keep going;
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
///  Cbrt
///

        f= sqrt(81.0);

        <<"$f $(typeof(f))\n"; // TBF typeof  CPP trans not moved to print arg

        chkR(f,9.0);

        f= cbrt(27.0);

        chkR(f,3.0);

        <<"$f $(typeof(f))\n";

        f= cbrt(125.0);

        <<"$f $(typeof(f))\n";

        chkR(f,5.0);
///

        chkOut(1);
#if __CPP__           

        exit(-1);

        }  ; // end of C++ main;
#endif     
//==============\_(^-^)_/==================//
