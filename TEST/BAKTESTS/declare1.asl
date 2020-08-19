
CheckIn()

// make 1 to stop if error
//Checkpause = 1

jj = 6

<<" %v $jj \n"

   CheckNum(jj,6)

//SetDEbug(2,"step")


int k =34

<<" %v $k \n"

   CheckNum(k,34)



float ytest = 1.234

<<" %V  $ytest \n"

   CheckNum(ytest,1.234)

// dynamic array declare with intial size

float Leg[10+]
//float Leg[100]

<<" %I $Leg \n"

 sz = Caz(Leg)

<<" %v $sz \n"



 cb  = Cab(Leg)

<<" %v $cb \n"





<<"%v $(Caz(Leg)) $(Cab(Leg)) \n"

double yr0 = -1.5
double yr1 = 1.5
double xr0 = -1.5
double xr1 = 1.5
double xr9 = (2 * -1.6)

<<"%V $xr0 $yr0 $xr1 $yr1 \n"

   CheckNum(yr0,-1.5)
   CheckNum(xr0,-1.5)
   CheckNum(xr1,1.5)
   CheckNum(xr9,-3.2)


int M[10]

  M = 8

<<" $M[0] \n"

<<" $M \n"

<<"%V $(Caz(M)) $(Cab(M))\n"

    if (Caz(M) == 10) {
     ok++
    }
    else {
     <<"fail $(Caz(M)) != 10 \n"
     bad++
    }
 ntest++




   msz = Caz(M)

   CheckNum(msz,10)

//   CheckNum(Caz(M),10)




int JJ[10][3]

<<" %V $(Caz(JJ)) $(Cab(JJ))\n"
  JJ[1][2] = 3

   CheckNum(JJ[1][2],3)

<<" $JJ[1][2] \n"




<<" %V $ntest  $k  \n"

<<" %V $k $ok $ntest $ytest \n"


<<" %V $(typeof(ntest))  $(typeof(ok)) $(typeof(k)) $(typeof(yr1)) \n"





int J[30]

  sz =Caz(J)
<<" %v $sz $(Cab(J)) \n"
 J[7] =7
 J[1] = 1

<<"%v $J[*] \n"
 
   CheckNum(J[7],7)
   CheckNum(J[1],1)



// FIX int MS[12] = 7

int MS[12]

MS = 37

<<"%V $(Caz(MS))  \n"
<<" $MS \n"

   CheckNum(MS[4],37)




<<" 2d  \m"
int P[10][3]

P = 76



<<"%v %R$P \n"

<<" $P \n"
<<" %v $P[2][1] \n"
  sz =Caz(P)
<<" %V $sz $(Cab(P)) \n"

      if (P[7][0] == 76) {
           ok++
      <<"2D pass $ok \n"
      }
      else {
      <<"2D fail $P[7][0] != 76 \n"
      }

      ntest++

   CheckNum(P[7][0],76)




 double dp = 10.0e25

 double dc =  2.9979e8

<<"%V  %e $dp $dc  \n"

   CheckNum(dp,10.0e25)

   CheckNum(dc,2.9979e8)


  dz= dp / dc

  dq = dz * dc

<<" $(typeof(dp))  $(typeof(dz))\n"

<<"%V  %e $dp $dc $dz $dq\n"

   CheckNum(dp,dq)

   CheckOut()

STOP!


prec=setap(20)

<<" %v $prec \n"

 pan p = 9.0345679979e8

 pan c =  2.9979e8

  z= p / c

  q = z * c

<<" $(typeof(p))  $(typeof(z)) $(typeof(q))\n"

<<"   $p $c $z \n"
<<"  %e $p $c $z \n"
<<" %V %p $p $q $c $z \n"

<<"%v  %e $q \n"

//  check within acceptable range

   pan pr
   pan qr

//   pan pr = fround(p,1)
//   pan qr = fround(q,1)

   pr = fround(p,2)
   qr = fround(q,2)

<<" %v $pr \n"

<<" %v $qr \n"


   CheckNum(pr,qr)

   CheckOut()

<<" done declare1 \n"


STOP!


