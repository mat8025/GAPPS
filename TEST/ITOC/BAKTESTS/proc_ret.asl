#! /usr/local/GASP/bin/asl


proc foo(x,y)
{

   z = x * y

   return z
}




  a = foo(2,3)


<<"%v $a \n"

   j = 1
   n = 12
   while (j < 4) {

      a = foo(j,n)


<<" $j * $n  = $a\n"
    j++
   }


STOP("DONE \n")



