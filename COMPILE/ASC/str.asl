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



#include "inc1.asl"

//#include "inc2.asl"

//  adding in inc4.asl"

//#include "inc4.asl"

#endif

////////////////////////////////////////////////


long add_main (int m, int n)
 {
 int am;
      am = m +n

 <<" $am = $m + $n \n"
      return am;
 }


               
#if CPP
// main start
int main( int argc, char *argv[] ) {
///

  Table_init();
///
#endif               
 
               


  ignoreErrors();

    k = 78
    r = 33

    y = exp(1)

<<"trying  auto create of w\n"
   w = 66



 sv = "this is a main string"

 <<"%V $sv \n"

 astr = "Hope springs "

 <<"%V $astr \n"

// auto create w
   w = 67
//   y = 2.7182
   
   u = 68
   
r2 = 7.898

 n= add_main(k,r)
 <<"proc returns $n \n"
// auto create r double ?
   r3 = 15.898


<<"%V $k $r $w $y $u $n $r $r2 $r3\n"




#if DO_INCS

<<"%V $k $r $w\n"

<<"MAIN accessing inc1 var $s_inc1 \n"
//<<" MAIN accessing inc2 var $s_inc2 \n"



//<<"from add_inc1 $z = $k + $r \n"


//<<" MAIN accessing inc3 var $s_inc3 \n"
//<<" MAIN accessing inc4 var $s_inc4 \n"




  z= add_inc1(k,r)

#endif

   x = 3.142
   ze =  54

<<" DONE MAIN $ze $x\n"

#if CPP              
  //////////////////////////////////
  exit(-1);
 }  /// end of C++ main   
#endif               

 