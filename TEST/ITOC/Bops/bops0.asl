/* 
 *  @script bops0.asl 
 * 
 *  @comment basic ops 
 *  @release CARBON 
 *  @vers 1.1 H Hydrogen [asl 5.80 : B Hg]                                  
 *  @date 01/31/2024 23:55:58 
 *  @cdate 01/31/2024 23:55:58 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2024
 * 
 */ 
//-----------------<V_&_V>------------------------//



#define _CPP_ 0
#define _ASL_ 1

#if _CPP_
#include "cpp_head.h" 
#endif

Str Use_= " Demo  of basic ops ";

#if _TRANS_

  Svar argv
  
  argc = argc()  ;  // want this to be evaluated  in translation
                          // but  not to be compiled  by cpp
			  // or interpreted by asl
#endif



#if _ASL_

#include "debug" 

  if (_dblevel >0) { 
   debugON() 
   <<"$Use_ \n" 
  } 

   allowErrors(-1); // set number of errors allowed -1 keep going 

  chkIn() ;

  chkT(1);

  allowDB("spe,opera,ds,rdp")
 #endif


int addem (int m, int n)
{

  int p = 0;

  p = m +n

  return p
}



// goes after procs
#if _CPP_
int main( int argc, char *argv[] ) { // main start 
#endif       



///
///  The very basic  statements
///


  
int db_ask = 1; // set to zero for no ask
int db_step = 1; // set to zero for no step




//TBF 2/1/24   -T translate should auto declare a,b,c,d,e,f to int
  int a = 2

  int b = 2

  int c = a +b

  chkN(c,4)
  
  if (c == 4) {

   chkT(1)
   <<" let's do more $c\n"
  }

  int d = a + b * c;

  chkN(d,10)

  int e = (a+b) * c;

  chkN(e,16)

  int f = (a+b) * c +2;

  chkN(f,18)
<<"%V $f\n"

  int g = addem(e,f)

  chkN(g,34)

<<"%V $g\n"

// chkOut(1);

#if _CPP_           
  exit(-1); 
  }  /// end of C++ main 
#endif     


///

//==============\_(^-^)_/==================//
