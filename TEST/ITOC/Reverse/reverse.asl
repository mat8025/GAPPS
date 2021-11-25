//%*********************************************** 
//*  @script reverse.asl 
//* 
//*  @comment  
//*  @release CARBON 
//*  @vers 1.2 He Helium [asl 6.2.71 C-He-Lu]                              
//*  @date Fri Sep 18 08:08:52 2020 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2014,2018 --> 
//* 
//***********************************************%
///
//setdebug(1,@keep)

   chkIn();

   I = vgen(INT_,20,0,1);

   <<"$I \n";

   chkN(I[19],19);
   

   J = vreverse(I);

   <<"$J \n";

   chkN(J[0],19);

   chkN(J[19],0);

   M = redimn(J,4,5);

   <<"\n";

   <<"$J \n";

   T= mrevrows(J);

   <<" revrows\n";

   <<"$T \n";

   T= mrevcols(J);

   <<"revcols\n";

   <<"$T \n";

   chkOut();

//===***===//
