
//setdebug(1)

setAP(100)

n = argc()

//<<"$n  $_argv \n"

pan E
pan p 

<<"pan_prime \n"

 if (n >=2) {

   p = atop(_argv[1])
 }
 else {

   p = atop(iread("input prime candidate :> "))

 }

//<<" is $_argv[1] prime \n"
<<"is $p  prime ?\n"

# is it prime  - crude version

 pan N = 0
# is it even ?

 pan a = p/2

 a= trunc(a)


  a = p/2
  a= trunc(a)
  N = a

  <<"%V $a $(typeof(a)) \n"
  <<"%V $N $(typeof(N)) \n"

 pan m = a * 2

<<"%V$m $(typeof(m)) \n"

if (m == p) {

<<" $p is div by 2 -- its even \n"
     stop!
}

pan i = 0

<<"\n"

  // only need to go to sqrt  way  
  pan k = 0

  i = 3
  N = p/3
  int ki = 0

  pan tf = 0

  tf = sqrt(p)


//<<"sqrt is $tf \n"

   rtf = trunc(tf)

<<"sqrt is f$tf $rtf\n"



  while ( 1 ) {

      a = p/i

      t= trunc(a + 0.000001)

      m = t * i

<<"%V$i $p $t $a $m \n"

     if (m == p) {

    <<" $p div by $i factor is $a \n-- not prime \n"

     stop!
     }


       i += 2;


   if (i > N) {
       <<"$i > $N \n"
       break
   }
   else {
 //      <<"$i < $N $(typeof(i)) \n"
   if (ki == 5000) {
     <<"$i < $N  $tf \n"
      ki = 0
   }
   }
   ki++

   N = p/ i
   N = trunc(N)
   
<<"%V$i or $N \n"

  }

<<"\nHey Baby $p is prime !!  - looked to $i\n"


stop!

;