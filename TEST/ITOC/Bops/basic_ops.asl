
CheckIn()

ret =opendll("math")

ret = 0

//prog= GetScript()

z = Sin(0.9)

<<" %v $z \n"

<<" %v $ret \n"

x = Cos(0.9)

<<" %v $z $x \n"

//   test some basics -- before using testsuite  
openDll("math")
//   declare
//setdebug(0)
int k = 4

<<"%v $k \n"

CheckNum(k,4)

float y = 3.2

<<"%v $y \n"

CheckFNum(y,3.2,6)




a = 2 + 2

<<"%v $a \n"
//     CheckNum(a,4)

sal = 40 * 75 * 4

<<"%v $sal \n"
     CheckNum(sal,12000)

   CheckOut()


STOP!
