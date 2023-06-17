///            
///  test svar
///            
               
#define ASL 1
#define CPP 0
#define USE_GRAPHICS 0
               
                            
//#include "debug.asl"
#if CPP
#include "cpp_head.h"                       
#endif               

///////////////  GLOBALS //////////////////


////////////////////////////////////////////////

               
#if CPP

int main( int argc, char *argv[] ) { // main start
///
#endif               
 


  ignoreErrors()

  Table_init()


  S= split("0 1 2 3 4 5 6 7 8 9 10")

   F= S[1:8:2] 

 <<"%(1, , ,\n)$F\n"


// does  F= S(100,200,5)  work in asl ?

  sr=iread("Svar range op ")



#if CPP              
  //////////////////////////////////
  exit(-1);
 }  /// end of C++ main   
#endif               

               
///////////////////////////    END OF SCRIPT ///////////////////////////////
