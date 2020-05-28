
setdebug(1,"trace","pline","step")

val = 90.0;
cmplx g[16] = {1,2,3,4,5,6,7,8,9,10};

sz = Caz(g)
<<"%V$sz $g\n"

 g[3]->Set(47,79)

<<"$g[3]\n"


  g[4]->setReal(val);


<<"$g[4] \n"

  g[4]->setReal(80);


<<"$g[4] \n"

exit()