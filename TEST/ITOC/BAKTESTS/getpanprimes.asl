
//  get the nth prime
//  BROKE!
// FIX pans not working in proc!!

pan N = 0
pan a = 0
pan m = 0
pan i = 0

pan hi = 0
int Ni = 0

A=ofw("panprimes")

proc is_n_prime(n)
{

  is_p = 1;


  N = n/3

  M = N +2 


    ki = 3
    i = 3

//<<"%V$n  $N $i\n"

    while (i < M) {


      a = n/i

      a= trunc(a + 0.00001)

      m = a * i

//<<"%V$n $a $m $i $N\n"


     if (m == n) {

  //  <<" $n div by $i factor is $a -- not prime \n"
        is_p = 0
       
     }

   i += 2

   if (i > M) {
        break
   }
 

   N = n/i
   M = N + 2
  }

if (is_p) {
//<<"$n  $i $N \n"
}

   hi = i

   return is_p
}


   KP = 50000; // get first 1000 primes
   int jj =1
   int ip
   pan j = 1
   pan k = 1
   int d = 0
   pan lp = 1

//   <<[A]"$j $k $d\n"
   ip = k
   jj = j
fprintf(A,'%d %d %d\n',jj,ip,d)
   <<"$j $k $d\n"
   fflush(1)
   j++
   k = 3
   d = k-lp

//   <<[A]"$j $k $d\n"
   ip = k
   jj = j
fprintf(A,'%d %d %d\n',jj,ip,d)
   <<"$j $k $d\n"
   j++
   lp = k
   k = 5
   d = k-lp
   ip = k
   jj = j

fprintf(A,'%d %d %d\n',jj,ip,d)
   <<"$j $k $d\n"

   int f5 = 1 

   while (1) {

    k += 2 
//<<"testing $k  $f5\n"
    if (f5 == 5) {
//<<"skipping $k  div by 5\n"
        f5 = 0
    }
    else {        
    p = is_n_prime(k)

    if (p) {
      d = k-lp
      j++
      <<"\t $j $k $d \n"
//   <<[A]"$j $k $d\n"
      jj = j
      ip = k
fprintf(A,'%d %d %d\n',jj,ip,d)
      lp = k
     }

    if (j == KP) {
       break
    }
   }
     f5++

   }

cf(A)