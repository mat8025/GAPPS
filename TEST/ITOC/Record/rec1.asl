
///
///  Records
///

setdebug(1,@keep,@filter,0,@trace);

checkIn()

int ival;


 record R[4+];

  sz = Caz(R);
  <<"%V$sz\n"

 R[0] = Split("80,1,2,3,40,5,6,7,8,9",",");

<<"%V$R[0]\n"

<<"%V$R[0][2]\n"
<<"%V$R[0][4]\n"


ival = atoi(R[0][2]);
sz  = csz(ival)
<<"ival $ival  bounds $(Cab(ival)) sz   $(csz(ival))\n"
checkNum(sz,0)
checkNum(ival,2)


//=============================
 R[5] = R[0];

<<"%V$R[5]\n"
<<"%V$R[5][2]\n"

ival = atoi(R[5][2]);
checkNum(ival,2)

 R[2] = R[0];

<<"%V$R[2]\n"

<<"%V$R[2][2]\n"

  sz = Caz(R);
  <<"%V$sz\n"

ival = atoi(R[2][2]);
sz  = csz(ival)
<<"ival $ival  bounds $(Cab(ival)) sz   $(csz(ival))\n"

checkNum(sz,0)
checkNum(ival,2)

<<"%V$R[2][4]\n"

ival = atoi(R[2][4]);

checkNum(ival,ptan("Zr"))

checkOut()
exit()



 R[1] = Split("10,12,23,34,45,56,67,78,89,90",",");

<<"%V$R[1]\n"
<<"%V$R[1][4]\n"

ival = atoi(R[1][4]);
sz  = csz(ival)
<<"ival $ival  bounds $(Cab(ival)) sz   $(csz(ival))\n"

checkNum(sz,0)
checkNum(ival,45)

ival = atoi(R[1][5]);
checkNum(ival,56)


 R[3] = R[0];

<<"3 == 0 %V$R[3]\n"


<<"[3][4] $R[3][4] \n"

<<"%V$R\n"

ival = atoi(R[3][4]);
checkNum(ival,4)

checkOut()

exit()

sz = Csz(R);
cols = Csz(R[0])
str val;
  val = R[1][4];

<<"val $val $(typeof(val)) $(Cab(val))  $(csz(val))\n"

ival = atoi(val);

<<"ival $ival $(Cab(ival))  $(csz(ival))\n"

ival = atoi(R[3][4]);

<<"ival $ival $(Cab(ival))  $(csz(ival))\n"

exit();

<<"%V $sz $cols \n"
for (i=0; i < sz ; i++) {
  for (j=0; j < cols ; j++) {
     ival = atoi(R[i][j]);
     <<"<$i><$j> $R[i][j]  : $ival\n"
   }
}

 


 


   ival = atoi(R[2][5]);

<<"$ival $(Cab(ival))  $(csz(ival))\n"

str sval

   sval = R[3][4];

<<"$sval $(typeof(sval))  $(Cab(val))  $(csz(val))\n"

<<"$sval[0] \n"

   
   

<<"$sval[1] \n"

ival = atoi( sval[0]);


<<"$ival $(typeof(ival))  $(Cab(ival))  $(csz(ival))\n"

ival->redimn();

<<"$ival $(typeof(ival))  $(Cab(ival))  $(csz(ival))\n"


 aval= ival[0]

<<"$aval $(typeof(aval))  $(Cab(aval))  $(csz(aval))\n"
