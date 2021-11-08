/* 
 *  @script vec.asl 
 * 
 *  @comment test vec class 
 *  @release CARBON 
 *  @vers 1.1 H Hydrogen [asl 6.3.58 C-Li-Ce]                               
 *  @date 11/05/2021 08:01:43 
 *  @cdate 11/05/2021 08:01:43 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 

;//----------------------//;

<|Use_= 
Demo  of test vec class 
/////////////////////// 
|>


#include "debug" 
if (_dblevel >0) { 
   debugON() 
   <<"$Use_ \n" 
} 


chkIn(_dblevel)

Vec V(INT_,12,255,0)


V.pinfo()


chkN(V[0],255)
chkN(V[11],255)

n = 12;
n.pinfo()
m = 255;

Vec U(INT_,n,m,0) ; 
//NIF 11/05/21 - declare via function
U.pinfo();

chkN(U[0],255)
chkN(U[11],255)



chkOut()
