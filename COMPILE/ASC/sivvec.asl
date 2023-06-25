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
//#include "debug"

   if (_dblevel >0) {

     debugON();

     }

   chkIn(_dblevel);
#endif

  //Vec<double> Vtst(10,10,1);
   //sdb(1,"step");

   Svar S

   a = 57.75;
   
   Siv T(FLOAT_,10,0,1);

   T.pinfo();

 //  Mda MD(DOUBLE_, 4,10,3,4,5);

//   MD.pinfo();
   



   Siv V(INT_,10,0,1);
   
   V.pinfo();

//   sr = iread("?")

   Siv R = T[1:8:2];

   R.pinfo();

   R = T[1:7:1];

   R.pinfo();

   V = 5 * a;

<<"%V $V\n"

   T = 7 * a;

<<"%V $T\n"

   T += V

<<"%V $T\n"


   
/*   

   
   Siv T (FLOAT_,10,0,1);//T= fgen(10,0,1);



   T.pinfo();

  chkN (T[1],1);

  <<"$T\n";



  

  R.pinfo();
  <<"$R\n";

//   r = R[0] ; // need [] type check

//<<"%V $r\n"


  chkOut();
  
*/
 <<"$('PBLACK_')  this is black print \n"
#if CPP              
  //////////////////////////////////
  exit(-1);
 }  /// end of C++ main   
#endif               

               
///////////////////////////    END OF SCRIPT ///////////////////////////////
