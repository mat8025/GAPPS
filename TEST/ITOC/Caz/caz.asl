// Caz  - Csz - 
setdebug(1)

<<" scalar \n"

int d


asz= Csz(d)
<<"array size (number of elements) is: $asz \n"

nd = Cnd(d)
<<"number of dimensions are: $nd \n"

ab = Cab(d)
<<"bounds are: $ab \n"


////////////////////////////////



<<"\n vector \n"

int A[6]  = { 1,2,4,9,8,6 }

a= A[0]

<<"$a\n"
<<"$A\n"

asz= Csz(A)
<<"array size (number of elements) is: $asz \n"

nd = Cnd(A)
<<"number of dimensions are: $nd \n"

ab = Cab(A)
<<"bounds are: $ab \n"



<<" $(Caz(A)) $(typeof(A)) \n"


//<<"%I $A \n"   // will crash why?

 d= Cab(A)

<<"%V $d \n"


/////////////////////////////////////////
<<"////\n Two dimensions \n"
// FIXME  -- won't fill in rows

 int  B[2][3] = { {0,3,2 }, {-1,1,-2} };


 <<"$B\n"

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