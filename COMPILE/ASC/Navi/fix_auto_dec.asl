///            
///  test auto_dec_via_func
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
               
               
               
  ignoreErrors();
               
            
    x= 1.5;
               
    y = atan(x);
               
    p = sin(4* x);

    z = x * y;

   <<"%V $x $y $z\n"

#if CPP              
  //////////////////////////////////
  exit(-1);
 }  /// end of C++ main   
#endif               

               
///////////////////////////    END OF SCRIPT ///////////////////////////////
