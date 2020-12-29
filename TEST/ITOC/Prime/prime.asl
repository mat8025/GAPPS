//%*********************************************** 
//*  @script prime.asl 
//* 
//*  @comment test for prime number 
//*  @release CARBON 
//*  @vers 1.3 Li Lithium [asl 6.3.2 C-Li-He]                                
//*  @date Mon Dec 28 17:11:27 2020 
//*  @cdate 1/1/2001 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%



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

is_prime = 1;
# is it even ?

 uint a = p/2

 // a = p/2

  N = a


  <<"%V $a $(typeof(a)) \n"
  <<"%V $N $(typeof(N)) \n"

 try {

 uint m = a * 2

<<"%V $m $(typeof(m)) \n"

if (m == p) {

<<" $p div by 2 -- its even \n"
     is_prime = 0;
     throw 0;
}

uint i

  // only need to go 1/3 way  - init


  N= p/3
  i = 3

  while (1) {


      a = p/i

      m = a * i

     if (m == p) {

      //<<" $p div by $i factor is $a -- not prime \n"
         throw 0;
 
     }
     r = N -i  
     if ((i % 25) == 0) {

     <<"checked $i  $r divisors still to check\n"
     <<". "

     }
   i += 2

   if (i >= N) {
       throw 1;
   }



   N = p/i

<<"$i or $N  \n"

  }
  
 }

   catch (int ball) {
    if (ball == 1) {
    <<"\nHey Baby $p is prime !! - looked to $i\n"
    }
    else {
       <<" $p div by $i factor is $a -- not prime \n";
    }
   }