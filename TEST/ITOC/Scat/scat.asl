//%*********************************************** 
//*  @script scat.asl 
//* 
//*  @comment  test scat
//*  @release CARBON 
//*  @vers 1.2 He Helium [asl 6.2.98 C-He-Cf]                            
//*  @date Wed Dec 23 11:14:41 2020 020 
//*  @cdate Fri Apr 17 22:26:53 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%



chkIn()

ws=scat("Happy"," Hols")
<<"%V$ws\n"

chkStr(ws,"Happy Hols")

int IV[]

IV->info(1)

char E[]

E->info(1)



E = scat("Happy"," Hols")

E->info(1)

<<"$(typeof(E))\n"
<<"$(Caz(E)) \n"
<<"%Vs$E\n"

<<"%d$E[0] \n"

chkN(E[0],72);
chkN(E[1],97);
chkN(E[1],'a');

<<"%c$E[0] \n"
<<"%d$E[1] \n"
<<"%c$E[1] \n"
<<"%d$E[::] \n"
<<"%c$E[::] \n"

ws = scat("c'est"," exactement"," ", "ce ","que ","je ","veux.")
<<"$ws \n"

chkOut()