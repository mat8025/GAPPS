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
<|Use_=
   Demo  of poffset;
///////////////////////
|>
#include "debug.asl"

   if (_dblevel >0) {

     debugON();

     <<"$Use_\n";

     }
   allowErrors(-1) ; ; // keep going 

   chkIn(_dblevel);

   int voo(int vect[])
   {

     vect.pinfo();
     <<"IN $vect \n" ;  ; // debug version alters poffset??; 
//Z<-pinfo() // TBC
//<<"pa_arg2 %V$k\n"
!t poffset correct?;

     vect[1] = 47;

     <<"add Ag $vect \n";

     vect[2] = 79;

     <<"add Au $vect \n";

     vect<-pinfo();

     vect[3] = 80;

     vect[4] = 78;

     vect[5] = 50;

     z= vect[5];

     vect.pinfo();

     <<"OUT $vect \n";

     return z;

     }
//[EP]=================

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
//[EP]=================

   int Roo(int ivec[])
   {

     ivec.pinfo();
  //   Z<-pinfo();      

     <<"IN $_proc %V $ivec \n";

     ivec[1] = 47;

     ivec[2] = 79;

     ivec[3] = 80;

     ivec[4] = 7;

     ivec.pinfo();

     <<"OUT %V $ivec \n";

     rvec = ivec;

     rvec.pinfo();

     <<"OUT %V $rvec \n";
!z

     return rvec;

     }
////////////  Array name ////////////////////////////////////////

   Z = Vgen(INT_,10,0,1);

   W= Z;

   W.pinfo();
!z

   <<"init $Z\n";
//   Z[0] = 36; 
//   Z[1] = 53; 
//   Z[9] = 28; 
   name_ref = 1;  ; //  this section did crash now OK 

   if (name_ref) {

     <<"before calling proc $Z\n";
//     voo(&Z);  // crash TBF 10/12/21

     voo(Z);  // name only - want to be equiv with &Z  

     <<"after calling proc $Z\n";

     chkN(Z[1],47);

     chkN(Z[2],79);

     chkN(Z[3],80);

     }

   <<"%V$W\n";

   voo(&W[3]);

   <<"%V$W\n";

   chkN(W[4],47);

   chkN(W[5],79);

   chkN(W[6],80);

   Z = W;

   <<"B4 calling  Roo $W\n";

   Y=Roo(&W[3]);

   <<"%V$W\n";

   <<"Y: $Y \n";
!z

   chkStage("PO correct?");

   <<"$Y[1] $Y[2] $Y[3]\n";

   y1= Y[1];

   <<"%V $y1\n";

   chkN(Y[1],47);

   chkN(Y[2],79);

   chkN(Y[3],80);

   chkN(Y[4],7);
//   chkStage("return ivec correct?")

   chkOut();
//===***===//
