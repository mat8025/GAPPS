///
///  parse scientific notation
///

setDebug(1,"trace","pline","~step");


checkIn();

const double Ev = 1.602e-29 ;

double ev1 = 3.1234567;


checkNum(ev1,3.1234567);


<<"%Ve $Ev\n"

checkFNum(Ev,1.602e-29);

const double Ev1 = 1.602e-10;


<<"%Ve $Ev1\n"


checkNum(Ev1,1.602e-10);

const double Ev2 = 1.602 * 10^^-7;


<<"%Ve $Ev2\n"

checkNum(Ev2, 1.602 * 10^^-7);

const double Ev3 = 1.602e29;


<<"%Ve $Ev3\n"

<<"%e $Ev3\n"


const double Ev4 = 1.602e5*1.5e3;

<<"%Ve $Ev4\n"

checkNum(Ev4,2.403000e+08);

const double Ev5 = 1.602e5 *1.5e3;

<<"%Ve $Ev5\n"

checkOut();