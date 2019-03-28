//%*********************************************** 
//*  @script abs.asl 
//* 
//*  @comment test Abs func 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                 
//*  @date Tue Mar 12 07:50:33 2019 
//*  @cdate Tue Mar 12 07:50:33 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%///

/{/*
Abs(A)
truncates a floating point number delivers absolute integer result.
if A is a vector then operation occurs on all elements of the vector.
e.g. V=Abs(A)  - V is a new vector of type integer of converted results.
(see Fabs)
/}*/

include "debug.asl"
debugON()


checkIn()

sfunc = "abs";

S=whatis(sfunc);

<<"$sfunc - $S\n"

  double y = 1234.123456


  a= abs(y)

<<"%V $y abs(y) $a  $(abs(y)) \n"

checkNum(a,1234)

  y= -1234.123456

  a= abs(y)

<<"%V $y abs(y) $a  $(abs(y)) \n"

checkNum(a,1234)


Y = vgen(FLOAT_,20,-1.75,0.25)

<<"%6.2f$Y \n"

A= Abs(Y)

<<"%6d$A \n"
<<"Vector A type  $(typeof(A)) size $(Caz(A)) \n"

// vmf not legal 
//Y->abs()
//<<"%6.2f$Y \n"

checkNum(A[0],1)
checkNum(A[19],3)


checkOut()