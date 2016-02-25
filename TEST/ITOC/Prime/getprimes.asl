
//  get the nth prime
int hi = 0
proc is_n_prime(n)
{
int N

  int a
  int m
  is_p = 1

  N = n/3

// test for number ending in 5 
// or skip every 5th
// <<"%V$n  $N\n"

  i = 3
  while (1) {


      a = n/i

      m = a * i
//<<"%V$n $a $m $i\n"
     if (m == n) {

//      <<" $n div by $i factor is $a -- not prime \n"
        is_p = 0
       
     }

      i += 2


   if (i >= N) {
     break
   }

   N = n/i

  }
//<<"$n $i\n"
   hi = i
   return is_p
}


   KP = 1000 // get first 1000 primes
   int j = 1
   int k = 1
   int d = 0
   int lp = 1
   <<"$j $k $d\n"
   j++
   k = 3
   d = k-lp
   <<"$j $k $d\n"
   lp = k

   k = 5
   d = k-lp
   j++
   <<"$j $k $d\n"
   lp = k

   int f5 = 1

   while (1) {

    k +=2 
    // check div 3
    // skip div 5 - cos we know every 5th will end in 5
    if (f5 == 5) {
        f5 = 0
    }
    else {    
    p = is_n_prime(k)

    if (p) {
     d = k-lp
     j++
     <<"$j $k $d $hi\n"
     lp = k
    }

     if (j == KP) {
       break
     }
    }

    f5++

   }
