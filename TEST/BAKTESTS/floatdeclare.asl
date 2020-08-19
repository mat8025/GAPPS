#
CheckIn()
//setdebug(0)

// we have to do the opendll explicitly -- for XIC

float v = 2.3


<<"%v $v $(typeof(v)) \n"
 CheckFNum(v,2.3,6)

double z = 3.6

<<"%V $z $(typeof(z)) \n"

// val via function

 CheckFNum(z,3.6,6)

double pi = 4.0 * atan(1.0)

<<"%V $pi $(typeof(pi)) \n"

 CheckFNum(pi,_PI,6)
// implicit dec --- probably should be double


pi2 =  4.0 * atan(1.0)

<<"%V $pi2 $(typeof(pi2)) \n"

 CheckFNum(pi2,_PI,6)

  CheckOut()
;




//