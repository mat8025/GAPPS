// op equals

CheckIn()

setdebug(1)
//filterdebug("--->,"<---","variable","token","scope","exp","l1_store")

  x = 4.0

<<"%V$x\n"

  x += 2

<<"%V$x\n"

checkFnum(x,6.0)



 ra = fgen(10,0,1)

<<"$ra\n"

  ra[0] = ra[1] + ra[2]

<<"$ra\n"

  ra[9] += 7

<<"$ra\n"

checkFnum(ra[9],16)

checkFnum(ra[0],3)

  ra[0] += ra[3]

checkFnum(ra[0],6)

<<"$ra\n"

checkFnum(ra[7],7)

j0 = 0
j1 = 1
j2 = 2
j3 = 3


 ra = fgen(10,0,1)

<<"$ra\n"

  ra[j0] = ra[j1] + ra[j2]

<<"$ra\n"

  ra[j0] += ra[j3]

<<"$ra\n"

  checkFnum(ra[j0],6)

<<"$ra[j0] $ra[j1]\n"

  checkFnum(ra[7],7)


proc aoe ( vec)
{

<<"in $_proc\n $vec\n"

  vec[j0] = vec[j1] + vec[j2]

  checkFnum(vec[0],3)

  //vec[j0] += vec[j3]

   vec[0] += vec[3]

  checkFnum(vec[0],6)

<<"$vec\n"

  checkFnum(vec[7],7)

// bug - it is doing vector wide +=  not per element

<<"$vec\n"

<<"$vec[j0] $vec[j1]\n"

}



 ra = fgen(10,0,1)

 aoe(ra)


CheckOut()
