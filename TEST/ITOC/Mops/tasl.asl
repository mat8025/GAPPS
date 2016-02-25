#! /usr/local/GASP/bin/asl
#/* -*- c -*- */

a = 0
b = 1

<<" %V $a $b \n"
 while (a > -2) {
<<" first in while %v $a\n"
 a--
<<" after a-- %v $a\n"
   if ( b > 0) {
<<" while-if TRUE $b \n"
    b++
   }
   else {
<<" while-else  $b \n"
   }
// a comment line does it cause problems
<<" last in while %v $a\n"
// another comment line does it cause problems
 }


STOP("DONE \n")



N =$2
y = 1

eq = 0
neq = 0
ntest = 0

<<" $y == $N ?? \n"
 if (y == N)
    eq++
 else
    neq++

 ntest++

<<" %V $eq $neq $ntest \n"

eq = 0
 if (a == 0) 
   eq = 1


<<"%V $a  $eq  \n"

STOP("DONE \n")


proc foo()
{
  x = 2
  return x
}


y = foo()


<<" proc returned $y \n"



STOP("DONE \n")






eq = 0
 if (a == 0) 
   eq = 1


<<"%V $a  $eq  \n"

eq = 0

 if (a == 0) {
   eq = 1
 }

<<"%V $a  $eq  \n"


STOP!
