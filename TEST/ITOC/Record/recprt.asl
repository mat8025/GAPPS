
include "debug.asl"

debugON();

record R[5];

checkIn()

 R[0] = Split("each to his own")
 R[1] = Split("and the devil take the hindmost")
 R[2] = Split("you are as strong as your will")
 R[3] = Split("this is the 4th record")

setdebug(1,@~trace);

wrow= 1;
wcol=2;
R->info(1)
wrd= "$R[wrow][wcol]";
R->info(1)
<<"$wrow $wcol  <|$wrd|>\n"


checkStr(wrd,"devil")




<<"%V$R[0]\n"

<<"%V$R[0][0] \n"
<<"%V$R[0][1] \n"

<<"%V$R[1]\n"
<<"%V$R[1][2] \n"
<<"%V$R[1][3] \n"
<<"/////\n"
for (wrow =0; wrow <4; wrow++) {
for (wcol =0; wcol <4; wcol++) {
 wrd= "$R[wrow][wcol]";
<<"%V$wrow $wcol $R[wrow][wcol] $wrd\n"
}
}

wrd= "$R[1][2]";

<<"%V [1][2]  $wrd\n"


wrow = 1;
wcol = 2;

R->info(1)
wrd= "$R[wrow][wcol]";
R->info(1)
<<"%V$wrow $wcol  $wrd\n"

checkStr(wrd,"devil")

wrow = 3;
wcol = 4;

wrd= "$R[wrow][wcol]";

checkStr(wrd,"record")

checkOut()

exit();

<<"%V$R\n"
<<"%V$R[::]\n"
<<"/////\n"
<<"%V$R[1]\n"
<<"%V$R[2]\n"
<<"%V$R[3]\n"

<<"/////\n"
exit()

<<"%V$R[1][::]\n"
<<"%V$R[1][0] \n"
<<"%V$R[1][3] \n"
<<"%V$R[2][2] \n"
<<"%V$R[3][4] \n"

