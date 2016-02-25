#! /usr/local/GASP/bin/spi

SetDebug(0)

N = 50
  argv = $2
 if (! (argv @= "")) 
  N= argv  
 
// lp1
// lp2
<<" $N input arg  ($argv )  \n"

 a = 2 ;  b = 3 ;  c = a * b ;

 <<" $a $b $c \n"



 if (c == 6) {

  <<" mul OK \n"
 }

 done = 0

 int k = 0

 while ( ! done)  {

  <<" top of while $k \n"

  k++

   if (k < N/2)  {
    <<" $k < $(N/2) \n"
   }

   if (k > (N+2)) {
    <<" $k > $N+2 - trying a break\n"
    break
   }

   if (k > N) {
    done = 1
    <<" $k > $N I am DONE $done \n"
   }

  <<" bottom of while $done\n"
 }

<<" OUTTA HERE! $k > $N \n"
<<" $k $done \n"

STOP!

