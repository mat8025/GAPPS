
chkIn()
int n = 3

    m = 4

    n += m

<<"%V $n $m \n"
 chkN(m,4)
 chkN(n,7)
    n -= m

<<"%V $n $m \n"

 chkN(m,4)
 chkN(n,3)
    n -= m

<<"%V $n $m \n"

// chkR(n,-1,6)

    n += m
 chkN(n,3)
<<"%V $n $m \n"

    n += m
 chkN(n,7)
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
 chkN(k,9)
 chkN(n,5)
chkOut()
stop!