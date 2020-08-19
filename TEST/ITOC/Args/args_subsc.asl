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

include "debug.asl";

   debugON();
   
   setdebug (1, @pline, @~step, @~trace,) ;
   
   
   chkIn(); 
   
   
   IV= vgen(INT_,10,0,1); 
   
   <<"$IV\n"; 
   
   
   testargs(2,IV); 
   
   fh =2.0;
   
   S=testargs(fh,IV[1:9:2]); 
   
   <<"$S\n"; 
   
   
   S=Split("$IV"); 
   
   
   testargs(2,S); 
   
   setdebug (1, @trace) ;
   testargs(2,S[1:5]); 
   

