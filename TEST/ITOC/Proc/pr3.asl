///
///
setdebug(1,"pline","trace")

#define ASK ans=iread();


chkIn();

proc foo(k)
{

<<"pa_arg %V$k\n"

  r = k * 13;

<<"%V $r \n"

  return r;
}


///////////////  Array name /////////////////////////
m = 60
Y= foo(m)

<<"Y: $Y\n"

chkN(Y,(m*13))

chkOut();
exit()
