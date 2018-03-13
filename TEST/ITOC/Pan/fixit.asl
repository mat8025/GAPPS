///
///

setdebug(1,@trace)

pan denom = 1.0;

pan F = 1;

  N = atoi(_clarg[1]);

<<"%V $N\n"

 for (j =0 ; j < N ; j++) {
 
     F = F * (j+1);
 
<<"%V $j  $F  $denom\n"

     denom =  1.0/F;


//<<"%V $denom\n"
//T= vinfo(&denom)
//T= vinfo(denom)
//<<"$T\n"
 }

p = denom ;
<<"%V $p\n"

T= vinfo(&denom)
<<"$T\n"




<<"%V$denom \n"

