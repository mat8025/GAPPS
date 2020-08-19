
int k = 3
int j = 4

 ma = memaddr(&k)

<<"%V$ma $k $j \n"

 memfill(ma,j)


<<"%V$k $j \n"





 val =memvalue(ma,"int")

<<"$val \n"

I = vgen(INT_,10,0,1)

 ma = memaddr(&I[0])

 val =memvalue(ma,"int")

<<"$val \n"

 val =memvalue(ma+1,"int")

<<"$val \n"

 val =memvalue(ma+2,"int")

<<"$val \n"

 val =memvalue(ma+3,"int")

<<"$val \n"

 val =memvalue(ma+4,"int")

<<"$val \n"

 val =memvalue(ma+8,"int")

<<"$val \n"