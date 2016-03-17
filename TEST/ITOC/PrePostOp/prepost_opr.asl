
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


int e = ++k ;

<<"%V$e $k \n"


int w = --k ;

<<"%V$w $k \n"

checkNum(e,4)
checkNum(w,3)



int Gc;


proc foo(a,b)
{
<<"%V$a $b\n"
 c= a + b
 
<<"sum %V$c \n"
 return c;
}


 k = 0

<<"%v $k \n"
k++
<<"%v $k \n"
checkNum(k,1)
k--
<<"%v $k \n"
checkNum(k,0)
++k++
<<"%v $k \n"
checkNum(k,2)
--k--
<<"%v $k \n"
checkNum(k,0)

double x0 = -10.0

<<"%v $x0 \n"

checkFNum(x0,-10)

x0++

checkFNum(x0,-9)

k = 2
m = 2

n = k++ + m--

<<"%V $n $k $m \n"

checkNum(n,4)

k = 2
m = 2

n = --k + ++m

checkNum(n,4)


<<"%V $n $k $m \n"


<<"b4foo %V $k $m \n"

 r=foo(k++,m++)
<<"%V $k $m \n"

checkNum(k,2)
checkNum(m,4)

checkNum(r,4)



<<"b4foo %V $k $m \n"

 r = foo(++k,++m)

<<"%V $k $m $r\n"

checkNum(k,3)
checkNum(m,5)

checkNum(r,8)


AV = igen(10,0,1)

<<"$AV\n"

checkNum(AV[1],1)

BV = AV++ ; // this should increment all elements in the vector

<<"$AV\n"

checkNum(BV[1],2)

<<"$BV\n"





checkout()
exit()
