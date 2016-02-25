
// test proc



CheckIn()

proc foo(a)
{
 <<" IN $_proc $a \n"

 float tmp

 tmp = a/2.0

 return tmp

}



x = 20.2

 <<"%V $_proc $x \n"

 y = Cos(x)

<<" $y \n"

 y = Sin(y)

<<" $y \n"

 y /= 2

  t = foo(Sin(Cos(x)))

<<"$x $t \n"

  CheckFNum(t,y,6)


x = -20.2

 <<"%V $_proc $x \n"

 y = Cos(x)

<<" $y \n"

 y = Sin(y)

<<" $y \n"

 y /= 2


  t = foo(Sin(Cos(x)))

<<"$x $t \n"

  CheckFNum(t,y,6)


 x = -15.2

 y = Sin(x)

 y = Cos(y)

<<" $y \n"

 y /= 2

  t = foo(Cos(Sin(x)))

<<"$x $t \n"

  CheckFNum(t,y,6)

 x = -15.2

 y = Sin(x)

 y = Cos(y)

 y = Sin(y)

 y /= 2

  t = foo(Sin(Cos(Sin(x))))

<<"$x $t \n"

  CheckFNum(t,y,6)


 x = -15.2

 y = Sin(x)

 y = Cos(y)

 y = Sin(y)

 y = Sqrt(y)

 y /= 2

  t = foo(Sqrt(Sin(Cos(Sin(x)))))

<<"$x $t \n"

  CheckFNum(t,y,6)



N = _clargs[1]

<<" $_clargs[::] \n"


//FIXME   t = foo(Cos(x))

t = foo(Cos(x))

 <<"$x $t \n"

CheckOut()

stop!



int k = 1

<<" START $k $N \n"

 a = 2
 y = a

<<" $y = $a \n"

proc poo()
{
// increments global k
// does calc and returns that value   
   k++
   a= k * 2
<<" in $_cproc %v $k $a\n" 
}


proc noo()
{
   k++
   a= k * 4
<<" in $_cproc %v $k $a\n" 
    return a 
}


 k = 0
 while ( k < N) {

<<" before poo call k is $k\n"

    poo()

<<" after poo call \n"
<<" 2 after poo call \n"

 <<" poo a is $a k is now $k\n"

 }


<<" DONE $k $N \n"

STOP!



////  TODO/FIX /////////////
// does not move to statement after proc call
// immediate statement after proc return is not executed

