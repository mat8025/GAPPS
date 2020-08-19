CheckIn()

prog= GetScript()




 y=Sin(1.0)

 <<" $y \n"

 y=Cos(0)

 <<"cos $y \n"

  checkNum(y,1.0)



 pi = 4.0 * atan(1.0)

<<"%v $pi \n"

y = Sin(pi/2.0)

<<" sin pi/2 $y \n"

  checkNum(Fround(y,2),1.0)



  pir =Fround(pi,5)  

 if ( Fround(pi,5) == 3.14159) {
<<" $pir == 3.14159 \n"
 }
 else {
<<" $pir != 3.14159 \n"

  }

   checkNum(Fround(pir,5),3.14159)

  CheckOut()

STOP!
