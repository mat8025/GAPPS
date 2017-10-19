//
// Re[inpt] = ri_j->getReal()  - ri_k->getReal()  // bug????
//

//setdebug(1,"pline")

checkIn()

N = 8

float Re[N]

 Re = -766667;

<<"$Re\n"

inpt = 0;
cmplx ri_j;
cmplx ri_k;


  ri_j->SetV(12,47);
  ri_k->SetV(79,85);

<<"%V$ri_j\n"
<<"%V$ri_k\n"

  Re[inpt] = ri_j->getReal()  - ri_k->getReal()  // bug????

<<"$Re\n"
<<"$Re[inpt]   == -67 \n"
checkFnum(Re[inpt],-67.0)
inpt++

  ri_kr = ri_k->getReal()  

<<"%V$ri_kr \n"
  ri_jr = ri_j->getReal()  

<<"%V$ri_jr \n"

  Re[inpt] = 13 ; // bug????input
  
<<"$Re\n"
<<"$Re[inpt]   == 13?? \n"
checkFnum(Re[inpt],13.0)
  inpt++;
  
  Re[inpt] = ri_j->getReal() ; // bug????

<<"$Re\n"
<<"$Re[inpt]   == 12?? \n"
checkFnum(Re[inpt],12.0)
  Re[inpt] = ri_j->getReal()  + ri_k->getReal(); // bug????

<<"$Re\n"

<<"$Re[inpt]   == 91?? \n"
checkFnum(Re[inpt],91.0)
   inpt--;

  Re[inpt] = ri_j->getReal()  + ri_k->getReal(); // bug????

<<"$Re\n"

<<"$Re[inpt]   == 91?? \n"

checkFnum(Re[inpt],91.0)


checkOut()

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