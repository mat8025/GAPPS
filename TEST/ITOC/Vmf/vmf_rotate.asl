//%*********************************************** 
//*  @script rotate.asl 
//* 
//*  @comment test rotate vector 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                 
//*  @date Tue Mar 12 07:50:33 2019 
//*  @cdate Tue Mar 12 07:50:33 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//*
//***********************************************%

/*
 rotate

rotate(vec, dir, nsteps)
or
Vec->rotate(dir,nsteps)

Vector is rotated in direction (1 forward , -1 backward) for nsteps

/////
*/




IV = vgen(INT_,20,0,1)

<<"$IV\n"

chkN(IV[0],0)

IV.rotate(1,3)


<<"$IV\n"

chkN(IV[0],17)

IV.rotate(-1,4)


<<"$IV\n"

chkN(IV[0],1)

rotate(IV,1,5)

<<"$IV\n"

chkN(IV[0],16)
//chkStage("rotate")

chkOut()

//=================//
