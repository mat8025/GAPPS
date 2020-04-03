//%*********************************************** 
//*  @script real.asl 
//* 
//*  @comment test real aka double (promote float to double) type 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                    
//*  @date Thu Apr  2 16:46:48 2020 
//*  @cdate Thu Apr  2 16:46:48 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%


#include "debug"

filterFuncDebug(ALLOWALL_,"xxx");
filterFileDebug(ALLOW_,"proc_","args_","scope_","declare_");

debugON()

setdebug(1,@pline,@trace)


CheckIn()

float f = 7.2

<<"$(typeof(f)) $f \n"

real r = 3.14259

<<"$(typeof(r)) $r \n"

r->info(1)

CheckOut()


f = r;

<<"$(typeof(f)) $f \n"


double d = r;

<<"$(typeof(d)) $d \n"

checkFnum(d,3.14259)


checkFnum(r,3.14259)

checkOut()

real FV[10]

FV[2] = 47

<<" $FV \n"

CheckFNum(FV[2],47,6)



CheckFNum(d,3)

FVG = vgen(REAL_,10,0,1)

<<" $FVG \n"

CheckFNum(FVG[2],2,6)

CheckOut()

