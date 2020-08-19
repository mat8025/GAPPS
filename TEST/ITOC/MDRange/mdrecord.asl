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

include "debug"
debugON()
setdebug(1,@pline,@trace,@keep)

filterFuncDebug(ALLOWALL_,"xxx");
filterFileDebug(ALLOWALL_,"yyy");

setDebug(1,@pline)

chkIn()

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

MD[0][5:10:1] = 54


chkN("set subset of eles",MD[0][5],54)

MD[1][3:8:1] = 28

chkN("set subset of eles",MD[1][6],28)

MD[1][3:8:] = 27

chkN("set subset of eles-default step",MD[1][6],27)


<<"$MD\n"


MD[2:4:1][4:10:1] = 77

<<"$MD\n"

chkN("set subset of eles",MD[3][6],77)


MD[2:4:1][4:9:] = 78

chkN("set subset of eles-default stride",MD[3][9],78)


Record RSV[>3]


RSV= MD


RSV->info()


<<"$RSV\n"


chkOut()


/{/*

 Should be able to specify a subset of a MD array for operations







/}*/