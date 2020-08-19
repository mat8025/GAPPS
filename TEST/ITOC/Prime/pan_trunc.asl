//  testing pan trunc
chkIn()
setAP(10)
setdebug(1)
pan p
//pan m

f = 10.23

p = f

<<"%V$p $f \n"

chkR(p,10.23)

m = trunc(p)


<<"%V$p $m $(typeof(m)) \n"



chkN(m,10)

chkOut()