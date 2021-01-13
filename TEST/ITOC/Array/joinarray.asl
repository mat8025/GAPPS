//%*********************************************** 
//*  @script joinarray.asl 
//* 
//*  @comment test  vec @+ operator
//*  @release CARBON 
//*  @vers 1.16 S Sulfur                                                  
//*  @date Sun Mar 10 16:39:32 2019 
//*  @cdate 1/1/2001 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%



#include "debug.asl";


if (_dblevel >0) {
   debugON()
}

/*
filterFuncDebug(REJECTALL_,"xxx");
filterFuncDebug(ALLOW_,"process_args","process_args_ptr",\
   "store_r_to_array","store_r_to_siv","storeCopyVar","storeSiv");
//filterFuncDebug(REJECT_,"checkProcFunc");
*/

chkIn(_dblevel);


// test array indexing



N = 20


 YV = Igen(N,21,1)

<<"%v $YV \n"





 vi = 5


int P[10]

  P[1] = 1
  P[2] = 3
  P[3] = 8
  P[8] = 47
  P[9] = 79  

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


YV = YV @+ P


<<"%v $sz \n"
<<" $YV \n"

 chkN(YV[29],79)

 chkN(NV[1],YV[1])

 chkN(NV[2],YV[2])


 chkOut()



exit()


