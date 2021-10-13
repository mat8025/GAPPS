//%*********************************************** 
//*  @script vecsubset.asl 
//* 
//*  @comment test vector subset ops
//*  @release CARBON 
//*  @vers 1.15 P Phosphorus                                              
//*  @date Sun Feb 10 10:43:30 2019 
//*  @cdate 1/1/2001 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%

<|Use_=
Demo  of vector subset  e.g. V[1,4,7] = 34;
///////////////////////
|>



#include "debug"

if (_dblevel >0) {
   debugON()
   <<"$Use_\n"   
}

filterFileDebug(REJECT_,"scopesindex_e.cpp","scope_e.cpp","scope_findvar");
filterFileDebug(REJECT_,"ds_sivbounds","ds_sivmem","exp_lhs_e","ds_storesiv");
filterFuncDebug(REJECT_,"vrealloc","init");


chkIn(_dblevel)

float F = 3.142;
<<"%V $F\n"
long L = 123456789;
<<"%V $L\n"


B=vgen(INT_,20,0,1)

<<"%V$B\n"
int a = 14;
chkN (B[0],0)
chkN (B[4],4)

 B[{2,4,7,a}] = 36;


<<"%V$B\n"

chkN (B[0],0)

chkN (B[2],36)
chkN (B[7],36)
chkN (B[14],36)

chkN (B[8],8)
//<<"%V$B[{2,4,7,8,14}]\n"


/// xic ?
///

C=vgen(INT_,4,34,1)

<<"%V$C\n"

B[{2,4,7,a}] = C

<<"%V$B\n"

chkN (B[2],34)
chkN (B[4],35)
chkN (B[7],36)
chkN (B[14],37)

chkOut()