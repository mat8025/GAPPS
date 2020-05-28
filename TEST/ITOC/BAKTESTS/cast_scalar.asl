
setdebug(2)

float a = exp(1.0)

<<"%V$a $(typeof(a)) \n"


 int b

  b = a


<<"%V$b $(typeof(b)) \n"


  c = a


<<"%V$c $(typeof(c)) \n"

  d = cast(a,INT)


<<"%V$d $(typeof(d)) \n"


  e = cast(a,DOUBLE)


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