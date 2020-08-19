
////
//// Unary
/// ic version does not get UPLUS correct

checkIn()
r = 1.0

rspo2 = -8.5 * r * r + -14.6 * r + -107.25 

checkFnum(rspo2,-130.35)

rspo2 = -8.5 * r * r + -14.6 * r + +107.25 

checkFnum(rspo2,84.15)
<<"%V $rspo2 \n"


checkOut()