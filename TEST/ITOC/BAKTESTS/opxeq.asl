
CheckIn()
int n = 3

    m = 4

    n += m

<<"%V $n $m \n"
 CheckNum(m,4)
 CheckNum(n,7)
    n -= m

<<"%V $n $m \n"

 CheckNum(m,4)
 CheckNum(n,3)
    n -= m

<<"%V $n $m \n"

// CheckFNum(n,-1,6)

    n += m
 CheckNum(n,3)
<<"%V $n $m \n"

    n += m
 CheckNum(n,7)
<<"%V $n $m \n"



  s = 0.00001

  x = 3481.0

  z = x

  s *= x


<<" $s $x $z \n"




    n += m

<<"%V $n $m \n"

    n -= m

<<"%V $n $m \n"

    n -= m

<<"%V $n $m \n"

   k = 45

<<" $k \n"

   k++

<<" $k \n"

   ++k 

<<" $k \n"

   ++k++ 

<<" $k \n"



   n = 5
   k /= n

<<" $k $n\n"
 CheckNum(k,9)
 CheckNum(n,5)
CheckOut()
stop!