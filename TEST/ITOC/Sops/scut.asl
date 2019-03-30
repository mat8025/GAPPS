//%*********************************************** 
//*  @script scut.asl 
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
 w2=scut(w1,nc) :- cuts nc chars of string from head or tail if nc is negative 
 or a section scut(w1,startc,endc) returns result
/}*/


include "debug.asl"
debugON()



CheckIn()


 w1="a_winters-tail.cpp"

<<"$w1\n"

 wt= scut(w1,-4)

<<"$wt\n"

 checkstr(wt,"a_winters-tail")

 wh= scut(w1,2)

<<"$wh\n"

 checkstr(wh,"winters-tail.cpp")


 wm= scut(w1,2,9)

<<"$wm\n"

 checkstr(wm,"a_tail.cpp")




 wm= scut(w1,-9,-5)

<<"<|$wm|>\n"

 checkstr(wm,"a_winters.cpp")

svar S = "una larga noche"

S[1] = "el gato mira la puerta"

S[2] = "y espera ratones"

S[3] = "un plan simple"

<<"$S \n"
T=S

T->scut(-3)


<<"$T \n"

T=S

T->scut(3)


<<"$T \n"

checkOut()