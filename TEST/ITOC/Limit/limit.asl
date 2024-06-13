//%*********************************************** 
//*  @script limit.asl 
//* 
//*  @comment test Limit SF 
//*  @release CARBON 
//*  @vers 1.2 He Helium [asl 6.3.2 C-Li-He]                                 
//*  @date Wed Dec 30 13:51:15 2020 
//*  @cdate 1/1/2005 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
//   
//  Limit
//
/*

A->limit(newrange_lower_limit,newrange_upper_limit)
A vector (or scalars) can be limited to values
at and between the specified limits. 
This is an inplace operation.
(see limitval)




*/

#include "debug"

  if (_dblevel >0) {

  debugON();

  }

  allowErrors(-1) ; // keep going;




chkIn()

F= vgen(FLOAT_,20,-7,1)

<<"%6.1f$F \n"

H=limitVal(F,-6,6)

<<"%6.1f$H \n"

chkR(H[0],-6)

chkR(H[19],6)


F.limit(-5,5)


<<"%6.1f$F \n"
chkR(F[0],-5)

chkR(F[19],5)


a = 7;

<<"$a\n"

a.limit(0,2)

<<"$a\n"
chkN(a,2);

b = -7;

<<"$a\n"

b.limit(0,2)

<<"$b\n"
chkN(b,0);

chkOut()

exit()