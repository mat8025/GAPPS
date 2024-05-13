

// test array indexing

#include "debug"

if (_dblevel >0) {
   debugON()
}


chkIn (_dblevel);
allowDB("spe_declare,parse,array", 1)

N = 20
int nloop = 1

 YV = Fgen(N,0,0.1)
   vi = 5

M = 7

float MM[]

while ( nloop < M) {

 ans=ask(" top of loop %V $nloop  ",0)

   YV = Grand(N)

  <<" $(typeof(YV)) \n"
   <<" %6.2f %V $YV \n"

  //  MM = YV[0:nloop:1]

 <<"what is happening ?\n"
 
//      X = YV[0:nloop*2:2]

//         X = YV[0:nloop*2:]

         X = YV[0:nloop]

//X = YV *2

    X.pinfo()

/*

  <<" $(typeof(MM)) \n"

  <<"$nloop %V %6.2f $MM \n"

    SM = YV[0:nloop:2]

  <<" $(typeof(SM)) \n"

  <<"$nloop %V %6.2f $SM \n"
*/


    nloop++
 
 ans=ask("%V $nloop incr?? ",0)

}

chkN(nloop,7)

Redimn(YV,5,4)

dmn = Cab(YV)

<<" $dmn \n"

<<" $YV \n"
ans=ask("%V $YV ",0)

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

<<" [$i ][$k ] $av \n"
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
  <<" [$j ][$i ][$k ] $av \n"
   k++
  }
   i++
 }
 j++
}




chkOut(1)
