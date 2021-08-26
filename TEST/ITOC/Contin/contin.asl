/* 
 *  @script contin.asl 
 * 
 *  @comment 1.2 
 *  @release CARBON 
 *  @vers 0.0   [asl 6.3.42 C-Li-Mo]                                        
 *  @date 07/14/2021 17:19:16 
 *  @cdate 07/14/2021 17:19:16 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 

<|Use_=
Demo  of continue line 
///////////////////////
|>


#include "debug.asl"


if (_dblevel >0) {
   debugON()
      <<"$Use_\n"   
}




//
// continue line test
//

chkIn(_dblevel)

a = 5.0
b = 57

float c = a + b

<<" $a + $b = $c \n"

chkR(c,62,6)

  c = a * \
  b ;

<<" $a * $b = $c \n"

chkR(c,285,6)


  c = a / \
  b ;

chkR(c,0.087719,6)


<<" $a / $b = $c \n"

  c  = ( a+ b) / \
        (a - b);

<<" ($a + $b) / ($a - $b) = $c \n"

chkR(c,-1.192308,6)

  c  = ( a+ b)  \
       / (a - b);

<<" ($a + $b) / ($a - $b) = $c \n"

chkR(c,-1.192308,6)


   w1= scat("hey",\
   " buddy")
   <<"$w1\n"

chkStr(w1,"hey buddy")

   w2=					\
        scat("hey"," buddy ", "what's", \
       " going ", 		\
		   " on ?");
   <<"$w2\n"


   w3=                                                       \
        scat("hola"," amigo ", "que",                                        \
                   " esta ", 		                                       \
		   " pasando ?");

<<"$w3\n"


chkOut()


/*

 TBF -- can not comment out between sucessive continuation lines


*/