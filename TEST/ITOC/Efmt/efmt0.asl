


//sdb(1,@step)
a =2;


f = 1.3e2;
<<"$f\n"

f = 1.3e(a);
<<"$f\n"

f = 1.3^^(a);
<<"$f\n"

fp = pow(1.3,a);
<<"$fp\n"

g = 1.3e-2;
<<"$g\n"

g = 1.3e(-a);
<<"$g\n"

g = 1.3^^(-a);
<<"$g\n"

gp = pow(1.3,-a);
<<"$gp\n"


hp = fp *gp;

!php


S=testargs(1,1.2e-3,4.3e3)


<<"%(1,,,\n)$S\n"
