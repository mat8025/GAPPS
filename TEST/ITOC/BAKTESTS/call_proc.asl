

<<" first line\n"

include "debug"

filterfuncdebug(ALLOWALL_,"xxx");

filterfiledebug(ALLOWALL_,"proc_","args_","scope_","class_","hop_");

setdebug(1,@pline,@trace)
checkin()

do_another = 1
do_mul_i = 1;
do_mul_f = 1;
do_mul_r = 1;

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

proc WhereAreWe()
{

 here= getDir();
 <<"current dir $here\n"
 return here;
}

<<"Proc WhereAreWe defined \n"

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

dir= getdir()

updir()

//pdir=updir()
pdir= getDir()
<<"%V $dir $pdir\n"

cdir = WhereAreWe()

<<"$cdir\n"

cdir->info(1)



 real f;
 real r = 0.707;

 f= sin(r)

<<"%V $f\n"

 f= Sin(r)

<<"%V $f\n"
checkrnum(f,sin(0.707))
double a =1.2



<<" trying simple SF call!\n"
  a= sin(0.7)
<<"%V $a\n"


//<<" trying missing SF call!\n"
//  a= nis(0.7)
//<<"%V $a\n"


checkrnum(a,sin(0.7))

  a= cos(0.7)
<<"%V $a\n"

checkrnum(a,cos(0.7))

  a= tan(0.7)
<<"%V $a\n"

checkrnum(a,tan(0.7))

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


checkrnum(b,sin(1.0))




real x = 3.2;
real y = 6.8;
if (do_mul_r) {
z = x * y
h= Mul(x,y)



<<"%V $h\n"
h->info(1)

<<"%V $x $y  $h $z\n"

checkrnum(z,h)

}


int m = 3;
int n = 7;

mn = m * n;
if (do_mul_i) {


proc Mul (int a, int b)
{
<<"$_proc  int $a $b \n"
  int  c;

  c= a * b;
  return c;
}
//====================//


g= Mul(m,n)


<<"%V $g\n"
g->info(1)

checkrnum(g,mn)
}

float fx = 5.2;
float fy = 7.8;

if (do_mul_f) {
r1 = fx * fy
r2= Mul(fx,fy)


<<"%V $r1  $r2\n"
r1->info(1)
r2->info(1)

checkrnum(r1,r2)
}

r5 = Mul(Mul(fx,fy), y)

r5->info(1)

r6 = y * r2

<<"%V$r2 $y $r6 $r5 \n"

checkrnum(r5,r6,2)

real rad = 0.8

<<" trying simple SF call!\n"
  a= sin(rad)
<<"%V $a\n"

checkrnum(a,sin(rad))

  k = 0;
 for (a= 0.1; a <= 6.0; a += 0.1) {
  k++;
  <<"$k $a \n"
  b = sin(a)
<<"$b\n"
 }


checkrnum(b,sin(6.0))


  a= cos(rad)
<<"%V $a\n"

checkrnum(a,cos(rad))



  a= tan(rad)
<<"%V $a\n"

checkrnum(a,tan(rad))




  b= 0.4
  a= sin(b)
 <<"%V $a\n"




checkOut()