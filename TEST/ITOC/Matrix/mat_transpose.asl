
/* 
 *  @script mat_transpose.asl                                           
 * 
 *  @comment check transpose op                                         
 *  @release 6.66 : C Dy                                                
 *  @vers 1.1 H Hydrogen [asl 6.66 : C Dy]                              
 *  @date 01/03/2026 21:33:42                                           
 *  @cdate 01/03/2026 21:33:42                                          
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2026 -->                               
 * 
 */ 

                                                                                                                                                                                                                                                                          

#define __CPP__ 0

#if __ASL__

 Str Use_= " Demo  of check transpose op ";

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

 

//
//
//


// test 
 int MS[] = {16, 3, 2, 13, 5, 10, 11, 8, 9, 6, 7, 12, 4 ,15, 14, 1}

  MS.redimn(4,4)

  <<"$MS\n"

  TMS= Mtrp(MS)

   <<"$TMS\n"
  
  


//  

N= 20

   R= Dgen(N*N,1,1)

//   R= Fgen(25,1,1)

// make it work as Double if needed


 <<" $(typeof(R)) \n"

 <<"%v \n $R \n"

  Redimn(R,N,N)

// %r print by rows -- %10r - force fold every 10

 <<"%r%v%6.2f \n $R \n"

X= Mtrp(R)

<<"%v%6.1f \n $X \n"


<<"%v%6.1f \n $R \n"

X= Minv(R)

<<"%v%6.1f \n $X \n"

<<"%v%6.1f \n $R \n"



X = R

for (i= 0; i < 3; i++) {

  Y = Minv(X)
<<"$i \n\n"
<<"%v%6.1f \n $Y \n"
  X = R + 1

}





  V=  Mtrp(R)


<<"%v%6.1f \n $V \n"

  T = Mtrp(V)

<<"%v%6.2f \n $T \n"


 int RS[] = {16, 3, 2, 13, 5, 10, 11, 8, 9, 6, 7, 12, 4 ,15, 14, 1, 47, 48, 49, 50}

  RS.redimn(4,5)
  
  <<"$RS\n"
  RS.pinfo()
  
  TRS= Mtrp(RS) ; // transpose and return the transposed matrix leaving original asis

   <<"$TRS\n"

  TRS.pinfo()


 exit()





///

  chkOut(1);



#if __CPP__           
  exit(-1); 
  }  // end of C++ main 
#endif     

 
//==============\_(^-^)_/==================//
