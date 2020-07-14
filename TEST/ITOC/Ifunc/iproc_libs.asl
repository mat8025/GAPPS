///
///
///
LD_libs++;

proc moo(int m)
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
proc hoo(int m)
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
proc woo(int m)
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
proc boo(int m)
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
