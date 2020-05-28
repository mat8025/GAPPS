//%*********************************************** 
//*  @script arrayprt.asl 
//* 
//*  @comment test array vec and ele print 
//*  @release CARBON 
//*  @vers 1.2 He Helium                                                  
//*  @date Fri Jan 18 19:25:04 2019 
//*  @cdate Fri Jan 18 19:25:04 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%



include "debug.asl"

debugON();


setDebug(1,@pline,@trace,"~step")

checkIn()


rl =vgen (FLOAT_, 10, 0, 1);


j1 = 2

t1 = rl[j1]

<<"%V $t1  $(typeof(t1))\n";

checkFNum (rl[j1], 2);

 ff= rl[j1];
<<" $ff   \n"
<<" $rl[j1]  2 \n"


checkOut()

