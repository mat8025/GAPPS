///            
///  test cprintf
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

  sv = "this is a string"

<<"%V $sv \n"


  Sv = split ("This is an svar array of strings")


  <<"%V $Sv\n"

  S= functions() ;
               
  S.sort();

//<<"%(1, , ,\n)$S[0:50:5]\n"

 <<" $S\n"


//  cprintf("%S\n",S);
               
              
               
    x= 1.5
               
    y = atan(x)
               
    p = sin(4* x)
               
         <<"%V $x $p $y \n"

/*

  S.pinfo()   

 F= search(S," atan (");
 <<"%(1, , ,\n)$F\n"
               
               
 F= search(S," sin (");
 <<"%(1, , ,\n)$F\n"
               
               
 F= search(S," search (");
 <<"%(1, , ,\n)$F\n"
               
 F= search(S," functions (");
 <<"%(1, , ,\n)$F\n"
*/
///////////////////////////////////////


#if CPP              
  //////////////////////////////////
  exit(-1);
 }  /// end of C++ main   
#endif               

               
///////////////////////////    END OF SCRIPT ///////////////////////////////
