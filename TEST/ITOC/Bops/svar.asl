

#define _CPP_ 0

//  use the asl  -T  flag to produce cpp compilable code
//  asl -wT xyz.asl
//  then the script xyz.asl  is converted to xyz.asc
//  and that asc file can be compiled with cpp
//
//  the translation flips the _CPP_ define to 1  in the resulting asc file
//  the makeasc  script  will compile  asc code
//  e.g. makeasc  xyz

//  just using asl  interpreter skips over _CPP_ sections in the asl script
//  and defines _ASL_ to 1 and _TRANS_ to 0
//  during transation _ASL_ is set to 0
//   so that code is left as is
//  _TRANS_ is set  1 so that code is evaluated for translation purposes
//   and will assist in compilation but will not be part  of the compiled
//   asc code
//

#if _CPP_
#include <iostream>
#include <ostream>

using namespace std;
#include "vargs.h"
#include "cpp_head.h" 
#include "consts.h"
#define PXS  cout<<

#include "vec.h"

#define _ASL_ 0
#define _TRANS_ 0
#endif





#if _TRANS_

  Svar argv
  
  argc = argc()  ;  // want this to be evaluated  in translation
                          // but  not to be compiled  by cpp
			  // or interpreted by asl
			  

//ans=query("translating hint argc $argc continue? :[y/n]") ;   if (ans != "y")    exit(-1) ;
//<<"%V $ans \n"

<<"%V $argc \n"

#endif


#if _CPP_

int main( int argc, char *argv[] ) { // main start
///
#endif      



 Str s;
  char c;
   s= "hey man can you access chars"

<<"%V $s\n"


<<"%V $s[1]\n"


    c =s[2]

//c.pinfo()
<<"%V %s $c\n"


   s[2] = 'N'

<<"%V $s\n"

 Svar fun;

    fun = functions()
    
<<" %(1,,,\n) $fun \n"

  Svar Sv;

   Sv[0] = "hey"

     Sv[1] = "man"

     Sv[2] = "focus"

  int i;

  for(i=0; i<4; i++) {

<<"sv $i  $Sv[i] \n"

  }





#if _CPP_              
  //////////////////////////////////
  exit(0);       // want to report code errors exit status
 }  /// end of C++ main   
#endif               

//==============\_(^-^)_/==================//

