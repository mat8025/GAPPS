/* 
 *  @script cast-vec.asl 
 * 
 *  @comment Test Cast of vector 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.16 C-Li-S]                                 
 *  @date Fri Feb  5 08:21:34 2021 
 *  @cdate 1/1/2007 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 



#include "debug"



chkIn(_dblevel)

int a = 1.0

float f = 3.1

<<"%V $a $(typeof(a)) \n"

  a += f
  
<<"%V $a $(typeof(a)) \n"


chkN(a,4.1)


VI = dgen(10,0,1)

<<"$VI \n"
 a= VI[1]


<<"%V $a $(typeof(a)) \n"

 a += VI[2]

<<"%V $a $(typeof(a)) \n"

  for (i = 1; i < 5; i++) {

    a += VI[i]

<<"%V $a $(typeof(a)) \n"

  }

chkN(a,13)


float b = 1.0

int m = 3

<<"%V $b $(typeof(b)) \n"

  b += m
  
<<"%V $b $(typeof(b)) \n"


chkN(b,4.0)

IV = igen(10,0,1)

<<"%V$IV \n"

VI = igen(10,0,1)

<<"%V$VI \n"
 b= VI[1]


<<"%V $a $(typeof(a)) \n"

 b += VI[2]

<<"%V $b $(typeof(b)) \n"

  for (i = 1; i < 5; i++) {

    b += VI[i]

<<"%V $b $(typeof(b)) \n"

  }

b->info(1)

<<"%V $b $(typeof(b)) \n"
//chkStage("??")

  chkR(b,13.0)




chkOut()