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
 
               


  ignoreErrors();

  Table_init();

  Svar R;
  
  sv = "this is a string"

<<"%V $sv \n"


  Sv = split ("This is an svar array of strings")


  <<"%V $Sv\n"

  S= functions() ;
               
  S.sort();

 <<"%(1, , ,\n)$S[0:50:5]\n"

 //<<" $S\n"

   F= S[100:200:5];  // range for cpp ?

// does  F= S(100,200,5)  work in asl ?


 <<"Svar range op \n"
 <<"%(1, , ,\n)$F\n"

// what is C++ equivalent of "%(1, , ,\n) ?

 <<"Svar range op \n"
 <<" $F\n" // ==> cprintf("%A\n",&F);
 <<"%(1, , ,\n)$F\n"

<<"//////////////////////////\n"

//  cprintf("%S\n",S);
               
              
               
    x= 1.5
               
    y = atan(x)
               
    p = sin(4* x)
               
         <<"%V $x $p $y \n"



 // S.pinfo()   // pinfo for svar - rather than Siv pinfo

 F= search(S," atan (");
 <<"%(1, , ,\n)$F\n"
               
/*               
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
