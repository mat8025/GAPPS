///
///
///


char dv[] = { 'G', 25, 28, 78, 'O', '0', 69, 75,76,77 }

<<"$dv \n"
<<"%c$dv \n"

<<"$dv[4]\n"

 CheckNum(dv[4], 'O' );

 S=testargs(dv[4], 'O' );


 <<"%(1,,,\n)$S\n"


 S=testargs(dv[4], 'ABC' );


 <<"%(1,,,\n)$S\n"