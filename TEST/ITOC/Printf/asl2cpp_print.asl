
/* 
 *  @script asl2cpp_print.asl                                           
 * 
 *  @comment testing asl print function cpp translation                 
 *  @release 6.59 : C Pr                                                
 *  @vers 1.1 H Hydrogen [asl 6.59 : C Pr]                              
 *  @date 01/22/2025 09:09:21                                           
 *  @cdate 01/22/2025 09:09:21                                          
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2025 -->                               
 * 
 */ 

#define __ASL__ 1
#define __CPP__ 0

#if __ASL__

 Str Use_= " Demo  of testing asl print function cpp translation ";

 Svar argv = _argv;  // allows asl and cpp to refer to clargs
 argc = argc();



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
  
    init_cpp(argv[0]) ; 

#endif       


  chkIn(1) ;

  chkT(1);

 



//  test translation of our print function
//  a = 123.456;
//  <<" our print   %V $a \n"
//  --> cprintf(" out print a %f \n",a);


 
 a = 123.4560

<<" print %v $a\n"

// r= <<" print %v $a\n"  ; // TBF ? EXP vs PRSTDOUT

// r.pinfo()
 
// <<"%V $r\n"
 
  chkF(a,123.4560,3)

  fname = "pout.txt"

  A = ofw(fname)

  <<"%V $A\n"
  
  <<[A]" print to fd %v $a $A\n"

  // r2 = <<[A]" Print %v $a $A\n" ;  // TBF fixed 1/22/25

  cf(A)

Str ts

   ts =     " paramexpand these $a $A "

<<"\n ts expanded to $ts \n"

   as = " auto paramexpand these $a $A $ts "

<<"\n as expanded to $as \n"

  as.pinfo()

///

  chkOut(1);

<<"que pasa?\n"


#if __CPP__           
  exit(-1); 
  }  // end of C++ main 
#endif     

 

//==============\_(^-^)_/==================//
