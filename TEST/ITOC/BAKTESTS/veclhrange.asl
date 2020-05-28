//%*********************************************** 
//*  @script veclhrange.asl 
//* 
//*  @comment test vector range ops 
//*  @release CARBON 
//*  @vers 1.2 He Helium                                                   
//*  @date Mon Apr  8 08:27:28 2019 
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

IV2= vgen(INT_,15,0,1)


<<"$IV2 \n"


IV2[1:3] *=2 ;

checkNum(IV2[1],2)
checkNum(IV2[2],4)
checkNum(IV2[3],6)
checkNum(IV2[4],4)

checkStage("self op * on lhrange  ")


<<"$IV2 \n"


IV2[1:8:2] +=7 ;

checkStage("self op + on lhrange  ")

<<"$IV2 \n"
checkNum(IV2[0],0)
checkNum(IV2[1],9)
checkNum(IV2[2],4)
checkNum(IV2[3],13)


IV3 = IV2[1:-3]

checkNum(IV3[0],9)
checkNum(IV3[1],4)
checkNum(IV3[2],13)

checkStage("RH range inserted correctly to new vec")
<<"$IV3 \n"

//  what of range overruns current array sizes
IV3[7:9] =IV2[1:3]

<<"$IV3 \n"
IV3->info(1)
checkNum(IV3[7],9)
checkNum(IV3[8],4)
checkNum(IV3[9],13)

<<"$IV3\n"
IV3->Info(1);
checkStage("RH range inserted correctly to LH range")


//int IV4[>5] = IV3
// BUG XIC
// BUG  does not clear existing range
IV3->info(1)

int IV4[>5] = IV3[::]   // BUG xic

<<"$IV4\n"

IV4->info(1)



<<"$IV3\n"

<<"$IV3[0:-1:2]\n"
<<"$IV3[1:-1:2]\n"


IV5 =    IV3[0:-1:2] + IV3[1:-1:2]

<<"$IV5 \n"
i=0;
checkNum(IV5[i++],13)
checkNum(IV5[i++],17)
checkNum(IV5[i++],18)
checkNum(IV5[i++],23)
checkNum(IV5[i++],17)
checkNum(IV5[i++],23)

//13 17 18 23 17 23


checkOut()


/{/*

  TBD
  warning for overrun of fixed array ?
  allow runtime mod to dynamic? - or exit store or op on vector 
 
   int IV4[>5] = IV3
 
  BUG XIC
  BUG  does not clear existing range

/}*/