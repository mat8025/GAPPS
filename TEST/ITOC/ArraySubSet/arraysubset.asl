//%*********************************************** 
//*  @script array-subset.asl 
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

/*

 // bug2fix should clear subi/subset each statement
 // else old selection overwritten 
*/

// have to use [{2,3,5}]  - OK?

<|Use_=
Demo  of vector set via list 
S = YV[P]
or
S = YV[{2,3,5}}

where P is vec
///////////////////////
|>






#include "debug"

if (_dblevel >0) {
   debugON()
}

chkIn(_dblevel)

/*
  FilterFileDebug(REJECT_,"~storetype_e");
  FilterFuncDebug(REJECT_,"~ArraySpecs",);
*/  
  
  
  B = vgen(INT_,10,0,1); 
  
  <<"$B\n"; 
  
  B[{3,5,6}] = 96;

  <<"$B\n"; 


  chkN(B[3],96); 
  chkN(B[5],96); 
  chkN(B[6],96); 

   A=  B[{3,5,6}]

<<"%V$A\n"

 // should clear subi/subset each statement
  
  B[{2,7,9}] = 79;
  
  <<"$B\n";
  


  chkN(B[2],79);
  chkN(B[7],79);
  chkN(B[9],79);


  chkN(B[3],96); 
  chkN(B[5],96); 
  chkN(B[6],96); 



  <<"$B\n"; 
  
  
  chkN(B[1],1); 
  
  chkOut();
  
//======================================//
