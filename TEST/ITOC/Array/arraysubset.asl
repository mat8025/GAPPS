//%*********************************************** 
//*  @script arraysubset.asl 
//* 
//*  @comment test  operation on array subsets 
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
  setdebug(1,@keep,@pline,@~trace);
  FilterFileDebug(REJECT_,"~storetype_e");
  FilterFuncDebug(REJECT_,"~ArraySpecs",);
  
  
  checkIn(); 
  
  B = vgen(INT_,10,0,1); 
  
  <<"$B\n"; 
  
  B[3,5,6] = 96;

  checkNum(B[3],96); 
  checkNum(B[5],96); 
  checkNum(B[6],96); 

  <<"$B\n"; 

 // should clear subi/subset each statement
  
  B[2,7,9] = 79;
  
  


  checkNum(B[2],79);
  checkNum(B[7],79);
  checkNum(B[9],79);


  checkNum(B[3],96); 
  checkNum(B[5],96); 
  checkNum(B[6],96); 



  <<"$B\n"; 
  
  
  checkNum(B[1],1); 
  
  checkOut();
  
//======================================//
