/* 
   *  @script procarray.asl
   *
   *  @comment
   *  @release CARBON
   *  @vers 1.1 H Hydrogen [asl 6.3.42 C-Li-Mo]
   *  @date 07/14/2021 16:54:35
   *  @cdate 07/14/2021 16:54:35
   *  @author Mark Terry
   *  @Copyright © RootMeanSquare  2010,2021 →
   *
   *  \\-----------------<v_&_v>--------------------------//
 */ 
///
///
///

<|Use_=
   Demo  of proc with array call;
///////////////////////
|>

#include "debug.asl"

   if (_dblevel >0) {

     debugON();

     <<"$Use_\n";

     }

   chkIn();

   int Voo(int veci[],int k);

   {

     veci.pinfo();

     k.pinfo();


     <<"IN %V $k $veci \n";


     veci[1] = 47;

     <<"[1] %V $veci \n";

     veci[2] = 79;

      veci.pinfo();

     <<"[1,2] $veci[1] $veci[2] \n";
     <<" %V $veci \n";

     veci[3] = 80;

      veci.pinfo();
     <<"[1,2] $veci[1] $veci[2] $veci[3]\n";

     veci.pinfo();

     <<"OUT %V $veci \n";

     rvec = veci[1];

     <<"OUT %V $rvec \n";

     return rvec;

     }

   vecM = vgen(INT_,10,0,1);

   vecM.pinfo();

   int j = 77;

   vecM[1] = 24;

   vecM[2] = 48;

<<"$vecM \n";

      chkN(vecM[1],24);

       chkN(vecM[2],48);

   fret = Voo(vecM,j) ;

   chkN(vecM[1],47);

   chkN(vecM[3],80);

   <<"$vecM \n";

   <<"%V$fret\n";

 j = 3;

    if (j <= 4) {
<<"$j\n"

    }

   chkOut();
