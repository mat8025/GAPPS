
/* 
 *  @script pow.asl 
 * 
 *  @comment test pow and ^^ operator func 
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

db_allow = 0; // set to 1 for internal debug print
db_ask = 0

allowDB("opera_,array_parse,parse,rdp_,pex",db_allow)

vp = 2 * 4.2

vp.pinfo()

vp = pow(2,4.2)

vp.pinfo()

 v = 2^^4.2

  chkF(v,vp)

  chkF(v,18.379174)
  
  v.pinfo()

  v2 = 2^^(4.2)

  v2.pinfo()

  chkF(v2,18.379174)

 // chkOut(1)


 v3 = 2.0^^4.2

v3.pinfo()

v4= pow(2,4.2)

v5 = 2.0^^4.1

f= 4.1

v6 = 2.0^^f

f= 4.2

v7 = 2.0^^f

v8 = pow(2.0,f)

v9 = exp(2)

v10 = exp(f)

v11 = pow(exp(1.0),f)
<<"%V $vp $v $v2 $v3 $v4 $v5 $v6 $v7 $v8 $v9 $v10 $v11\n"

 chkR(v,vp)


asn=ask("^^ works as pow?",db_ask)


 chkR(v2,vp)



vp = pow(2,(4.2*2.1))

 v = 2.0^^ (4.2*2.1)

<<"$vp $v \n"

 chkF(v,vp)

chkStage("^^ == Pow ?")


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

int vi;

vi = 2^^5 ;

long vl;

vl = 2^^7 ;
vp = pow(2,5)

<<"%V $v $vp $vi $vl\n"


chkR(v,16.0)

chkN(vl,128)


chkOut()