//%*********************************************** 
//*  @script shift.asl 
//* 
//*  @comment Test shiftL shiftR SF  
//*  @release CARBON 
//*  @vers 1.2 He Helium [asl 6.3.1 C-Li-H]                                  
//*  @date Sun Dec 27 22:00:20 2020 
//*  @cdate 1/1/2005 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%



/*
shiftL()

/////
I->shiftL(newval,[nplaces],[vecsize])
An  VMF operation to shift elements of an vector one place to the left 
and replace the last element with
a  new val. 
Can be repeated nplaces. 
If vector size is specified as less than actual size the element can 
be inserted at the specified 'end'. (same for shiftR) 
*/



chkIn()

I = vgen(INT_,10,0,1)

<<"$I \n"

chkN(I[0],0)

I->shiftL(I[0])

chkN(I[0],1)

<<"$I \n"

I->shiftL(I[0])

chkN(I[0],2)
chkN(I[9],1)

<<"$I \n"


I->shiftL()


<<"$I \n"


I->shiftL(10)


<<"$I \n"


D = vgen(DOUBLE_,10,0,1)

<<"%6.2f$D \n"


D->shiftL(10)

chkN(D[0],1)



<<"%6.2f$D \n"


I->shiftR(-1)


<<"$I \n"

chkN(I[0],-1)

chkN(I[9],0)


D->shiftR(-47)

chkN(D[0],-47)

<<"%6.2f$D \n"

D->shiftR(79)

chkN(D[0],79)
chkN(D[1],-47)

<<"%6.2f$D \n"


I->shiftR(-79,5)




<<"$I \n"


I->shiftR()

chkN(I[0],0)

<<"$I \n"

chkOut()