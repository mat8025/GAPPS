
cmplx twf;

<<"%V$twf\n"
twf->Set(47,79.0)

<<"%V$twf\n"
twf->Set(80,45.0)

<<"%V$twf\n"

  for (i = 1; i <=10 ; i++) {

 twf->Set(80+i,45.0-i) ; /// weird parse ; has to be space away from () 
<<"%V$twf\n"

  }

N = 8

float Re[N]

 Re = -766667;

<<"$Re\n"

inpt = 0
cmplx ri_j
cmplx ri_k


  ri_j->Set(12,47)
  ri_k->Set(79,85)

<<"%V$ri_j\n"
<<"%V$ri_k\n"

  Re[inpt] = ri_j->getReal()  - ri_k->getReal()  // bug????

<<"$Re\n"

  inpt++

  ri_kr = ri_k->getReal()  

<<"%V$ri_kr \n"
  ri_jr = ri_j->getReal()  

<<"%V$ri_jr \n"

  Re[inpt] = ri_j->getReal()  * ri_k->getReal() ; // bug????

<<"$Re\n"

  inpt++

  ri_kr = ri_k->getReal()  

<<"%V$ri_kr \n"

  ri_jr = ri_j->getReal()  

<<"%V$ri_jr \n"

  Re[inpt] = ri_j->getReal()  - ri_k->getReal() +ri_j->getImag() ; // bug????

<<"$Re\n"

  inpt++

  ri_kr = ri_k->getReal()  

<<"%V$ri_kr \n"

  Re[inpt] = ri_j->getReal()  + ri_k->getReal()  // bug????

<<"$Re\n"