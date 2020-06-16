//%*********************************************** 
//*  @script anonvec.asl 
//* 
//*  @comment test use of anonvec {1,2,3} as arg 
//*  @release CARBON 
//*  @vers 1.3 Li Lithium                                                  
//*  @date Sat May 11 09:54:28 2019 
//*  @cdate 1/1/2010 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2019 → 
//* 
//***********************************************%
///
///
///


checkIn(_dblevel)


int veo[2] = {4,5}
<<"$veo \n"

int ves[2] = {1,-1}

<<"$ves \n"

checkNum(ves[0],1)
checkNum(ves[1],-1)





int vec[] = {0,1,2,3,4,5,6,7,8,9}

<<"$vec\n"

Table = vvgen(INT_,20,veo,ves)

<<"%(2,, ,\n)$Table \n"

printArgs(veo,ves)

<<"////////////\n"
printArgs({0,1,2,3,4,5,6,7,8,9})


// show list arg arrives as array of values
S=testArgs({0,1,2,3,4,5,6,7,8,9})
<<"//////S//////\n"
<<"%(1,,,\n)$S\n"




T=testArgs({"hey","hago","haces","hace"})

<<"///////T/////\n"
<<"%(1,,,\n)$T\n"
C=split(T[5])
<<"$C[1]\n"
checkStr(C[1],"<hace>")


printArgs({"hey","hago","haces","hace"})


T=testArgs({"hacer","preterite","hice","hiciste","hizo","hicimos","hicisteis","hicieron"})

<<"///////T/////\n"
<<"%(1,,,\n)$T\n"
C=split(T[5])
<<"$C[1]\n"
checkStr(C[1],"<hiciste>")

//T->Delete()

fprintfArgs(1,{"hacer","preterite","hice","hiciste","hizo","hicimos","hicisteis","hicieron"})

T=testArgs({"hacer","imperfect","hacía","hacías","hacía","hacíamos","hacíais","hacían"})

<<"///////T/////\n"
<<"%(1,,,\n)$T\n"
C=split(T[5])
<<"$C[1]\n"
checkStr(C[1],"<hacías>")



checkOut()
