opendll("math")



  y = Sin(_PI/4.0) 
  z = Cos(_PI/4.0) 

<<" $y $z $_PI \n"

  z = Sin(_PI/4.0) * Cos(_PI/4.0)

<<" $z  \n"


  z = Sin(Cos(_PI/4.0))

<<" $z  \n"

Class Point 
{
  float x;
  float y;

 CMF set(a,b)
  {
      x = a
      y = b
  }

 CMF getx()
  {
     return x
  }

 CMF gety()
  {
     return y
  }

 CMF  mul(a)
  {
      float tmp
      tmp = (a * x)
      return tmp
  }

  CMF print()
 {
<<"%V $x $y \n"

 }


}


 Point A
 Point B
 Point C

 A->set(0.15,0.2)

 A->print()


  my = A->mul( Sin(0.5) )

 A->print()

<<"%V $my \n"





;