/* 
 *  @script lhrange.asl 
 * 
 *  @comment test lh range select 
 *  @release CARBON 
 *  @vers 1.16 S Sulfur [asl 6.3.60 C-Li-Nd] 
 *  @date 11/18/2021 07:01:39          
 *  @cdate 1/1/2001 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
                                                                




///////////////////////



#include "debug.asl"

   if (_dblevel >0) {

     debugON();

     }
     

  showUsage("Demo  of lhrange assignment")

   chkIn(_dblevel);

   N= 20;

   int RHV[N];

   int LHV[N];

   RHV= Igen(N,0,1);

   <<" %V$RHV \n";

   LHV = RHV;

   <<" %V$LHV \n";

   <<" %V$RHV \n";

   x= RHV[1];

   <<"%v$x\n";

   chkN(x,1);

   <<" %V$RHV[1] \n";

   <<" %V$RHV[2] \n";

   <<" %V$LHV[1] \n";

   <<" %V$LHV[2] \n";

   chkN(LHV[1],1);

   LHV[1] = RHV[7];

   <<" %V$LHV[1] \n";

   LHV[1:3] = RHV[7:9];

   <<" %V$LHV \n";

   chkN(LHV[1],7);

   <<" $RHV[12:14] \n";

   LHV[5:9:2] = RHV[12:14];

   <<" $LHV[5:9:2] \n";

   <<" $LHV \n";

   chkN(LHV[7],13);

//   TSN = RHV[1:5] + RHV[7:11];

   <<" $RHV[1:5:1] \n";

    <<" $RHV[7:11] \n";
   fileDB(ALLOW_,"opera_main","ds_arraycopy","rdp_l2","rdp_l5","rdp_l6","rdp_store","tokget","primitive");
      fileDB(ALLOW_,"rdp_l3","rdp_l4","rdp_l5","rdp_store","rdp_token");

     TSN = RHV[1:5:1] + RHV[7:11:1];

   <<"%v $TSN \n";

   chkN(TSN[1],10);

   TSN = RHV[0:-1:2] + RHV[1:-1:2];

   <<"%v $RHV \n";

   <<"%v $TSN \n";

   chkN(TSN[1],5);

   TSN = RHV[0:-1:] + RHV[1:-1:1];

   <<"%v $RHV \n";

   <<"%v $TSN \n";

   chkOut();

//===***===//
