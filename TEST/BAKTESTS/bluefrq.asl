# Thu Dec 28 12:49:14 2017 5.99

include "consts"

double wlen;

wlen = 380 * 1.0e-9;
<<"%e$wlen\n"
t=wlen/_c;
f= 1.0/t;
<<"$f\n"
thz= f * 1.0e-12;
<<"$f $thz\n"
