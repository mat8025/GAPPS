#! /usr/local/GASP/bin/asl
SetPCW("writepic","writeexe")

// FIX - compile as declare then assign
//int N = $2
//double M
openDll("math")

setap(50)    // set precision to 50 decimal places

// FIX pan N  = GetArgN()
pan N 

 N  = GetArgN()

<<" %v $N \n"

pan M

 M = GetArgN()

<<" %V  $M   \n"



P = N * M

<<" $P = $N * $M \n"


Q = N / M

<<" $Q =  $P/ $M   \n"

R = P / M

<<" $R =  $P/ $M   \n"




 i = 0

 while (i < 40) {

  
  P = 2 * P

<<" $i : $P \n"
<<" $i : $(panilength(P)) \n"

  i++
 }


STOP!
