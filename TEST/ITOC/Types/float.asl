//%*********************************************** 
//*  @script float.asl 
//* 
//*  @comment test float type 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                    
//*  @date Thu Apr  2 16:46:01 2020 
//*  @cdate Thu Apr  2 16:46:01 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%


CheckIn()

float FV[10]

FV[2] = 47

<<" $FV \n"

CheckFNum(FV[2],47,6)

float d =3

<<"$(typeof(d)) $d \n"

CheckFNum(d,3)

FVG = vgen(FLOAT_,10,0,1)

<<" $FVG \n"

CheckFNum(FVG[2],2,6)

CheckOut()

