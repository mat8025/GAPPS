/* 
 *  @script testargs.asl                                                
 * 
 *  @comment test arg processing                                        
 *  @release Oxygen                                                     
 *  @vers 1.4 Be Beryllium [asl 5.8 : B O]                              
 *  @date 07/29/2023 16:22:59                                           
 *  @cdate 07/29/2023 13:44:48                                          
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2023 -->                               
 * 
 */ 

//-----------------<v_&_v>------------------------//

Str Use_= " Demo  of test arg processing ";


#include "debug" 

  if (_dblevel >0) { 
   debugON() 
   <<"$Use_ \n" 
} 

   allowErrors(-1); // set number of errors allowed -1 keep going 

  chkIn(_dblevel) ;

  chkT(1);

///
///
///

float getRC(float v, int np)
{

   rv =fround(v,np);

   return rv;

}

int goo(int m, int q)
{

<<"$_proc   $m $q\n"
//  q.pinfo()
  int n = m + q;
<<"%V $n\n"
  return n;
  
}

int foo ()
{

  int k = km;
  int r = om;
 // int d;
//  k = 4;
    d=goo(k,r)   ; // autodeclare - bad icode
//  int d=goo(k,r)

<<" %V $d  $k $r\n"

  return d;
}


int km = 4;
int om = 7;
float rx = 2.3;

float ry = -4.5;

Str s = "my string";

int j = 7;



   p =foo();

km = 14;
om = 17;

   z = foo();

<<"%V $p $z \n"

exit()



A = testargs(1,km,rx,ry,s,76)

<<"%(1, , ,,\n)$A\n"


Gevent G;


   G.geteventRxRy(rx,ry)

<<"%V $rx $ry\n"


//   G.geteventRxRy(&rx,&ry) // warn to ignore & rx,ry treated as ref parameters
   

//<<"%V $rx $ry\n"



exit();



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

///

 chkOut();

  exit();

///----------(^-^)----------\\\
