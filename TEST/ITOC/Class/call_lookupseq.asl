///
///
///

do_debug = 1
do_sf = 1

do_proc = 1;
do_promote = 0;
do_proc_nest = 0;

if (do_debug) {

include "debug"

filterfuncdebug(ALLOWALL_,"xxx");

filterfiledebug(ALLOWALL_,"proc_","args_","scope_","class_");

//debugON()







<<"did we get here ok\n"
}


setdebug(1,@pline,@trace)

checkin(0)



 double a =1.2

if (do_sf) {

<<" trying simple SF call!\n"
  a= sin(0.7)
<<"%V $a\n"

checkRnum(a,sin(0.7))

  a= cos(0.7)
<<"%V $a\n"

checkRnum(a,cos(0.7))

  a= tan(0.7)
<<"%V $a\n"

checkRnum(a,tan(0.7))

  b= 0.4
  a= sin(b)
 <<"%V $a\n"

 int k = 0;
 for (a= 0.1; a <= 1.0; a += 0.1) {
  k++;
  <<"$k $a \n"
  b = sin(a)
<<"$b\n"

}


checkRnum(b,sin(1.0))

}
//===============================

if (do_proc) {


proc Sin (real a)
{
<<"$_proc  $a \n"
real y;
 y = sin(a)
 <<" out $y \n" 
  return y
}
//=================//


<<"Proc Sin defined \n"
 real r = 0.707;

 f= Sin(r)

<<"%V $f\n"
checkRnum(f,sin(r))



//====================//

proc Mul (real a, real b)
{
<<"$_proc  real $a $b \n"
 real c;

  c= a * b;

  return c;
}


//====================//
proc Mul (float a, float b)
{
<<"$_proc  float $a $b \n"
 float c;

  c= a * b;

  return c;

}


//====================//
proc Mul (int a, int b)
{
<<"$_proc  int $a $b \n"
 int  c;

  c= a * b;

  return c;

}
//====================//



real x = 3.2;
real y = 6.8;

z = x * y
h= Mul(x,y)



<<"%V $h\n"
h->info(1)

<<"%V $x $y  $h $z\n"

checkRnum(z,h)




int m = 3;
int n = 7;

mn = m * n;

g= Mul(m,n)


<<"%V $g\n"
g->info(1)

checkRnum(g,mn)





float fx = 5.2;
float fy = 7.8;

r1 = fx * fy
r2= Mul(fx,fy)


<<"%V $r1  $r2\n"
r1->info(1)
r2->info(1)

checkRnum(r1,r2)

}

if (do_promote ) {


r4 = x * fy
r3= Mul(x,fy)

r3->info(1)
r4->info(1)

checkRnum(r3,r4)

}

if (do_proc_nest) {

r5 = Mul(Mul(fx,fy), y)

r5->info(1)

r6 = y * r2

<<"%V$r2 $y $r6 $r5 \n"

checkRnum(r5,r6,2)

}

checkOut()