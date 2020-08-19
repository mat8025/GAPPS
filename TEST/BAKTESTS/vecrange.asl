//%*********************************************** 
//*  @script vecrange.asl 
//* 
//*  @comment test vector range ops 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                 
//*  @date Tue Mar 12 07:50:33 2019 
//*  @cdate Tue Mar 12 07:50:33 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%


include "debug.asl";

debugON();
  setdebug(1,@keep,@pline,@trace);
  FilterFileDebug(REJECT_,"~storetype_e");
  FilterFuncDebug(REJECT_,"~ArraySpecs",);
  
  CheckIn();



  V= vgen(INT_,10,0,1);

 <<"$V\n"


  checkNum(V[2],2)
  checkNum(V[9],9)

  T = V[1:3]
  <<"$T\n"

  j=1;
  
  for (i=0;i<3;i++) {
    checkNum(T[i],j++)
  }
 
  T = V[1:3] + V[2:4]
  <<"$T\n"
   j = 3
   for (i=0;i<3;i++) {
    checkNum(T[i],j); j +=2;
  }


  T = V[1:3] + V[2:4] + V[3:5]
  <<"$T\n"

   j = 6;
   for (i=0;i<3;i++) {
    checkNum(T[i],j); j +=3;
  }


  T = V[1:3] + V[2:4] + V[3:5] + V[4:6]
  <<"$T\n"
  
   j = 10;
   for (i=0;i<3;i++) {
    checkNum(T[i],j); j +=4;
  }

   S= V[7:9] + V[2:4]
<<"$S\n"   
   V[0:2] =  V[7:9] + V[2:4]

<<"$V\n"

  checkNum(V[0],S[0])
  checkNum(V[1],S[1])
  checkNum(V[2],S[2])  

   R=vvcomp(S,V,3)
   <<"$R\n"

  checkOut()