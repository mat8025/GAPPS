//%*********************************************** 
//*  @script rec-assign.asl 
//* 
//*  @comment test rec ele field assign 
//*  @release CARBON 
//*  @vers 1.2 He Helium [asl 6.2.99 C-He-Es]                                
//*  @date Fri Dec 25 14:39:09 2020 
//*  @cdate 1/1/2012 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
///
/// 
///

//record R[];  // TBF

// test assignment of ele and field

chkIn(1)

record R[10];


sz = Caz(R)
<<"%V $sz\n"

R[0] = Split("how many cols in this record?")

<<"in record[0] we have:-  $R[0] \n"

<<"in record[0][1] we have:-  $R[0][1] \n"

rf = R[0][2];

<<"%V$rf $R[0][2]\n"

nd = Cab(R)
<<"%V $nd\n"

sz = Caz(R)
<<"%V $sz\n"

chkStr(rf,"cols")

chkOut()
exit()


R[0] = Split("does this replace")

<<"in record[0] now we have:-  $R[0] \n"



R[1] = R[0];

<<"in %V$R[1]\n"

<<" assigning to R[0][2] \n"

R[0][2] = "hey"


<<"in record[0] we have:-  $R[0] \n"


R[0][3] = "man"


<<"in record[0] we have:-  $R[0] \n"


R[1][3] = "man"


<<"in record[1] we have:-  $R[1] \n"

