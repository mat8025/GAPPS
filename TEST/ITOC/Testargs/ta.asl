///
///
///

//setDebug(1,"pline","trace","~step")

#include "debug"

float getRC(float v, int np)
{

   rv =fround(v,np);

   return rv;

}


int k = 1;

V=vgen(INT_,10,0,1)

<<"%V $V\n"

A = testargs(V);
<<"$A\n"

V.pinfo();


  r20 = sin ( cos (2 * 45) * sin (4 *30) )

  r21 = sin (cos(2*45)*sin(4*30))

<<" %V $r20 $r21\n"

A = testargs(1,r20,r21,sin ( cos (2 * 45) * sin (4 *30) ))

<<"%(1, , ,,\n)$A\n"

A = testargs(1,r20,r21,sin ( cos (2 * 45)), fround(r21,1))

<<"%(1, , ,,\n)$A\n"



  chkN(r20,r21);
  
 float tl = 3.1249;
 
 float cals = d2r(getRC(tl,6));

<<"%V $tl $cals\n"

A = testargs(tl,3,getRC(tl,3), fround(tl,3))

<<"%(1, , ,,\n)$A\n"
B1 = 45;
 B2=  35;


  r5 =  d2r(B1+B2-180)

 r6 =  d2r( B1 +B2 - 180)

chkN(r6,r5)

chkOut()

A = testargs(&V);
<<"$A\n"

V.pinfo();

chkOut()


A = testargs(&V[8]);
<<"$A\n"




!i V

A = testargs(&V[k]);
<<"$A\n"


!a







<<"$k\n"
k++;

<<"$k\n"






A = testargs(79);
<<"$A\n"



A = testargs(3);
<<"$A\n"
<<"%(1, , ,,\n)$A\n"




A=testargs(k,"pline","trace","step");
<<"%(1, , ,,\n)$A\n"


<<"///////////////\n"
<<"%(1, , ,,\n)$A\n"
//ans = iread();
//<<"$ans\n"

ms= "fine"

<<"$ms\n"

Tcf = ofw("test_crashes");

<<"$Tcf \n"
<<[Tcf]"oh come on!!\n"

cf(Tcf)


<<"$k \n";

q =79;


Z = vgen(INT_,10,0,1)


A = testargs(1,k,&q, Z, &Z[2]);
<<"///////////////\n"
<<"%(1, , ,,\n)$A\n"



B = testargs("fine",ms, "a very long goodbye");
<<"%(1, , ,,\n)$B\n"

C = testargs("test_crashes");
<<"%(1, , ,,\n)$C\n"


wr=typeof(C)
<<"%V$wr\n"

<<"%V$(typeof(C))\n"


D= testargs("$wr $k");
<<"%(1, , ,,\n)$D\n"

D= testargs("$(k+1)");
<<"%(1, , ,,\n)$D\n"


D= testargs("$(pow(k,2))");
<<"%(1, , ,,\n)$D\n"

E= testargs("$(caz(C))");
<<"%(1, , ,,\n)$E\n"

E= testargs("$(typeof(C))");
<<"%(1, , ,,\n)$E\n"