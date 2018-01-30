///
///
///
setdebug(1,"trace","keep")
filterDebug(1,"Vdeclare","fillarray","declareSet","getsivp")

vsz = 17;

int x[] = vgen(INT_,vsz,1,2)   //   FAIL xic

//int x[];
//x= vgen(INT_,vsz,1,2)   //   FAIL


sz= Caz(x);
<<"$sz %V $x\n"

x[vsz] = 88;

sz= Caz(x);
<<"$sz %V $x\n"


<<"$x[0] $x[1]\n"

int y[] = vgen(INT_,vsz,0,1)   //   FAIL


sz= Caz(y);
<<"$sz %V $y\n"

<<"$y[0] $y[1]\n"
y[vsz] = 88;

sz= Caz(y);
<<"$sz %V $y\n"