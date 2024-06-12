/* 
 *  @script oo_global_id.asl 
 * 
 *  @comment  
 *  @release CARBON 
 *  @vers 1.1 H Hydrogen [asl 6.3.46 C-Li-Pd]                               
 *  @date 08/09/2021 08:20:59 
 *  @cdate 08/09/2021 08:20:59 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 

<|Use_=
Demo  of include chain

///////////////////////
|>
                                                               

#include "debug"

if (_dblevel >0) {
   debugON()
   <<"$Use_\n"   
}

chkIn()


#include "finc.asl"

Turnpt  Wtp[10]; //



Wtp[1]->Print()
Wtp[8]->Print()

chkN(Ntp_id,10)
<<"%V$Ntp_id\n"
chkT(1)
chkOut()

exit()