//%*********************************************** 
//*  @script vmf-cut.asl 
//* 
//*  @comment test prune func 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                 
//*  @date Tue Mar 12 07:50:33 2019 
//*  @cdate Tue Mar 12 07:50:33 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%

<|Use_=

   Demo  of vmf cut function;
/////////////////////// 
|>

#include "debug"

   if (_dblevel >0) {

     debugON();

     <<"$Use_ \n";

     }
     
//filterFileDebug(REJECT_,"scopesindex_e.cpp","array_parse.cpp");
//filterFuncDebug(REJECT_,"~storeSiv","checkProcFunc");

   chkIn();

   int I[] = vgen(INT_,20,0,1);

   <<"I[] : $I \n";

   I.pinfo();

   I[14].Set(747);

   I.pinfo();

   chkN(I[14],747);

   <<"I[] : $I[::] \n";

   I.pinfo();


   I[5:13:2].Set(50,3);

   I.pinfo();

   <<"I[] : $I[::] \n";

   chkN(I[5],50);

   chkN(I[7],53);

   chkN(I[9],56);

   C = Igen(4,12,1);

   <<"%V $C \n";

   I.cut(C);

   <<" $I \n";

   chkN(I[12],16);

   float F[];

   F= Fgen(20,0,1);

   sz = Caz(F);

   <<"$sz $F \n";
//<<"%,j%{5<,\,>\n}%6.1f$F\n"

   <<"%6.1f $F\n";

   C = Igen(4,12,1);

   <<"%V $C \n";

   F.cut(C);

   <<"%6.1f  $F \n";

   chkR(I[12],16,6);

   <<" $I[::] \n";
   I.pinfo()
   I[3:8:1].cut();


   I.pinfo()
   <<" $I[::] \n";

   chkN(I[3],56);

   F[3:8].cut();

   <<" %6.1f $F[::] \n";

   chkR(F[3],9,6);

   F[3].cut();

   <<" %6.1f $F[::] \n";
//chkStage("cut")

   chkOut();

//===***===//
