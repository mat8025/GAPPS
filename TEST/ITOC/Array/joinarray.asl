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



  include "debug.asl";
  debugON();
  setdebug(1,@keep,@pline,@~trace);
  FilterFileDebug(REJECT_,"~storetype_e");
  FilterFuncDebug(REJECT_,"~ArraySpecs",);
  


CheckIn()

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

checkNum(YV[29],79)

 checkNum(NV[1],YV[1])

 checkNum(NV[2],YV[2])


 CheckOut()
exit()


