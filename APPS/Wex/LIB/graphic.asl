//%*********************************************** 
//*  @script graphic.asl 
//* 
//*  @comment connect/launch graphic (X) server 
//*  @release CARBON 
//*  @vers 1.2 He Helium                                                   
//*  @date Wed Apr 10 07:49:47 2019 
//*  @cdate Wed Apr 10 07:46:58 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
   
//////////////////////////// Connect with Graphic server ///////////////////////
   
   int Graphic = checkGWM(); 
   int X;
   
   if (!Graphic) {
     X=spawnGWM("ASL"); 
     Graphic = checkGWM(); 
     }
   
   if (! Graphic) {
     printf("can't go graphic!! exiting\n"); 
     exit(-1); 
     }
   
     openDll("plot") ;  //  should be automatic -- but for XIC launch best to use! 
     openDll("image") ;  
//#include "tbqrd.asl"  // bug nested?
// cout<<"Graphic DONE\n";  

////////////////////////////////////////////////////////////////////////////////////////////////
