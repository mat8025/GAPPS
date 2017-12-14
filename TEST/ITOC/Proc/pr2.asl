///
///
setdebug(1,"pline","trace")

#define ASK ans=iread();


checkIn();
//proc foo(int vect[],k)
proc foo(vect[],k)
{

<<"$_proc IN $vect \n"

<<"pa_arg2 %V$k\n"

  vect[0] = 28
  vect[1] = 47
  vect[5] = k;

<<"vect OUT $vect \n"
<<"vect[0] $vect[0] \n"

  checkNum(vect[0],28)
  
  rvect = vect;


<<"rvect OUT $rvect \n"
  checkNum(rvect[0],28);
  
  checkNum(Z[0],0);

<<"Z OUT $Z \n"

  return rvect

  //  return vect
}


///////////////  Array name ////////////////////////
<<" main \n";

Z= Vgen(INT_,15,0,1);


<<"Z: $Z\n"

Y= foo(&Z[2], 31)

<<"Y: $Y\n"

checkNum(Y[0],28)

checkStage()


exit()


 Z= Vgen(INT_,15,0,1);

 Y= foo(Z, 31)

<<"Y: $Y\n"

checkNum(Y[0],28)

<<"$Y \n"
<<"Y $Y[0] == 28 ?\n"

<<"$Z\n"
<<"Z $Z[0] == 0 ?\n"

checkNum(Z[0],0);


checkStage()


exit()

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


