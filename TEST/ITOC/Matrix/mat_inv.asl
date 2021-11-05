/* 
 *  @script mat_inv.asl 
 * 
 *  @comment test matrix inverse func 
 *  @release CARBON 
 *  @vers 1.1 H Hydrogen [asl 6.3.58 C-Li-Ce]                               
 *  @date 11/03/2021 09:11:20 
 *  @cdate 11/03/2021 09:11:20 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 

;//----------------------//;

<|Use_= 
Demo  of test matrix inverse func 
/////////////////////// 
|>

#include "debug" 
if (_dblevel >0) { 
   debugON() 
   <<"$Use_ \n" 
} 

chkIn(_dblevel)


 float M[] = {4,7,2,6} 

<<"$M\n"

  M.redimn(2,2)


<<"M= $M\n"
  T =M

<<"T= $T\n"

  IM = Minv(M)

<<"M= $M\n"


chkR(IM[0][0],0.6)
chkR(IM[1][0],-0.2)

<<"IM =$IM \n"


  IDM = M * IM;

<<"$IDM \n"
chkR(IDM[0][0],1.0)
chkR(IDM[1][1],1)


mprt(IM)

chkOut()









R= Dgen(25,1,1)

 <<" $(typeof(R)) \n"

 <<"%v \n $R \n"

  Redimn(R,5,5)


 <<"%r %6.1f \n $R \n"

<<" minv \n"

  V=  Minv(R)


<<"%r%6.1f \n $V \n"



