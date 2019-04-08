//%*********************************************** 
//*  @script veclhrange.asl 
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
  setdebug(1,@keep,@pline,@~trace);


checkIn()


IV= vgen(INT_,10,0,1)


<<"$IV \n"


IV *=2 ;


<<"$IV \n"

checkNum(IV[1],2)
checkNum(IV[2],4)
checkNum(IV[3],6)
checkNum(IV[4],8)

IV2= vgen(INT_,10,0,1)


<<"$IV2 \n"


IV2[1:3] *=2 ;

checkNum(IV2[1],2)
checkNum(IV2[2],4)
checkNum(IV2[3],6)
checkNum(IV2[4],4)



<<"$IV2 \n"


IV2[1:8:2] +=7 ;


<<"$IV2 \n"
checkNum(IV2[1],9)
checkNum(IV2[2],4)
checkNum(IV2[3],13)

checkOut()