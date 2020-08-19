setdebug(1)

chkIn()

proc foo(int vec[],k)
{
<<"$_proc IN $vec \n"
<<"pa_arg2 %V$k\n"
  vec[0] = 47
  vec[1] = 78
  vec[2] = 79
<<"OUT $vec \n"
  return vec
}




///////////////  Array name ////////////////////////////////////////
Z = Vgen(INT,10,0,1)

<<"before calling proc $Z\n"


// TBD FIX it does not compute the offset 
// so proc does not operate on the third element in vector

Y= foo(&Z[3],4)  

<<"after proc $Z\n"

if ((Z[3] == 47)  && (Z[4] == 78)) {
   <<"Z[3] and Z[4] correct \n"
}

 chkN(Z[3],47)
 chkN(Z[5],79)



<<"return vec $Y\n"


chkOut()
stop!

 chkN(Y[0],47)
 chkN(Y[2],79)





