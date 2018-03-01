///
///  generate armstrong numbers
///

proc getArmN (char  cna[])
{
int psum = 0;
//<<"%V $cna[::] \n"
     cn = cna - 48;
<<"%V $cn[::]\n"
    psum = 0;
      
      for (i=0; i < np ;i++) {
  //     <<"$i $cn[i]\n"
        psum += pw[cn[i]]; // get the nth pwr of the  ith place digit
      }
      
<<" %V $psum\n"
      return psum;
}



int Anum[100];

int sum = 0;
int psum = 0;

int np =  atoi (_clarg[1])
int totn=0;

char nv[20];
char nvm[np];
 nvm = 48;
 
int ks = 1 * 10^(np-1);

      for (i=0; i < np ;i++) {
            totn += 9*10^i ;
      }

ks= 1000;

//ks = atoi (_clarg[1])
//kstep = atoi (_clarg[2])
//endnum = ks + kstep;

//<<" from $ks to $totn\n";



T = FineTime()

n= 0;

int pw[10];

      for (i=0; i < 10 ;i++) {
            pw[i] = i^np ;
	    <<"<$i>$pw[i] \n"
      }

<<"%V$totn \n"
// make begin
begin =1
for (i=0; i < (np-1) ;i++) {
begin *= 10;
}

maxn = 0;
int ip = 1;
int jp =0

k = 9;

while (jp < (np-1)) {
ip = 1;
while (1) {

maxn += pw[k];

if (maxn > totn) {
  maxn -= pw[k];
  break;
}
nvm[jp] = k+48;
ip++;
jp++;
if (jp == np) {
   break;
}
}

<<"$k $ip $maxn $totn  $(maxn-totn)\n"

sumsofar =getArmN(nvm)
<<"$sumsofar < $totn\n"
k--;
}
nvm[np-1] += 1;  // FIXED  -XIC VERS??
//nvm[np-1] = 48+k+2;
<<"%s $nvm\n"
sumover =getArmN(nvm)
<<"$sumover > $totn\n"

endnum = atoi(nvm)
<<" so do ArmNUmbers from $begin to %s $nvm %d $endnum\n"



if (endnum > totn) {
  endnum = totn;
}



str s="123";
last_Mu = memused();
// reset ks - to last session

    j= 0;
  //checkMemory(1);

   for (k=begin; k<= endnum; k++) {


     if ((j % 5000) == 0) {
           Mu= memused();

	  // dumpmemtable();
	   <<"<$j>  %V $k  $Mu \n"
            if ((Mu[0]) > 50000) {
<<"too much mem used $Mu\n"
            break;
           }
      }

     j++;;
    //<<"$k\t      \r"
   // <<"%V $mu\n"
  //    ans= iread();
   //   last_mu = mu;
      psum = 0;
      s="$k"
      scpy(nv,s);
      nv -= 48;
      
      for (i=0; i < np ;i++) {
      
         psum += pw[nv[i]]; // get the nth pwr of the  ith place digit
         if (psum > k) {
     // <<"$psum > $k\n";
           break;
	 }
      }
      
      if (k == psum) {
      Anum[n] = k;
      n++;
      <<"$n $k   $psum\n"
      }
      
    }

dt=FineTimeSince(T);
secs = dt/1000000.0;
<<"between $ks  and $k "

<<"there are $n armstrong $np numbers took $secs\n "
 for (i=0; i< n; i++) {
  <<"$(i+1)  $Anum[i]\n"
 }

fname = "Armstrong_${np}_nums"

A=ofw(fname)

<<[A]"/{/*\n"
<<[A]"Armstrong $np\n"
<<[A]"there are $n Armstrong $np numbers took $secs  secs\n "
 for (i=0; i< n; i++) {
  <<[A]"$(i+1)  $Anum[i]\n"
 }
<<[A]"/}*/\n "
cf(A)

///////////////////////

/{/*
Armstrong 1
there are 9 Armstrong 1 numbers 0,1,2,3,4,5,6,7,8,9
 /}*/

/{/*
Armstrong 2
there are 0 Armstrong 2 numbers took 0.007702  secs
 /}*/
 

/{/*
Armstrong 3
there are 4 Armstrong 3 numbers took 0.536666  secs
 1   153
2  370
3  371
4  407
/}*/
 


/{/*
Armstrong 4
there are 3 Armstrong 4 numbers took 5.891107  secs
 1   1634
2  8208
3  9474
/}*/





// Armstrong 5
// 54748
// 92727
// 93084

// Armstrong 6
// 548834

// Armstrong 7
// 1741725
// 4210818
// 9800817
// 9926315

