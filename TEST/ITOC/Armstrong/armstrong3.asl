///
///  generate armstrong numbers
///

int Anum[100];

int sum = 0;
int psum = 0;

int np = 8;
int totn=0;

char nv[20];

int ks = 1 * 10^(np-1);

      for (i=0; i < np ;i++) {
            totn += 9*10^i ;
      }

   ks= 15440000;

ks = atoi (_clarg[1])
kstep = atoi (_clarg[2])
endnum = ks + kstep;

//<<" from $ks to $totn\n";

if (endnum > totn) {
  endnum = totn;
}

T = FineTime()

n= 0;

int pw[10];

      for (i=0; i < 10 ;i++) {
            pw[i] = i^np ;
//	    <<"<$i>$pw[i] \n"
      }

str s="123";
last_Mu = memused();
// reset ks - to last session

    j= 0;
  //checkMemory(1);

   for (k=ks; k<= endnum; k++) {


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