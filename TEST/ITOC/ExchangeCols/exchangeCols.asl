//%*********************************************** 
//*  @script exchangeCols.asl 
//* 
//*  @comment test exchangeCols of Matrix 
//*  @release CARBON 
//*  @vers 1.2 He Helium [asl 6.3.2 C-Li-He]                                 
//*  @date Mon Dec 28 22:03:48 2020 
//*  @cdate 1/1/2008 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%


//M = {2,3,4,5,6,7 };   // should work - but needs fix
chkIn()

int M[] = {2,3,4,5,6,7 };  // explicit  dec works

M->info(1)

M->redimn(2,3)

M->info(1)

<<"$M\n"

P = exchangeCols(M,0,2)

<<"$P \n"
P->info(1)

P = exchangeCols(M,1,2)

<<"$P \n"


P = exchangeCols(M,0,1)

<<"$P \n"
chkR(P[0][0],M[0][1])
chkR(P[0][1],M[0][0])
chkR(P[2][0],M[2][1])


chkOut()