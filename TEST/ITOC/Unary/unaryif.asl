

chkIn()

float dFT60 = 2.0

//int xbin

N = 5
<<" $N \n"
//OpenDll("math")
int ok = 0
int bad = 0
int ntest = 0

Graphic = 0


  if (!Graphic) {
    <<" not  ~0 == $Graphic graphic true \n"
   ok++
  }
  else {
    <<" 1  == %v $Graphic graphic  \n"
    bad++
  }
 ntest++
nwr = -1

 if (nwr == -1) {
    <<" $nwr == -1 \n"
 ok++
 }
 else {
 bad++
 }

 ntest++

 if (nwr == -1) 
 ok++
 else 
 bad++
 ntest++

 k = abs(-2)
 <<" abs(-2) $k $(abs(2)) \n"

 if ( abs(2)) {
  ok++
 <<" abs(2) TRUE \n"
 }
 else
 bad++
 ntest++

 if ( abs(2)) 
  ok++
 else
 bad++
 ntest++



 pcc= (100.0 * ok)/ntest

<<"%-24s:$N : :success $ok failures $bad  %6.1f $pcc\% \n"

chkN(ok,5)

chkOut()

