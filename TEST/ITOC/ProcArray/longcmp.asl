//%*********************************************** 
//*  @script longcmp.asl 
//* 
//*  @comment test long compare 
//*  @release CARBON 
//*  @vers 1.37 Rb Rubidium                                               
//*  @date Mon Jan 21 06:40:50 2019 
//*  @cdate 1/1/2005 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%

<|Use_=
Demo  of long cmp  ;
///////////////////////
|>

#include "debug"
//#include "hv.asl"

<<"%V $_dblevel\n"

if (_dblevel >0) {
   debugON()
    <<"$Use_\n"   
}

ignoreErrors()

chkIn(_dblevel)



//short nsp = 10;
//double nsp = 10;
//int nsp = 10;

long nsp = 10;

int j= 0;

nsp->pinfo()

  <<" test $j < $nsp \n"
   if (j < nsp) {
     <<"$j < $nsp\n"
    chkT(1)
   }
   else {
   <<"test fail\n"
   chkT(0)
   }



   if (j > nsp) {
     <<"$j > $nsp\n"
   }
   else {
   <<"$j <= $nsp\n"
   }

for ( i=0; i<nsp-1; i++) {
      <<"$i $j \n";
      j++;
      if (j > 20)
        break;
   }

<<"\n"


   if (i < nsp) {
     <<"$i < $nsp\n"
         chkT(1)
   }

   if (i > nsp) {
     <<"$i > $nsp\n"
         chkT(0)
   }



chkOut()
