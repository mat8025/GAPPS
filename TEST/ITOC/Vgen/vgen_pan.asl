/* 
 *  @script vgen-pan.asl 
 * 
 *  @comment test vec gen of pan type 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.28 C-Li-Ni]                                
 *  @date 02/28/2021 08:19:42 
 *  @cdate 1/1/2021 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 


#include "debug"


if (_dblevel >0) {
   debugON()
}


 chkIn(_dblevel)


pan incr = 1.5;

pan starti = 1.0



<<"%V $incr $starti \n"


incr->info(1)

starti->info(1)



S=testargs(incr,starti)


<<"$S\n"



   vecp= vgen(PAN_,30,starti,incr)

   vecp->info(1)

<<" $vecp \n"

chkR(vecp[1],2.5)

incr = -1.5;

  vecp2= vgen(PAN_,30,starti,incr)

chkR(vecp2[1],-0.5)

starti = -1.0

  vecp3= vgen(PAN_,30,starti,incr)

chkR(vecp3[1],-2.5)

incr = 1.5;

  vecp4= vgen(PAN_,30,starti,incr)

chkR(vecp4[1],0.5)

chkOut()