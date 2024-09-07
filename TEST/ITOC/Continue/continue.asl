/* 
 *  @script continue.asl                                                
 * 
 *  @comment  break/continue                                            
 *  @release Carbon                                                     
 *  @vers 1.2 He Helium [asl 6.54 : C Xe]                               
 *  @date 08/27/2024 09:03:44                                           
 *  @cdate 08/27/2024 08:44:35 Hydrogen [asl 6.54 : C Xe]               
 *  @author Mark Terry Hydrogen [asl 6.54 : C Xe]                       
 *  @Copyright © RootMeanSquare 2024 -->                               
 * 
 */ 



#define __CPP__ 0

#if __ASL__

 Str Use_= " Demo  of test break/continue ";

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

 

///
///
///


// test continue statement


  k =0;
  j=0
    while (1) {

      k++;
     <<"%V $k \n"
     if (k > 10) {
     <<"going to break @ $k\n"
      break;
     }
     if (k >3) {
       <<"going to skip rest to the end of while @ $k\n"
       continue
     }
     <<"if $k > 3 this should skip to end of loop - but not break out \n"

     
     <<" $k <= 3 \n"

     <<" not see if continue \n"
     j++;


     }

chkN(j,3)
 chkN(k,11)
 
<<"Out @ $k\n"



///

  chkOut(1);



#if __CPP__           
  exit(-1); 
  }  // end of C++ main 
#endif     

 

//==============\_(^-^)_/==================//
