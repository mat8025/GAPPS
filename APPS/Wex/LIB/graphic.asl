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
<<"local LIB Graphic check\n"   
   Graphic = CheckGwm(); 


   if (!Graphic) {
    X=spawngwm(); 
    Graphic = CheckGwm(); 
     }
   
   if (! Graphic) {
     <<"can't go graphic!! exiting\n"; 
    exit(); 
     }
   
      OpenDll("plot") ;  //  should be automatic -- but for XIC launch best to use! 
      OpenDll("image")
      
//#include "tbqrd.asl"  // bug nested?

<<"Done graphic \n";

////////////////////////////////////////////////////////////////////////////////////////////////
