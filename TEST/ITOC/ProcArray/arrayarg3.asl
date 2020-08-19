
setdebug(1)
chkIn()

proc foo(int vec[],k)
{
<<"$_proc IN $vec \n"
<<"pa_arg2 %V$k\n"
  vec[1] = 47
  vec[2] = 79
  vec[3] = 80
  vec[4] = 78
  vec[5] = 50

<<"OUT $vec \n"
  return vec
}


Z = Vgen(INT,10,0,1)

Z[0] = 36

<<"$Z\n"

Z[6] = 28

<<"before calling proc\n"

<<"$Z\n"



//Y = foo(&Z,3)  // FIXED -------- Y is now created correctly with the return vector 

//Y=foo(Z,3)  // TBD FIX -- default array name is ref call

Y= foo(&Z[1],4)  // TBD FIX it does not compute the offset - so proc operates on the third element in

<<"after proc $Z\n"

chkN(Z[1],47)
chkN(Z[6],28)

if ((Z[2] == 47)  && (Z[7] == 28)) {

<<"Z[1] and Z[6] correct \n"

}

if ((Z[1] == 47) ) {
 <<"Z correct \n"
}
else {
 <<"Z wrong \n"
}

<<"return vec $Y\n"


chkN(Y[1],47)
chkN(Y[6],28)

if ((Y[1] == 47)  && (Y[6] == 28)) {

<<"return of Y[1] and Y[6] is correct \n"

}
else {

<<" return vector incorrect !\n"

}


chkOut()



stop!


if (Y[1] == 47) {
<<"Y correct \n"
}
else {
<<"Y wrong \n"

}

stop!


/////////////////////  simple scalar ///////////////////

proc doo(a,b)
{

  c= a + b
<<"%V$c\n"
  return c

}


  t=doo(3,4)
<<"$t\n"

  t=doo(7,8)
<<"$t\n"


  t=doo(27,35)
<<"$t\n"


stop!
