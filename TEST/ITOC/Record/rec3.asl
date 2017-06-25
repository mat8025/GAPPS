///
///  Records
///

//record R[];  // TBF

// test assignment of ele and field

setDebug(1);

record R[10];

R[0] = Split("how many cols in this record?")

<<"in record[0] we have:-  $R[0] \n"

<<"in record[0][1] we have:-  $R[0][1] \n"

rf = R[0][2];

<<"%V$rf $R[0][2]\n"

checkStr(rf,"cols")

checkOut()
exit()


R[0] = Split("does this replace")

<<"in record[0] now we have:-  $R[0] \n"



R[1] = R[0];

<<"in %V$R[1]\n"

<<" assigning to R[0][2] \n"

R[0][2] = "hey"


<<"in record[0] we have:-  $R[0] \n"


R[0][3] = "man"


<<"in record[0] we have:-  $R[0] \n"


R[1][3] = "man"


<<"in record[1] we have:-  $R[1] \n"

