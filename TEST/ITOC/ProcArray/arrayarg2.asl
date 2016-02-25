setdebug(1)

setPrintIndent(3)

checkIn()

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

///////////////  Array name ////////////////////////////////////////
 Z = Vgen(INT,10,0,1)

<<"init $Z\n"

 Z[0] = 36
 Z[1] = 53
 Z[6] = 28

<<"before calling proc $Z\n"

  Y=foo(Z,3)  // TBD FIX -- default array name is ref call

<<"after calling proc $Z\n"

  if ((Z[1] == 47)  && (Z[6] == 28)) {
   <<"Z[1] and Z[6] correct \n"
  }

  if ((Z[1] == 47) ) {
    <<"Z[1] correct \n"
  }
  else {
   <<"Z wrong \n"
  }


checkNum(Z[1],47)

checkNum(Z[6],28)

<<"Array Name return vec $Y\n"

checkStage("ArrayName")

///////////////  &Array ////////////////////////////////////////

  showStatements(1)


  Z = Vgen(INT,10,0,1)

  Z[0] = 36
  Z[8] = 28

 // Z[0] = 36  // FIX TBD last element offset is being used as function para offset!!


  <<"before calling proc\n"

  <<"$Z\n"

   Y = foo(&Z,3)  // FIXED -------- Y is now created correctly with the return vector 


<<"after calling proc $Z\n"

  checkNum(Z[1],47)
  checkNum(Z[8],28)

  checkStage("&Array")


Z = Vgen(INT,10,0,1)

Z[0] = 36
Z[8] = 28

<<"before calling proc $Z\n"

// TBD FIX it does not compute the offset - so proc does not operate on the third element in

  Y= foo(&Z[2],4)  

<<"after proc $Z\n"

 if ((Z[3] == 47)  && (Z[8] == 28)) {
   <<"Z[3] and Z[8] correct \n"
 }

 if ((Z[3] == 47) ) {
  <<"Z correct \n"
 }
 else {
  <<"Z wrong \n"
 }


  checkNum(Z[3],47)
  checkNum(Z[8],28)

  checkStage("&Array[2]")
  showStatements(0)

<<"return Y vec $Y\n"



 checkNum(Y[1],47)
 checkNum(Y[6],28)

  checkStage("ArrayReturn")


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
