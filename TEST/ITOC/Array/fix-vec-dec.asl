//%*********************************************** 
//*  @script lhe.asl 
//* 
//*  @comment test LHS array ele use 
//*  @release CARBON 
//*  @vers 1.38 Sr Strontium                                              
//*  @date Fri Jan 18 20:40:11 2019 
//*  @cdate 1/1/2007 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
///
///
///






checkIn(_dblevel) // _dblevel == 1 stop - interact on fail else run until exit -- report status on checkout



Data = vgen(INT_,10,-5,1)


<<"$Data \n"

<<"$Data[1:3] \n"
<<"$Data[1]\n"
<<"$Data[2]\n"
<<"$Data[3]\n"


Data->info(1)

checkNum(Data[1],-4)

sz= Caz(Data)

<<"%V$sz \n"

checkNum(sz,10)

////
int Vec[5];

Vec->info(1)

sz= Caz(Vec)

<<"%V$sz \n"


int Vec2[>10];

Vec2->info(1)

sz= Caz(Vec2)

<<"%V$sz \n"

checkNum(sz,10)





checkOut()


