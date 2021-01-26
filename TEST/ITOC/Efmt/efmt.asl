///
///  parse scientific notation
///




chkIn(_dblevel);

e = 1234.567
//sdb(1,@step)
a =2;


f = 1.3e2;
<<"$f\n"

//f = 1.3e(a);
//<<"$f\n"

g = 1.3e-2;
<<"$g\n"

//g = 1.3e(-a);
//<<"$g\n"



h1 = f *g;
!ph1
h = 1.3e-2 * 1.3e2;


!ph


//!a



h1 = 1.3^^-2 
!ph1

h0 =  1.3^^2;
!ph0


!ph1
//!a

h2 = f *g;

<<"%V $f $g $h $h1 $h2\n"


chkR(e,1234.567);

const double Ev = 1.602e-2;

double ev1 = 3.1234567;


chkN(ev1,3.1234567);


<<"%Ve $Ev\n"


chkR(Ev,1.602e-2);

Ev6 = 1.0e2;

<<"$Ev6\n"

Ev6 = 1.0e-2 ;

<<"$Ev6\n"

Ev6 = 1.0e-2 * 1.0e2;

<<"$Ev6\n"

Ev7 = 1.0e2 * 1.0e-2;

<<"$Ev7\n"

chkR(Ev6,Ev7);

chkR(Ev6,(1.0e-2 * 1.0e2));


const double Ev1 = 1.602e-10;


<<"%Ve $Ev1\n"


chkN(Ev1,1.602e-10);

const double Ev2 = 1.602 * 10^^-7;


<<"%Ve $Ev2\n"

chkN(Ev2, 1.602 * 10^^-7);

const double Ev3 = 1.602e29;


<<"%Ve $Ev3\n"

<<"%e $Ev3\n"


const double Ev4 = 1.602e5*1.5e3;

<<"%Ve $Ev4\n"

chkN(Ev4,2.403000e+08);

const double Ev5 = 1.602e5 *1.5e3;

<<"%Ve $Ev5\n"

chkOut();