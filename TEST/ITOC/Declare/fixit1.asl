
char a = 'G'
char b = 'X'
char c = 'A'
char d = 'B'
char e

e = 'L'



<<" %d $a %x $a %c $a \n"

<<" %d $b %x $b %c $b \n"

<<" %d $e %x $e %c $e \n"




proc poo( x, y)
{
   if (x == y) {
     <<" that checks $x == $y \n"
   }
   else {

    <<" $x != $y \n"

   }

}


 poo (a,71)
 poo  (e,'L')
stop!

 poo (a, 'G')


 poo (b, 'X')


 poo (c, 'A')

 poo (d, 'B')


stop!




<<"$c $p $a \n"

<<"%X $c $p $a \n"


stop!



char dv[] = { 'G', 65,66,67, 'O', '0', 0 }


<<"$dv \n"
<<"$dv[0] \n"
<<"$dv[1] \n"

sz = Caz(dv)

<<"%V $sz \n"

<<"%I $dv \n"



 a = 'G'

<<"%I $a \n"

<<"%V $dv[0] $a \n"


;