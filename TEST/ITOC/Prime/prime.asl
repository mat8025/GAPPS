
// FIXME uint p = iread(":> ")

uint p 

//uint a
//uint m

 n = argc()

<<"$n  $_argv \n"

 if (n >=2) {

   p = atoi(_argv[1])
 }
 else {

   p = atoi(iread("input prime candidate :> "))

 }


<<"is $p prime ?\n"

# is it prime  - crude version


# is it even ?

 uint a = p/2

 // a = p/2

  N = a


  <<"%V $a $(typeof(a)) \n"
  <<"%V $N $(typeof(N)) \n"



 uint m = a * 2

<<"%V $m $(typeof(m)) \n"

if (m == p) {

<<" $p div by 2 -- its even \n"
     stop!
}

uint i

  // only need to go 1/3 way  - init


  N= p/3
  i = 3

  while (1) {


      a = p/i

      m = a * i

     if (m == p) {

      <<" $p div by $i factor is $a -- not prime \n"

     stop!
     }
     r = N -i  
     if ((i % 9999) == 0) {

     <<"checked $i  $r divisors still to check\n"
     <<". "

     }
   i += 2

   if (i >= N) {
     break
   }



   N = p/i

<<"$i or $N  \n"

  }


<<"\nHey Baby $p is prime !! - looked to $i\n"

stop!

;