
setdebug(1)

proc foo()
{
<<" $_proc \n"

  // showStack();

}


setap(50)

nurser = scat("Jolly ", "Jack ", " Horner");
<<"$nurser \n";

wi = sstr(nurser,"ack")

<<"%V$wi\n"

double d = 123.456789;

<<"$d \n"

 if (d == 123.456789) {
<<"$d is 123.456789\n"
 }


long l = 123456789;

<<"$l \n"

 if (l == 123456789) {
<<"$l is 123456789\n"
 }


//cmplx cx = {1,2};

cmplx cx

 cx->Set(1,2)

<<"%V$cx \n"
dcmplx dx;

dx = cx;

<<"%V$dx $(typeof(dx))\n"

 pan a = 0.30000000000000000802500000000;

<<"$(typeof(a)) $a\n"


pan b = 10.0000000000000003210000457;

<<"$(typeof(b)) $b\n"

// b->set("0.000000000047");

//<<"$(typeof(b)) $b\n"

pan c = 12300000.0000321000123000000100;

<<"$(typeof(c)) $c\n"

     if (c == 12300000.00003210001230000100) {
<<"$c is 12300000.00003210001230000100\n"

     }
     else {
<<"need a precision test !\n"

     }


foo()

 c= 123456789.98765432100000000100

<<"%V$c \n"


<<"DONE\n"