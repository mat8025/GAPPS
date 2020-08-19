#! /usr/local/GASP/bin/asl

// test proc

N = $2

int k = 1

<<" START $k $N \n"


proc poo(pa)
{
// increments global k
// does calc and returns that value   
   k++
   a= k * 2
<<" in $_cproc %V $k $a $pa\n" 
    return a 
//   return (a * 2.0)
}


proc noo()
{
   k++
   a= k * 4
<<" in $_cproc %v $k $a\n" 
    return a 
}

 pf = 2.0
 am = 3.0
 k = 1


 b = foo(N)

<<" foo returns $b \n"

 a= foo(N) * pf

<<" $a = $(foo(N)) * $pf \n"


 a = foo(N) * pf * am
 
<<" $a = $(foo(N)) * $pf * $am \n"

 c = foo(N) * pf * am
 
<<" $c = $(foo(N)) * $pf * $am \n"


 a = pf * N

<<" $a $pf * $N \n"


 c = pf * N * am

<<" $c $pf * $N * $am \n"




STOP!


 a = pf * am / N

<<" $a = $pf * $am / $N \n"


 a = pf * am / N  + N

<<" $a = $pf * $am / $N + $N\n"

 a = (pf * am )/ ( N  + N)

<<" $a = ($pf * $am )/ ($N + $N )\n"

 a=foo(N)

<<" $a $N \n"

 a=foo(N) * pf

<<" $a $N \n"

STOP!

    y = poo(k)  * pf

 <<" poo returns $y  k is now $k\n"


STOP!




 while ( k < N) {

<<" before poo call k is $k\n"

    y = poo(k)  * pf

<<"ln 1 after poo call \n"
<<"ln 2 after poo call \n"

 <<" poo returns $y  k is now $k\n"

 }


<<" DONE $k $N \n"
STOP!

////  TODO/FIX /////////////
// immediate statement after proc return is not executed
// .axe fails
