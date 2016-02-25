#/* -*- c -*- */

// test complex & dcomplex types

//SetDebug(1,"pline")
checkIn()

cmplx a
cmplx b;


  a->set(2.5,0.5)

  mag = a->Mag()
  ph = a->Phase()
  re = a->getReal()
  im = a->getImag()

<<"%V$mag $ph $re $im\n"

<<"%V$a $b\n"


  b->Set(0.5,-1.0)

  c = a + b

<<"%V$a + $b $c \n"

  c = a - b

<<"%V$a - $b $c \n"  

  c = a * b

<<"%V$a * $b $c \n"

  d = a / b

<<"%V$a /  $b $d \n"

  e = d * b

<<"%V$d *  $b  = $e \n"


dcmplx  r
dcmplx  t
dcmplx  rt
  r->Set(2.5,0.5)

  rmag = r->Mag()
  rph = r->Phase()
  rre = r->getReal()
  rim = r->getImag()

<<"%V$rmag $rph $rre $rim\n"
<<"$(typeof(r))\n"

  t->Set(-3.512345,0.767345)

  rmag = t->Mag()
  rph = t->Phase()
  rre = t->getReal()
  rim = t->getImag()

<<"%V$rmag $rph $rre $rim\n"
<<"$(typeof(t))\n"


   rt = t + a

<<"%V$t +  $a  = $rt \n"

   rt = t * a

<<"%V$t *  $a  = $rt \n"

   rt = a * t

<<"%V$a *  $t  = $rt \n"          

    
  rt = t + r

<<"%V$t +  $r  = $rt \n"  
  
  
  
  rmag = rt->Mag()
  rph = rt->Phase()
  rre = rt->getReal()
  rim = rt->getImag()

<<"PLUS %V$rmag $rph $rre $rim\n"
<<"$(typeof(rt))\n"



  
  rt = t * r

  rmag = rt->Mag()
  rph = rt->Phase()
  rre = rt->getReal()
  rim = rt->getImag()

<<"MUL %V$rmag $rph $rre $rim\n"

<<"$(typeof(rt))\n"

<<"%V$t *  $r  = $rt \n"  
  

  rt = t / r

  rmag = rt->Mag()
  rph = rt->Phase()
  rre = rt->getReal()
  rim = rt->getImag()

    <<"DIV %V$rmag $rph $rre $rim\n"

<<"$(typeof(rt))\n"

<<"%V$t /  $r  = $rt \n"  
  
    checkNum(1,1)
    checkOut()
    
  stop()

  cmplx f = {1,2}

<<"%V$f \n"


 cmplx F[10]

<<"%V$F \n"
F = vgen (CMPLX,10,1,1)


G = vgen (CMPLX,10,1,-1)



  // FIXIT
  //F[0:-1] = 3

<<"%V$F \n"

  // cmplx G[10]

<<"%V$G \n"


   Z = F * G

<<"%V$Z \n"

  G->setReal(vgen(FLOAT_,10,1,3))
  G->setImag(vgen(FLOAT_,10,1,-4))

<<"%V$G \n"

  R=G->getReal()
<<"%V$R \n"

  I=G->getReal()
<<"%V$I \n"

  
  Mg=G->Mag()
<<"%V$Mg \n"

  Ph=G->Phase()
<<"%V$Ph \n"




STOP!


N = 11
cmplx A[N]

<<"%v $A[0:10] \n"

<<"$(typeof(A)) $(Caz(A)) \n"

// FIX IC redundant ele/push_sivele

   A[2]->real (0.3)  // just real ele

   A[3]->imag (0.4)  // just imag ele

<<"%v $A \n"

   R=A->Real() // real part

<<"%v $R \n"

   A[4]->Set(0.55,0.69)

<<"%v $A[*] \n"

   I=A->Imag() // real part

<<"%v $I \n"
ttyin()

STOP!

    val = 0.1

    for (j = 1; j < 10; j++) {

     A[j]->Real(val)  // just real ele
     A[12]->Real(val)

     R=A->Real() // real part

     <<"%v $R[0:12] \n"

    val += 0.1
ttyin()
   }


   A->real(Sin(Fgen(N,0,0.1)))


   R = A->real(Cos(Fgen(N,0,0.1)))

<<" $(Caz(R)) \n"

  <<"\n%v $R[0:10] \n"
ttyin()

   R = A->Real(Sin(Fgen(N,0,0.1)))

<<" $(Caz(R)) \n"


  <<"\n%v $R[0:10] \n"

   A->Imag(4.0)      // imag vector set to zero

   I= A->Imag()     // get imag part

<<" $(Caz(I)) \n"
  <<"%v $I[0:10] \n"

<<"%v $A->Imag() \n"


<<"\n %v $A[0:10] \n"


   B = A

<<"\n %v $B[0:10] \n"

   C = A + B

<<"\n %v $C[0:10] \n"

   C = A - B

<<"\n %v $C[0:10] \n"

   C = A * B

<<"\n %v $C[0:10] \n"

   C = A / B

<<"\n %v $C[0:10] \n"






STOP!

   A[3] = {0.3,42.0}  

<<"\n %v $A[0:10] \n"


   A[3] = {0.3,42.0}  

<<"\n %v $A[0:10] \n"


   A[9] = {0.3,42.0}  

<<"\n %v $A[0:10] \n"






//  a = {1.0,0.5}
//  b = (0.5,-1.0}



  r= a->Set(1.0,0.5)

<<" %v $r \n"
  b->Set(0.5,-1.0)

<<"%v $(typeof(a)) \n"
<<"%v $(typeof(b)) \n"

  c= a + b

<<"%v $(typeof(c)) \n"

<<"%V $a $b $c \n"

<<" complex type - ops \n"




STOP!







   A[2]->imag (-0.5)  // just imag ele

   A[3] = {0.3,0.4}  



   A[0:20:2]->imag(5.0)      // imag subscripted part of vector set to zero


STOP("DONE")
float V[12]
j = 0
    V[j] = 3

<<" $V[0:10] \n"

    for (j = 1; j < 3; j++) {
    V[j] = j

<<" $V[0:10] \n"
    }
