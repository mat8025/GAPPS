

<|Use_=
Demo  of exp-sivs;
///////////////////////
|>
/*
#include "debug"

if (_dblevel >0) {
   debugON()
   <<"$Use_\n"   
}
*/
//filterFileDebug(REJECT_,"scopesindex_e.cpp","scope_e.cpp","scope_findvar");
//filterFileDebug(REJECT_,"ds_sivbounds","ds_sivmem","exp_lhs_e");



if (argc() > 1) {

N = atoi(_clarg[1])
}
else {

 N =16;
}


chkIn()


 M = 2^^4


ap=log2(32.0);

<<"$N $M 2^^4 $ap\n"

ap=log2(N);

int np2 = log2(N)


<<"%V $M $ap $np2\n"

N++;


int np3 = log2(N)


<<"%V $N  $np3\n"

N++;

!a

N -= 2;

I = vgen(INT_,N,0,1)

<<"$I\n"

 int np = ap;

<<"$N must be pwr of 2 $np\n"

 M = 2^^np

 if (N != M) {
<<"$N not a pwr of 2\n"
  exit()
 }


 int npd = 0;
 int nswaps = 0;
 int a;
 int b;

 for (i= 0;i < N; i++) {
   a = i;
 //  <<"$i $a $(dec2bin(i)) \n"

   b = 0;
   for (j = 0; j < np ; j++) {
      c = a & 1;
      b += c;
      b = b << 1;
     // b <<= 1;
      a = a >> 1;
      <<"%V $a $b $c\n"
   }
    //b /=2;
    b = b >> 1;
   <<"%$i $b $(dec2bin(b)) \n"
  pd = 0;
  if (i == b) {
    pd = 1;
    npd++;
  }
  else if ( i > b) {
   nswaps++;
   <<"swapping %V$i for $b\n"
   tmp = I[b];
   I[b] = I[i];
   I[i] = tmp;
  }
   <<"%$i $b $pd $(sele(dec2bin(i),-1,np))\n"
 }

<<"%V$npd\n"


<<"$I\n"
chkT(1)

chkOut()