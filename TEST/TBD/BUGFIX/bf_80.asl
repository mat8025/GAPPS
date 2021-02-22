
////
//// Unary
/// ic version does not get UPLUS correct

chkIn()
r = 1.0

rspo2 = -8.5 * r * r + -14.6 * r + -107.25 

chkR(rspo2,-130.35)

rspo2 = -8.5 * r * r + -14.6 * r + +107.25 

chkR(rspo2,84.15)
<<"%V $rspo2 \n"


chkOut()