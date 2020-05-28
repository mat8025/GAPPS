///
///
///


include "debug"
debugON()



sdb(1,@keep,@trace)

checkMemory(1); // 1 - track memory use
pan psum = 0;
pan pk = 400;

checkin()
               Mu= memused();
	       svm = Mu[0];
  for (i = 1; i <= 500 ; i++) {
        psum += i;
    if (psum > pk) {
<<" $psum > $pk \n"
       break;
    }
     Mu= memused();
//<<"<$i> $psum $(Mu[0] -svm) $Mu \n"
<<"<$i> $psum $Mu \n"
      svm = Mu[0];
  }

checkNum(psum,406)

checkOut()

exit()