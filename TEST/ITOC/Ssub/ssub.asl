/* 
 *  @script ssub.asl 
 * 
 *  @comment sub pat in a str rgx 
 *  @release 6.35 : C Br 
 *  @vers 1.4 Be Beryllium [asl 6.35 : C Br]                                
 *  @date 06/23/2024 13:24:39 
 *  @cdate 1/1/2015 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2024
 * 
 */ 
//-----------------<V_&_V>------------------------//

        




/*
#include "debug"

   if (_dblevel >0) {

        debugON();

        <<"$Use_ \n";

   }
*/  // this should not be seen line 32

#define __CPP__ 0

#if __CPP__
#include <iostream>
#include <ostream>

using namespace std;
#include "vargs.h"
#include "cpp_head.h"
#define PXS  cout<<

#define CPP_DB 0

#endif

/*
<|TB=
   ssub()
   ssub
   ssub(w1,w2,w3,{dir})
   
   substitutes string w3 into w1 for  first occurrence of w2 returns the result.
   if dir 1 (default) starts at left, -1 from right, dir = 0 global substitute.
   if w3 set to "" (i.e. NULL)  delete operation (deletes occurence of w2).
   if dir > 1 then that many substitutions are performed from the left if possible.
|>
*/

  Svar sargs;
   Str Use_= " Demo  of sub pat in a str rgx ";
// CPP main statement goes after all procs

#if __CPP__
   int main( int argc, char *argv[] ) {

   for (int i= 0; i <argc; i++) {
     sargs.cpy(argv[i],i);
   }

   init_cpp();


#endif       
///
///
///
///   !checkSvarg (s, 1)) ==> !s->checkArgCount( 1))
// sed line which works
// cat foo | sed  s/checkSvarg\ \(s,/s-\>checkArgCount\ \(/ > noo
// check literal ssub
// use ssubrgx

  allowErrors(-1); // set number of errors allowed -1 keep going;

   chkIn(1) ;

//   <<" $TB\n";
#if __ASL__

<<" ASL section no translate \n"

#endif

   chkT(1);

   w1 = "if ( !checkSvarg (s, 1))";

   w2 = "!checkSvarg (s, ";

   w3 = "s->checkArgCount (";

   <<"$w1 \n";

   w4 =  ssub(w1,w2,w3);

   <<"$w4 \n";

   w5 = " a completely different line";

   w2 ="line";

   w3 = "sentence";

     <<"%V $w5 $w2 $w3 \n";

   w6 =  ssub(w5,w2,w3);

   <<"%V $w5 $w2 $w3 $w6\n";

   <<"$w6 \n";

   <<"use ssubrgx !\n";

   w6 =  ssub(w5,w2,w3);

   <<"$w5 \n";

   <<"$w6 \n";

   <<"use rgx !\n";

   w6 =  ssub(w5,w2,w3);

   w2="li.*";

   <<"$w5 \n";

   <<"rgx pat is <|$w2|>  sub is <|$w3|> \n";

   w6 =  ssub(w5,w2,w3);

   <<"%V $w5 $w2 $w3 $w6\n";

// now run over a file - speed ?

     chkStr("OK","OK");
     chkStr("OK","NOTOK");

   chkStr(w6," a completely different sentence");

   chkOut(1);

#if __CPP__           
   exit(-1);

   }  ; // end of C++ main;
#endif     
///

//==============\_(^-^)_/==================//

