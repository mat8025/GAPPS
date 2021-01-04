

N = atoi(_clarg[2])
tt = atoi(_clarg[3])
M = 2 *N

<<"%V $tt $N \n"

/*

just some
 comments


*/


<<" $tt times table \n"
//tt =3

int k = 0

a = 3

b = 3 ; c = a * b

<<" %v $c \n"

k++

  for (k = 1; k < M ; k++) {

<<" for begin loop val $k < $M \n"

   if ( k > N ) { 
 <<" attempting break out ! $k > $N \n"
    break
// continue
 <<" should not see this !\n"
   }

//<<" out of if $k \n"

  a= k * tt

 <<" $k * $tt = $a \n"

 }




<<" DONE %V $k  $N $M \n"


///////////////////////////////
