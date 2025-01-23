


a =123.456

<<"%V $a\n"

A = ofw("fstrout.txt")
<<"%V $A\n"


<<[A]" %V $a \n"

<<[A]" $(a+2)\n"


//fprintf(A," fprintf %d\n",A);

!!"cat fstrout.txt"

cf(A)


