//%*********************************************** 
//*  @script rec1.asl 
//* 
//*  @comment test recA=rec5 use 
//*  @release CARBON 
//*  @vers 1.36 Kr Krypton                                                
//*  @date Sat Jan 19 06:45:00 2019 
//*  @cdate 1/1/2007 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%

///
///  Records
///



include "debug.asl"

debugON();


setdebug (1, @pline, @~step, @trace, @soe) ;

checkIn(1)

  Record R[4+];


  Nrecs = Caz(R);
  Ncols = Caz(R,1);

<<"num of records $Nrecs  num cols $Ncols\n";

recinfo = info(R);
<<"$recinfo \n"


 R[0] = Split("80,1,2,3,40,5,6,7,8,9",',');
 R[1] = Split("82,5,4,3,40,5,6,7,8,9",',');
 R[2] = Split("83,7,6,5,40,5,6,7,8,9",',');
 R[3] = Split("84,8,7,6,40,5,6,7,8,9",',');
 R[4] = Split("85,9,8,7,40,5,6,7,8,47",',');
 R[6] = Split("87,9,8,7,40,5,6,7,8,79",',');


<<" $R[::] \n"


  Nrecs = Caz(R);
  Ncols = Caz(R,1);

<<"num of records $Nrecs  num cols $Ncols\n";

 recinfo = info(R);
 <<"$recinfo \n"




<<"%V$R[0]\n"

<<"%V$R[0][2]\n"
<<"%V$R[0][4]\n"


int ival = atoi(R[0][2]);
sz  = csz(ival)
<<"ival $ival  bounds $(Cab(ival)) sz   $(csz(ival))\n"
checkNum(sz,0)
checkNum(ival,2)


//=============================
 R[5] = R[1];

<<"%V$R[5]\n"
<<"%V$R[5][2]\n"
fval = atoi(R[1][2]);
ival = atoi(R[5][2]);
ival->info(1)
checkNum(ival,fval)


<<"%V$R[3]\n"
R[3][3]=R[2][3]
<<"%V$R[3]\n"

<<"%V$R[2][3]\n"
<<"%V$R[3][3]\n"

fval = atoi(R[2][3]);
ival = atoi(R[3][3]);

checkNum(ival,fval)



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


pval = ptan("Zr");

<<"%V $pval \n"
checkNum(ival,pval)
checkNum(ival,ptan("Zr"))

<<" $R[::] \n"

deleteRows(R,2,4)

<<" $R[::] \n"

deleteRows(R,1,-1)

<<" $R[::] \n"


recinfo = info(R);
<<"$recinfo \n"

 R[1] = Split("82,5,4,3,40,5,6,7,8,29",",");
 R[2] = Split("83,7,6,5,40,5,6,7,8,30",",");
 R[3] = Split("84,8,7,6,40,5,6,7,8,31",",");
 R[4] = Split("85,9,8,7,40,5,6,7,8,32",",");
 R[6] = Split("87,9,8,7,40,5,6,7,8,33",",");

<<" $R[::] \n"

deleteRows(R,1,-1)

recinfo = info(R);
<<"$recinfo \n"

<<" $R[::] \n"

 R[1] = Split("82,5,4,3,40,5,6,7,Sn,50",",");
 R[2] = Split("83,7,6,5,40,5,6,7,Sb,51",",");
 R[3] = Split("84,8,7,6,40,5,6,7,Te,52",",");
  R[7] = Split("84,8,7,6,40,5,6,7,I,53",",");

<<" $R[::] \n"

recinfo = info(R);
<<"$recinfo \n"




//////////////////////////////////////////


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


<<"%V$R[3][4]\n"

ival = atoi(R[3][4]);
<<"%V $ival\n"
checkNum(ival,40)

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
