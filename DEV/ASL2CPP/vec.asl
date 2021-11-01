/* 
 *  @script vec.asl 
 * 
 *  @comment vec input to cpp convertor 
 *  @release CARBON 
 *  @vers 1.1 H Hydrogen [asl 6.3.58 C-Li-Ce]                               
 *  @date 10/29/2021 11:27:05 
 *  @cdate 10/29/2021 11:27:05 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
;//----------------------//;
<|Use_= 
Demo  of vec input to cpp convertor 
/////////////////////// 
|>

#include "debug" 
if (_dblevel >0) { 
   debugON() 
   <<"$Use_ \n" 
} 

chkIn(_dblevel)




////

  Mat MA(INT_,5,4);

MA.pinfo()

  Vec V(DOUBLE_,10,10,1)


  V[2] = 76
  V[8] = 44
  V[9] = 90

int i = 48

 V.pinfo()


 V[1:9:2] = i;

 V.pinfo()

Mat MA(INT_,5,4)

Mat MB(INT_,5,4)

//Mat T(M);

       M = 78;
       M[2][3] = -47;

  MA [ 12: 18 :2] [1:3:1 ] =  MB [ 11: 17 :2] [2:5:1 ]




int addem (int k, int m)
{

   n = (k+m);

  return n;

}



exit()
