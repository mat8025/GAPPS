
setdebug(1)

N = atoi (_clarg[1])
 if (N <= 0) {
 <<"bad N \n"
  exitsi()

 }
// is it power of 2 ?

 int n = log2(N)

  M = 2^^n

<<"%V$N $n  $M\n"

 if (M != N) {

<<"not power of 2\n"

  exitsi()

 }

<<"%V $n\n"






proc bitrev( ival, n)
{

int I[]

     k = 1

     for (j = 0; j < n ; j++) {
        b = (ival & k);
        k = ( k << 1);
        I[j] = !(b ==0);
     }

     I->reverse()

     c =0

     k = 1

     for (j = 0; j < n ; j++) {
       if (I[j] == 1) {
         c = c + k
       }
         k = (k << 1)
     }

     return c;
}


r =0
w =0





  for (i = 0; i < N ; i++) {

       r=bitrev(i,n)




<<"$i  $r \n"


  }


for (i = 0; i < N ; i++) {

       w=nbitrev(i,n)
<<"$i  $w\n"
}