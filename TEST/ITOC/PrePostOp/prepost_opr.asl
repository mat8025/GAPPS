
setdebug(1)

proc foo(a,b)
{
<<"%V$a $b\n"
 c= a + b
<<"sum %V$c \n"

}

int k = 0

<<"$v $k \n"
k++
<<"$v $k \n"
k--
<<"$v $k \n"
++k++
<<"$v $k \n"
--k--
<<"$v $k \n"

double x0 = 0.0

<<"$v $x0 \n"

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

<<"$v $x0 \n"

A = igen(10,0,1)

<<"$A\n"

B = A++

<<"$B\n"

<<"$A\n"

stop!
