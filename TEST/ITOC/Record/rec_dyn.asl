//%*********************************************** 
//*  @script rec_dyn.asl 
//* 
//*  @comment test record dynamic expansion 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                    
//*  @date Mon Feb 17 08:12:54 2020 
//*  @cdate Mon Feb 17 08:12:54 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%

#include "debug.asl"

   if (_dblevel >0) {

     debugON();

     }

   chkIn(_dblevel);

   Record R[>2] ;

   void recspecs()
   {
   cb = Cab(R);
   sz= Caz(R);
   <<"%V$sz $cb\n";
   R.pinfo();
   }

  recspecs();

  R[0] = Split("Ich gehe jeden Tag");

  recspecs();

  <<"$R\n";

  chkStr(R[0][3],"Tag");

  R[1] = Split("Je marche tous les jours");

  recspecs();

  <<"$R\n";

  <<"%V $R[1][2] \n";

  chkStr(R[1][2],"tous");

  R[2] = Split("Camino todos los dias");

  recspecs();

  <<"$R\n";

  chkStr(R[2][1],"todos");

  R[3] = Split("Gym five days a week");

  recspecs();

  <<"$R\n";

  chkStr(R[3][0],"Gym");

  R[15] = Split("Necesito correr más");

  recspecs();

  <<"$R\n";

  Ncols = 10;

  Delc = 44;

  B=ofw("junk.rec");

  <<"$R\n";

  nrw=writeRecord(B,R,@del,Delc,@ncols,Ncols);

  cf(B);

  chkStage();

  chkProgress("How Good");

  chkOut();

//==============\_(^-^)_/==================//
