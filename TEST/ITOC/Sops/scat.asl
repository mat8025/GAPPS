//%*********************************************** 
//*  @script scat.asl 
//* 
//*  @comment test Scat func 
//*  @release CARBON 
//*  @vers 1.2 He Helium                                                   
//*  @date Fri Mar 29 09:08:52 2019 
//*  @cdate Tue Mar 12 07:50:33 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%///

/{/*
scat
ws=scat(w1,w2,{w3,w4,...})
concatenates w2 to w1 (or more args) returns the result
/}*/


include "debug.asl"
debugON()



CheckIn()


ws=scat("Happy"," Hols")
<<"%V$ws\n"

checkStr(ws,"Happy Hols")

checkStage("single cat")

char E[]

E = scat("Happy"," Hols")

<<"$(typeof(E))\n"
<<"$(Caz(E)) \n"
<<"%Vs$E\n"

<<"%d$E[0] \n"

checkNum(E[0],72);
checkNum(E[1],97);
checkNum(E[1],'a');

<<"%c$E[0] \n"
<<"%d$E[1] \n"
<<"%c$E[1] \n"
<<"%d$E[::] \n"
<<"%c$E[::] \n"

checkStage("char cat")

ws=scat("Happy"," Hols"," are"," here", " again")
<<"%V$ws\n"

checkStr(ws,"Happy Hols are here again");

checkStage("mulitple cats")

CheckOut()