//%*********************************************** 
//*  @script cbrt.asl 
//* 
//*  @comment test cbrt cube root SF 
//*  @release CARBON 
//*  @vers 1.2 He Helium [asl 6.2.99 C-He-Es]                                
//*  @date Sat Dec 26 08:52:05 2020 
//*  @cdate 1/1/2005 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
///
///  Cbrt
///



chkIn()

f= Sqrt(81.0)

<<"$f $(typeof(f))\n"

f= Cbrt(81.0)

<<"$f $(typeof(f))\n"


f= Cbrt(125.0)

<<"$f $(typeof(f))\n"

chkR(f,5.0)

chkOut(1)

