

#include "debug"

   if (_dblevel >0) {

     debugON();

     }

chkIn();

   int k = 0;
   
   
    while (1) {

<<"loop start $k\n";

      if (k > 3) {

       <<"break $k\n";

       break;

       }

     k++;

     <<"loop end $k\n";

     }


 chkN(k,4);

  chkOut();
