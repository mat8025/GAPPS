//%*********************************************** 
//*  @script lhrange.asl 
//* 
//*  @comment test lh range select 
//*  @release CARBON 
//*  @vers 1.15 P Phosphorus                                              
//*  @date Sun Feb 10 10:43:30 2019 
//*  @cdate 1/1/2001 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
  
  
  include "debug.asl";
  debugON();
  setdebug(1,@keep,@pline);
  FilterFileDebug(REJECT_,"~storetype_e");
  FilterFuncDebug(REJECT_,"~ArraySpecs",);
  
CheckIn()


N= 20

int RHV[N]

int LHV[N]


    RHV= Igen(N,0,1)

<<" %V$RHV \n"


    LHV = RHV

<<" %V$LHV \n"

<<" %V$RHV \n"

     x= RHV[1]

<<"%v$x\n"
   checkNum(x,1)



<<" %V$RHV[1] \n"
<<" %V$RHV[2] \n"



<<" %V$LHV[1] \n"
<<" %V$LHV[2] \n"

 CheckNum(LHV[1],1)




    LHV[1] = RHV[7]

<<" %V$LHV[1] \n"



    LHV[1:3] = RHV[7:9]

<<" %V$LHV \n"



 CheckNum(LHV[1],7)


<<" $RHV[12:14] \n"

    LHV[5:9:2] = RHV[12:14]

<<" $LHV[5:9:2] \n"

<<" $LHV \n"

 CheckNum(LHV[7],13)


   TSN = RHV[1:5] + RHV[7:11]

<<"%v $TSN \n"

 CheckNum(TSN[1],10)


   TSN = RHV[0:-1:2] + RHV[1:-1:2]

<<"%v $RHV \n"
<<"%v $TSN \n"

 CheckNum(TSN[1],5)

   TSN = RHV[0:-1:] + RHV[1:-1:1]

<<"%v $RHV \n"
<<"%v $TSN \n"


 CheckOut()

//======================================//