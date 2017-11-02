setdebug(1,"trace")

proc foo(vec[])
{

<<"$_proc IN $vec \n"

  vec[0] = 47;

  rvec = vec;
<<"rvec: $rvec \n"

<<"$_proc OUT $vec \n"
  return rvec;
}


 Z= Vgen(INT_,15,0,1);


<<"$Z\n"

 Z[5] = 31;

<<"$Z\n"

 Y = foo(&Z[3]);

<<"Z: $Z\n"

<<"Y: $Y\n"

