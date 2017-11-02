///
///
setdebug(1,"pline","trace")

#define ASK ans=iread();


checkIn();
//proc foo(int vec[],k)
proc foo(vec[],k)
{

<<"$_proc IN $vec \n"
<<"pa_arg2 %V$k\n"

  vec[0] = 28
  vec[1] = 47
  vec[5] = k;

<<"vec OUT $vec \n"

  checkNum(vec[0],28)
  
  rvec = vec;


<<"rvec OUT $rvec \n"
  checkNum(rvec[0],28);
  
  checkNum(Z[0],0);

<<"Z OUT $Z \n"

  return rvec

  //  return vec
}


///////////////  Array name /////////////////////////
 Z= Vgen(INT_,15,0,1);

 Y= foo(&Z[2], 31)


checkNum(Y[0],28)

exit()
<<"$Y \n"
<<"Y $Y[0] == 28 ?\n"

<<"$Z\n"
<<"Z $Z[0] == 0 ?\n"

checkNum(Z[0],0);


checkStage()

ASK




Z = Vgen(INT_,15,0,1);

<<"$Z\n"

<<"$Z[0] == 0 ?\n"


W= foo(&Z[3], 79)

checkNum(W[0],28)
checkNum(W[5],79)

<<"$W \n"

<<" $W[0] == 28 ?\n"

<<"$Z\n"
<<"Z $Z[0] == 0 ?\n"

checkNum(Z[0],0)

ASK;


checkOut();
exit()




I=vgen(INT_,10,0,1)

J = I

<<"$I\n"
<<"$J\n"

//J= &I[2];

//<<"$J\n"

J=  I[2:-2:1];

<<"$J\n"


