///
///
///
LD_libs++;

proc moo(m)
{
static int znt = 0;
znt++;
<<"IN $_proc $znt $m\n"


if (znt > 10) {
  <<" repeat call $znt \n"
  exit();
}
  k = m+ znt;
  return k;
}
//=======================//
proc hoo(m)
{
static int znt = 0;
znt++;
<<"IN $_proc $znt $m\n"


if (znt > 10) {
  <<" repeat call $znt \n"
  exit();
}
  k = m+ znt;
  return k;
}
//=======================//
proc woo(m)
{
static int znt = 0;
znt++;
<<"IN $_proc $znt $m\n"


if (znt > 10) {
  <<" repeat call $znt \n"
  exit();
}
  k = m+ znt;
  return k;
}
//=======================//
proc boo(m)
{
static int znt = 0;
znt++;
<<"IN $_proc $znt $m\n"


if (znt > 10) {
  <<" repeat call $znt \n"
  exit();
}
  k = m+ znt;
  return k;
}
//=======================//
