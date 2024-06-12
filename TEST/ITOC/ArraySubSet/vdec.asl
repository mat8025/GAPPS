//%*********************************************** 
//*  @script vdec.asl 
//* 
//*  @comment create vec with list declaration
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                  
//*  @date Tue Jun 25 18:48:42 2019 
//*  @cdate Tue Jun 25 18:48:42 2019 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2019 → 
//* 
//***********************************************%

<|Use_=
Demo   int G[] = {1,2,Vec,57}
///////////////////////
|>


#include "debug"

if (_dblevel >0) {
   debugON()
   <<"$Use_\n"   
}


chkIn()

  int P[5]

  P[0] = 7
  P[1] = 2  
  P[2] = 3
  P[3] = 8
  P[4] = 10

chkN(P[1],2)
<<"%V$P\n"

  int H[]= {12,13,14,15}

<<"$H\n"

chkN(H[1],13)

<<"%V$P\n"

  int G[]= {12,13,P,67}

<<"%V $G\n\n"

chkN(G[1],13)
chkN(G[2],7)

   G->pinfo()
<<"%V$P\n"
   P->pinfo()



  float R[] = {12,13,P,67}

<<"%V$R\n"

   printargs(1, {12,13,P},P)






chkOut()


