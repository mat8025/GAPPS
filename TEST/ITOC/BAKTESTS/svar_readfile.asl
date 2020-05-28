//%*********************************************** 
//*  @script svar_readfile.asl 
//* 
//*  @comment reads file into svar 
//*  @release CARBON 
//*  @vers 1.3 Li Lithium                                                  
//*  @date Fri Jan  3 11:12:03 2020 
//*  @cdate 1/1/2004 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%


set_debug(1)

Svar Wd

A= ofr("svar_readfile.asl")

P=readfile(A)

nlines=caz(P)

<<"$nlines \n"

<<" $P\n";



<<"first line $P[0]\n"

<<"last line $P[nlines-1]\n"

cf(A)

exit()
//////////////////////// last-line //////////////////////