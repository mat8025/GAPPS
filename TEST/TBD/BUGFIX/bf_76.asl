//
// Re[inpt] = ri_j->getReal()  - ri_k->getReal()  // bug????
//

//setdebug(1,"pline")

chkIn()

N = 8

float Re[N]

 Re = -766667;

<<"$Re\n"

inpt = 0;
cmplx ri_j;
cmplx ri_k;


  ri_j->Set(12,47);
  ri_k->Set(79,85);

<<"%V$ri_j\n"
<<"%V$ri_k\n"

  Re[inpt] = ri_j->getReal()  - ri_k->getReal()  // bug????

<<"$Re\n"
<<"$Re[inpt]   == -67 \n"
chkR(Re[inpt],-67.0)
inpt++

  ri_kr = ri_k->getReal()  

<<"%V$ri_kr \n"
  ri_jr = ri_j->getReal()  

<<"%V$ri_jr \n"

  Re[inpt] = 13 ; // bug????input
  
<<"$Re\n"
<<"$Re[inpt]   == 13?? \n"
chkR(Re[inpt],13.0)
  inpt++;
  
  Re[inpt] = ri_j->getReal() ; // bug????

<<"$Re\n"
<<"$Re[inpt]   == 12?? \n"
chkR(Re[inpt],12.0)
  Re[inpt] = ri_j->getReal()  + ri_k->getReal(); // bug????

<<"$Re\n"

<<"$Re[inpt]   == 91?? \n"
chkR(Re[inpt],91.0)
   inpt--;

  Re[inpt] = ri_j->getReal()  + ri_k->getReal(); // bug????

<<"$Re\n"

<<"$Re[inpt]   == 91?? \n"

chkR(Re[inpt],91.0)


chkOut()

exit()
/{
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

/}