/* 
 *  @script mda_test.asl  
 * 
 *  @comment test cpp compile include and sfunc 
 *  @release CARBON 
 *  @vers 1.1 He Helium [asl 6.3.73 C-Li-Ta]                                
 *  @date 01/16/2022 10:43:41 
 *  @cdate 08/12/2022
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2022
 * 
 */ 
;//-----------------<v_&_v>------------------------//

///
///  
///

/// cpp debug ??
int run_mda_asl = 0;
Str mda_ans="xxx";
#define ASL 0
#define CPP 1

//printf("ASL %d CPP %d\n", ASL,CPP); // not CPP outside of main


#if ASL
// the include  when cpp compiling will re-define ASL 0 and CPP 1
#include "compile.asl"
#define AST mdaans=query("?","ASL DB goon",__LINE__,__FILE__);
//  printf("ASL %d CPP %d\n",ASL,CPP);
#endif






#if ASL
<<"ASL   $(ASL) CPP $(CPP)\n"
printf("ASL %d CPP %d\n", ASL,CPP);
#define COUT //
 run_vec asl = runASL();
printf("run_asl %d\n",run_vec_asl);

printf("ASL %d CPP %d\n", ASL,CPP);

#endif




#if CPP
#warning USING_CPP

#define CDB ans=query("?","goon",__LINE__,__FILE__);
#define CDBP(x) ans=query(x,"goon",__LINE__,__FILE__);

#include <iostream>
#include <ostream>

#include "vec.h"
#include "mat.h"
#include "mda.h"
#include "uac.h"

#include "gline.h"
#include "glargs.h"
#include "winargs.h"
#include "woargs.h"
#include "vargs.h"
#include "gevent.h"


int showMda(Mda& T)
{
  double val ;

   val = T.getEleD(dimns(1,1,1));

   printf("showMda: val (1,1,1) %f\n",val);
   COUT(T);


}

void
Uac::mdaWorld(Svarg * sarg)  
{
   dbt("debug \n");
   Str ans= "xyz";
   cout << "Hello simple Mda test  " << ans << endl;
   //setDebug(2,"pline");
   dbt("debug in mdaWorld\n");

#endif



  Siv MS(INT_);

  MS=14;

  COUT(MS);

 

 cout << "Siv MS " << MS << endl;
  
double rms;
double val;
double dval;
   Vec<double> D(20);

   D.pinfo();
//ans=query("?","Vec D(20) ",__LINE__);

cout << " declaring MD " << endl;
   Mda MD(DOUBLE_, dimns(3,5,4,6));

//mda_ans = query(" declared OK ","??",__LINE__);

#if CPP
cout << "MD = " << MD << endl;
cout << " trying access " << endl;
#endif

int index = 6;
int sz = MD.getSize();
   COUT(index)
   pa(sz, index);
   COUT(MD);

   COUT("/////////////////////////////////");

 printArray(1,MD,1,"%4f",-1);

mda_ans = query("all 0","??",__LINE__);

   MD = 0.0;
   COUT(MD);

mda_ans = query("all 0","??",__LINE__);

   dval = 76.67;
 printf("doing Bes range setup \n");
   MD(Bes(0,1,1),Bes(0,1,1), Bes(1,3,1)) = 777.880;

   MD.pinfo();
   COUT(MD);

mda_ans = query("Bes pass?","??",__LINE__);

   MD = dval;  // the whole array is set

   COUT(MD);


  val = MD.getEleD(dimns(3,4,3,5));

  dval = MD.eleD(4,3,5);

  printf("val %f dval %f \n",val, dval);



  val = MD.eleD(1,1,1);

  printf("val %f\n",val);

   chkF(val,dval);

   printf("try MD(1,1,1) = 47.74D; \n");
   
   MD(1,1,1) = 47.74;

   dval = 54.45;
   
   MD(2,3,4) = dval;

   MD(4,3,5) = dval*2;
 COUT(MD);
printf("1,1,1 to 87.78\n");
     MD(1,1,1) = 87.78;
   
COUT(MD);
  COUT("/////////////////////////////////\n");
 printArray(1,MD,1,"%4.2f",-1);

  COUT("/////////////////////////////////\n");
 printArray(1,MD,1,"%3.1f",-1);


   Mda MDI(INT_, dimns(3,5,4,6));


 //  MDI = MD;
 pa("MDI");
 printArray(1,MDI,1,"%d",-1);


// try 4D

  COUT("/////////////4D///////////////////\n");
   Mda MD4I(INT_, dimns(4,3,3,3,3));

       MD4I  = 55; // works

     MD4I(Bes(0,1,1),Bes(0,1,1), Bes(0,1,1), Bes(0,2,2)) = 78; // OK?

 printArray(1,MD4I,1,"%d");

MD4I.pinfo();

/*


  // M[2][3] = 47;

  val = MD.Dele(1,1);

  chkF(val,dval);

   MD(dvec(1,2,3)) = 77.88; // 



   COUT(M);

  val = M.Dele(1,2);


  

  chkF(val,77.88);

 MD( rows(0,3,1), cols(1,3,2))  = 23.34;   // range setting  bes

   COUT(M);

  int rvec[3] = {1,4,1};
    int cvec[3] = {0,4,-1};

 M( rvec, cvec)  = 17.71;   // range setting  bes
   COUT(M);

 //M( (const int[]) {0,5,1}, (const int[]) {1,3,1})  = 46.64;

//COUT(M);


 printf("val %f\n",val);

  val = M.Dele(2,3);

 printf("val %f\n",val);

  showMda(M);


#if ASL

<<"%V $index $V[7] \n";

#endif






 short jj = 9;


 printf("[j] LH access \n");



#if ASL
<<"%V $jj $V[jj] \n";
pa(jj, V[jj]);
#else
;
#endif






//  3,4,5 D
// has to be vargs 

*/


chkOut();
  dbt("Exit cpp testing Mda \n");

#if CPP
}

//==============================//

 extern "C" int mda_test(Svarg * sarg)  {

    Uac *o_uac = new Uac;

   // can use sargs to select uac->method via name
   // so just have to edit in new method to uac class definition
   // and recompile uac -- one line change !
   // plus include this script into 

    dbt("extern C mda_test\n");
    o_uac->mdaWorld(sarg);
        dbt("EXIT extern C mda_test\n");
     return 1;
  }

#endif

//================================//






