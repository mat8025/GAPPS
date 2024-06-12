///
///  check for mem leak
///


chkIn()

checkMemory(1); // 1 - track memory use
int sum = 0;
int nsum = 0;
long product = 1;
int pk = 5000;
               Mu= memused();
	       svm = Mu[0];
  for (i = 1; i <= 1000 ; i++) {
        sum += i;
	nsum -= i;
	product = sum * 2;
	
    if (sum > pk) {
<<" $sum > $pk \n"
       break;
    }
     Mu= memused();
<<"<$i> $sum $nsum $product $(Mu[0] -svm)  \n"
//<<"<$i> $psum $Mu \n"
      svm = Mu[0];
  }

<<"$sum $nsum $product $svm  $Mu\n"


chkOut()

