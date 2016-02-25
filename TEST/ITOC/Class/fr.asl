opendll("math")
setdebug(0)
CheckIn()

  y = Sin(_PI/4.0) 
  z = Cos(_PI/4.0) 

<<" $y $z $_PI \n"

  z = Sin(_PI/4.0) * Cos(_PI/4.0)

<<" $z  \n"


  z = Sin(Cos(_PI/4.0))

<<" $z  \n"




Class Point 
{
 float x 
 float y 


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

}





 Point A

<<" declared a Point \n"
stop!

 Point B
 Point C

 A->set(0.15,0.2)
 B->set(2.0,2)
 C->set(1,0.2)




<<"%V $A->x $A->y \n"
<<"%V $B->x $B->y \n"
<<"%V $C->x $C->y \n"


stop!
;