#! /usr/local/GASP/bin/asl

// test array indexing
OpenDll("math")
N = 20

 YV = Igen(N,21,1)
<<" $YV \n"

 vi = 5 ; ni = 7

<<" %V $vi $ni \n"

 Enerthres = $2

<<" $Enerthres \n"

   KT = Sel(YV,"<",Enerthres)

   sz = Caz(KT) 

<<" $sz %v $KT \n"
  
   GRSAC = YV
   sz = Caz(GRSAC)

 <<" $sz ${GRSAC[0:8]} \n"

	if (KT[0] != -1) {
         GRSAC[KT] = 2.0
        }




<<" %v $GRSAC \n"
<<" DONE \n"


STOP!

int nloop = 0

while ( nloop < N) {

   P[nloop] = nloop

   val = YV[P]

  <<"$nloop  $val \n"

 nloop++
}





STOP!
