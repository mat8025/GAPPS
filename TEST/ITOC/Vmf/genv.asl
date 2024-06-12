/* 
   *  @script genv.asl
   *
   *  @comment test vmf generate/fill vector
   *  @release CARBON
   *  @vers 1.2 He Helium [asl 6.3.8 C-Li-O]
   *  @date Tue Jan 12 10:10:20 2021
   *  @cdate 1/1/2012
   *  @author Mark Terry
   *  @Copyright © RootMeanSquare  2010,2021 →
   *
   *  \\-----------------<v_&_v>--------------------------; //
 */ 
///
///
///

<|Use_=
   Demo  of vmf set
   
///////////////////////
|>

#include "debug"

   if (_dblevel >0) {

     debugON();

     <<"$Use_\n";

     }

   filterFileDebug(REJECT_,"array","args","store","exp");
//filterFileDebug(REJECT_,"ds_sivbounds","ds_sivmem","exp_lhs_e","ds_storesiv");
//filterFuncDebug(REJECT_,"vrealloc","init","varIndex");

   chkIn();

   int I[];

   I.pinfo();

   <<" $I \n";

   I[0:8].Set(0,1);

   <<" $I \n";

   chkN(I[1],1);

   I.pinfo();

   chkN(I[8],8);

   I[0:30:1].Set(0,3);

   <<" $I \n";

   I.pinfo();

   sz = I.Caz();
//<<" $(I.Caz()) \n"

   <<" $sz \n";

   float F[];

   <<"%v $F \n";

   j = 30;

   F[0:j].Set(0);

   F[1:j:3].Set(1,2);

   chkR(F[1],1);

   chkR(F[4],3);

   <<" $F \n";

   R= Urand(30);

   <<"$R\n";

   F[0:j:3].Set(3.0);

   <<"$F \n";

   F[0:j:3].Rand(3);

   <<"$F \n";

   <<"\n //////\n $F \n";

   chkOut();

//===***===//
