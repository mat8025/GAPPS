

// test array indexing

N = 20
nloop = 1

 YV = Fgen(N,0,0.1)
   vi = 5

M = 3

while ( nloop < M) {

   YV = Grand(N)

<<" %6.2f %v $YV \n"
  MM = Stats( YV)

<<"%v %6.2f  $MM \n"
      a = nloop

   <<" %V $a $nloop \n"

   ymin = MM[vi]  
   ymax = MM[6]

   ymean = MM[1]   
   ysd = MM[4]

  <<" $(typeof(MM)) \n"
  <<" $(typeof(ymax)) \n"

  <<"$nloop TDD %V %6.2f $ymin $ymax $ymean $ysd \n"

 nloop++
}




nd = YV->Redimn(5,4)

dmn = Cab(YV)

<<" %V $nd $dmn \n"



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

<<" [${i}][${k}] $av \n"
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
  <<" [${j}][${i}][${k}] $av \n"
   k++
  }
   i++
 }
 j++
}




