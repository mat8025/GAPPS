///
///
///


CheckIn()


proc poo(a)
{
 float tmp

 tmp = a/2.0

 return tmp

}
//=====================

N = _clarg[1]
M = _clarg[2]

<<" $_clarg[0:-1] \n"

 a=testargs(N,M)

<<" $a $N $M\n"

 int k = 0

 kt = typeof(k)

 <<"%V $k $kt \n"

 ut = utime()

 <<"%V $ut \n"

 y = 1.0 

 m = 2

  d = 45.0

  r = deg2rad(d)

<<"%V $r \n"

  x= Sin(r)

  <<"Sin $r = $x   \n"

  x= Sin(deg2rad(d))

  <<"Sin $d degs = $x   \n"


  y= Cos(deg2rad(d))

  <<"Cos $d degs = $y   \n"


  z = Sin(deg2rad(d)) * Cos(deg2rad(d))

  <<" Sin $d * Cos $d  = $z\n"

  float w = x * y

  <<" $x * $y = $w \n"

  //     CheckNum(w,z)

  z = Cos(Sin(deg2rad(d))) * Sin(Cos(deg2rad(d)))

<<" $z \n"

  w = Cos(x) * Sin(y)

<<" $w \n"

  CheckFNum(w,z,4)

// FIXME

  z = Sin(Cos(Sin(deg2rad(d)))) * Cos(Sin(Cos(deg2rad(d))))

<<" $z \n"



  w = Sin(Cos(x)) * Cos(Sin(y))

<<" $w \n"

  CheckFNum(w,z,3)


  t = poo(x)

<<"$x $t \n"


//FIXME   t = poo(Cos(x))

 t = poo(Cos(x))
 <<"$x $t \n"



  k = 0

 while (k <= 360) {

  x= Sin(deg2rad(k))

//    <<"$k  $x\n"

  k++

 }


CheckOut()




