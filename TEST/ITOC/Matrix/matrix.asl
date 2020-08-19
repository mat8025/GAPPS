//%*********************************************** 
//*  @script matrix.asl 
//* 
//*  @comment test matrix ops 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                    
//*  @date Thu Feb 20 08:27:55 2020 
//*  @cdate Thu Feb 20 08:27:55 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%


include "debug"; 
   debugON(); 
   
   
   filterFuncDebug(ALLOWALL_,"xxx");
   filterFileDebug(ALLOWALL_,"yyy");


setdebug(1,@pline,@~trace,@keep); 
chkIn()

int M[5][4]

V=vgen(INT_,4,0,1)

<<"$V\n"
<<"////////////////\n"
M[0][::] = V
M[2][::] = V

<<"$M\n"

M2= matgen(FLOAT_,5,4,0,1)

<<"$M2\n"

M2->info(1)

chkN(M2[0][0],0)
chkN(M2[4][3],19)

M3=cyclerow(M2,7)

chkN(M3[0][0],12)
<<"$M3\n"

<<"$M2\n"

M2->cycleRow(7)

<<"$M2\n"

M2->cycleRow(-1)

<<"$M2\n"

M3=cyclecol(M2,1)

<<"$M3\n"

M3->cycleCol(2)

<<"$M3\n"

M4= cycleCol(M3,-1)

M3->cycleCol(-1)

<<"$M3\n"

<<"$M4\n"

M4= cycleCol(M3,2)


M3->cycleCol(2)

<<"$M3\n"

<<"$M4\n"


checkVector(M3,M4)

checkVector(M2,M4)

<<"$M2\n"

I= Cmp(M2,M4,"==",1)

<<"$I \n"

M2->cycleCol(1)

checkVector(M2,M4)

<<"$M2\n"

I= Cmp(M2,M4,"==",1)

<<"$I \n"

chkOut()