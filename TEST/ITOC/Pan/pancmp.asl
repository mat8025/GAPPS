///
///
///


chkIn(_dblevel)

checkMemory(1); // 1 - track memory use
pan psum = 0;
pan pk = 400;
               Mu= memused();
	       svm = Mu[0];
  for (i = 1; i <= 500 ; i++) {
        psum += i;
    if (psum > pk) {
<<" $psum > $pk \n"
       break;
    }
     Mu= memused();
<<"<$i> $psum $(Mu[0] -svm) $Mu \n"
//<<"<$i> $psum $Mu \n"
      svm = Mu[0];
  }

chkR(psum,406.0)

chkOut()

