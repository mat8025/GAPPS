#! /usr/local/GASP/bin/asl

// test proc

N = _clarg[1]

int k = 1

<<" START $k $N \n"


proc poo(mf)
{
// increments global k
// does calc and returns that value   
float b

   k++

   a= k * mf
   b = a * 3
   c = b * mf
   d = c * mf
   e = d * mf
<<" in $_cproc %V $k $a $b $c $d $e\n" 
}


proc noo()
{
   k++
   a= k * 4
<<" in $_cproc %V a $k\n" 
    return a 
}


 k = 1
 pmf = 4 
 while ( k < N) {

<<" before poo call k is $k\n"

    poo(pmf)

   
<<" after poo call \n"
<<" 2 after poo call \n"
//     k++
 <<" poo %V  $k\n"

 }


<<" DONE $k $N \n"
STOP()
;

////  TODO/FIX /////////////
// does not move to statement after proc call
// immediate statement after proc return is not executed
// .exe fails
