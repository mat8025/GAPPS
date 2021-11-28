//%*********************************************** 
//*  @script list-declare.asl 
//* 
//*  @comment test list declare 
//*  @release CARBON 
//*  @vers 1.3 Li Lithium [asl 6.2.68 C-He-Er]                               
//*  @date Sun Aug 30 14:37:21 2020 
//*  @cdate 1/1/2007 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
#include "debug"

   if (_dblevel >0) {

     debugON();

     }

   chkIn(_dblevel);

   str le;

   str le12;

   Mol = ( "JAN","FEB","MAR","APR" ,"MAY","JUN", "JUL", "AUG", "SEP", "OCT", "NOV" , "DEC" ) ;

   <<"List is $Mol \n";

   sz = caz(Mol);

   <<" %V $sz \n";

   <<"$(typeof(Mol)) size $(caz(Mol)) $sz \n";

   chkN(sz,12);

   <<"first month $Mol[0]\n";

   <<"second month $Mol[1]\n";

   <<"twelveth month $Mol[11]\n";

   le4 = Mol[3];
//<<"$(typeof(le4)) %V$le4\n"

   <<"le4 $le4 \n";

   chkStr(le4,"APR");

   le12 = Mol[11];

   <<"$(typeof(le12)) %V$le12\n";

   le = Mol[0];

   <<"$(typeof(le)) %V$le\n";

   chkStr(le,"JAN");

   <<"le checked\n";

   chkStr(Mol[0],"JAN");

   <<"Mol[0] checked\n";

   le = Mol[1];

   chkStr(le,"FEB");

   <<"$(typeof(le)) %V$le\n";

   chkStr("FEB",Mol[1]);

   <<"$Mol[1] Mol[1] checked\n";

   chkStr(Mol[1],"FEB");

   chkOut();
//////////////////////////////////

//===***===//
