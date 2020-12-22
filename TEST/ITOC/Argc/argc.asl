//%*********************************************** 
//*  @script argc.asl 
//* 
//*  @comment test count and CL args 
//*  @release CARBON 
//*  @vers 1.2 He Helium [asl 6.2.98 C-He-Cf]                            
//*  @date Tue Dec 22 09:15:02 2020 020 
//*  @cdate 1/1/2005 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
///
///  argc
///



 na = argc()
 <<"%V $na\n"

 na2= Caz(_clarg)
 <<"%V $na2\n"

 for (i = 0; i < na; i++) {

<<"$i  $_clarg[i]\n"

 }


<<"$_clarg[::] \n"

<<"$_clarg[1:-1:] \n" ;  // arg1 ... last

<<"$_clarg[2:-2:] \n" ;  // arg2 ... penultimate

//////////////////////////TBD /////////////////////////////

/*

 1. needs range spec fix 


*/