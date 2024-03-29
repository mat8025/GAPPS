/* 
 *  @script scalarvec.asl 
 * 
 *  @comment scalar vec ops 
 *  @release CARBON 
 *  @vers 1.5 B Boron [asl 6.3.59 C-Li-Pr] 
 *  @date 11/13/2021 11:44:02          
 *  @cdate 1/1/2001 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 


<|Use_=
   Demo  of scalar ? vector ops
///////////////////////
|>

#include "debug"

   if (_dblevel >0) {

     debugON();

     <<"$Use_\n";

     }

  //_dblevel=1

   db_ask = 0;
  
  _dblevel.pinfo()

   chkIn(_dblevel);

//ans = ask(" dbl $_dblevel  $k $j $g",1)

   allowErrors(-1) ; // keep going;

   I = vgen(INT_,10,0,1);

   <<"$I\n";

   chkN(I[1],1);

   K = I - 255;

   chkN(K[1],-254);

   <<"$K\n";

   M = 512 - I;

   <<"$M\n";

   chkN(M[1],511);

   U = vgen(UCHAR_,12,0,1);

   U.pinfo();

   <<"$U\n";

   sz = Caz(U);

   <<"%v$sz\n";

   u = U[1];

   chkN(U[1],1);

   u.pinfo();

   chkN(u,1);

   W= U[1:8:2];

   <<"%V$W \n";

   chkN(W[1],3);
// chkN(U[1],1)

   <<"%V$U\n";

   W= U - 32;

   <<"%V$W \n";

   <<"$(typeof(W)) \n";

   if (! chkN(W[1],225)) {  // U is unsigned

   <<"FAIL $W[1] 255\n");

   }

  <<"%V$U\n";

  if (! chkN(U[1],1) ) {

   <<"FAIL $U[1] 1\n");

   }

  sz = Caz(U);

  <<"%v$sz \n";

  T = U -255;

  <<"%V$T\n";

  sz = Caz(T);

  <<"%v$sz \n";

  pinfo(U);

  sz= Caz(U);

  <<"U %V$sz\n";
//  V = 255 -U ; // should be illegal not produce vector - not CPP trans

  sz.pinfo();
//Vec V(INT_,sz,255) ; // TBF 11/04/21  doesn't process var arg??
// needs full spec of args
//Vec V(INT_,sz,255,0) ;  // TBF
<<"%V $sz\n"
  Vec V(INT_,sz,255,0);

  V.pinfo()

  V -= U;

  V.pinfo()

ans = ask("  V -= U ?",db_ask)


  chkN(V[0],255);

  chkN(V[1],254);

  U.pinfo()

  sz = Caz(U);

  <<"%v$sz \n";

  <<"%V $U\n";

  chkN(U[1],1);

  chkN(U[2],2);

  chkN(V[1],254);

  <<"%V$U\n";

  chkN(U[1],1);

  <<"%V$U\n";

  W= U[0:9:3];

  <<"%V$W \n";

  <<" $U[1:8:2]\n";

  T = 255 - U[1:8:2];

  <<"%V$T\n";

  chkN(T[1],252);

  <<"%V$U\n";

  chkN(U[1],1);

  chkOut(1);


//==============\_(^-^)_/==================//';

