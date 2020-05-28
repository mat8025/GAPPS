//%*********************************************** 
//*  @script double.asl 
//* 
//*  @comment test double type 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                    
//*  @date Thu Apr  2 16:45:21 2020 
//*  @cdate Thu Apr  2 16:45:21 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%


CheckIn()

double DV[10]

DV[2] = 47

<<" $DV \n"

CheckFNum(DV[2],47,6)

double d =3

<<"$(typeof(d)) $d \n"

CheckFNum(d,3)

DVG = vgen(DOUBLE_,10,0,1)

<<" $DVG \n"

CheckFNum(DVG[2],2,6)

CheckOut()
;
