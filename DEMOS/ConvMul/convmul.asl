
//// multiply vua convolution

// int numbers for now
// input numbers 1 and 2

if (slen(_clarg[1]) <= slen(_clarg[2]) ) {
 a = _clarg[1]
 b = _clarg[2]
}
else {
 a = _clarg[2]
 b = _clarg[1]

}

<<"%V $a $b\n"
alen = slen(a)
blen = slen(b)

<<"%V $alen $blen\n"

pan m
pan n

int M[blen];
int N[blen+alen-1];
ulong R[blen+alen-1];


ns = blen+alen-1;


  n = atop(a);
  m= atop(b);

<<"%V $n $m $ns\n"

<<"$N \n"

<<"$M \n"

// copy longest to M vector

i = atoi(sele(a,0,1))

j = atoi(sele(b,0,1))

<<"%v $i $j\n"

 for (k=0; k<alen; k++) {
   j = alen-1-k;
   i = atoi(sele(a,j,1));
   N[k] =i;
 }



 for (k=0;k<blen; k++) {
   i = atoi(sele(b,k,1))
   M[k] =i;
 }

// reverse order of N vector - zero pad to n+m-1 length

<<"$N \n"

<<"$M \n"









// N vector to register n+m -1 length
// left justified - zero padded
nmuls = 0;
nadds = 0;
rsum = 0;
ai= alen -1;
for (k=0;k<ns; k++) {
// for n+m -1 steps

// multiply point by point -  and sum to result vector n+m-1 length

// shift n vector right -
  rsum = 0;
  ai= alen -1;
  for (j=0;j<blen;j++) {
  rsum += N[ai+j] * M[j];
  nmuls++;
  nadds++;
  }
  R[k] = rsum;
N->ShiftR()

<<"$N $rsum\n"

}
// then build answer -  each step - with carry operation right to left


<<"$R\n"
// convert result vector to number
pan ans = 0;
pan lans = 0;
pan s = 0;
pan r= 1;
j= ns-1;
for (k=0;k<ns; k++) {
  s = (R[j] * r);
  //ans += (R[j] * r);
  ans = lans +s ;
  <<"$k $ans $R[j] $r $s $lans\n"
  nadds++;
  r *= 10;
  j -= 1;
  lans = ans;
}

<<"$ans\n"

mans = n * m ;

<<"$(typeof(mans)) $mans\n"
<<"%V $nmuls $nadds\n"


// 
