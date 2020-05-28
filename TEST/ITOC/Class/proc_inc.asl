///
///
///



proc Sin (real a)
{
<<"$_proc  $a \n"
real y;
 y = sin(a)
   ZIN()
<<"$_proc OUT $y \n"
  return y
}
//=================//


<<"Proc Sin defined \n"

proc WhereAreWe()
{
<<"$_proc  IN \n"
 here= getDir();
 <<"current dir $here\n"
    x2= cos(1.0)
    <<"%V$x2\n"
   ZIN()
 <<"$_proc  OUT \n"
 return here;
}

<<"Proc WhereAreWe defined \n"

proc ZIN()
{
 <<"$_proc  IN \n"
<<" live in ZIN\n"
    ZOUT()
 <<"$_proc  OUT \n"
}

proc ZOUT()
{
 <<"$_proc  IN \n"
<<" scream and ZOUT\n"
 <<"$_proc  OUT \n"
}


<<"included procs\n"