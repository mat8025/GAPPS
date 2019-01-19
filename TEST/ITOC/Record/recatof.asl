
include "debug.asl"

debugON();

record R[5];
Rn = 6;
checkIn()

proc Score()
{
  f =0;
  for (i=0; i<Rn;i++) {

  f += Atof(R[i][wcol])
  <<"$i $R[i][wcol] $f\n"
  }

  return f;
  
}

//===========================//

 R[0] = Split("0 1 2 3 4 5")
 R[1] = Split("0 1 2 3 4 5")
 R[2] = Split("0 1 2 3 4 5")
 R[3] = Split("10 11 12 13 14 15")
 R[4] = Split("20 21 22 23 24 25")
 R[5] = Split("30 31 32 33 34 35")

PCDoneCol = 3;

wrow= 1;
wcol=2;
R->info(1)
wrd= "$R[wrow][wcol]";
R->info(1)
<<"$wrow $wcol  <|$wrd|>\n"

<<"$R[1][2]\n"

float f;

  f = Atof(R[1][2])

<<"%V $f\n"
wcol = 4;
  f = Atof(R[wrow][wcol])

<<"%V $f\n"


rf=Score()
checkNum(rf,84)

  <<"%V$R[1][PCDoneCol] \n"
  R[1][PCDoneCol] = "42";
  <<"%V$R[1][PCDoneCol] \n"




checkStr( R[1][PCDoneCol], "42");

 R[wrow][wcol] = "68";

 wrd = R[wrow][wcol];




 checkStr( R[wrow][wcol], "68");

<<"$wrow $wcol  <|$wrd|>\n"

checkStr( wrd, "68");

 wrd = R[wrow+4][wcol+1];

<<"$wrd   $R[5][5] \n"

 checkStr( R[wrow+4][wcol+1], "35");

 checkStr( R[wrow*2][wcol+1], "5");

<<"$wrd   $R[2][5] \n"

 checkStr( R[wrow*3][wcol-1], "13");

wrd = R[wrow*3][wcol-1];
 
<<"$wrd   $R[wrow*3][wcol-1] \n"


wrd = R[Trunc(wrow*3.4)][wcol-1];
 
<<"$wrd   $R[wrow*3][wcol-1] \n"
checkStr( wrd, "13");


wrd = R[Round(wrow*3.7)][Round(wcol-1.6)];

<<"$wrd  $(Round(wcol-1.6))  \n"

//<<"$wrd   $R[Round(wrow*3.7)][Round(wcol-1.6)] \n"

checkStr( wrd, "22");


wrd = R[Round(wrow*3.7)][Round(wcol-2.6)];

col = Round(wcol-2.6);

<<"$wrd  $(Round(wcol-2.6)) $col \n"

checkStr( wrd, "21");
checkOut()

exit()