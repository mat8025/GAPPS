///
///
///


#define DB_IT    0
#define GT_DB   0



#define _CPP_ 0
// asl  -T  flag to produce cpp compilable code 
//  the script xyz.asl  is converted to xyz.asc  and that file can be compled with cpp
//  the translation flips the _CPP_ define to 1  in the resulting asc file
//  the make_asc  script  will compile  asc code
//  e.g. make_asc  xyz.asc

//  just using asl  interpreter skips over _CPP_ sections in the asl script
//  and defines _ASL_ and _TRANS_ to 1
//

#if _CPP_
#include <iostream>
#include <ostream>

using namespace std;
#include "vargs.h"
#include "cpp_head.h" 
#define PXS  cout<<



#define _ASL_ 0
#define _TRANS_ 1
#endif

#define NPTS 100

///////////////  GLOBALS //////////////////



//////////////// INCLUDES ////////////////

//  asl -T will produce inc1.asc -- which contains cpp code
#include "inc1.asl"


///////////////  PROCS  /////////////////////




/////////////    MAIN ///////////////////////////

#if _CPP_

int main( int argc, char *argv[] ) { // main start
///
#endif


#if _ASL_

<<"ASL no trans %V $run_asl  \n"

#endif


#if _TRANS_

<<"TRANS so trans %V $_TRANS_  \n"

#endif


#if _CPP_
//  not interpreted by ASL
  printf("leave cpp alone\n");

#endif


#if _ASL_
// this section is interpreted only will not be converted to cpp code
// with the asl -T  compile option

   <<" leave this alone ! don't cppify\n"

#endif

<<" _TRANS_ is $_TRANS_ \n"
<<" _CPP_ is $_CPP_\n"
<<" _ASL_ is $_ASL_\n"

#if _CPP_
// should be valid cpp
   printf(" do this trans if _CPP_ is set - not seen by asl script interpreter \n");
#endif 


// outside of _ASL_ and _CPP_ so goahead and cppify when translating

   ignoreErrors();

int IV[NPTS] 


  IV[2] = 77
  
int k = 66

<<" translate this $k \n"

float f = sin(0.5)

<<" translate this $f \n"

#if _ASL_
<<" running as ASL \n"
#endif

<<"  ASL is $_ASL_ \n"

<<"  CPP is $_CPP_ \n"

<<"  TRANS is $_TRANS_ \n"

<<"  N is $NPTS \n"

  int n = NPTS

<<"  n is $n \n"

#if _CPP_              
  //////////////////////////////////
  exit(-1);
 }  /// end of C++ main   
#endif               

               
///////////////////////////    END OF SCRIPT ///////////////////////////////




////////////////




