

proc foo(int vec[],k)
{
<<"$_proc IN $vec \n"
<<"pa_arg2 %V$k\n"
  vec[1] = 47
  vec[5] = 80
<<"OUT $vec \n"
  return vec
}


Z = Vgen(INT,10,0,1)
Z[0] = 35
Z[2] = 79
<<"$Z\n"

  Y=foo(Z,3)  // TBD FIX -- default array name is ref call

<<"after proc $Z\n"


  Y=foo(&Z,3)  // TBD FIX -- default array name is ref call

<<"after proc $Z\n"


stop!