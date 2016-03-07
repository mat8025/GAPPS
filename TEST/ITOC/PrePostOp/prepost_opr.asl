
//setdebug(1,"trace")


checkIn()
A= vgen(INT_,10,0,1)

<<"$A\n"

A[0] = 47;
A[1] = 79;
A[2] = 80;
A[3] = 14;

<<"$A\n"

int k = 0;

b = A[k]

<<"0th ele is $b\n"

checkNum(b,47)


b= A[k++]

<<"0th ele is still $b\n"

checkNum(b,47)


<<"%V$k\n"

b = A[k]

<<"1st ele is $b \n"

checkNum(b,79)


b= A[k++]

<<"1st ele is $b \n"

checkNum(b,79)


<<"%V$k\n"

b= A[k++]

<<"2nd ele $b \n"

checkNum(b,80)

<<"%V$k\n"

k++;

b= A[k++]

<<"4th ele $b \n"

checkNum(b,4)

<<"%V$k\n"


b= A[k--]

<<"%V$b \n"

checkNum(b,5)

<<"%V$k\n"


b= A[--k]

<<"%V$b \n"


checkNum(b,14)

<<"%V$k\n"

checkNum(k,3)

b= A[++k--]

<<"%V$b \n"

<<"%V$k\n"

checkNum(k,3)
checkNum(b,4)
checkout()

exit()





proc foo(a,b)
{
<<"%V$a $b\n"
 c= a + b
<<"sum %V$c \n"
}


int k = 0

<<"%v $k \n"
k++
<<"%v $k \n"
k--
<<"%v $k \n"
++k++
<<"%v $k \n"
--k--
<<"%v $k \n"

double x0 = 0.0

<<"%v $x0 \n"

x0++

k = 2

m = 2

n = k++ + m--

<<"%V $n $k $m \n"


n = --k + ++m

<<"%V $n $k $m \n"


<<"b4foo %V $k $m \n"

 foo(k++,m++)
<<"%V $k $m \n"


<<"b4foo %V $k $m \n"

 foo(++k,++m)
<<"%V $k $m \n"


exit()

 foo(--k,++m)

<<"%V $k $m \n"

<<"%v $x0 \n"

A = igen(10,0,1)

<<"$A\n"

B = A++

<<"$B\n"

<<"$A\n"

checkout()


stop!
