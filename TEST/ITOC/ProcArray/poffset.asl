//%*********************************************** 
//*  @script poffset.asl 
//* 
//*  @comment check ptr offset code 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen [asl 6.2.63 C-He-Eu]                               
//*  @date Sat Aug  8 14:05:52 2020 
//*  @cdate Sat Aug  8 14:05:52 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
myScript = getScript();
///
///
///

#include "debug"

if (_dblevel >0) {
   debugON()
}




chkIn(_dblevel);



proc Roo(int ivec[])
   {
     ivec->info(1);
     Z->info(1);      
     
<<"IN %V $ivec \n"; 
<<"  %V $Z\n"

      ivec[1] = 47; 
      ivec[2] = 79;
      ivec[3] = 80;      
      ivec->info(1); 

<<"OUT %V $ivec \n";
<<"OUT %V $Z\n"

     rvec = ivec;

     return rvec; 
}


////////////  Array name ////////////////////////////////////////
   Z = Vgen(INT_,10,0,1); 
   
   <<"init $Z\n"; 
   
//   Z[0] = 36; 
//   Z[1] = 53; 
//   Z[9] = 28; 
   
  <<"before calling proc $Z\n";

    Y=Roo(&Z[3]); 
   
   <<"after calling proc $Z\n"; 

   chkN(Z[4],47);
   chkN(Z[5],79);
   chkN(Z[6],80);      
   checkStage("PO correct?")
<<"$Y \n"

   chkN(Y[1],47);
   chkN(Y[2],79);
   chkN(Y[3],80);      
   checkStage("return ivec correct?")

chkOut ()