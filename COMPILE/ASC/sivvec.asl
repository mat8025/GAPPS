///            
///  test siv vec ops
///            
   


#define ASL 1
#define CPP 0
#define ASL_DEBUG 0
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
 

#if  ASL_DEBUG
#include "debug"

   if (_dblevel >0) {

     debugON();

     }

   chkIn(_dblevel);
#endif

  //Vec<double> Vtst(10,10,1);

     Siv V (INT_,10,0,1);

   Siv T (FLOAT_,10,0,1);//T= fgen(10,0,1);

  V.pinfo();

   T.pinfo();

  chkN (T[1],1);

  <<"$T\n";



  Siv R = T[1:8:2]

  R.pinfo();
  <<"$R\n";

//   r = R[0] ; // need [] type check

//<<"%V $r\n"


  chkOut();
  


#if CPP              
  //////////////////////////////////
  exit(-1);
 }  /// end of C++ main   
#endif               

               
///////////////////////////    END OF SCRIPT ///////////////////////////////
