///
///
///


 CheckIn()

//uint p = 65119 
uint p = 127

//uint a
//uint m

n = argc()

<<"$n  $_argv \n"


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

  
  is_prime = 1
  for (i = 3 ; i < N ; i += 2) {

      a = p/i

      m = a * i

     if (m == p) {

      <<" $p div by $i factor is $a -- not prime \n"
       is_prime = 0
       break;
     }
     r = N -i  
     if ((i % 9999) == 0) {

//     <<"checked $i  $r divisors still to check\n"
     <<". "

     }
  }

<<"\nHey Baby $p is prime !!\n"

  CheckNum(is_prime,1)
  CheckOut()

