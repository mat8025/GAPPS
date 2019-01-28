//%*********************************************** 
//*  @script arrayarg2.asl 
//* 
//*  @comment test proc array args 
//*  @release CARBON 
//*  @vers 1.37 Rb Rubidium                                               
//*  @date Mon Jan 21 06:40:50 2019 
//*  @cdate 1/1/2005 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%


include "debug.asl"

debugON();

setdebug (1, @pline, @~step, @trace) ;


civ = 0;

cov= getEnvVar("ITEST")
if (! (cov @="")) {
civ= atoi(cov)
<<"%V $cov $civ\n"

}

checkIn(civ)




proc foo(int vec[],k)

{
<<"$_proc IN $vec \n"
<<"pa_arg2 %V$k\n"

  vec[1] = 47
  vec[2] = 79
  vec[3] = 80
  vec[4] = 78
  vec[5] = 50

<<"OUT $vec \n"
  rvec = vec;
  return rvec
}

///////////////  Array name ////////////////////////////////////////
 Z = Vgen(INT_,10,0,1)

<<"init $Z\n"

 Z[0] = 36
 Z[1] = 53
 Z[6] = 28

<<"before calling proc $Z\n"

  Y=foo(Z,3) 

<<"after calling proc $Z\n"

//iread()

  if ((Z[1] == 47)  && (Z[6] == 28)) {
   <<"Z[1] and Z[6] correct \n"
  }

  if ((Z[1] == 47) ) {
    <<"Z[1] correct \n"
  }
  else {
   <<"Z wrong \n"
  }


checkNum(Z[1],47)

checkNum(Z[6],28)

<<"Array Name return vec $Y\n"

checkStage("ArrayName")

///////////////  &Array ////////////////////////////////////////

//  showStatements(1)


  Z = Vgen(INT_,10,0,1)

  Z[0] = 36
  Z[8] = 28

 // Z[0] = 36  // FIX TBD last element offset is being used as function para offset!!

  <<"before calling proc\n"

  <<"$Z\n"
  // Y = foo(&Z,3)  // TBF-------- Y 
   Y = foo(&Z[0],3)  // FIXED -------- Y is now created correctly with the return vector
 //  Y = foo(Z,3)  // FIXED -------- Y is now created correctly with the return vector 


<<"after calling proc $Z\n"

  checkNum(Z[1],47)
  
  checkNum(Z[8],28)

  checkStage("&Array")




Z = Vgen(INT_,10,0,1)

Z[0] = 36
Z[8] = 28

<<"before calling proc $Z\n"

// TBD FIX it does not compute the offset - so proc does not operate on the third element in

<<"before calling proc $Z\n"

  Y2= foo(&Z[2],4)

<<"after proc Z: $Z\n"


<<"after proc Y2: $Y2\n"

 if ((Z[3] == 47)  && (Z[8] == 28)) {
   <<"Z[3] and Z[8] correct \n"
 }

 if ((Z[3] == 47) ) {
  <<"Z correct \n"
 }
 else {
  <<"Z wrong \n"
 }


  checkNum(Z[3],47);
  checkNum(Z[8],28);

  checkStage("&Array[2]")

<<"return Y vec $Y\n"

  checkNum(Y2[1],47)

  checkNum(Y2[6],28)

  checkStage("ArrayReturn")


checkOut()

exit()