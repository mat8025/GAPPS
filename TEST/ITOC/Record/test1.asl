
include "debug.asl"

debugON();

record R[5];

chkIn()

 R[0] = Split("each to his own")
 R[1] = Split("and the devil take the hindmost")
 R[2] = Split("you are as strong as your will")
 R[3] = Split("this is the 4th record")

setdebug(1,@trace);
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

wrow= 1;
wcol=2;
wrd= "$R[wrow][wcol]";
<<"%V$wrow $wcol  $wrd\n"
chkStr(wrd,"devil")

chkOut()

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

