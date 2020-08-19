



SetDebug(1,"trace")

chkIn()

//record R[10][10];
record R[10];


 R[0] = Split("how many cols in this record?")

<<"%V$R[0]\n"

<<"%V$R[0][3]\n"

R[2] = R[0];

<<"%V$R[2]\n"
<<"%V$R[2][1]\n"
<<"%V$R[2][2]\n"

R[5] = R[0];

<<"in %V$R[5]\n"
<<" %V$R[5][1]\n"
<<" %V$R[5][2]\n"
<<" %V$R[5][5]\n"



   R[5][0] = R[2][1];

<<"in %V$R[5]\n"

   R[5][1] = R[2][0];

<<"in %V$R[5]\n"

chkStr(R[5][0],"many")
chkStr(R[5][1],"how")

sz= Caz(R[5])

<<"$sz\n"

chkOut()
