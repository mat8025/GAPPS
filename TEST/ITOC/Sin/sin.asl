
//
// test Sin function
//

chkIn()
 a = 1.0;

 a = Sin(0.5)

chkR(a,0.479426)

<<"%V $a = Sin(0.5) \n"

<<"%V $a = $(Sin(0.5)) \n"

 a = Cos(0.5)

chkR(a,0.877583)

<<" $a = $(Cos(0.5)) \n"

 a = Tan(0.5)
<<"Tan $a = $(Tan(0.5)) \n"

 a = Log(0.5)
<<"Log(0.5) $a = $(Log(0.5)) \n"
 a = 4*atan(1.0)
<<"atan(1.0) $a = $(atan(1.0)) $(4*a)\n"
chkR(a,3.141593)

chkOut()
