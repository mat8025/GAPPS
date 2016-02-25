#! /usr/local/GASP/bin/asl

// test proc

N = GetArgI()

int k = 1

<<" START $k $N \n"


proc poo( pa )
{
// increments global k
// does calc and returns that value   
   k++
   a= k * pa

<<" in $_cproc %V $k $a $pa\n" 
ttyin()
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


 k = 0
 while ( k < N) {

<<" before poo call k is $k\n"

    y = poo(k)

<<"ln 1 after poo call \n"
<<"ln 2 after poo call \n"

 <<" poo returns $y  k is now $k\n"

 }


<<" DONE $k $N \n"
STOP!

////  TODO/FIX /////////////
// immediate statement after proc return is not executed
// .axe fails
