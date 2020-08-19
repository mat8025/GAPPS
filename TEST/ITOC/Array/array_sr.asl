//%*********************************************** 
//*  @script array_sr.asl 
//* 
//*  @comment test select_range 
//*  @release CARBON 
//*  @vers 1.16 S Sulfur                                                  
//*  @date Sat Mar  9 16:54:34 2019 
//*  @cdate 1/1/2001 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
  
  
include "debug"

if (_dblevel >0) {
   debugON()
}


  
  chkIn(_dblevel); 
  
  I = vgen(INT_,10,0,1); 
  
  <<"%V$I \n"; 
  
  K = I[2:8]; 

  K->info(1)
 
  <<"%V$K\n"; 
  
   chkN(K[0],2); 
  
   K = I[6:1:-1]; 

   K->info(1)

  <<"%V$K\n";
  <<"K0 $K[0]\n"
  <<"K5 $K[5]\n"
  k = K[5];
  <<"%V $k $K[5]\n"
  chkN(K[0],6); 
  chkN(K[1],5); 
  chkN(K[5],1); 
  
   K = I[6:1:1]; 

   K->info(1)

  <<"%V$K\n"; 
  
  chkN(K[0],6); 
  chkN(K[1],7); 
  chkN(K[5],1); 
  
  chkOut(); 
  
//======================================//