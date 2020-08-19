#! /usr/local/GASP/bin/asl

// test proc

N = $2

int k = 1

<<" START $k $N \n"

 a = 2
 y = a

<<" $y = $a \n"

here ="/usr/local/GASP/GASP-3.2.0/TOOLS/ITOC/"
<<" $here \n"

include "$here/poo"

<<" after include file \n"

int ok = 0
int bad = 0
int ntest = 0

 k = 0

 while ( k < N) {

<<" before poo call k is $k\n"

     poo()

<<" ln 1 after poo call \n"
<<" ln 2  after poo call \n"

 <<" poo a is $a k is now $k\n"
  

 }

 if (k == N)
     ok++
 else 
     bad++

 ntest++

<<" DONE $k $N \n"

 pcc= (100.0 * ok)/ntest

<<"%-24s:$1: :success $ok failures $bad  %6.1f $pcc\% \n"

STOP!


