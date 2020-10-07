//%*********************************************** 
//*  @script imave.asl 
//* 
//*  @comment test image average (reduction) function 
//*  @release CARBON 
//*  @vers 1.2 He Helium [asl 6.2.75 C-He-Re]                                
//*  @date Sun Oct  4 06:39:57 2020 
//*  @cdate Sun Oct  4 06:39:57 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
myScript = getScript();
///
///   test imave
///

opendll("image");

IC=vgen(INT_,225,0,1)

//IC->redimn(8,8)

Redimn(IC,15,15)
<<"$(Cab(IC))\n"
<<"$IC\n"


 OC= imave(IC,3)

<<"$(Cab(OC))\n"
<<"$OC\n"



 OC= imave(IC,5)

<<"$(Cab(OC))\n"
<<"$OC\n"


IC=vgen(INT_,256,0,1)

//IC->redimn(8,8)

Redimn(IC,16,16)
<<"$(Cab(IC))\n"
<<"$IC\n"


 OC= imave(IC,3)

<<"$(Cab(OC))\n"
<<"$OC\n"



 OC= imave(IC,5)

<<"$(Cab(OC))\n"
<<"$OC\n"




exit()