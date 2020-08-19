//  testing pan trunc
checkIn()
setAP(10)
setdebug(1)
pan p
//pan m

f = 10.23

p = f

<<"%V$p $f \n"

checkFNum(p,10.23)

m = trunc(p)


<<"%V$p $m $(typeof(m)) \n"



checkNum(m,10)

checkOut()