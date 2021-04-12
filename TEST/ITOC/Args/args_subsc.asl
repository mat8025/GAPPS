//%*********************************************** 
//*  @script args_subsc.asl 
//* 
//*  @comment test svar range arg 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                  
//*  @date Sun Apr  7 20:48:52 2019 
//*  @cdate Sun Apr  7 20:48:52 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%

#include "debug.asl";

   
   
   if (_dblevel >0) {
   debugON()
   }


 chkIn (_dblevel)

   
   
   
   
   
   IV= vgen(INT_,10,0,1); 
   
   <<"$IV\n"; 
   
   
   testargs(2,IV); 
   
   fh =2.0;
   
   S=testargs(fh,IV[1:9:2]); 
   
   <<"%(1,,,\n)$S\n"; 
   
   
   S=Split("$IV"); 
   
   
   T=testargs(2,S); 

<<"%(1,,,\n)$T\n"; 

   T=testargs(2,S[1:5]); 
   
<<"%(1,,,\n)$T\n"; 

chkR(fh,2.0)
chkOut()