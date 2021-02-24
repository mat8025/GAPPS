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

///
///
///

#include "debug"


if (_dblevel >0) {
   debugON()
}


chkIn(_dblevel);

//sdb(2,@keep);

int voo(int vect[])
{
//<<"$_proc IN $vect \n" ;  // debug version alters poffset??

//Z->info(1)
//<<"pa_arg2 %V$k\n"

  vect->info(1)
  vect[1] = 47;
<<"add 47 $vect \n"
  vect->info(1)
  vect[2] = 79;
<<"add Au $vect \n"

  vect[3] = 80
  vect[4] = 78
  vect[5] = 50
  z= vect[5]
  vect->info(1)
  
<<"OUT $vect \n"

  return z;
}
//============================


void Noo(int ivec[])
   {
    // ivec->info(1);
     //Z->info(1);      
     
////<<"IN %V $ivec \n"; 
//<<"  %V $Z\n"

      ivec[1] = 47; 
      ivec[2] = 79;
      ivec[3] = 80;      
   //   ivec->info(1); 

<<"OUT %V $ivec \n";
//<<"OUT %V $Z\n"

     
}



int Roo(int ivec[])
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
<<"OUT %V $rvec \n";
     return rvec; 
}


////////////  Array name ////////////////////////////////////////
   Z = Vgen(INT_,10,0,1); 
   W= Z;
   <<"init $Z\n"; 
   
//   Z[0] = 36; 
//   Z[1] = 53; 
//   Z[9] = 28; 

<<"before calling proc $Z\n";
    voo(Z);
  <<"after calling proc $Z\n";
   chkN(Z[1],47);
   chkN(Z[2],79);
   chkN(Z[3],80);      

    Z = W

  <<"before calling proc $Z\n";
   voo(&Z[3]);
  <<"after calling proc $Z\n";

<<"$Z[4] \n"

   chkN(Z[4],47);
   chkN(Z[5],79);
   chkN(Z[6],80);
//chkOut ()

    Z = W

    Y=Roo(&Z[3]); 
   
   <<"after calling proc $Z\n"; 

 //  chkStage("PO correct?")
<<"Y: $Y \n"
<<"$Y[1] $Y[2] $Y[3]\n"
y1= Y[1]
<<"%V $y1\n"

   chkN(Y[1],47);
   chkN(Y[2],79);
   chkN(Y[3],80);      
//   chkStage("return ivec correct?")

chkOut ()