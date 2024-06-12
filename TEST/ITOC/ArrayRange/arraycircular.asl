/* 
   *  @script arraycircular.asl
   *  @comment test vector range spec - forward,backward
   *  @release CARBON
   *  @vers 1.2 He Helium [asl 6.3.42 C-Li-Mo]
   *  @date 07/14/2021 16:12:25
   *  @cdate Tue Jun 25 18:48:42 2019
   *  @author Mark Terry
   *  @Copyright © RootMeanSquare  2010,2021 →
   *  \\-----------------<v_&_v>--------------------------//
 */ 

   
<|Use_=
   Demo  of vector range  e.g. V[0:10:2] = 5;
///////////////////////
|>

#include "debug"

   if (_dblevel >0) {

     debugON();

     <<"$Use_\n";
 }


//filterFileDebug(REJECT_,"scope","args","rdp","exp");		
//filterFileDebug(REJECT_,"ds_sivbounds","ds_sivmem","exp_lhs_e");

   chkIn();

int do_minus_range =1;
int do_test = 0;



   B=vgen(INT_,100,0,1);
   
//Vec B(INT_,10,0,1)  // TBF 11/06/21  XIC crash

   B.pinfo();


    C = B[::];
    

   <<"%V$B\n";

   <<"%V$C\n";

    D= C[2:20:]
    
<<"%V$D\n";

<<"%V$D[::]\n";

<<"%V$D[2:-1:2]\n";

chkN(C[23],B[23])


chkOut()



if (do_test) {
   chkN (B[0],0);

   chkN (B[4],4);
}
    D= B[-2:1:-1];

   <<"%V$D\n";

   <<"%V$B[-1:0:-1]\n";
if (do_test) {
   chkN (D[0],8);

   chkN (D[2],6);
}
   <<"circular buffer  $B[-1:8:1] \n";

   B.pinfo();

   <<"%V$B \n";

 //  E= B[-42:9:1];
   E= B[-42:9:1];

<<"%V$E\n";

     E2= B[-4:9:1];

<<"%V$E2\n";
neg_start = 1;
if (bad_neg_start) {
     E3= B[-2:9:1];
}
else {
      E3= B[98:9:1];
}
<<"%V$E3\n";



B.pinfo()

   Z= B[-1:7:1]; //[-1:7:1]

   <<"%V$Z\n";
if (do_test) {
   chkN(Z[0],9);

   chkN(Z[1],0);

   chkN(Z[2],1);

   chkN(Z[3],2);
}


   E= B[-1:8:1];

   <<"%V$E\n";

//   chkN (E[0],9);

   B.pinfo()
   
   F= B[-1:8:1];  // crash

   <<"%V$F\n";

   D.pinfo();

   D[11] = 7;

   D.pinfo();
   B.pinfo();
   
//<<"before  D= B[-1:8:1]; \n"

<<"before  D = B[-10:8:1]\n"
  D = B[-1:8:1];
 //D= B[90:8:1]; 

  <<"%V$D\n";

   D.pinfo();


 <<"B[-1:2:1] $B[-1:2:1]   \n";
if (do_test) {
   chkN (D[0],9);

   chkN (D[1],0);

   chkN (D[2],1);

   chkN (D[3],2);
}
chkT(1)
chkOut()
