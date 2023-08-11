///
///   create an asc file (cpp compatible) from asl script
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



#define WX 1

///////////////  GLOBALS //////////////////

#include "inc1.asl"



#define ASZ 10
int N = 12

int Veci[ASZ]

////////////////////////////////////////////////

#if CPP

int main( int argc, char *argv[] ) { // main start
///
#endif               
   ignoreErrors();
   
int a =1
int b= 0
int t
int i

int j

 for (j=0; j < 6; j++) {
    a= 1;
    b= 0;
    for (i=0; i<N;i++) {

       Veci[i] = b
       t = a
       a = t + b
       b = t
   <<"%V $t $b $a\n"
    }

<<"$Veci \n"

  <<" $Veci[j] \n"
//  ans=query(">")
  }

<<"%V $Inc1_val \n"

#if CPP              
  //////////////////////////////////
  exit(-1);
 }  /// end of C++ main   
#endif               

               
///////////////////////////    END OF SCRIPT ///////////////////////////////
