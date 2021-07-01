//%*********************************************** 
//*  @script arraysubscbyvec.asl 
//* 
//*  @comment test  subsc by vector
//*  @release CARBON 
//*  @vers 1.15 P Phosphorus                                              
//*  @date Sun Feb 10 10:43:30 2019 
//*  @cdate 1/1/2001 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%

<|Use_=
Demo  of subs by vec;
///////////////////////
|>




#include "debug.asl";

if (_dblevel >0) {
   debugON()
   <<"$Use_\n"   
}
 



 //filterFileDebug(ALLOWALL_,"yyy");
  //FilterFileDebug(REJECT_,"storetype_e");
// FilterFuncDebug(REJECT_,"~ArraySpecs",);
  


chkIn(_dblevel)

// test array indexing



N = 20


 YV = Igen(N,21,1)

<<"%v $YV \n"




 vi = 5


int P[10]

  P[1] = 1
  P[2] = 3
  P[3] = 8
  P[8] = 7
  P[9] = 9  

YV[0] = 74
<<"%v $P \n"

NV = YV @+ P

sz = Caz(NV)

<<"%v $sz \n"

<<"%v $NV \n"

<<" $YV \n"

<<" $NV[2] \n"

<<" $NV[22] \n"
<<" $YV \n"

 S = YV[{P,10}]

<<" %v $P \n"
<<" %v $S \n"
 chkN(S[0],74)

 chkN(S[2],24)
 sz=Caz(S)

<<"%v $sz\n"

 chkN(sz,6)
 
 chkOut()
exit()


