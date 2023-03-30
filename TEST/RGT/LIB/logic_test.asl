/* 
 *  @script logic_test.asl 
 * 
 *  @comment test cprintf  
 *  @release CARBON 
 *  @vers 1.1 H Hydrogen [asl 4.4.82 Be-Be-Pb]                              
 *  @date 03/28/2023 12:06:34 
 *  @cdate 03/28/2023 12:06:34 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2023
 * 
 */ 
;//-----------------<v_&_v>------------------------//;

//Use_= " Demo  of test  ";

//  script and func stem   

///
///
///

#define ASL 1
#define CPP 0


#if ASL
//  compile.asl  when cpp compiling will re-define ASL 0 and CPP 1
#include "compile.asl"
#endif


#if ASL
#define cout //
#define COUT //
//int run_vec asl = runASL();
#define CDB ans=query("go on");
//#define CDBP (x) ans=query(x,"go on"); // asl not working
#define CDBP //
#include "debug.asl";

if (_dblevel >0) {
   debugON()
   <<"$Use_\n"
}
   chkIn(_dblevel); 
#endif


#if CPP
#warning USING_CPP
#define CDBP(x) ans=query(x,"go on",__LINE__,__FILE__);
#define CDB ans=query("?","go on",__LINE__,__FILE__);
#define chkEQ(x,y)  chkN(x,y,EQU_, __LINE__);

#include <iostream>
#include <ostream>

#include "vec.h"
#include "uac.h"
#include "gline.h"
#include "glargs.h"
//  IF USING  graphics
#include "winargs.h"
#include "woargs.h"
#include "vargs.h"
#include "gevent.h"

///xxx
int Rgt::logic_test(Svarg * sarg)  
{
  Str ans = "?";
  printf("hey logic\n");
  cout << " logic test  " << ans << endl;
  RUN_ASL = 0;

#endif





int a = 1;
int b = 2;
   
int k = 77;
float fv = 39.00;
Str sv = "this is a string";
long L = 1964;


     cprintf("int k is %d float fv is %f sv str is %S L is %ld  \n end of \n",k,fv,sv,L);


int ab = 2 + 3;

  cprintf("ab %d \n",ab);

  chkEQ(ab,5);

  int n1 = 1;

   cprintf("n1 %d\n",n1);

  chkEQ(n1,1);

  n1++;

  cprintf(" n1 %d \n",n1);

  chkEQ(n1,2);

  ++n1;

  cprintf("n1 %d\n",n1);

 
   int lop = 0; 
   
   if (a > 0 ) {

  //   <<" ($a > 0)  \n";
    cprintf(" (a %d > 0)  \n",a);
     
     lop = 1; 
     }
   else {

cprintf(" NOT (a %d > 0 ) \n",a);

  }
   
   
   chkTrue(lop); 
   
    lop = 0; 
   
   if ((a > 0) && (b > 2)) {
     cprintf(" (a %d > 0 && b %d > 2) \n",a,b); 
     
     }
   else {
     cprintf(" NOT (a %d > 0 && b %d > 2) \n",a,b); 
     lop = 1; 
     }
   
   
   chkTrue(lop); 
   int c= 0; 
   
   while (c < 5) {
     c++; 
     b = 0; 
     if (c < 4) {
       
       if ( (a == 0) || (b > 1)) {
         cprintf(" (a %d ==  0 || b %d > 1) \n",a,b); 
         
         }
       else {
         cprintf(" NOT (a %d == 0 || b %d > 1) \n",a,b); 
         lop = 1; 
         }
       
       
       chkTrue(lop); 
       }
     }
   

   chkOut();


///////////////////////////////////////////////////////////////////////////////////////

#if CPP
}

//==============================//

 extern "C" int logic_test(Svarg * sarg)  {

   Rgt *o_rgt = new Rgt;

   Str a0 = sarg->getArgStr(0) ;

   printf("calling rgt method for logic\n");

   cout << " cmd line  parameter is: "  << " a0 " <<  a0 << endl;

  Svar sa;

   cout << " paras are:  "  << a0.cptr(0) << endl;
   sa.findWords(a0.cptr());

   cout << " The cmd  args for this module are:  "  << sa << endl;

   // can use sargs to select rgt->method via name
   // so just have to edit in new mathod to rgt class definition
   // and recompile rgt -- one line change !
   // plus include this script into 


     o_rgt->logic_test(sarg);

     return 1;
  }

#endif


/*
//////////////////////////////////////////////////////////////////////////

  For a new script  - check it does not already exist in rgt*.h

  
   your script stem name  e.g. logic_test for logic_test.asl script

   one time

  (1)  append '#include "logic_test.asl"' to rgt_apps.h 

  (2) append  ' int logic_test (Svarg * sarg); ' rgt_methods.h

  (3) append  ' "logic_test", '  to rgt_functions.h


   to compile 
cd  ~/gapps/TEST/RGT/LIB
type make install

       make install > junk 2>&1 ; grep error junk

 for easy inspection of compile errors




#run_rgt
#===================
#echo  $*
asl  -s 'Str dll = "rgt" ; Str prg = _clarg[1]; Svar z=_clarg[2:-1:1]; Str sa="$z"; <<"$sa \n"; opendll("$dll"); <<"%V $prg "; ret = $prg (sa); exit(0); ' $*
#============================
*/