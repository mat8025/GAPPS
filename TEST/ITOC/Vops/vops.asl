/* 
 *  @script vops.asl 
 * 
 *  @comment test vector ops 
 *  @release CARBON 
 *  @vers 1.3 Li Lithium [asl 6.3.62 C-Li-Sm] 
 *  @date 11/27/2021 10:05:43          
 *  @cdate Wed Apr 3 22:25:24 2019 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 


<|Use_=
   Demo  of vector ops;
///////////////////////
|>

#include "debug.asl"

   if (_dblevel >0) {

     debugON();

     <<"$Use_\n";

     }

   chkIn();

   PFIV = Igen(10,0,1);

   <<"$PFIV \n";

   chkN(PFIV[0],0);

   chkN(PFIV[9],9);

   PFIV = PFIV + 2;

   <<" $PFIV \n";

   chkN(PFIV[0],2);

   PFIV += 3;

   <<" $PFIV[::] \n";

   chkN(PFIV[0],5);

   PFIV[3] = 4;

   <<" $PFIV[::] \n";
//<<" $PFIV[0] \n"
//<<" $PFIV[3] \n"
// FIXME

   PFIV[3] = -3;

   <<" $PFIV[::] \n";

   PFIV *= 2;

   <<" $PFIV[::] \n";

   chkN(PFIV[0],10);

   PFIV = PFIV * 2;

   <<" $PFIV \n";

   chkN(PFIV[0],20);

   PFIV /= 4;

   <<" $PFIV \n";

   chkN(PFIV[0],5);
//%*********************************************** 
//*  @script vopsele.asl 
//* 
//*  @comment test vector ops 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                  
//*  @date Wed Apr  3 22:26:49 2019 
//*  @cdate Wed Apr  3 22:26:49 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
/*
   set() ~ sets values in a vector or a scalar()
   V->set(value)
   V[3]->set(value)
   V[1:20:2]->set(value_vec)
   V[1:20:2]->set(value_vec,incr)
   sets elements of a variable to supplied value vector.
   if the variable is a scalar then just its value is set.
   Can be used to set a specified element of the variable array,
   or a subrange or the entire array.
   The initial vaue can be incremented at each set step to create a series.
//===================================//
*/

// leading > make it a dynamic expandable array

   int J[>20];

   J[0:30:].Set(12,2)  ;   // TBF XIC version does not fill in stride and fails ??;

   <<"$J \n";

   J[0:30:1].Set(10,2);

   chkN(J[30],70);

   J.pinfo();

   <<"$J \n";

   int sum;

   <<"%V$sum \n";

   sum = J[1] + J[2];

   <<"  %V$sum = $(J[1]) + $(J[2])   \n";

   chkN(sum,26);

   chkOut();

   sum = J[2] + J[1];

   <<"  %V$sum = $J[2] + $J[1]   \n";

   chkN(sum,26);

   sum = J[1] + J[2] + J[3];

   <<"  %V$sum = $J[1] + $J[2] + $J[3]  \n";

   chkN(sum,42);

   sum = J[3] + J[2] + J[1];

   <<"  %V$sum = $J[3] + $J[2] + $J[1]  \n";

   chkN(sum,42);

   sum = J[1] + J[2] + J[3] + J[4];

   <<"  %V$sum = $J[1] + $J[2] + $J[3] + $J[4] \n";

   chkN(sum,60);

   sum = J[2] + J[1] + J[4] + J[3];

   <<"  %V$sum = $J[2] + $J[1] + $J[4] + $J[3] \n";

   chkN(sum,60);

   int k = 11;

   sum = J[2] + J[1] + k + J[4] + J[3];

   <<"  %V$sum = $J[2] + $J[1] + $k + $J[4] + $J[3] \n";

   chkN(sum,71);

   sum = k + J[2] + J[1]  + J[4] + J[3];

   chkN(sum,71);

   sum = J[2] + J[1]  + J[4] + J[3] + k;

   chkN(sum,71);

   chkOut();

//===***===//
