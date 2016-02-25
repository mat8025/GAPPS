
x = 3/8.0

<<"%V$x\n"



opendll("math")
opendll("stat")
opendll("plot")
y = tan(x)

<<"$y = tan( $x ) \n"


 A = { 1.0,2,3,4,5,6,7,8,9 }

<<"$A\n"

 A->redimn(3,3)

// B=redimn(A,3,3)


//<<"$B\n"

  C= transpose(A)

<<"$C\n"