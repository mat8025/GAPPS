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
//test using Compare


#include "debug.asl"

   if (_dblevel >0) {

     debugON();

     }
     

  showUsage("Demo  of lhrange assignment")

   db_allow = 0
   
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

   allowDB("spe,ic,pex,parse,array",db_allow)

   RHV.pinfo()

   <<"%V $RHV[12:14:1] \n";

//!b  allow margin code ops??



  ans=ask(" RHV[12:14] ? ",0);




   LHV[5:9:2] = RHV[12:14];

   LHV.pinfo()
   
   <<" $LHV[5:9:2] \n";

   <<" $LHV \n";

   chkN(LHV[7],13);

//   TSN = RHV[1:5] + RHV[7:11];

      RHV.pinfo()
	   
   <<" $RHV[1:5:1] \n"; // TBF  5/19/24  asl no vecprint  xic prints entire vec

    <<" $RHV[7:11] \n";





// FIXED 5/19/24 asl not making a local copy of each range for each item in RHS eqn!

     TSN = RHV[1:5:1] + RHV[7:11:1]; 

   <<"%V $TSN \n";

   chkN(TSN[0],8);
   
   chkN(TSN[1],10);
   
   chkN(TSN[2],12);
   
   chkN(TSN[4],16);   


    

   TSN = RHV[0:-1:2] + RHV[1:-1:2];  // 

   <<"%V $RHV \n";

   TSN.pinfo()

   <<"%V $TSN \n";

   chkN(TSN[1],5);

  // TSN = RHV[1:-1:] + RHV[1:-1:1]; // TBF 5/19/24 stride not cleared

   TSN2 = RHV[1:-1:1] + RHV[1:-1:1];

   <<"%V $RHV \n";

   <<"%V $TSN2 \n";
   TSN2.pinfo()
 
   chkOut();

//===***===//
