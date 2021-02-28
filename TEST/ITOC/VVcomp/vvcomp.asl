//%*********************************************** 
//*  @script vvcomp.asl 
//* 
//*  @comment test func vvcomp 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                 
//*  @date Tue Mar 12 07:50:33 2019 
//*  @cdate Tue Mar 12 07:50:33 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%

/*
R=vv_comp(A,B,{n})
compares two arrays, upto n points
and returns vector R where
R[0] sum of differences,
R[1] sum of squares of differences
R[2] = 2.0 if all A gt B
R[2] = 1.0 if all A gt or eq B
R[2] = 0.0 if all A  eq B
R[2] = -1.0 if all A  eq or lt B
R[2] = -2.0 if all A   lt B
R[2] = -3.0 if some gt and eq and  lt B
R[3] first index location of smallest difference
*/


#include "debug.asl";

if (_dblevel >0) {
  debugON()
}


/*
  FilterFileDebug(REJECT_,"~storetype_e");
  FilterFuncDebug(REJECT_,"~ArraySpecs",);
 */
  
  chkIn();

  V= vgen(INT_,10,0,1)
  T= V;


<<"$V\n"
<<"$T\n"

R= vvcomp(V,T)

<<"$R\n"

chkR(R[2],0)

  V +=1

<<"$V\n"

R= vvcomp(V,T)

<<"$R\n"

chkR(R[2],2)

R= vvcomp(T,V)

<<"$R\n"

chkR(R[2],-2)



DV= vgen(DOUBLE_,10,0,1)
  DT= DV;


<<"$DV\n"
<<"$DT\n"

R= vvcomp(DV,DT)

<<"$R\n"

chkR(R[2],0)

  DV +=1

<<"$V\n"

R= vvcomp(DV,DT)

<<"$R\n"

chkR(R[2],2)

R= vvcomp(DT,DV)

<<"$R\n"

chkR(R[2],-2)


chkOut()

