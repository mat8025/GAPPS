//%*********************************************** 
//*  @script exchangeRows.asl 
//* 
//*  @comment test exchangeRows of Matrix 
//*  @release CARBON 
//*  @vers 1.2 He Helium [asl 6.3.2 C-Li-He]                                 
//*  @date Mon Dec 28 22:03:48 2020 
//*  @cdate 1/1/2008 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%

chkIn(_dblevel)

//M = {2,3,4,5,6,7}
float M[] = {2.0,3,4,5,6,7 };

M->redimn(3,2)
M->info(1)
<<"$M\n"

P = exchangeRows(M,0,2)

<<"$P \n"


P = exchangeRows(M,1,2)

<<"$P \n"


P = exchangeRows(M,0,1)

<<"$P \n"

chkR(P[0][0],M[1][0])
chkR(P[0][1],M[1][1])
chkR(P[1][0],M[0][0])


chkOut()