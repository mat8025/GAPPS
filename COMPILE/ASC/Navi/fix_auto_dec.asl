///            
///  test auto_dec_via_func
///            
               
  #define _ASL_ 1 
  #define _CPP_ 0  

#define USE_GRAPHICS 0

#if _ASL_
    int run_asl = runasl()
    <<"still in ASL leave section"
#endif    

                            
//#include "debug.asl"
#if _CPP_
#include "cpp_head.h"                       
#endif


               
///////////////  GLOBALS //////////////////
  AG = 77         
               
////////////////////////////////////////////////

///////////////  INCLUDES  OF ASL CODE //////////////////
#include "extra.asl"               
               
////////////////////////////////////////////////

///////////////  INCLUDES  OF COMPILED ASL   i.e. ASC FILES //////////////////
//#include "extra.asc"               
               
////////////////////////////////////////////////
Svar sargs;               
#if _CPP_        
               
int main( int argc, char *argv[] ) { // main start

 cout << "In CPP main " << endl ;
///// CPP section
   for (int i= 0; i <argc; i++) {
     sargs.cpy(argv[i],i);
   }
#endif

#else
<<" NOT CPP section\n"
<<" so ASL rules here ?\n"
#endif               

#if _ASL_
<<"  $(_ASL_)  in main \n"
<<" not seen when translating !\n"
#endif               
               
    ignoreErrors()

    fs = "now check vmf slen return"

    len = fs.slen()

nwr =0;  // TBF 6/21/24  sac to int nwr = 0;
  w = "xyz" ; // TBF 6/21/24  sac to Str = 0;

     byfile = sargs[1]

    x= 1.5

     j = sin(4* x)
 

    y = atan(x)
    run_asl = runASL();
    p = sin(4* x)
  
    z = x * y
 
   <<"%V $x $y $z\n"

    w= addem(x,y)

   <<"$x + $y == $w\n"

   int AFH= -1

   <<"GLOBAL $AG\n"

<<" making for the exit\n"
#if _CPP_
  
  //////////////////////////////////
  cout << " cpp_exit " << endl ; 
  exit(-1);
 }  /// end of C++ main   
#endif               

               
///////////////////////////    END OF SCRIPT ///////////////////////////////
