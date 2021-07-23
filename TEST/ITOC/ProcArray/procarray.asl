/* 
 *  @script procarray.asl 
 * 
 *  @comment  
 *  @release CARBON 
 *  @vers 1.1 H Hydrogen [asl 6.3.42 C-Li-Mo]                               
 *  @date 07/14/2021 16:54:35 
 *  @cdate 07/14/2021 16:54:35 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 

///
///
///
<|Use_=
Demo  of proc with array call;
///////////////////////
|>


#include "debug.asl"


if (_dblevel >0) {
   debugON()
      <<"$Use_\n"   
}


chkIn(_dblevel);


   int Voo(int veci[],int k)
   {
     veci->info(1); 
     k->info(1);
     //Z->info(1) ;
     
<<"IN %V $k $veci \n"; 
//<<"IN  %V $Z\n"

      veci[1] = 47; 
      veci[2] = 79;
      veci[3] = 80;      
      veci->info(1); 


     <<"OUT %V $veci \n";


     rvec = veci[1];
     <<"OUT %V $rvec \n"; 
     return rvec; 
     }


vecM = vgen(INT_,10,0,1)

<<"$vecM \n"

int j = 77;

 fret = Voo(vecM,j) ;

  chkN(vecM[1],47)
    chkN(vecM[3],80)


<<"$vecM \n"

<<"%V$fret\n"


chkOut()