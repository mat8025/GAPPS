///
///
setdebug(1,"pline","trace")

proc foo(int vec[],k)
{
<<"$_proc IN $vec \n"
<<"pa_arg2 %V$k\n"
  vec[0] = 28
  vec[1] = 47
  //vec[2] = 79
  //vec[3] = 80
  //vec[4] = 78
  //vec[5] = 50

<<"OUT $vec \n"

  rvec = vec;
  return rvec
  //  return vec
}


///////////////  Array name ////////////////////////////////////////
Z= Vgen(INT_,15,0,1);

 Y= foo(Z, 4)


<<"$Y \n"


Z = Vgen(INT_,15,0,1);
<<"$Z\n"

Y= foo(&Z[3], 3)

<<"$Y \n"







exit()




I=vgen(INT_,10,0,1)

J = I

<<"$I\n"
<<"$J\n"

//J= &I[2];

//<<"$J\n"

J=  I[2:-2:1];

<<"$J\n"


