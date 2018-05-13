
///
///  Records
///

setdebug(1,@keep,@filter,0,@~trace);

 record R[2+];


 R[0] = Split("0,1,2,3,4,5,6,7,8,9",",");

<<"%V$R[0]\n"


<<"%V$R[0][2]\n"


 R[1] = Split("10,12,23,34,45,56,67,78,89,90",",");

<<"%V$R[1]\n"

 R[2] = R[1];

 R[3] = R[0];


<<"$R \n"
int ival;
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
