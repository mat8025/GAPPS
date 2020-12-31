//%*********************************************** 
//*  @script trunc.asl 
//* 
//*  @comment test Round function 
//*  @release CARBON 
//*  @vers 1.3 Li Lithium                                                 
//*  @date Thu Jan 17 10:59:36 2019 
//*  @cdate 1/1/2005 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%

//include "debug.asl"
#include "debug.asl"

debugON();

chkIn()

double f= atan(1.0) * 4.0

#include "fooi"

i = Trunc(f);


<<"%V $f $i  $(typeof(i)) \n"

chkN(i,3)

f +=0.5

i = Trunc(f);


<<"%V $f $i  $(typeof(i)) \n"

chkN(i,3)

chkOut()
