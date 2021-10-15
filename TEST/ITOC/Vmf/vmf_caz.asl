//%*********************************************** 
//*  @script caz.asl 
//* 
//*  @comment test Caz func 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                 
//*  @date Tue Mar 12 07:50:33 2019 
//*  @cdate Tue Mar 12 07:50:33 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%///

/*
Caz,Csz ~ check size, check array size

/////
Caz(A) of Caz(&A)
returns current size (number of elements) where A is an  vectoror matrix
Caz(&i) 
would return 0  when i is a scalar.

Caz(A[1:9:2]) returns 5 
the subscripted size 
assuming A has at least 10 elements.


*/

<|Use_=
Demo  of Caz SF

///////////////////////
|>
                                                               

#include "debug"

if (_dblevel >0) {
   debugON()
   <<"$Use_\n"   
}

int DC[5];

DC[1] = 1

DC[4] = 4

int d;

d = 79;

<<" $d scalar $(Sizeof(d))\n"

asz= Csz(&d)

<<"array size of d $d $(typeof(d))  is: $asz \n"

nd = Cnd(&d)
<<"number of dimensions are: $nd \n"
chkN(nd,0)

ab = Cab(&d)
<<"bounds are: $ab \n"
chkN(ab[0],0)


chkN(asz,0)
DC->info(1)
asz= Csz(DC)
//<<"%V$asz\n"
//DC->info(1)

<<"array size of $DC $(typeof(DC))  is: $asz \n"
chkN(asz,5)
nd = Cnd(DC)
<<"number of dimensions are: $nd \n"
chkN(nd,1)

ab = Cab(DC)
ab->info(1)
<<"bounds are: $ab \n"

chkN(ab[0],5)



////////////////////////////////

<<"\n Svar vector \n"

Svar SC;

<<"$SC scalar $(Sizeof(SC))\n"

SC[0] = "hey"

SC[1] = "mark"

asz= Csz(SC)

<<"$asz  $(Cab(SC))\n"

<<"\n vector \n"

int A[6]  = { 1,2,4,9,8,6 }

a= A[0]

<<"$a\n"
<<"$A\n"

asz= Csz(A)
<<"array size (number of elements) is: $asz \n"
chkN(asz,6);

nd = Cnd(A)
<<"number of dimensions are: $nd \n"
chkN(nd,1)
ab = Cab(A)



<<"bounds are: $ab \n"


<<" $(Caz(A)) $(typeof(A)) \n"


//<<"%I $A \n"   // will crash why?

 d= Cab(A)

<<"%V $d \n"


/////////////////////////////////////////
<<"////\n Two dimensions \n"
// FIXME  -- won't fill in rows

int  B[6] = { 0,3,2,-1,1,-2} ;

 <<"%V $B\n"


asz= Csz(B)
<<"array size (number of elements) is: $asz \n"
chkN(asz,6);
nd2 = Cnd(B)
<<"number of dimensions are: $nd2 \n"
chkN(nd2,1)
ab = Cab(B)

<<"bounds are: $ab \n"

 d= Cab(B)

<<"%V $d \n"


  B->redimn(2,3)


asz= Csz(B)
<<"array size (number of elements) is: $asz \n"
chkN(asz,6);

nd2 = Cnd(B)

<<"number of dimensions are: $nd2 \n"
nd2->info(1)
chkN(nd2,2)
ab = Cab(B)

<<"bounds are: $ab \n"

 d= Cab(B);

/*

 int C[3][3][3] = { { {0,1,2}, {3,4,5}, {6,7,8} },
                    { {9,10,11}, {12,13,14}, {15,16,17} },
		    { {18,19,20}, {21,22,23}, {24,25,26}}
		    };
                        


int  B[2][3] 
  k= 0;
  for (i = 0; i < 2; i++) {
   for (j = 0; j < 3; j++) {
     B[i][j] = k++;
   }
}


b = B[0][0]
<<"$b\n"

b = B[0][2]
<<"$b\n"




asz= Csz(B)
<<"array size (number of elements) is: $asz \n"

nd2 = Cnd(B)
<<"number of dimensions are: $nd2 \n"

ab = Cab(B)

<<"bounds are: $ab \n"

 d= Cab(B)

<<"%V $d \n"
*/

//chkStage("caz")

chkOut()

