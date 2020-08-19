#! /usr/local/GASP/bin/spi


tt = $2
N = $3

M = 2 *N
<<"%V $tt $N \n"

#{

just some
 comments


#}


<<" $tt times table \n"
//tt =3

int k = 0

a = 2

b = 3 ; c = a * b

<<" %v $c \n"

 while ( k < M ) {

   k++

   if ( k > N ) { 
    break
   }

  a= k * tt

 <<" $k * $tt = $a \n"

 }


STOP!


///////////////////////////////
#{

   if ( k > N ) {
<<" $k breaking out ! \n"
    break
   }





#}
