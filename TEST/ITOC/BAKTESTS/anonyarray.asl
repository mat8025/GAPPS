
setdebug(0)

a = 4
b = 6

int A[]=  {a,1,2,3};

<<" $A \n"

//int B[2][4] = { {a,1,2,3} , {9,5,6,7} };

//<<" $B \n"

ks = testArgs(1,A)
<<"%(1, , ,\n)$ks \n"

<<" anonyarray as arg\n"
ks= testArgs(A, {a,1,2,3,b} , "some other arg" )
<<"%(1, , ,\n)$ks \n"
//k= foota( {a,1,2,3} , {9,5,6,7,8} , {10,11,a,14,17} )


stop!


//k= foota([a,1,2,3])

 fv[] = {1,2,3, 4, a}


<<"%v $fv \n"

  pv = fv 

<<"%v $pv \n"


  pv = fv @+ {5,6,7,8}

<<"%v $pv \n"

;
