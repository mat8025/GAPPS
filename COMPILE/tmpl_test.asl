/* 
 *  @script tmpl_test.asl 
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
#endif

#if CPP
#warning USING_CPP
#define CDBP(x) ans=query(x,"go on",__LINE__,__FILE__);
#define CDB ans=query("?","go on",__LINE__,__FILE__);
#define CHKNE(x,y)  chkN(x,y,EQU_, __LINE__);

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


int Uac::tmpl_test(Svarg * sarg)  
{
  Str ans = "?";
  cout << " tmpl test  " << ans << endl;
  RUN_ASL = 0;

#endif




 ////////////////////////////////////// COMMON  CODE  ASL/CPP compatible  /////////////////////

int k = 77;
float fv = 39.00;
Str sv = "this is a string";
long L = 1964;

#if ASL
     printf("int k is %d float fv is %f sv str is %s %ld\n",k,fv,sv,L);
#else
     cprintf("int k is %d float fv is %f sv str is %S L is %ld  \n end of \n",k,fv,sv,L);

#endif





///////////////////////////////////////////////////////////////////////////////////////

#if CPP
}

//==============================//

 extern "C" int tmpl_test(Svarg * sarg)  {

   Uac *o_uac = new Uac;

   Str a0 = sarg->getArgStr(0) ;

   printf("calling uac method \n");

    cout << " cmd line  parameter is: "  << " a0 " <<  a0 << endl;

  Svar sa;

   cout << " paras are:  "  << a0.cptr(0) << endl;
   sa.findWords(a0.cptr());

   cout << " The cmd  args for this module are:  "  << sa << endl;

   // can use sargs to select uac->method via name
   // so just have to edit in new mathod to uac class definition
   // and recompile uac -- one line change !
   // plus include this script into 


     o_uac->tmpl_test(sarg);

     return 1;
  }

#endif


/*
//////////////////////////////////////////////////////////////////////////

  For a new script  - check it does not already exist in uac*.h

  
   your script stem name  e.g. tmpl_test for tmpl_test.asl script

   one time

  (1)  append '#include "tmpl.asl"' to uac_apps.h 

  (2) append  ' int tmpl (Svarg * sarg); ' uac_methods.h

  (3) append  ' "tmpl", '  to uac_functions.h


   to compile 
cd  ~/gasp_CARBON/APPS/uac
type make install

       make install > junk 2>&1 ; grep error junk

 for easy inspection of compile errors




#run_uac
#===================
#echo  $*
asl  -s 'Str dll = "uac" ; Str prg = _clarg[1]; Svar z=_clarg[2:-1:1]; Str sa="$z"; <<"$sa \n"; opendll("$dll"); <<"%V $prg "; ret = $prg (sa); exit(0); ' $*
#============================
*/