
/* 
 *  @script pee.asl                                                     
 * 
 *  @comment log peeing                                                 
 *  @release 6.59 : C Pr                                                
 *  @vers 1.1 H Hydrogen [asl 6.59 : C Pr]                              
 *  @date 01/20/2025 19:01:50                                           
 *  @cdate 01/20/2025 19:01:50                                          
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2025 -->                               
 * 
 */ 


#define __CPP__ 0

#if __ASL__

 Str Use_= " Demo  of log peeing ";

 Svar argv = _argv;  // allows asl and cpp to refer to clargs
 argc = argc();


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
    init_cpp(argv[0]) ; 

#endif       

 // showenv() ; // TBD need cpp
  
  chkIn(1) ;

//  chkT(1);

 

// PeeFrq

bmt = "p"
val = "1"
dt = "1"
dt = date()
int A = -1
<<" $dt  $bmt $val\n"

fname ="peefrq.dat"
sz=fexist(fname, 0,1)
 
if (sz == -1) {
A=ofw(fname)
}
else { 
A=ofa(fname) ;
}

//<<" %V $A\n"

fseek(A,0,2)

<<"$dt $bmt $val\n"


<<[A],"$dt $bmt $val\n"
 fseek(A,0,0)

// cf(A)

 Svar C
 Str sve = "XX"
//A=ofr(fname) ;


  C.readFile(A) ; // TBD  allow FH


// C.readFile(fname) ; 





//<<"0 $C[0] \n" ;  // need cpp pex for svar element

//<<"[2] $C[2] \n"
//<<"[3] $C[3] \n"
<<" $C \n"

//<<"[-1] $C[-1] \n"

cf(A)

  sve = C[2]

<<" %V $sve\n"

<<" C[1:4]  \n $C[1:4] \n"

///

  chkOut(1);



#if __CPP__           
  exit(-1); 
  }  // end of C++ main 
#endif     

 

//==============\_(^-^)_/==================//
