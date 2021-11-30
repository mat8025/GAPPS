/* 
 *  @script m3d_assign.asl 
 * 
 *  @comment test substitute func 
 *  @release CARBON 
 *  @vers 1.4 Be Beryllium [asl 6.3.59 C-Li-Pr] 
 *  @date 11/14/2021 20:00:49          
 *  @cdate Tue Mar 12 07:50:33 2019 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */
 
<|Use_=
   Demo  M3D 
|>



#include "debug";

   if (_dblevel >0) {

     debugON();

 <<"$Use_\n";
 
     }

   allowErrors(-1);

   chkIn(_dblevel);


   nrows = 7;

chkT(0)

   n_feat = 8;

   int Nit[nrows][n_feat];

   int Nic[5][100][n_feat];

   Nit[1:4:][0] = 47;

   chkN(Nit[1][0],47);

   Nit[::][0] = 2;

   chkN(Nit[1][0],2);

   Nit[::][7] = 7;

   Nit[::][3] = 79;

   fail1 = 0;

   fail2 = 0;

<<"$Nit \n"


   for (k = 0; k < nrows; k++) {

     for (i = 0; i < n_feat; i++) {

       Nit[k][i] = i+k;

       }

     }




<<"$Nit \n"

   for (k = 0; k < nrows; k++) {

     for (i = 0; i < n_feat; i++) {

//       chkN(Nit[k][i], (i+k));
<<"$k $i  $Nit[k][i]  $(i+k)\n"
       }

     }




   <<"$Nit[i][0:7:] \n";
   kc = 0;

   kci = 0;

   i = 0;

   <<"%V$i \n";

   i++;

   <<"%V $Nic[kc][kci][2] \n";


   <<"$Nit[i][0:7:] \n";

   <<"$Nit[2:5][0:7:] \n";

   <<"%V$kc $kci $i\n";


   Nic[kc][kci][0] = Nit[i][0];

   Nic[kc][kci][1] = Nit[i][2];

   <<"%V $Nic[kc][kci][0] $Nit[i][0] \n"

   <<"%V $Nic[kc][kci][1] $Nit[i][2] \n"
   chkN(Nic[kc][kci][1],Nit[i][2])



   Nic[0:4][0:9][1] = Nit[i][2];

   <<"%V $Nic[3][kci][1] \n";

   Nic[1][2][0:7:1] = Nit[i][0:7:1];

   kci = 4;

   kc = 3;

   Nic[kc][kci][0:7:1] = Nit[i][0:7:1];

   <<"%V $Nic[kc][kci][0:7:] \n";

   i++;

   <<"%V$i\n";
//<<"%V$i $Nit[i][0:7:] \n"

   Nic[kc][kci][::] = Nit[i][::];

   <<"%V $Nic[kc][kci][2] \n";
 
   <<"%V $Nic[kc][kci][0:7:] \n";
   <<"%V $kc  $kci \n"
 Nic.pinfo()   

   Nic[kc][kci][0:5:] = Nit[i][2:7:];
//  <<"%V$i $Nit[i][0:7:] \n"

   <<"%V $Nic[kc][kci][0:7:] \n";

   i++;

   Nic[kc:kc][kci][0:5:] = Nit[i][2:7:];

   <<"%V$i $Nit[i][2:7:] \n";

   <<"%V $Nic[kc][kci][0:5:] \n";

   <<"%V$i $Nit[i][2] \n";

   <<"%V $Nic[kc][kci][0] \n";


   chkN(Nic[kc][kci][0] ,Nit[i][2]);


   for (i = 0 ; i < nrows ; i++) {

     <<"%V$i $kc $kci \n";

     <<"%V$Nit[i][0:7:] \n";

     Nic[kc:kc][kci][::] = Nit[i][::];

     <<"%V $Nic[kc][kci][0:7:] \n";
//   x= Nic[kc][kci][0] = 47

     for (j = 0; j < n_feat ; j++) {

<<"%V $kc $kci $j \n"
       x= Nic[kc][kci][j];

       y= Nit[i][j];

       if (x != y) {

         fail1=1;

         }

       }

     if (fail1) {

       <<"%V$fail1 \n";
//ans =iread()

       }

     }

   if (fail1) {

     <<"%V$fail1 \n";
//ans =iread()

     }

   for (i = 0 ; i < nrows ; i++) {

     Nic[kc:kc][kci][0:5:] = Nit[i][2:7:];

     <<"$Nit[i][0:7:] \n";
 // <<"sp $Nic[kc][kci][0:7:] \n"
//i_read()

     x1= Nic[kc][kci][0];

     y1= Nit[i][2];

     if (x1 != y1) {

       fail2++;
//	iread()

       <<"%V$x1 $y1 \n";

       <<"sp $Nic[kc][kci][0:7:] \n";

       }

     if (fail2) {

       <<"%V$fail2 \n";
//ans =iread()

       }

     kci++;

     }

   <<"%V$fail1 $fail2\n";

   chkN(fail1,0);

   chkN(fail2,0);

   chkT(1);

   chkOut();

//===***===//
