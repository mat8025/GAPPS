#! /usr/local/GASP/bin/asl

SetDebug(0)

tt = $2
N = $3

M = 2 * N

<<"%V $tt $N \n"

#{

just some
 comments

#}


<<" $tt times table \n"
//tt =3

int k = 0

a = 3

b = 3 ; c = a * b

<<" %v $c \n"

 while ( k < M ) {

   k++
  if (k < M ) {
   if ( k > N ) { 
 <<" attempting break ! $k > $N \n"
    break
   <<" should not see this !\n"
   }

//<<" out of if $k \n"

  a= k * tt

 <<" $k * $tt = $a \n"
   }

 }



<<" DONE %V $k  $N $M \n"


STOP("DONE\n")

