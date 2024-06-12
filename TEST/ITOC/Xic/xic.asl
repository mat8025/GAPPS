/* 
 *  @script xic.asl 
 * 
 *  @comment speed test 
 *  @release CARBON 
 *  @vers 1.8 6.3.71 C-Li-Lu 
 *  @date 01/13/2022 10:40:07          
 *  @cdate 01/12/2022 13:31:20 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2022
 * 
 */ 
;//----------------<v_&_v>-------------------------//;                   
 
//1234//////////////////////////////////////////////

<|Use_= 
Demo  of speed test 
/////////////////////// 
|>

#include "debug"
#include "hv"


  if (_dblevel >0) { 
   debugON() 
   <<"$Use_ \n" 
} 

   allowErrors(-1); 

  chkIn()

myscript = getScript();

<<"%v$myscript \n"


  chkT(1);


 

////
////   speed test
////


int a = 1;
int b = 2;

int c = 1;

int i;

//N= 100;
N= 10000;

  for (i = 0; i < N; i++) {

   c = a * b;
   a++;
    b++;
   if ( (i % 1000) == 0) {
   <<" $c = $a * $b \n";
  }
  }

chkT(1)

chkOut()



//// 11/3/21  2137 msecs
///  2161 -- coded opera_ic_multiply
///  2466
///  2489
///  2248