
setdebug(1)

//float F[] = {1.0,2.0,3.0,4.0}
F= vgen(DOUBLE,100,0,0.25)
<<"$F\n"


   retype(&F,INT)

<<"$F\n"

<<"%X$F\n"

//   retype(&F,DOUBLE)
   F->retype(DOUBLE)

<<"$F\n"

