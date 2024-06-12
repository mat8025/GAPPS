/* 
 *  @script arrayjoin.asl                                               
 * 
 *  @comment test array join                                            
 *  @release Boron                                                      
 *  @vers 1.3 Li Lithium [asl 5.91 : B Pa]                              
 *  @date 03/23/2024 10:01:54                                           
 *  @cdate Fri May 1 07:35:20 2020                                      
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2024 -->                               
 * 
 */ 

                                                                       
#include "debug"

   if (_dblevel >0) {

     debugON();

     }

   chkIn();

   N = 20;

   YV = Igen(N,21,1);

   <<"%v $YV \n";

   vi = 5;

   int PV[10];

   PV[1] = 1;

   PV[2] = 2;

   PV[3] = 3;

   PV[8] = 8;

   PV[9] = 9;

   YV[0] = 74;

   <<"%V $PV \n";

   NV = YV @+ PV;

   <<"%V $NV \n";

   sz = Caz(NV);

   <<"%v $sz \n";

   <<"%v $NV[29] \n";

   chkN(NV[19],40);

   chkN(NV[29],9);

   <<"%v $NV \n";

   chkN(sz,30);



   <<" $YV \n";

   <<" $NV[2] \n";

   <<" $NV[22] \n";

   <<"%V $YV \n";

   <<"%V $PV \n";

//   YV = YV @+ PV;

 //   YV.join(PV)

   ysz= Caz(YV)
   <<"%V $ysz \n"

   vvcat(YV,PV)
    
   <<"%V $YV \n";
   <<"%V $PV \n";   

ans = ask("YV cat PV ?\n",0)


     allowDB("array,ic",0)

   <<" %v $PV \n";

   S = YV[PV];

   <<" %v $S \n";
   <<" %v $PV \n";


   chkN(NV[1],YV[1]);

   chkN(NV[2],YV[2]);

<<"%V $PV\n"
<<"%V $NV\n"

   chkN(NV[21],PV[1]);

<<"%V $NV[21]   $PV[1] \n"

   chkOut(1);


//==============\_(^-^)_/==================//';