/* 
 *  @script vgen_pan.asl 
 * 
 *  @comment test vec gen of pan type 
 *  @release CARBON 
 *  @vers 1.3 Li Lithium [asl 6.3.59 C-Li-Pr] 
 *  @date 11/16/2021 21:17:03          
 *  @cdate 1/1/2021 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
 

#include "debug"

   if (_dblevel >0) {

     debugON();

     }

   chkIn();

   pan incr = 1.5;

   pan starti = 1.0;

   chkR(incr,1.5,1);

   pan pres = 2.5;

   pan pn;

   pn = starti + incr;

   <<"%V $pn  $incr $starti \n";

   chkR(pn,pres,1);

   pn.pinfo();

   incr.pinfo();

   starti.pinfo();

   S=testargs(&incr,starti);

   <<"$S\n";

   vecp2 = pgen(30,1.0,&incr);

   <<" $vecp2 \n";

   vecp= vgen(PAN_,30,1.0,1.5);

   <<" $vecp \n";

   vecp.pinfo();

   <<"$vecp[1] \n";

   chkR(vecp[1],2.5);

   incr = -1.5;

   vecp2= vgen(PAN_,30,starti,incr);

   chkR(vecp2[1],-0.5);

   starti = -1.0;

   vecp3= vgen(PAN_,30,starti,incr);

   chkR(vecp3[1],-2.5);

   incr = 1.5;

   vecp4= vgen(PAN_,30,starti,incr);

   chkR(vecp4[1],0.5);

   chkOut();

//===***===//
