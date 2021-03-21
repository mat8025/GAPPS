/* 
 *  @script cmplx.asl 
 * 
 *  @comment test cmplx types 
 *  @release CARBON 
 *  @vers 1.4 Be Beryllium [asl 6.3.12 C-Li-Mg] 
 *  @date Tue Jan 19 08:05:59 2021 
 *  @cdate 1/1/2003 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
                                                                      
#include "debug"


if (_dblevel >0) {
   debugON()
}



chkIn(_dblevel)


int I[10] = {0,1,2,3,4,5,6,7,8,9};

!iI

cmplx a;
cmplx b;


a->set(2.5,0.5)


a->info(1)

chkR (a->getReal(),2.5);
x= a->getReal();
y= a->getImag();
<<"%V $a  $x  $y\n"

a->setReal(3.5)

<<"%V $a\n"

a->setImag(-4.7)

<<"%V $a\n"

x= a->getReal();
y= a->getImag();
<<"%V $a  $x  $y\n"

chkR (x,3.5)
chkR (y,-4.7)

a->info(1)


cmplx g[16] = {1,2,3,4,5,6,7,8,9,10};

sz = Caz(g)

!ig
!pg

//float sum =0;

int A[3] = {1,2,3}
  sz = Caz(A)

<<"%V $sz $A\n"
!i A
  sum = Sum(A);

<<"%V$sum \n"
  sum->info(1)

 chkN(sum,6)


A={1,2,3,4,} ;   // OK
  sum = Sum(A);
<<"%V$A \n"
<<"%V$sum \n"
 chkN(sum,10)

  //sum = Sum({1,2,3,4});

sum = Sum({1,2,3,4});  //!OK

<<"%V$sum \n"
//!p sum


 chkN(sum,10)






sz = Caz({1,2,3});

<<"%V $sz\n"




float F[10] = {0,1,2,3,4,5,6,7,8,9};

<<"$F\n"

int I2[] = {11,1,2,3,4,5,6,7,8,12};

<<"$I2\n"



/*
  g->SetReal(77);
<<"%V$sz $g\n"
  g->SetImag(-21);
<<"%V$sz $g\n"
*/

g[0]->Set(80,15);
<<"$g\n"

A= {11,12,13,14,15,16};
!pA
B= A * -1;

g[1:6:1]->SetReal(A)
g[1:6:1]->SetImag(B)

//g[1:6:1]->SetReal({1,2,3,4,5,6})  // FIX anon array as arg?

<<"$g\n"


g[1:6:1]->SetImag({6.1,6.2,6.3,6.4,6.5,6.6})

sz = Caz(g)
<<"%V$sz $g\n"

g[1:6:1]->SetReal({1,2,3,4,5,6})

<<"$g\n"
  
float rv[10];

rv[0] = 19;
rv[1] = 20;
rv[2] = 21;
rv[3] = 268;
rv[4] = 166;
rv[5] = 68;

g[1:6:1]->SetReal({1,2,3,4,5,6})

<<"$g\n"
gr = g->getReal()

for (i= 1; i < 6; i++) {
chkN(gr[i],i)
}

g[1:6:1]->SetImag({7,8,9,10,11,12})

<<"$g\n"

gi = g->getImag()

gi->info(1)

<<"%V $gi \n"


for (i= 1; i <= 6; i++) {
  chkN(gi[i],6+i)
}


g[1:6:1]->SetImag({-1.0,-2.0,-3.0,-4,-5,-6.2})

<<"$g\n"


g[1:6:1]->SetReal(rv)

<<"$g\n"

g[1:6:1]->SetImag(rv)

<<"$g\n"



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

    d = a / b;

<<"%V$a /  $b $d \n"

  e = d * b

<<"%V$d *  $b  = $e \n"


    dcmplx  r;
    dcmplx  t;
    dcmplx  rt;

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
  
    chkN(1,1)

    float fv[4] = {1,2,3,4};

<<"$fv\n"


  g[3]->Set(47,79)

  <<"%V$sz $g\n"

  g[4]->setReal(80)

  g[5]->setImag(85)
  
<<"%V $g\n"
  
  g->SetReal(rv)

  
