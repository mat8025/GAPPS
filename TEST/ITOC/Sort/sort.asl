/* 
 *  @script sort.asl 
 * 
 *  @comment test inplace sort,reverse and isort VMF, SF 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.8 C-Li-O]                                  
 *  @date Mon Jan 11 08:36:29 2021 
 *  @cdate 1/1/2005 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 

///
///
///


chkIn(_dblevel)


I = vgen(INT_,10,0,2)

<<"$I \n"
chkN(I[1],2)

I->reverse()

<<"$I \n"
chkN(I[1],16)


I->sort()

<<"$I \n"

chkN(I[1],2)

I->reverse()

chkN(I[1],16)

K =Sort(I)
K->info(1)
<<"K: $K \n"
<<"I: $I \n"

I->shuffle(10)

<<"I: $I \n"


K = Isort(I)

<<"$K \n"



K =Sort(I[0:5])

<<"K: $K \n"

<<"$I \n"


M = vgen(INT_,20,0,1)

M->redimn(4,5)

<<"$M\n"

M->Sort()

<<"$M\n"

L= cyclerow(M,1)

<<"$L \n"

<<"$M\n"

L= cyclecol(M,1)

<<"$L \n"

chkOut()
exit()

