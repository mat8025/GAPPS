//%*********************************************** 
//*  @script mdrecord.asl 
//* 
//*  @comment check md range ops 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                    
//*  @date Mon Feb  3 08:48:06 2020 
//*  @cdate Mon Feb 15 08:48:06 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
#include "debug.asl";


if (_dblevel >0) {
   debugON()
}

chkIn(_dblevel)

int MD[5][10];

chkN("init Array zero ",MD[0][1],0)
chkN("init Array zero ",MD[0][-1],0)

MD[0][1] = 79

chkN("Set element",MD[0][1],79)

MD[0][0:8:1] = 79

chkN("set subset of elements",MD[0][8],79)

MD[1][::] = 80

chkN("set default range",MD[1][1],80)

<<"$MD\n"

MD[0][5:9:1] = 54


chkN("set subset of eles",MD[0][5],54)

MD[1][3:8:1] = 28

chkN("set subset of eles",MD[1][6],28)

MD[1][3:8:] = 27

chkN("set subset of eles-default step",MD[1][6],27)


<<"$MD\n"


MD[2:4:1][4:9:1] = 77

<<"$MD\n"

chkN("set subset of eles",MD[3][6],77)


MD[2:4:1][4:9:] = 78

chkN("set subset of eles-default stride",MD[3][9],78)
MD[2:4][0:3] = 85

MD[0:3][0] = -34

Record RSV[>3]


RSV= MD


RSV->info(1)


<<"$RSV\n"

val = RSV[2][4]

<<"$val\n"
chkStr(val,"78.000000")

val = RSV[2][1]

<<"$val\n"
chkStr(val,"85.000000")

chkStr(RSV[2][1],"85.000000")


RSV= MD[0:2][1:5:]

RSV->info(1)
<<"$RSV\n"

V=vgen(FLOAT_,10,0,1)
<<"$V\n"


Record RV[>3]


RV =V

RV->info(1)
<<"$RV\n"

chkOut()


/{/*

 Should be able to specify a subset of a MD array for operations







/}*/