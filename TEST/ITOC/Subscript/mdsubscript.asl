

//  


R= Igen(20,1,j)


Redimn(R,4,5)

<<"%v %r $R \n"
 k =0
 p = 0
 for (j = 0; j < 3; j++) {

<<" %V $p $k \n"

 CV =  R[*][k++]

 <<"%v \n $CV \n"
 dim = Cab(CV)
<<" %v $dim \n"

 RV =  R[p++][*]



 <<"%v \n $RV \n"
 dim = Cab(RV)
<<" %v $dim \n"

   Redimn (CV,1,4)

 <<"%v \n $CV \n"
 dim = Cab(CV)
<<" %v $dim \n"

}



  exit();



 for (j = 1 ; j <= 3 ; j++) {
R= Igen(20,1,j)


<<"%v\n $R \n"

 R = 0.0

 <<"%v \n $R \n"

}

STOP!


 R = 77.0

 <<"%v \n $R \n"

 R *= 2

 <<"%v \n $R \n"


 R *= 0

 <<"%v \n $R \n"



R= Igen(20,1,1)

 <<"%v \n $R \n"


V= Igen(30,1,3)

 <<"%v \n $V \n"

R = V

 <<"%v \n $R \n"

STOP!

Redimn(R,4,5)

j = 0

 <<"%v \n $R \n"

 dim = Cab(R)
<<" %v $dim \n"

 R = 0.0

 <<"%v \n $R \n"


STOP!








 CV =  R[*][j]

 <<"%v \n $CV \n"
 dim = Cab(CV)
<<" %v $dim \n"








STOP!





int M[7][4]

     sz = Caz(M)

<<" $(typeof(M)) $sz   \n"

<<" $M \n"

M[0:2][1] = 6

<<"\n $M \n"




M[0:2][3] = 9

<<"\n $M \n"

M[4:6][3] = 11

<<"\n $M \n"


Y = M[0:2][1:3]

<<"\n[0:2][1:3] --> \n\n $Y \n"


Y =  M[*][1:3]

<<"\n[*][1:3] --> \n\n $Y \n"




Z = M[0:2][1,3]

<<"\n[0:2][1,3] --> \n\n $Z \n"



R = M[0:2][*]

<<"\n [0:2][*] --> \n\n $R \n"

<<" DONE \n"

    T = M[0:2,4:6][*]

    <<"\n M[0:2,4:6][*] --> \n\n $T\n"

<<" DONE \n"
STOP!


for (i = 0; i < 4 ; i++) {

  Y= M[i][*]

sz = Caz(Y)

<<" $(typeof(Y)) $sz \n $Y \n"

}



