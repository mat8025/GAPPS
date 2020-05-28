
// test array indexing

N = 14
int nloop = 1

 YV = Fgen(N,0,0.1)
   vi = 5

M = 7


while ( nloop < M) {

   YV = Grand(N)

  <<" $(typeof(YV)) \n"
   <<" %6.2f %v $YV \n"

    MM = YV[0:nloop]

  <<" $(typeof(MM)) \n"

  <<"$nloop %V %6.2f $MM \n"

    SM = YV[0:nloop:2]

  <<" $(typeof(SM)) \n"

  <<"$nloop %V %6.2f $SM \n"



 nloop++
}



STOP!
Redimn(YV,5,4)

dmn = Cab(YV)

<<" $dmn \n"

<<" $YV \n"


 av = YV[2][0]

<<" $av \n"
 int i = 0

 while ( i < 5) {

 av = YV[i][0]

<<" $av \n"

 i++
 }


 i = 0
 int k

 while ( i < 5) {

 k = 0
 while (k < 4) {
 av = YV[i][k]

<<" [$i][$k] $av \n"
 k++
 }

 i++
 }


Redimn(YV,2,5,2)

dmn = Cab(YV)

<<" $dmn \n"

<<" $YV \n"
int j = 0

while (j < 2) {
 i = 0
 while ( i < 5) {
  k = 0
  while (k <2) {
   av = YV[j][i][k]
  <<" [$j][$i][$k] $av \n"
   k++
  }
   i++
 }
 j++
}



STOP!
