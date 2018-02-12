///
///  generate armstrong numbers
///

int Anum[100];

int sum = 0;
int psum = 0;

int np = 7;
int totn=0;

char nv[20];

int ks = 1 * 10^(np-1);

      for (i=0; i < np ;i++) {
            totn += 9*10^i ;
      }


<<" from $ks to $totn\n";

n= 0;

int pw[10];

      for (i=0; i < 10 ;i++) {
            pw[i] = i^np ;
//	    <<"<$i>$pw[i] \n"
      }

str s="123";
int last_mu = memused();
// reset ks - to last session
   ks= 8700000;
    for (k=ks; k<= totn; k++) {

     mu= memused();
    
    <<"$k\t \t $(mu-last_mu)      \r"
   // <<"%V $mu\n"
  //    ans= iread();
      last_mu = mu;
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

<<"done there are $n armstrong numbers for $np place numbers\n"

 for (i=0; i< n; i++) {
  <<"$(i+1)  $Anum[i]\n"
 }