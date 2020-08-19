
N = atoi(_clarg[1])
I = vgen(INT_,N,0,1)

<<"$I\n"

 int np = log2(N);

<<"$N must be pwr of 2\n"

 M = 2^^np

 if (N != M) {
<<"$N must be pwr of 2\n"
  exit()
 }


 int npd = 0;
 int nswaps = 0;
 int a;
 int b;

 for (i= 0;i < N; i++) {
   a = i;
 //  <<"$i $a $(decbin(i)) \n"

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
  // <<"%$i $b $(decbin(b)) \n"
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
   <<"%$i $b $pd $(sele(decbin(i),-1,np))\n"
 }

<<"%V$npd\n"


<<"$I\n"
