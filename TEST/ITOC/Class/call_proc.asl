

<<" first line\n"

//include "debug"


//sdb(1,@pline,@trace)
//chkIn()

do_another = 1
do_mul_i = 1;
do_mul_f = 1;
do_mul_r = 1;

//====================//
//include "proc_inc"



proc Sin (double a)
{
<<"$_proc  $a  vers 1\n"
real y;
 y = sin(a)
//   ZIN()
<<"$_proc OUT $y \n"
  return y
}
//=================//
<<"Proc Sin double defined \n"
proc Sin (float a)
{
<<"$_proc  $a  vers 1\n"
real y;
 y = sin(a)
//   ZIN()
<<"$_proc OUT $y \n"
  return y
}
//=================//
<<"Proc Sin float defined \n"


proc Sin (float a[])
{
<<"$_proc  $a  vers 1\n"
real y;

 y = sin(a[0])
//   ZIN()
<<"$_proc OUT $y \n"
  return y
}
//=================//
<<"Proc Sin float vec defined \n"




b = Sin(0.7)

<<"ans $b \n"

float val = 0.5

c = Sin(val)

<<"ans $c \n"







//=================//

proc Sin (real a)
{
<<"$_proc  $a vers2\n"
real y;
 z = cos(a)
<<"$_proc OUT $z \n"
  return z
}

<<"Proc Sin re-defined \n"

b = Sin(0.7)

<<"ans $b \n"


//=================//

proc ZIN()
{
<<"--->vers1 \n"   
<<"%V $_proc  $_scope  \n"
<<"%V $_pstack\n"
<<"%V $_pinclude\n"
<<" live in ZIN\n"
   //ZOUT()
<<"<--- <|$_proc|>  <|$_scope|>  <|$_pstack|> <|$_pinclude|> \n"
}

<<"Proc ZIN  defined \n"

ZIN()

//=================//
proc ZIN()
{
<<"--->vers 2\n"   
<<"%V $_proc  $_scope  \n"
<<"%V $_pstack\n"
<<"%V $_pinclude\n"
<<" live in ZIN\n"
<<"<--- <|$_proc|>  <|$_scope|>  <|$_pstack|> <|$_pinclude|> \n"
}
<<"Proc ZIN  re-defined \n"
//=================//

ZIN()




proc WhereAreWe()
{
<<"--->\n"   
<<"%V $_proc  $_scope  \n"
<<"%v $_pstack\n"
<<"%V $_pinclude\n"
<<"%V $_include\n"


here= getDir();
 <<"current dir $here\n"
    x2= cos(1.0)
    <<"%V$x2\n"
   ZIN()
<<"<--- <|$_proc|>  <|$_scope|>  <|$_pstack|> <|$_pinclude|> \n"   
 return here;
}

<<"Proc WhereAreWe defined \n"






proc ZOUT()
{
<<"--->\n"   
<<"%V $_proc  $_scope \n"
<<"%V $_pstack\n"
<<"%V $_pinclude\n"
<<" scream and ZOUT\n"
<<"<--- <|$_proc|>  <|$_scope|>  <|$_pstack|> <|$_pinclude|> \n"
  return 1;
}


<<"included procs\n"



//
proc Mul (real a, real b)
{
<<"$_proc  IN real $a $b \n"
 real c;

  c= a * b;
 <<"$_proc  OUT \n"
  return c;
}


//====================//
proc Mul (float a, float b)
{
<<"$_proc  float $a $b \n"
 float c;

  c= a * b;
 <<"$_proc  OUT \n"
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

dir= getdir()

updir()

//pdir=updir()
pdir= getDir()



<<"%V $_include $_pstack  $_script\n"
<<"%V $dir $pdir\n"



<<"stack: $(showstack()) \n"
<<"scope: $(showscope())\n"

<<"%V $_scope $_pstack\n"



cdir = WhereAreWe()
<<"after proc WAW hidden statement\n"
<<"statement visible %V $_proc $_pstack  $_script\n"


<<"$cdir\n"

cdir->info(1)
<<"after VMF hidden statement\n"
<<"statement visible %V $_proc $_pstack  $_script\n"


// we should be back in main scope - here - test
 ZOUT()
<<"after proc ZOUT hidden statement?\n"
<<"statement visible %V $_proc $_pstack  $_script\n"




 res=ZIN()
<<"after proc ZIN hidden statement?\n"
<<"statement visible %V $_proc $_pstack  $_script\n"




res= ZOUT()
<<"after proc ZOUT hidden statement?\n"
<<"statement visible %V $_proc $_pstack  $_script\n"



WhereAreWe()
<<"after proc WAW hidden statement\n"
<<"statement visible %V $_proc $_pstack  $_script\n"

<<"%V $_scope $_pstack $_include\n"




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
  b = Sin(a)
<<"$b\n"
//ans=iread("?")
 }


checkrnum(b,sin(1.0))


cdir = WhereAreWe()

<<"$cdir\n"

cdir->info(1)




float x = 3.2;
float y = 6.8;

h= Mul(x,y)

if (do_mul_r) {
z = x * y




<<"%V $h\n"
h->info(1)

<<"%V $x $y  $h $z\n"

checkrnum(z,h)

}


int m = 3;
int n = 7;

mn = m * n;
if (do_mul_i) {





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
 for (a= 0.1; a <= 6.0; a += 0.5) {
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




chkOut()