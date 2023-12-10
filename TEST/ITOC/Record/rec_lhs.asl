//%*********************************************** 
//*  @script reclhs.asl 
//* 
//*  @comment test lh assignment 
//*  @release CARBON 
//*  @vers 1.3 Li Lithium [asl 6.2.53 C-He-I]                                
//*  @date Sat May 30 20:15:15 2020 
//*  @cdate 1/1/2012 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%

<|Use_=
   Demo  of record lhs
///////////////////////
|>

#include "debug"

   if (_dblevel >0) {

     debugON();

     <<"$Use_\n";

     }

   chkIn(_dblevel);

   record R[10];

   R[0] = Split("0 1 2 3 4 5 6 7 8 9");

   <<"$R[0]\n";

   R[1] = Split("0 1 2 3 4 5");

   R[2] = Split("0 1 2 3 4 5");

   R[3] = Split("10 11 12 13 14 15");

   R[4] = Split("20 21 22 23 24 25");

   R[5] = Split("30 31 32 33 34 35");

   R[6] = Split("40 41 42 43 44 45");

   <<"$R[6]\n";

   Str wrd2;

   R->pinfo();

   kc = 1;

   j = 5;

   nval = 4.3;

   wrd = "$nval";

   R[j][3+kc] = "$nval";

   wrd2= R[j][3+kc];

   <<"%I $wrd2\n";

   <<"%V $wrd $wrd2 $R[j][3+kc]\n";

   chkStr(wrd2,"$nval",4);

   <<"R[0] $R[0] \n";

   <<"R[${j}] $R[j] \n";
 //R[j][3] = "%6.2f$nval";

   R[j][3] = "$nval";

   <<"$j R[j] $R[j] \n";

   kc = 2;

   nval = 3.1;

   R[j][kc] = "$nval";

   <<"$j $kc R[j][kc] $R[j] \n";

   nval = 1.23;

   R->info(1);

   kc = 1;

   for (j= 0; j < 5; j++) {

     R[j][2+kc] = "$nval";

     R[j][kc] = "$nval";
!pnval

     <<"$j <|$nval|>\n";

     R->info(1);

     <<"$j $kc $R[j][2+kc] $nval \n";

     <<"$R[j]\n";

     R->info(1);

     wrd = R[j][kc];

     R->info(1);

     <<"%V $wrd  $nval\n";

     chkStr(wrd,"$nval",4);
 //ans=query()

     nval += 0.01;

     kc++;

     }

   j=5;

   wrd = R[j+1][kc-1];

   <<"$(j+1) $(kc-1)  \n";

   R->info(1);

   <<"%V $wrd  \n";

   <<"$R[6][1] \n";

   R->info(1);

   <<"$R\n";

   wrd = R[5][3];

   <<"<|$wrd|>\n";

   chkStr(wrd,"4.30",4);

   R->info(1);

   <<"$R[5][4]\n";

   chkStr(R[5][4],"4.300",4);

   chkOut();

//==============\_(^-^)_/==================//
