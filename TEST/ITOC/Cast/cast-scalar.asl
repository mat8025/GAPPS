/* 
 *  @script cast-scalar.asl 
 * 
 *  @comment test cast function 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.16 C-Li-S]                                 
 *  @date Thu Feb  4 20:23:21 2021 
 *  @cdate 1/1/2006 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 

chkIn()

float a = exp(1.0)

<<"%V$a $(typeof(a)) \n"


 int b

  b = a


<<"%V$b $(typeof(b)) \n"


  c = a


<<"%V$c $(typeof(c)) \n"

  d = cast(INT_,a)

chkN(b,d)

<<"%V$d $(typeof(d)) \n"


  e = cast(DOUBLE_,a)

chkR(e,a)

<<"%V$e $(typeof(e)) \n"

int k = 3
float f = 2.0
 k = a
   <<"%V  $b $(typeof(b)) \n"
   <<"%V  $f $(typeof(f)) \n"
   <<"%V  $a $(typeof(a)) $k\n"

  for (i = 0; i < 4 ; i++) {

    //b = (a *  (i+1))
    b *= a
    f *= a

  <<"%V $i $b $(typeof(b)) $f $(typeof(f)) $k\n"

   k  = a + k

  }

chkOut()

exit()