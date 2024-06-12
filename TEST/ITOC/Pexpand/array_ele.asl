///
///
///

#include "debug.asl"




   chkIn();

   chkT(1);

   nd = 10;

   int index[nd];

   index = 0;

   index.pinfo();

   <<"%V $index \n";

    index[7] += 1;
    
<<"%V $index \n";

<<"%V $index[0] $index[1] $index[2] $index[7] $index[9] \n";

askit(1)

   a = index[0];

   <<" %V $a\n";

   chkN(a,0);


   a = index[7];

   <<" %V $a\n";

   chkN(a,1);

   index[8] += 2

   index.pinfo();

   <<"%V $index \n";

   chkN(index[8],2);


   index[0] = 787;

   a = index[0];

   <<" %V $a\n";

   chkN(a,787);

   <<"%V $index \n";

   index.pinfo();
    // index[0] += 1;

   index[1] = 1689;

   <<"%V $index \n";

   chkN(index[1],1689);

   index.pinfo();

   a = index[0];

   <<" %V $a\n";

   index.pinfo();

   a = index[0];

   index[0] += 2;

   <<"after += \n";

   chkN(index[0],a+2);

   <<"%V $index \n";

   index.pinfo();

   <<"%V $index \n";

   a = index[3];

   index[3] += 3;

   chkN(index[3],a+3);

   <<"%V $index \n";

   a = index[4];

   index[4] += 2;

   chkN(index[4],a+2);

   chkN(index[5],0);

   chkN(index[9],0);

   <<"%V $index \n";

   index.pinfo();

   b = index[0];

   <<" %V $b\n";

   index.pinfo();

   <<"%V $index \n";

   chkOut("ArrayELE OK?");
///
///
///

//==============\_(^-^)_/==================//
