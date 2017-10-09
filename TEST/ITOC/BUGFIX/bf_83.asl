//setdebug(1,"trace")

checkIn()

int a = 4;

<<"%V$a\n"

int b = -4;

<<"%V$b\n"

float c = 47.0;

<<"%V$c\n"

float d = -79.0;

<<"%V$d\n"

float e = -7;

<<"%V$e\n"

float q = -7;<<"%V$q\n";int m = -4;<<"%V$m\n";double dl=-47.79;<<"$dl\n";

checkFnum(q,-7)
checkNum(b,-4)
checkNum(a,4)
checkFnum(e,-7)
checkFnum(dl,-47.79)


checkOut()