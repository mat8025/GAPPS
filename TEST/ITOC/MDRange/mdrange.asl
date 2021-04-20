//%*********************************************** 
//*  @script mdrange.asl 
//* 
//*  @comment check md range ops 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                    
//*  @date Mon Feb  3 08:48:06 2020 
//*  @cdate Mon Feb  3 08:48:06 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%

<|Use_=
Demo  of MD  range
///////////////////////
|>


#include "debug";



if (_dblevel >0) {
   debugON()
   <<"$Use_\n"
}


filterFileDebug(REJECT_,"scopesindex_e.cpp","scope_e.cpp","scope_findvar");
filterFileDebug(REJECT_,"ds_sivbounds","ds_sivmem","exp_lhs_e");
filterFuncDebug(REJECT_,"vrealloc","Svar","init");


chkIn(_dblevel)

int MD[5][20];

MD->info(1)

//!p MD
MD[0][1] = 77;
<<"%V $MD[0][1]\n"
chkN(MD[0][1],77)

chkN("init Array zero ",MD[0][1],77)

chkN(MD[0][-1],0)



chkN("init Array zero ",MD[0][-1],0)

MD[0][1] = 79



chkN("Set element",MD[0][1],79)

MD[0][0:19:1] = 79

chkN("set subset of elements",MD[0][2],79)

MD[1][::] = 80

chkN("set default range",MD[1][1],80)

<<"$MD\n"

MD[0][5:10:1] = 54


chkN("set subset of eles",MD[0][5],54)

MD[1][6:11:1] = 28

chkN("set subset of eles",MD[1][6],28)

MD[1][6:11:] = 28

chkN("set subset of eles-default step",MD[1][6],28)



<<"$MD\n"


MD[2:4:1][6:11:1] = 77

<<"$MD\n"

chkN("set subset of eles",MD[3][6],77)


MD[2:4:1][6:11:] = 78

chkN("set subset of eles-default stride",MD[3][6],78)


/////////////////////////////////////////   3D /////////////////////////////////////////
int M3D[3][5][20];

<<"$M3D \n"


M3D[1][1][1] = 16
M3D[2][2][2] = 18

<<"$M3D \n"

chkN("3D ele set",M3D[1][1][1],16)
chkN("3D ele set",M3D[2][2][2],18)


M3D[1][1][2:10:1] = 6

<<"$M3D \n"

chkN("3D inner range set",M3D[1][1][2],6)



M3D[1][1:3][2:10:1] = 15

<<"$M3D \n"


chkN("3D middle & inner range set",M3D[1][1][2],15)
chkN("3D middle & inner range set",M3D[1][1][10],15)
chkN("3D middle & inner range set",M3D[1][2][2],15)
chkN("3D middle & inner range set",M3D[1][2][10],15)
chkN("3D middle & inner range set",M3D[1][3][10],15)




M3D[2][1:3][2:10:1] = 17


chkN("3D middle & inner range set",M3D[2][1][2],17)
chkN("3D middle & inner range set",M3D[2][1][10],17)
chkN("3D middle & inner range set",M3D[2][2][2],17)
chkN("3D middle & inner range set",M3D[2][2][10],17)
chkN("3D middle & inner range set",M3D[2][3][10],17)




<<"$M3D \n"



M3D[1:2][1:3][2:10:1] = 18

<<"$M3D \n"

chkN("3D outer, middle & inner range set",M3D[2][1][2],18)
chkN("3D outer,middle & inner range set",M3D[2][1][10],18)
chkN("3D outer,middle & inner range set",M3D[2][2][2],18)
chkN("3D outer,middle & inner range set",M3D[2][2][10],18)
chkN("3D outer,middle & inner range set",M3D[2][3][10],18)




M3D[::][1:3][2:10:1] = 19

<<"$M3D \n"

