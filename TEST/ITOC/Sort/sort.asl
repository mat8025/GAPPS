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

<|Use_=
Demo  of svar;
///////////////////////
|>

#include "debug"

if (_dblevel >0) {
   debugON()
   <<"$Use_\n"   
}


k= 2

  if (k > 0) {
  <<"$k > 0\n"  
  <<"$Use_\n"   
  }
  else {
<<"$k  (k >0 )  not working - fix \n"

  }

chkIn()


I = vgen(INT_,10,0,2)

<<"$I \n"
chkN(I[1],2)

I->reverse()

<<"$I \n"
chkN(I[1],16)


I->shuffle(10)

<<"$I \n"

I->sort()

<<"$I \n"

chkN(I[1],2)




K =Sort(I)

K->info(1)
<<"K: $K \n"
<<"I: $I \n"



I->shuffle(10)

<<"I: $I \n"


//K = Isort(I)

K = sort(I)

<<"$K \n"

I->sort()

<<"$I \n"

KS = I[1:7:1]

<<"KS:= I[1:7:1] $KS \n"

chkN(KS[0],2)
chkN(KS[1],4)


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

chkN(L[0][0],15)

<<"$M\n"

L= cyclecol(M,1)

<<"$L \n"
chkN(L[0][0],1)

chkOut()


