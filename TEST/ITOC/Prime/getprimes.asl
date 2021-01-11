//%*********************************************** 
//*  @script getprimes.asl 
//* 
//*  @comment find first N primes 
//*  @release CARBON 
//*  @vers 1.3 Li Lithium [asl 6.2.97 C-He-Bk]                               
//*  @date Sun Dec 20 12:32:47 2020 
//*  @cdate 1/1/2005 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%

///
///



//  get the nth prime
int hi = 0;

int is_n_prime(int n)
{
int N

  int a
  int m
  is_p = 1;

 // N = n/3
  N = n/2

// test for number ending in 5 
// or skip every 5th
//<<"%V$n  $N\n"

  int i = 3
  
  while (1) {


      a = n/i

      m = a * i
//<<"%V$n $a $m $i\n"
     if (m == n) {

    <<" $n div by $i factor is $a -- not prime \n"
        is_p = 0;
       break;
     }

      //i += 2
      i++


   if (i >= N) {
     break
   }
  
  N = n/i

  }

   hi = i
   if (is_p) {
<<"Prime $n $i $is_p\n"
   }


  return is_p
}

//=======================================//

   KP = 2000; // get first n primes

A=ofw ("Primes${KP}.txt")


   int j = 1
   int k = 1
   int d = 0
   int lp = 1
   <<"$j $k $d\n"
    <<[A]"[${j}] $k $d $hi\n"     
   j++;

   k = 2
   d = k-lp
   <<"$j $k $d\n"
    <<[A]"[${j}] $k $d $hi\n"           
   lp = k
   j++;
   k = 3
   d = k-lp
   <<"$j $k $d\n"

    <<[A]"[${j}] $k $d $hi\n"     
   lp = k
   j++;
   
   k = 5
   d = k-lp
   j++
   <<"$j $k $d\n"

    <<[A]"[${j}] $k $d $hi\n"     
   lp = k

   int f5 = 1

   while (j < KP) {

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
     <<"PRIME [${j}] $k $d $hi\n"
    <<[A]"[${j}] $k $d $hi\n"     
     lp = k
    }

     if (j == KP) {

<<" $j == $KP \n"

       break;
     }
    }

    f5++
//<<"%V $f5\n"
}


//
cf(A)
<<" Exit @ $j  $KP \n";