/* 
 *  @script mat_test.asl  
 * 
 *  @comment test cpp compile include and sfunc 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.73 C-Li-Ta]                                
 *  @date 01/16/2022 10:43:41 
 *  @cdate 01/16/2022 10:43:41 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2022
 * 
 */ 
;//-----------------<v_&_v>------------------------//

///
///  cinclude  ---  chain of include asl - cpp compile OK?
///

/// cpp debug ??
int run_mat_asl = 0;
Str matans="xxx";
#define ASL 1
#define CPP 0

//printf("ASL %d CPP %d\n", ASL,CPP); // not CPP outside of main


#if ASL
// the include  when cpp compiling will re-define ASL 0 and CPP 1
#include "compile.asl"
#define AST matans=query("?","ASL DB go on",__LINE__,__FILE__);
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

#define CDB ans=query("?","go on?",__LINE__,__FILE__);
#define CDBP(x) ans=query(x,"go on?",__LINE__,__FILE__);

#include <iostream>
#include <ostream>

#include "vec.h"
#include "mat.h"
#include "uac.h"

#include "gline.h"
#include "glargs.h"
#include "winargs.h"
#include "woargs.h"
#include "vargs.h"
#include "gevent.h"


int showMat(Mat& T)
{
  double val ;

   val = T.Dele(1,1);

   printf("showMat: val (1,1) %f\n",val);
   COUT(T);


}

void
Uac::matWorld(Svarg * sarg)  
{
   dbt("debug \n");
   Str ans= "hey xyz";
   cout << "Hello simple Mat test  " << ans << endl;
   //setDebug(2,"pline");
   dbt("debug in matWorld\n");
   CDBP("Que");
#endif



  Siv MS(INT_);

  MS=14;

  COUT(MS);

 pra(MS);

cout << "Siv MS " << MS << endl;
  CDB;


double rms;
double val;
double dval;
   Vec<double> D(20);

   D.pinfo();
//ans=query("?","Vec D(20) ",__LINE__);

   CDB;
   Mat M(DOUBLE_,5,4);

#if CPP
cout << "M = " << M << endl;
cout << " trying access " << endl;
#endif

int index = 6;

   COUT(index)

   COUT(M);
   dval = 76.67;
   
   M = dval;  // the whole array is set 

  // M[2][3] = 47;

  val = M.Dele(1,1);

  chkF(val,dval);

   M(1L,2L) = 77.88; // ele set at row 1 col 2



   COUT(M);

  val = M.Dele(1,2);


  

  chkF(val,77.88);

 M( rows(0,3,1), cols(1,3,2))  = 23.34;   // range setting  bes

   COUT(M);

  int rvec[3] = {1,4,1};
    int cvec[3] = {0,4,-1};

 M( rvec, cvec)  = 17.71;   // range setting  bes
   COUT(M);
   ans = "M(rvec,cvec)";
   CDBP("M(rvec,cvec)");

 //M( (const int[]) {0,5,1}, (const int[]) {1,3,1})  = 46.64;

//COUT(M);

 pra("print M?\n",M);
 CDBP("pra(M) ?");
 printf("val %f\n",val);

  val = M.Dele(2,3);

 printf("val %f\n",val);

  showMat(M);


#if ASL

<<"%V $index $V[7] \n";

#endif






 Siv SV(INT_,1,10,-3,1);
 
 SV.pinfo();

  index = SV[2];



pra("?","SV $index",__LINE__);
  
// rms = V.getVal(index);

 // rms = V[index]; // [] access


//pra( " rms =V[6] ",rms);

//COUT(V(index));

// will only work for Vec type double
 //V[4] = 37; // [] LH access

//cout << "V[4]= 37 " << V[4] << endl;



 short jj = 9;


 printf("[j] LH access \n");



#if ASL
<<"%V $jj $V[jj] \n";
pra(jj, V[jj]);
#else
 //cout << "V(9)= 98 " << V[9] << endl;

//COUT(V[9]);
#endif




//ans= query("??V[4]");

//cout <<"vec  type sequence\n";

//
 // can't do an exact cpp operator version
//  can do G(0,-1,2) for cpp
//  but then require revise for asl - or translate/prep program
//  can use vmf,cpp functions
//  

// for Matrix
// instead of M[0:3;1][0:-1:1]
// need M(rng(0,3,1), rng(0,1,1))

//  3,4,5 D
// has to be vargs 

// pra("fill subset range 0,-1,2) ",G);

chkOut();
  dbt("Exit cpp testing Mat \n");

#if CPP
}

//==============================//

 extern "C" int mat_test(Svarg * sarg)  {

    Uac *o_uac = new Uac;

   // can use sargs to select uac->method via name
   // so just have to edit in new mathod to uac class definition
   // and recompile uac -- one line change !
   // plus include this script into 

    dbt("extern C mat_test\n");
    o_uac->matWorld(sarg);
        dbt("EXIT extern C mat_test\n");
     return 1;
  }

#endif

//================================//






