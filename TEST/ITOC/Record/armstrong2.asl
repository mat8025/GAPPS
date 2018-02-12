///
///  generate armstrong numbers
///

int Anum[100];

int sum = 0;
int psum = 0;

int np = 7;
int totn=0;

      for (i=0; i < np ;i++) {
            totn += 9*10^i ;
      }

int ks = 1 * 10^(np-1);
<<" from $ks to $totn\n";

n= 0;

int pw[10];

      for (i=0; i < 10 ;i++) {
            pw[i] = i^np ;
//	    <<"<$i>$pw[i] \n"
      }


int pt[10];

      for (i=0; i < 10 ;i++) {
            pt[i] = 10^i ;
	//    <<"<$i>$pt[i] \n"
      }



    for (k=ks; k<= totn; k++) {
    <<"$k\r"
      sum =0;
      psum = 0;
      kr = k;
      for (i=0; i < np ;i++) {
      // get the i place digit
      nkr = (kr/10 *10);
      m = kr -nkr;

//                sum += (m*(10^i));
              //  sum += (m*pt[i]);
		
//		psum += m^np; // replace with array pw[m]
                psum += pw[m];

   //   <<"%V $k $i $kr $nkr $m $sum $psum\n"
    //  ans=iread()
       kr = nkr/10;
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