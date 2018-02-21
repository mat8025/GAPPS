///
/// Caz  - Csz - 
///

//envDebug()
DBIT = 2;

setDebug(1);

<<"hey buddy move on up\n"
<<"$_clarg[0] $_clarg[1] \n"

<<" %V $DBIT\n";

int d;

d = 79;


<<" $d scalar $(Sizeof(d))\n"

checkIn();

asz= Csz(d)
<<"array size (number of elements) is: $asz \n"

checkNum(asz,0)
nd = Cnd(d)
<<"number of dimensions are: $nd \n"
checkNum(nd,0)

ab = Cab(d)
<<"bounds are: $ab \n"
checkNum(ab,0)

////////////////////////////////

<<"\n Svar vector \n"

Svar S;

<<"$S scalar $(Sizeof(S))\n"

S[0] = "hey"

S[1] = "mark"

asz= Csz(S)

<<"$asz  $(Cab(S))\n"

<<"\n vector \n"

int A[6]  = { 1,2,4,9,8,6 }

a= A[0]

<<"$a\n"
<<"$A\n"

asz= Csz(A)
<<"array size (number of elements) is: $asz \n"
checkNum(asz,6);

nd = Cnd(A)
<<"number of dimensions are: $nd \n"
checkNum(nd,1)
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
checkNum(asz,6);
nd2 = Cnd(B)
<<"number of dimensions are: $nd2 \n"
checkNum(nd2,1)
ab = Cab(B)

<<"bounds are: $ab \n"

 d= Cab(B)

<<"%V $d \n"


  B->redimn(2,3)


asz= Csz(B)
<<"array size (number of elements) is: $asz \n"
checkNum(asz,6);
nd2 = Cnd(B)
<<"number of dimensions are: $nd2 \n"
checkNum(nd2,2)
ab = Cab(B)

<<"bounds are: $ab \n"

 d= Cab(B);


checkOut()

exit()

/{

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
/}