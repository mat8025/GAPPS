#! /usr/local/GASP/bin/asl
#/* -*- c -*- */

//  
set_debug(0)

float Y[] = { 1.0, 2.0, 3.5 }    ;                 


sz = Caz(Y) 

<<"OK $(typeof(Y)) $sz  $Y \n"




//float F[] = Grand(20,7)

   F = Grand(20,7)

     sz = Caz(F)

<<" $(typeof(F)) $sz  $F \n"

  F[22] = 7

<<" $(typeof(F)) $sz  $F \n"


R = Grand(20)

sz = Caz(R)


<<" $(typeof(R)) $sz  $R \n"


Redimn(R,4,5)

sz = Caz(R)

<<" $(typeof(R)) $sz \n $R \n"

for (i = 0; i < 4 ; i++) {

  Y= R[i][*]

sz = Caz(Y)

<<" $(typeof(Y)) $sz \n $Y \n"

}


float YV[4][]


    YV[0][0] = 99
<<"\n $YV \n"
    YV[1][1] = 98
<<"\n $YV \n"
    YV[2][2] = 97
<<"\n $YV \n"
    YV[3][3] = 96
<<"\n $YV \n"



STOP!

 PG = R[*][2]

<<" %v $PG \n"


sz = Caz(PG)

<<" $(typeof(PG)) $sz  $PG \n"


STOP!

 PG = 4^PG

<<" $PG \n"


