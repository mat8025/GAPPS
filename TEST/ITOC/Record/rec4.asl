



SetDebug(1,"trace")

CheckIn()

record R[10];


 R[0] = Split("how many cols in this record?")

<<"%V$R[0]\n"

R[2] = R[0];

<<"%V$R[2]\n"


   R[5][0] = R[2][1];

<<"in %V$R[5]\n"

   R[5][1] = R[2][0];

<<"in %V$R[5]\n"

checkStr(R[5][0],"many")
checkStr(R[5][1],"how")


checkOut()
