/* 
 *  @script pfmt.asl                                                    
 * 
 *  @comment                                                            
 *  @release Carbon                                                     
 *  @vers 1.2 He Helium [asl 6.46 : C Pd]                               
 *  @date 07/09/2024 15:23:27                                           
 *  @cdate 11/28/2021 14:28:59                                          
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2024 -->                               
 * 
 */ 


                                                                                                                                                                                   

#define __CPP__ 0

#if __ASL__

 Str Use_= " Demo  of format in asl print ==>cprintf  ";

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

 //allowDB("spe,rdp,vmf",1)

//   float TFV[] = vgen(float_,10,1,0.5);   // TBF ? 7/9/24  the return type is first parameter
// what is the work around    Vec<type> TFV(10,1,0.5)  ? translation ?
//  float TFV[];

   n = 10

 //  TFV[n] = fgen(n,1,0.5);
  Vec<float> TFV (n,1,0.5);
  //TFV.pinfo()

  <<"%6.3f $TFV\n";

   T= split("%V %6.2f$TFV");
   
  T.pinfo()
   <<"$T\n";

   cprintf("\n%A\n",&T);
//ans=ask(" T $T ",1)
   cprintf("\n%A\n",T);

//ans=ask(" T $T ",1)
   chkStr(T[2],"1.50");

   chkStr(T[3],"2.00");

   chkStr(T[4],"2.50");

<<"%V%6.2f$TFV\n";
    <<"%V%6.2f$TFV\n"



//===***===//


///

  chkOut(1);



#if __CPP__           
  exit(-1); 
  }  // end of C++ main 
#endif     

 

//==============\_(^-^)_/==================//
