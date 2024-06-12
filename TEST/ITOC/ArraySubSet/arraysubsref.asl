//%*********************************************** 
//*  @script arraysubsref.asl 
//* 
//*  @comment test vector range spec - forward,backward 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                  
//*  @date Tue Jun 25 18:48:42 2019 
//*  @cdate Tue Jun 25 18:48:42 2019 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2019 → 
//* 
//***********************************************%



<|Use_=
Demo  of vector range
///////////////////////
|>



#include "debug"

if (_dblevel >0) {
   debugON()
   
}



chkIn()



// test array indexing

 N = 20

 YV = Igen(N,21,1)

<<"$YV \n"

 IV = YV[0:5]

<<"$IV \n"

 chkN(IV[0],YV[0])

 chkN(IV[5],YV[5])


 IV = YV[1:7:2]
 NV = YV[2:10:2]

sz = Caz(IV)

<<"%v $sz \n"

<<"%v $YV \n"

<<"%v $IV \n"

<<"%v $NV \n"



 chkN(IV[0],YV[1])

 chkN(IV[1],YV[3])

 chkN(IV[3],YV[7])





 a = 1
 b = 7
 c = 2

 IV = YV[a:b:c]

<<"%v $IV \n"



 chkN(IV[0],YV[1])

 chkN(IV[1],YV[3])

 chkN(IV[3],YV[7])

 IV = YV[a+1:b+1:c]

<<"$IV \n"

 chkN(IV[0],YV[2])

 chkN(IV[1],YV[4])

 chkN(IV[3],YV[8])

 IV = YV[a+1:12:c+1]

<<" IV = YV[a+1:12:c+1] \n"

<<"$IV \n"


 chkN(IV[0],YV[2])

 chkN(IV[1],YV[5])

 chkN(IV[3],YV[11])



<<" TBD FIX IC \n"

<<" IV = YV[a+1::c+1] \n"




 IV = YV[a+1:-1:c+1]

  <<"$IV \n"


 chkN(IV[0],YV[2])
 chkN(IV[1],YV[5])
 chkN(IV[4],YV[14])


 chkOut(1)



