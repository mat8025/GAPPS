///
///
///


#include "debug"


if (_dblevel >0) {
   debugON()
}

 dballow = 1;
 chkIn()
allowDB("opera_,spe_,str_,array_parse,parse,rdp_,pex,ic",db_allow);

 Vec<float> fv(10,0,1)


 fv.pinfo()

<<"$fv \n"

  chkR(fv[1],1.0)

 fv[0] = -32;
 fv[2] = 77;
 fv[3] = 80;

<<"$fv \n"

chkN(fv[3],80)

vs = version()

pi =  atan(1.0) 

pi2 =  asin(1.0) 

<<" %V $vs $pi $pi2 \n"

<<" $(version()) $(asin(1.0)) \n"

chkOut(1)


