//%*********************************************** 
//*  @script arrayjoin.asl 
//* 
//*  @comment  test array join 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                    
//*  @date Fri May  1 07:35:20 2020 
//*  @cdate Fri May  1 07:35:20 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%

#include "debug"

if (_dblevel >0) {
   debugON()
}


chkIn(_dblevel)

N = 20


 YV = Igen(N,21,1)

<<"%v $YV \n"

 vi = 5


int PV[10]

  PV[1] = 1
  PV[2] = 3
  PV[3] = 8
 

YV[0] = 74
<<"%v $PV \n"

NV = YV @+ PV

sz = Caz(NV)

<<"%v $sz \n"

<<"%v $NV \n"
chkN(sz,30)

chkOut()




<<" $YV \n"

<<" $NV[2] \n"

<<" $NV[22] \n"


<<" $YV \n"


YV = YV @+ PV

<<" $YV \n"


 S = YV[PV]

<<" %v $PV \n"
<<" %v $S \n"

 chkN(NV[1],YV[1])

 chkN(NV[2],YV[2])

 chkN(NV[21],P[1])


 chkOut()



