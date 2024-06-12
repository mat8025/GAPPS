/* 
 *  @script arraysubvec.asl                                             
 * 
 *  @comment test array range subscript via vector                      
 *  @release Boron                                                      
 *  @vers 1.4 Be Beryllium [asl 5.80 : B Hg]                            
 *  @date 02/02/2024 06:52:36                                           
 *  @cdate 1/1/2010                                                     
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2024 -->                               
 * 
 */ 



<|Use_=
   Demo  of vector set via nested array index
   S = YV[P]
   where P is vec
///////////////////////
|>


#include "debug"

   if (_dblevel >0) {

     debugON();

     <<"$Use_\n";

     }



   chkIn();
// test array indexing
  if (_dblevel > 1) {
   allowDB("spe,opera_,array_parse,rdp_,ds,ic_")
 }

   int P[5];

    P.pinfo()

    sz= P.Caz();

<<"%V $sz\n"

   ans=ask(DB_prompt,0)

    chkN(sz,5)

int PMD[4][3]

    sz= PMD.Caz();

<<"%V $sz\n"
chkN(sz,12)

   ans=ask(DB_prompt,0)
   
    chkStage("int P[5 OK? ") ;  // parameter to exit , pause ?

    
    



   N = 20;

   YV = vgen(INT_,N,20,1);

   <<" %V$YV \n";

   vi = 5;

   <<"%V$vi\n";



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

  int R[3]={12};

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
