

int a[]
int b[]

//ptr d

// a[0:20:2] = 3


 a[0:20:2]->Set(3)

<<" $a \n"

 b[0:20:2]->Set(2,4)

<<"%v $b \n"

<<"%v $a \n"

<<" $(typeof(a)) \n"

   d = &a

<<" $(typeof(d)) \n"

<<" ptr %v $d \n"

 a[0:20:2]->Set(4,3)

<<" reset %v $a \n"

<<" ptr update %v $d \n"

 c = d 

<<" $c \n"

<<"%I $c \n $d \n"
<<"%v $c \n"

  d[0:20:2]->Set(5,3)


<<"%v $a \n"

<<"%v $d \n"

stop!



<<"%v $a \n"

<<"%v $d \n"

    d = &b

<<"%v $d \n"

;



