//%*********************************************** 
//*  @script scat.asl 
//* 
//*  @comment  test scat
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                    
//*  @date Fri Apr 17 22:26:53 2020 
//*  @cdate Fri Apr 17 22:26:53 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%



CheckIn()

ws=scat("Happy"," Hols")
<<"%V$ws\n"

checkStr(ws,"Happy Hols")

char E[]

E=scat("Happy"," Hols")

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

ws = scat("c'est"," exactement"," ", "ce ","que ","je ","veux.")
<<"$ws \n"

CheckOut()