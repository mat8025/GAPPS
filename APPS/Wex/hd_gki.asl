/* 
 *  @script gki.asl                                                     
 * 
 *  @comment calc gki from glucose and ketone readings                  
 *  @release 6.54 : C Xe                                                
 *  @vers 1.2 He Helium [asl 6.54 : C Xe]                               
 *  @date 08/18/2024 16:17:50                                           
 *  @cdate 08/18/2024 16:17:50                                          
 *  @author Mark Terry                                                  
 *  @author Mark Terry                                                  
 * 
 */ 

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          

#define __CPP__ 0

#if __ASL__

 Str Use_= " Demo  of calc gki from glucose and ketone readings ";

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
    init_cpp() ; 

#endif       


  chkIn(1) ;

  chkT(1);

 

/* 
 *  @script gki.asl                                                     
 * 
 *  @comment calc gki from glucose and ketone readings                  
 *  @release 6.54 : C Xe                                                
 *  @vers 1.2 He Helium [asl 6.54 : C Xe]                               
 *  @date 08/18/2024 16:12:02                                           
 *  @cdate 08/18/2024 16:12:02                                          
 *  @author Mark Terry                                                  
 * 
 */ 


#define __CPP__ 0

#if __ASL__

 Str Use_= " Demo  of calc gki from glucose and ketone readings ";

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
     init_cpp(argv[0]); 

#endif       



  chkT(1);

 

//
//
//

//gl = _argv[1]
//k =  _argv[2]


glr = atof(argv[1])
kr = atof(argv[2])


  gki = glr/18.0 / kr

<<"%V $gki glr kr \n"



//============================================
/*
blood glucose result divided by 18, then divided by the blood ketone result.
Dividing the blood glucose result by 18 converts
 the reading from mg/dL to mmol/L. 
*/

///




#if __CPP__           
  exit(-1); 
  }  // end of C++ main 
#endif     

 

//==============\_(^-^)_/==================//


///

  chkOut(1);



#if __CPP__           
  exit(-1); 
  }  // end of C++ main 
#endif     

 

//==============\_(^-^)_/==================//
