//%*********************************************** 
//*  @script vec-declare.asl 
//* 
//*  @comment  test syntax for vec declare via {} list 
//*  @release CARBON 
//*  @vers 1.2 He Helium [asl 6.2.99 C-He-Es]                                
//*  @date Sat Dec 26 09:14:39 2020 
//*  @cdate Sat Dec 26 09:14:39 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
#include "debug.asl";



if (_dblevel >0) {
   debugON()
}


chkIn()


int V[] = {1,2,3,4,5,6,7}


<<"$V\n"

V->info(1);


chkN(V[0],1)
chkN(V[6],7)


chkOut();

