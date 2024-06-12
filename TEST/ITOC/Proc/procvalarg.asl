

///
/// procvalarg
#include "debug"

   allowErrors(-1) ; // keep going;

   if (_dblevel >0) {

     debugON();


     }

   chkIn();

 showUsage("How to use val args") ;



 int sumarg (int vi, int ui)
   {

     <<"val args int %V  $vi $ui \n";

     vi.pinfo();

     ui.pinfo();


     int zi;

     zi.pinfo();

     zi = vi + ui;

     zi.pinfo();

     vi.pinfo();

     ui.pinfo();

     <<"%V$vi + $ui = $zi\n";

//   v++;

     vi = vi +1;

     <<" changing first arg to %V$vi\n";

     vi.pinfo();

     ui = ui * 2;

     <<" changing second arg to %V$ui \n";

     ui.pinfo();

     <<"args out %V$vi $ui $zi\n";


     return zi;

     }
//=======================//

<<"should be calling summarg int args vers with  val args\n";

   <<"IN %V $n $m $p \n";


   int o = 4;

   int q = 7;

   fileDB(ALLOW_,"spe_proc")

   p = sumarg(o,q);

   <<"returned %V $o $q $p \n";

   chkN(o,4);

   chkN(q,7);

   chkN(p,11)

   chkOut()

   exit()