<<"%V $g\n"



  g[6]->SetReal(1001)

     <<"%V $g\n"



       <<"%V $g\n"
       
  g[2:12:2]->SetReal(rv);

     <<"%V $g\n"

  g[0:12:2]->SetImag(rv);

     <<"%V $g\n"

     g[6:12:]->SetReal({4,5,6});

     <<"%V $g\n"


     g[0:2]->SetReal({1,2,3});

     <<"%V $g\n"     
     
g[0]->Set(1,2);
<<"$g\n"


g[1]->Set(3,4);

<<"$g\n"


g->Set(1,2,3,4);

<<"$g\n"

    cmplx f;

f->set(1,2);

<<"%V$f \n"

     
  //cmplx h = {1,2};


<<"%V$F \n"
F = vgen (CMPLX_,10,1,1)


G = vgen (CMPLX_,10,1,-1)


<<"%V$G \n"



  // FIXIT
  //F[0:-1] = 3

<<"%V$F \n"

  // cmplx G[10]




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


N = 11

cmplx AV[N]


AV->info(1)
<<"%v $AV[0:10] \n"

<<"$(typeof(AV)) $(Caz(AV)) \n"

// FIX IC redundant ele/push_sivele

   AV[2]->Setreal (0.3)  // just real ele

   AV[3]->SetImag (0.4)  // just imag ele

<<"%v $AV \n"

AV->info(1)

   R=AV->getReal() // real part
R->info(1)
<<"%v $R \n"


   AV[4]->Set(0.55,0.69)

<<"%v $AV[*] \n"

   I=AV->GetImag() // imag part

<<"%v $I \n"




    val = 0.1

    for (j = 1; j < 10; j++) {

     AV[j]->SetReal(val)  // just real ele

     AV[12]->SetReal(val)

     R=AV->getReal() // real part

   
     <<"%v $R \n"

    val += 0.1

   }


   AV->Setreal(Sin(Fgen(N,0,0.1)))


   R = AV->SetR(Cos(Fgen(N,0,0.1)))
R->info(1);
<<" $(Caz(R)) \n"

   T= R[0:10];

<<"$T \n"

  <<"\n%v $R[0:10] \n"


   R = AV->setR(Sin(Fgen(N,0,0.1)))

<<" $(Caz(R)) \n"


  <<"\n%v $R[0:10] \n"

   AV->SetI(4.0)      // imag vector set to zero

   I= AV->getImag()     // get imag part

<<" $(Caz(I)) \n"
  <<"%v $I[0:10] \n"

<<"%v $AV->getImag() \n"


<<"\n %v $AV[0:10] \n"


   B = AV

<<"\n %v $B[0:10] \n"

   C = AV + B

<<"\n %v $C[0:10] \n"

   C = AV - B

<<"\n %v $C[0:10] \n"

   C = AV * B

<<"\n %v $C[0:10] \n"

   C = AV / B

<<"\n %v $C[0:10] \n"


   AV[3]->set(0.3,42.0)  

<<"\n %v $AV[0:10] \n"


   AV[3]->set(0.3,42.0)  

<<"\n %v $AV[0:10] \n"


   AV[9]->set(0.3,42.0)  

<<"\n %v $AV[0:10] \n"






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



   AV[2]->setI (-0.5)  // just imag ele

   AV[3]->Set(0.3,0.4) 


   AV[0:20:2]->SetImag(5.0)      // imag subscripted part of vector set to zero



float V[12];

<<"$V\n"
chkOut ()

j = 0
    V[j] = 3

<<" $V[0:10] \n"

    for (j = 1; j < 3; j++) {
    V[j] = j

<<" $V[0:10] \n"
    }

dcmplx DCV[>10]


DVR=vgen(DOUBLE_,10,0,0.25)
DVI=vgen(DOUBLE_,10,-10,0.25)

<<"$DVR\n"
<<"$DVI\n"

DCV->setReal(DVR)
DCV->setImag(DVI)


<<"$DCV\n"

DVGR=DCV->getReal()

<<"$DVGR\n"
dv= 0.0

for(i=0;i<10;i++) {

chkR (DVGR[i],dv);
dv += 0.25
}

chkOut()