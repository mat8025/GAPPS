/* 
   *  @script while_nest.asl
   *
   *  @comment test while loops
   *  @release CARBON
   *  @vers 1.2 He Helium [asl 6.3.58 C-Li-Ce]
   *  @date 11/08/2021 11:27:24
   *  @cdate 1/1/2001
   *  @author Mark Terry
   *  @Copyright © RootMeanSquare  2010,2021 →
   *
   *  \\-----------------<v_&_v>--------------------------//
 */ 



#include "debug.asl"

   if (_dblevel >0) {

     debugON();

     <<"$Use_ \n";

     }

   chkIn(_dblevel);
///
///
///

   N=3;

   k= 0;

   while (1) {

     if (k >=N) {

       break;

       }

     k++;

     }

   chkN(k,N);


   k=0;

   n = 0;

   while (1) {

     k=0;

     done = 0;

     while (!done) {

       if (k <=N) {

         k++;

         }

       else {

         done =1;

         break;

         }

       }

     chkN(done,1);

     n++;

     if (n >5) {

       break;

       }

     <<"%V$k $n\n";

     }

   chkN(n,6);

   k.pinfo();

   chkOut();
