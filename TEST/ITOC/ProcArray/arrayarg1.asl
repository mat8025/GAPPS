
setdebug(1,"trace")
checkIn()

proc foo(int vec[],k)
{
<<"$_proc IN $vec \n"

<<"pa_arg2 %V$k\n"

  vecp = vec;

  vec[1] = 47;
<<"add 47 $vec \n"  
  vec[2] = 79;
<<"add Au $vec \n"

  vec[3] = 80
  vec[4] = 78
  vec[5] = 50

<<"OUT $vec \n"

<<"OUT orig entry $vecp \n"

  return vec
}
//============================

Z = Vgen(INT_,10,0,1)


Z[0] = 36

<<"$Z\n"

Z[6] = 28

<<"before calling proc\n"

<<"$Z\n"
 W = Z

//Z[0] = 37

//Y = foo(&Z,3)  // FIXED -------- Y is now created correctly with the return vector 

Y = foo(Z,3)  // FIXED -------- Y is now created correctly with the return vector 

//Y=foo(Z,3)  // TBD FIX -- default array name is ref call

//Y= foo(&Z[2],4)  // TBD FIX it does not compute the offset - so proc operates on the third element in

<<"after proc $Z\n"

checkNum(Z[1],47);

checkNum(Z[6],28);

if ((Z[1] == 47)  && (Z[6] == 28)) {

<<"Z[1] and Z[6] correct \n"

}

if ((Z[1] == 47) ) {
 <<"Z correct \n"
}
else {
 <<"Z wrong \n"
}

<<"return vec $Y\n"


checkNum(Y[1],47)
checkNum(Y[6],28)

if ((Y[1] == 47)  && (Y[6] == 28)) {

<<"return of Y[1] and Y[6] is correct \n"

}
else {

<<" return vector incorrect !\n"

}






Y= foo(&W[2],4)  // TBD FIX it does not compute the offset - so proc operates on the third element in


checkOut()



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
