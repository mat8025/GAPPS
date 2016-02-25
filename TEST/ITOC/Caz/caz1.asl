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
