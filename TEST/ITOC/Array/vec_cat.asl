//%*********************************************** 
//*  @script vec_cat.asl 
//* 
//*  @comment test concat of vecs 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                    
//*  @date Wed May  6 20:00:27 2020 
//*  @cdate Wed May  6 20:00:27 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
//myScript = getScript();
//
///
//  test vec cat expand ops
#include "debug"

   if (_dblevel >0) {

     debugON();

     }

   chkIn(_dblevel);

   showUsage("test vec cat expand ops" );

   int M[];

   int N[];

   int P[];

   N= igen(20,0,1);

   <<"%V $N \n";

   P= N;

   <<"%V $P \n";

   P[10] = 80;

   P[30] = 47;

   <<"%V $P \n";
   

   P.pinfo();

   chkN(P[30],47);

   P[25] = 79;

   chkN(P[25],79);

   <<"$P \n";

   M= igen(10,0,-1);

   <<"$M \n";

    fileDB(ALLOW_,"opera_cathold","opera_main","ds_arraycopy");


   V = M @+ P   ; //  c++ V = M ; V.join(P) ? ? V= M & P  ?;
                      //  for vecs & is join ?

   <<"$V \n";

   V.pinfo();


   chkN(V[1],-1);

   chkN(V[11],1);

   chkN(V[39],0);

   chkN(V[40],47);

   chkN(V[35],79);

   chkOut();
///////////////////////////////
