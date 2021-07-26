
/* 
 *  @script caz.asl 
 * 
 *  @comment test Caz func 
 *  @release CARBON 
 *  @vers 1.6 C Carbon [asl 6.3.27 C-Li-Co] 
 *  @date 02/27/2021 09:36:03 
 *  @cdate Tue Mar 12 07:50:33 2019 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 

<|Use_=
Demo  of ^^ and pow   ;
///////////////////////
|>





#include "debug.asl"

if (_dblevel >0) {
   debugON()
    <<"$Use_\n"   
}

chkIn(_dblevel);


vp = 2 * 4.2
!p vp

vp = pow(2,(4.2))

 v = 2^^4.2
 v2 = 2.0^^(4.2)
  v3 = 2.0^^4.2


v4= pow(4.2,4.2)
<<"$vp $v $v2 $v3 $v4\n"

 chkR(v,vp)


 chkR(v2,vp)



vp = pow(2,(4.2*2.1))

 v = 2.0^^ (4.2*2.1)

<<"$vp $v \n"

 chkR(v,vp)




//setdebug(1)
a= 1.0;


 v = 2^^(a/12.0)


 chkR(v,1.059463)

vp = pow(2.0,(1.0/12))

<<"$v $vp\n"



 v = 2^^(11.0/12)

<<"$v\n"


 v = 2^^(12.0/12)

<<"$v\n"

 chkR(v,2)

 v = 2^^(12.01/12);

<<"$v\n"

 v2 = 2.0^^(12.01/12);

<<"%V $v $v2\n"



 v = 2^^(-12.0/12);

<<"$v\n"

 v = 2^^(24.0/12);

<<"$v\n"


 v = 2^^(-24.0/12);

<<"$v\n"

v = 2^^4

vp = pow(2,4)

<<"$v $vp\n"
chkR(v,16.0)


chkOut()