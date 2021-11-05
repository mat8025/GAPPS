/* 
 *  @script compare.asl 
 * 
 *  @comment test compare ops 
 *  @release CARBON 
 *  @vers 1.1 H Hydrogen [asl 6.3.58 C-Li-Ce]                               
 *  @date 11/04/2021 16:43:09 
 *  @cdate 11/04/2021 16:43:09 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 

;//----------------------//;

<|Use_= 
Demo  of test compare ops 
/////////////////////// 
|>


#include "debug" 
if (_dblevel >0) { 
   debugON() 
   <<"$Use_ \n" 
} 

chkIn(_dblevel)

/////////////






////   <= != >=  ===
chkIn(_dblevel) 

a = 1;

b = 2;

   if (b > -3) {

    <<" %Vb  > -1 \n"
     chkT(1)
   }


   if (a != -1) {
    <<" %Va != -1 \n"
     chkT(1)
   }




   if (b >=  -1) {

    <<" %Vb  >= -1 \n"
     chkT(1)
   }

   if (b == 2  ) {

    <<" %Vb == 2 \n"
     chkT(1)
   }

   if (b >  a) {

    <<" %V $b  > $a \n"
     chkT(1)
   }


   if (a <  b) {

    <<" %V $a  > $b \n"
     chkT(1)
   }



chkOut()




 