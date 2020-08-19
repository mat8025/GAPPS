//setdebug(0)

uint p 
uint lp 

uint a
uint m
uint i
uint maxdp = 0
uint maxfac = 0


np = 100

n = argc()

<<"$n  $_argv \n"

 if (n >=2) {

   np = _argv[1]
 }

<<" first $np primes to find !\n"

 k = 4



///        the first 4  -- then we can easily skip numbers ending in 5
//  
<<"[1] 1 0\n"
<<"[2] 2 1\n"
<<"[3] 3 1\n"
<<"[4] 5 2\n"


//  we start on 7 and go in two's skipping every 5th condiate it ends in 5

 p = 7
 lp = 5

 j = 1

 while (k < np) {



# is it prime  - crude version

  if ((j % 5) != 0) {
// <<"$j is $p prime ?\n"
# is it even ?

  a = p/2

 
  N = a
  
  is_prime = 1


  for (i = 3 ; i < N ; i += 2) {

      a = p/i

      m = a * i

     if (m == p) {

      //<<" $p div by $i factor is $a -- not prime \n"
      is_prime = 0
      if (i > maxfac) {
        maxfac = i
      }
       break
     }
     r = N -i  

     if ((i % 100) == 0) {
//     <<"checked $i  $r divisors still to check\n"
     }

  }


  if (is_prime) {
   k++ 
   dp = p - lp
   <<"[${k}] $p $dp\n"
   if (dp > maxdp) {
    maxdp = dp
   }
   lp = p
  }


  }
  p += 2
  j++
}

<<"%V $maxdp  $maxfac\n"

stop!

;