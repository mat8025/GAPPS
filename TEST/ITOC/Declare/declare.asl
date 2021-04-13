//%*********************************************** 
//*  @script declare.asl 
//* 
//*  @comment test basic declare statments 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                    
//*  @date Sat May  9 08:59:31 2020 
//*  @cdate Sat May  9 08:59:31 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%

///
///
<|Use_=
Demo  of declare 
e.g.
double yr0 = -1.5
etc
///////////////////////
|>


#include "debug"

if (_dblevel >0) {
   debugON()
   <<"$Use_\n"
}


chkIn(_dblevel)

//filterFileDebug(ALLOWALL_,"yyy");
//filterFuncDebug(ALLOWALL_,"yyy");

proc Foo(int a)
{
  int k = 2
<<" entered $_proc single arg %V$a $k $A\n"
 chkN(k,2)
 chkN(a,A)
}

//======================================//




proc Foo(int a, int b)
{
<<" $_proc 2 args $a $b\n"
  int x;
  int y = 1;
  y->info(1);
  chkN (y ,1)
  x = a;
  y = b;
  a->info(1)
  c= x+ y;

<<"%V $c $a $b $x $y \n"

  return c;
}
//======================================//

<<" Main \n"


A =4;

Foo(A,5)


A++

d=Foo(A,5)



A++;


e=Foo(A)



int q;

int m = 3;
int n = 4;


 pri = Foo(m,n)


<<"%V $pri $m $n\n"

 x= Sin(0.5)

<<"%V $x\n"

chkN(pri,7)

//!a 2 args
//!a 2 args version?
 pri = Foo(74,79)



<<"%V  $m $n\n"



chkN(pri,(74+79))



int ok = 0;
int ntest = 0;

jj = 6

<<"%V$jj \n"

   chkN(jj,6)


int k =34;

<<" %v $k \n"

   chkN(k,34)

float ytest = 1.234;

<<"%V$ytest \n"

   chkR(ytest,1.234,6)

// dynamic array declare with intial size

//float Leg[10+]


float Leg[12]



Leg[8] = 8


<<"%I $Leg \n"

 sz = Caz(Leg)

<<"%V$sz \n"

 cb  = Cab(Leg)

<<"%V$cb \n"


<<"%v $(Caz(Leg)) $(Cab(Leg)) \n"






double yr0 = -1.5
double yr1 = 1.5
double xr0 = -1.5
double xr1 = 1.5
double xr4 = 2.6 + 2
double xr5 = -2.6 + 2
double xr6 = 2.6 - 2
double xr7 = 1.6 * 2
double xr8 = (1.6 * 2)
double xr9 = (-1.6 * 2)

<<"%V $yr0 $yr1 $xr0 $xr1 $xr4 $xr5 $xr6 $xr7 $xr8 $xr9 \n"



   chkN(yr0,-1.5)
   chkN(xr0,-1.5)
   chkN(xr1,1.5)

   chkN(xr4,4.6)
   chkN(xr5,-0.6)
   chkN(xr6,0.6)
   chkN(xr7,3.2)      
   chkR(xr8,3.2000);
<<"%V$xr9 $(typeof(xr9))\n"

   chkR(xr9,-3.2000);


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

   chkN(msz,10)




int JJ[10][3]

<<" %V $(Caz(JJ)) $(Cab(JJ))\n"
  JJ[1][2] = 3

   chkN(JJ[1][2],3)

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
 
   chkN(J[7],7)
   chkN(J[1],1)



// FIX int MS[12] = 7

int MS[12]

MS = 37

<<"%V $(Caz(MS))  \n"
<<" $MS \n"

   chkN(MS[4],37)




<<" 2d  \m"
int P[10][3]

P = 76



<<"%(10,, ,\n) $P \n"

<<" $P \n"
<<" %v $P[2][1] \n"
  sz =Caz(P)
<<"$sz $(Cab(P)) \n"

      if (P[7][0] == 76) {
           ok++
      <<"2D pass $ok \n"
      }
      else {
      <<"2D fail $P[7][0] != 76 \n"
      }

      ntest++

   chkN(P[7][0],76)




 double dp = 10.0e25

 double dc =  2.9979e8

<<"%e$dp $dc  \n"

   chkN(dp,10.0e25)

   chkN(dc,2.9979e8)


  dz= dp / dc

  dq = dz * dc

<<" $(typeof(dp))  $(typeof(dz))\n"

<<"%e$dp $dc $dz $dq\n"

   chkN(dp,dq)


 chkOut()
