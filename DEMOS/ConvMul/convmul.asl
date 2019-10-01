//%*********************************************** 
//*  @script convmul.asl 
//* 
//*  @comment multiply via convolution 
//*  @release CARBON 
//*  @vers 1.2 He Helium                                                   
//*  @date Sun Aug 11 09:26:49 2019 
//*  @cdate Sun Aug 11 06:43:58 2019 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2019 → 
//* 
//***********************************************%

//// multiply via convolution

// integer numbers for now
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
ns = blen+alen-1;

int M[blen];
int N[ns];

double H[alen];
double X[blen];

ulong R[ns];




double Out[ns];


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
   H[k] =i;
 }



 for (k=0;k<blen; k++) {
   i = atoi(sele(b,k,1))
   M[k] =i;
   X[k]=i;
 }

// reverse order of N vector - zero pad to n+m-1 length

<<"$N \n"

<<"$M \n"









// N vector to register n+m -1 length
// left justified - zero padded
/{
nmuls = 0;
nadds = 0;
rsum = 0;
ai= alen -1;


for (k=0;k<ns; k++) {
// for nlen+mlen -1 steps

// multiply point by point -  and sum to result vector ns length

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
/}


//====================================//
 double sum;
 h_size = alen;
 x_size = blen;

nlmuls = 0;
nladds = 0;

 <<"H $H\n"
 for (j = 0; j < ns; j++) {

		x = j;
		sum = 0.0;

		k = h_size - 1;
		ci = j;

		while (1)
		  {
		    // as long as we have overlap - sum is computed
		    // 
		    if (x < x_size)
		      sum += (H[k] * X[ci]);

                    nlmuls++;
		    nladds++;
		    
                    k--;
		    if (k < 0)
		      break;
		    x--;
		    if (x < 0)
		      break;
		    ci--;
		    if (ci < 0)
		      break;

		  }
		Out[j] = sum;
	      }
	  


<<"$Out \n"

//===================================//


// then build answer -  each step - with carry operation right to left
<<"$R\n"
// convert result vector to number
pan ans = 0;
pan lans = 0;
pan s = 0;
pan ds = 0;
pan r= 1;
j= ns-1;


for (k=0;k<ns; k++) {
//  s = (R[j] * r);
  ds = (Out[j] * r);
  //ans += (R[j] * r);
  ans = lans +ds ;
  <<"$k $ans $R[j] $r  $ds $lans\n"
  nladds++;
  r *= 10;
  j -= 1;
  lans = ans;
}

<<"$ans\n"

mans = n * m ;

<<"$(typeof(mans)) $mans\n"
//<<"%V $nmuls $nadds\n"
<<"%V $nlmuls $nladds\n"

// check with DSP version
H->reverse()
<<"$H\n"
<<"$X\n"

LV=lconvolve(H,X)

<<"$LV\n"

<<"$H\n"

// 
