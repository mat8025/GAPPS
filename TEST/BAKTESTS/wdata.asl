//%*********************************************** 
//*  @script wdata.asl 
//* 
//*  @comment writes data as binary 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                  
//*  @date Sun Mar 31 17:33:55 2019 
//*  @cdate Sun Mar 31 17:33:55 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
///
///
///

/{/*
 writes data vectors and scalars e.g. wdata(Vec1,Vec2[0:10:2],a,b) 

 search for wdata 
 wdata,vwrite
 w_data(A,V,V2[a:b:c],a,...)
 writes the vectors (which can be subscripted) into the file pointed to by file handle A.
 returns number of items written
 e.g wdata(A,F)
 would write the entire vector F to file, 
 

 The list of variables can include scalars.
 A string constant e.g. w_data(A,"ABCD") is written as a sequence of chars.
 (see rdata,wcdata)
/}*/




include "debug.asl"
debugON()

checkIn()

IV=vgen(INT_,20,0,1)

<<"$IV\n"

A=ofw("vec.dat")

wdata(A,IV)

cf(A)

A=ofr("vec.dat")


RV=rdata(A,INT_)

<<"$RV\n"
for (i=0;i<20;i++) {
checkNum(RV[i],i)
}
cf(A)

A=ofr("vec.dat")

float FV[+10];
FV=rdata(A,INT_)

<<"$FV\n"



checkOut()



////////////// TBD ////////////////////
