


proc array_sub( rl)
{
float t1
float t2
<<"////////////////////////// IN PROC //////////////\n"
<<"$rl \n"

     t1 = rl[4] 
<<"%V$t1\n"
<<"$(Caz(t1))\n"
checkFnum(t1,4)

     t2 = rl[0] 
<<"%V$t2\n"
<<"$(Caz(t2))\n"
checkFnum(t2,0)


  return t1
}

//////////////////////////////////////////////////////////////////////////////////////

CheckIn()

double Real[10]

Real = dgen(10,0,1)

val = array_sub(Real)

<<"%V$val \n"
sz = Caz(val)
<<"%V$sz\n"

CheckOut()
exitsi()