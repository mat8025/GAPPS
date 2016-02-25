#! /usr/local/GASP/bin/asl

SetPCW("writepic","writeexe")


N=GetArgF()
<<" in $N \n"
k = 10


 while( k-- > 0) {
 
   x= Fround(N,k)
   <<"$N [${k}] $x \n"

 }


STOP!