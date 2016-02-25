
checkIn()

r = 1.0

<<"%V $r \n"

rspo2 = -8.5 * r * r  

<<" %v $rspo2 \n"

checkFnum(rspo2,-8.5)

rspo2 = -8.5 * r * r  + -14.6 

<<" %v $rspo2 \n"

checkFnum(rspo2,-23.1)


rspo2 = -8.5 * r * r + -14.6 * r 

<<"%V $rspo2 \n"
checkFnum(rspo2,-23.1)

rspo2 = -8.5 * r * r + -14.6 * r + 108.25 

checkFnum(rspo2,85.15)
<<"%V $rspo2 \n"

rspo2 = -8.5 * r * r + -14.6 * r + +107.25 

checkFnum(rspo2,84.15)
<<"%V $rspo2 \n"

rspo2 = -8.5 * r * r + -14.6 * r + -107.25 

checkFnum(rspo2,-130.35)
<<"%V $rspo2 \n"


checkOut()
STOP!