chkN("3D outer all, middle & inner range set",M3D[0][1][2],19)
chkN("3D outer all,middle & inner range set",M3D[1][1][10],19)
chkN("3D outer all,middle & inner range set",M3D[2][2][2],19)
chkN("3D outer all,middle & inner range set",M3D[0][2][10],19)
chkN("3D outer all,middle & inner range set",M3D[1][3][10],19)
chkN("3D outer all,middle & inner range set",M3D[2][3][10],19)


I = vgen(INT_,20,0,1)

<<"$I\n"


M3D[::][1:3][2:10:1] = I[2:10]

<<"$M3D \n"



///////////////////////////////// M4D //////////////////////////////////////

int M4D[2][3][5][20];

//M4D = vgen(INT_,600,0,1);

sz=Caz(M4D)

bd = Cab(M4D)
<<"%V $sz $bd\n"

M4D->info(1)


//M4D->redimn(2,3,5,20)

sz=Caz(M4D)

bd = Cab(M4D)

<<"%V $sz $bd\n"


<<"$M4D \n"




M4D[0][1][1][1] = 16
M4D[1][2][2][2] = 18

<<"$M4D \n"



chkN("4D ele set",M4D[0][1][1][1],16)
chkN("4D ele set",M4D[1][2][2][2],18)




M4D[0][1:2][1:3][2:12:1] = 47

chkN("4D outer ele middle & inner range set",M4D[0][1][2][10],47)

<<"$M4D \n"


M4D[1][1:2][1:3][2:12:1] = 47

chkN("4D outer ele middle & inner range set",M4D[1][1][2][10],47)

<<"$M4D \n"

//chkOut(); exit();


M4D[::][1:2][1:3][2:18:1] = 48

chkN("4D outer ele middle & inner range set",M4D[1][1][2][10],48)

<<"$M4D \n"

M4D[::][1:2][1:4][2:18:1] = 50

chkN("4D outer ele middle & inner range set",M4D[1][1][2][10],50)

<<"$M4D \n"

// bug - XIC does not check bounds - fixed?
//M4D[::][1:3][1:4][2:18:1] = 51

M4D[::][1:2][1:4][2:18:1] = 51
nb = Cab(M4D)



<<"%V $nb \n"







chkN("4D outer ele middle & inner range set",M4D[1][1][2][10],51)

M4D[::][0:2][1:4][2:18:1] = 52

chkN("4D outer ele middle & inner range set",M4D[1][1][2][10],52)

<<"$M4D \n"


M4D[::][0:2][0:4][2:18:1] = 53
M4D[1][2][4][19] = 90

chkN("4D outer ele middle & inner range set",M4D[1][1][2][10],53)
chkN("4D outer ele middle & inner range set",M4D[1][2][4][10],53)
chkN("4D outer ele middle & inner range set",M4D[1][2][4][18],53)
chkN("4D outer ele middle & inner range set",M4D[1][2][4][19],90)

<<"$M4D \n"


M4D[0][0][0:4][2:18:1] = I[2:18]

I += 1

M4D[0][1][0:4][2:18:1] = I[2:18]

I += 1

M4D[0][2][0:4][2:18:1] = I[2:18]

I += 1


M4D[1][0][0:4][2:18:1] = I[2:18]

I += 1

M4D[1][1][0:4][2:18:1] = I[2:18]

I += 1

M4D[1][2][0:4][2:18:1] = I[2:18]

I += 1







//M4D[1][0:2][0:4][2:18:1] = I[2:18]

<<"$M4D \n"




chkN("4D outer ele middle & inner range set",M4D[0][2][4][2],4)
chkN("4D outer ele middle & inner range set",M4D[1][2][4][2],7)


chkN("4D outer ele middle & inner range set",M4D[0][2][4][18],20)
chkN("4D outer ele middle & inner range set",M4D[1][2][4][18],23)


M4D->info(1)


chkOut(); exit();


M4D[1][1][1][5:15] = 86


<<"$M4D \n"


chkOut();




/*

 Should be able to specify a subset of a MD array for operations







*/