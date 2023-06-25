///            
///  test str 
///            
               
#define ASL 0
#define CPP 0
#define USE_GRAPHICS 0

#define DO_INCS 1
                            
//#include "debug.asl"
#if CPP
#include "cpp_head.h"                       
#endif               

///////////////  GLOBALS //////////////////

  a_main = 456

  b_main = 456.321


  c_str = "main str"
  
#if DO_INCS

<<" including stuff\n"

#include "inc1.asl"

#include "inc2.asl"

//  adding in inc4.asl"

#include "inc4.asl"
#endif

////////////////////////////////////////////////

               
#if CPP
// main start
int main( int argc, char *argv[] ) {
///
  <<"not see in asl tranlation !\n"
  Table_init();
///
#endif               
 
               


  ignoreErrors();
  
 sv = "this is a main string"

 <<"%V $sv \n"

 Str astr = "Hope springs "

 <<"%V $astr \n"

  int  k = 77
  int  r = 33
  int  w = 66
<<"%V $k $r \n"

#if DO_INCS

<<"%V $k $r $w\n"

<<"MAIN accessing inc1 var $s_inc1 \n"
<<" MAIN accessing inc2 var $s_inc2 \n"

//  z= add_inc1(k,r)

//<<"from add_inc1 $z = $k + $r \n"


<<" MAIN accessing inc3 var $s_inc3 \n"
<<" MAIN accessing inc4 var $s_inc4 \n"

#endif


   ze =  54

<<" DONE MAIN $ze\n"

#if CPP              
  //////////////////////////////////
  exit(-1);
 }  /// end of C++ main   
#endif               

 