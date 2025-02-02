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


  chkIn(1) ;

  chkT(1);

 


# PeeFrq

bmt = "p"
val = "1"

dt = date()

<<" $dt  $bmt $val\n"

fname ="peefrq.dat"
sz=f_exist(fname, 0,1)
 
if (sz == -1) {
A=o_file(fname,"w+")
}
else { 
A=o_file(fname,"r+") ;
}

//<<" %V $A\n"

f_seek(A,0,2)

<<[A],"$dt $bmt $val\n"
f_seek(A,0,0)

C=readfile(A)

cf(A)

<<" $C \n"



///

  chkOut(1);



#if __CPP__           
  exit(-1); 
  }  // end of C++ main 
#endif     

 

//==============\_(^-^)_/==================//
