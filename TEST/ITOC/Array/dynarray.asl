//%*********************************************** 
//*  @script dynarray.asl 
//* 
//*  @comment test dynamic arrays 
//*  @release CARBON 
//*  @vers 1.15 P Phosphorus                                              
//*  @date Sun Feb 10 10:43:30 2019 
//*  @cdate 1/1/2001 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
 
 
  include "debug.asl"; 
  debugON(); 
  setdebug(1,@keep,@pline); 
  FilterFileDebug(REJECT_,"storetype_e","ds_storevar","ds_sivmem");
  FilterFuncDebug(REJECT_,"ArraySpecs",); 
 
 
  CheckIn(); 
 
  int ival;

  int IVD[];

  sz = Caz(IVD);
  <<"%V $sz\n";


  int IVF[5];

  sz = Caz(IVF);
  <<"%V $sz\n"; 



  int IV[4+];
  sz = Caz(IV);
  <<"%V $sz\n"; 
 
  CheckNum(sz,4);
 
  IV[1] = ptan("AT");
  <<"$IV\n"; 
 
  CheckNum(IV[1],85);
  IV[5] = ptan("Ac");
  <<"$IV\n"; 
 
  CheckNum(IV[5],89);
 
  float FV[5];
 
  FV[2] = ptan("Rh");
 
  sz = Caz(FV);
  <<"%V$sz\n"; 
  
  <<"$FV\n"; 
 
  CheckFnum(FV[2],45);
 
  CheckOut(); 
 
  exit(); 
