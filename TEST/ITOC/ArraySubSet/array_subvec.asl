/* 
 *  @script array_subvec.asl 
 * 
 *  @comment test array range subscript via vector 
 *  @release CARBON 
 *  @vers 1.3 Li Lithium [asl 6.3.60 C-Li-Nd] 
 *  @date 11/19/2021 07:55:53          
 *  @cdate 1/1/2010 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 


<|Use_=
   Demo  of vector set via nested array index
   S = YV[P]
   where P is vec
///////////////////////
|>

 // filterFileDebug(REJECT_,"array_parse","~store","args_");
//  filterFileDebug(REJECT_,"array_parse");
 // filterFileDebug(ALLOW_,"array_parse");
  filterFileDebug(REJECT_,"array_parse");
#include "debug"

   if (_dblevel >0) {

     debugON();

     <<"$Use_\n";

     }





   chkIn(_dblevel);
// test array indexing

   N = 20;

   YV = vgen(INT_,N,20,1);

   <<" %V$YV \n";

   vi = 5;

   <<"%V$vi\n";

   int P[5];

   P[0] = 1;

   P[1] = 2;

   P[2] = 3;

   P[3] = 8;

   P[4] = 10;

   <<"%V$P\n";

   int G[]={P,12,13};

   sz= G.Caz();

<<"%V$sz\n"


  <<"%V$G\n";

   chkN(sz,7)

  int R[]={12};

  <<"%V$R\n";

  int Q[]={12,17};

  <<"%V$Q\n";

   sz= Q.Caz();

<<"%V$sz\n"

   chkN(sz,2)

   chkN(P[2],3);

   chkN(P[4],10);

  S1= YV[{1,3,7}]

  <<"%V$S1\n";


  S1.pinfo()
  sz=S1.Caz()

  chkN(sz,3)



  S = YV[{P,12,13}];

  <<"%V$S\n";

  S.pinfo();

  chkN(S[0],YV[1]);

  chkN(S[1],YV[2]);

  chkN(S[2],YV[3]);

  chkN(S[3],YV[8]);

  chkN(S[4],YV[10]);

  chkN(S[5],YV[12]);
  
// even better
// try recurse
/*
  C = igen(2,1,1)
  <<"$C\n"
  W = YV[{P[C]}]
  <<"$W\n"
*/


  chkOut();

//===***===//
