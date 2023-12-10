//%*********************************************** 
//*  @script rec_prt.asl 
//* 
//*  @comment test record print 
//*  @release CARBON 
//*  @vers 1.2 He Helium [asl 6.2.61 C-He-Pm]                                
//*  @date Tue Jun 30 10:19:19 2020 
//*  @cdate 1/1/2017 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%

   myScript = getScript();

   chkIn(_dblevel);

   record R[5];

   R[0] = Split("each to his own");

   R[1] = Split("and the devil take the hindmost");

   R[2] = Split("you are as strong as your will");

   R[3] = Split("this is the 4th record");

   R[4] = Split("and the 5th record next");

   wrow= 1;

   wcol=2;

   R.pinfo();

   val = R[wrow][wcol];

   wrd= "$R[wrow][wcol]";

   R.pinfo();

   <<"$wrow $wcol  $val <|$wrd|>\n";

   chkStr(wrd,"devil");

   <<"%V$R[0]\n";

   <<"%V$R[0][0] \n";

   <<"%V$R[0][1] \n";

   <<"%V$R[1]\n";

   <<"%V$R[1][2] \n";

   <<"%V$R[1][3] \n";

   <<"; /////\n";

   for (wrow =0; wrow <4; wrow++) {

     for (wcol =0; wcol <4; wcol++) {

       wrd= "$R[wrow][wcol]";

       <<"%V$wrow $wcol $R[wrow][wcol] $wrd\n";

       }

     }

   wrd= "$R[1][2]";

   <<"%V [1][2]  $wrd\n";

   wrow = 1;

   wcol = 2;

   R.pinfo();

   wrd= "$R[wrow][wcol]";

   R.pinfo();

   <<"%V$wrow $wcol  $wrd\n";

   chkStr(wrd,"devil");

   wrow = 3;

   wcol = 4;

   wrd= "$R[wrow][wcol]";

   chkStr(wrd,"record");

   <<"%V $R\n";

   <<"%V $R[::]\n";

   <<"; /////\n";

   <<"%V$R[1]\n";

   <<"%V$R[2]\n";

   <<"%V$R[3]\n";

   <<"; /////\n";

   <<"%V$R[1][::]\n";

   <<"%V$R[1][0] \n";

   <<"%V$R[1][3] \n";

   <<"%V$R[2][2] \n";

   <<"%V$R[3][4] \n";

   <<"%V\n $R[1:4:][::]\n";

   <<"R[1:4:][1:3:]\n";

   <<" $R[1:4:][1:3:]\n";

   chkOut();

//==============\_(^-^)_/==================//
