//%*********************************************** 
//*  @script arrayarg1.asl 
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

setdebug (0, @pline, @~step, @~trace) ;


civ = 0;

cov= getEnvVar("ITEST")
if (! (cov @="")) {
civ= atoi(cov)
<<"%V $cov $civ\n"
}

chkIn(civ)




//proc foo(int vec[],k)
proc foo(vec,k)
{
<<"$_proc IN $vec \n"

<<"pa_arg2 %V$k\n"

  vecp = vec;

  vec[1] = 47;
<<"add 47 $vec \n"  
  vec[2] = 79;
<<"add Au $vec \n"

  vec[3] = 80
  vec[4] = 78
  vec[5] = 50

<<"OUT $vec \n"

<<"OUT orig entry $vecp \n"

  return vec
}
//============================

Z = Vgen(INT_,10,0,1)

wt= Z->typeof();
<<"$wt $(typeof(Z))\n"

Z[0] = 36

<<"$Z\n"

Z[6] = 28

<<"before calling proc\n"

<<"$Z\n"
 W = Z

//Z[0] = 37

//Y = foo(&Z,3)  // FIXED -------- Y is now created correctly with the return vector 
setdebug (1, @pline, @~step, @trace) ;
Y = foo(Z,3)  // FIXED -------- Y is now created correctly with the return vector 

//Y=foo(Z,3)  // TBD FIX -- default array name is ref call

//Y= foo(&Z[2],4)  // TBD FIX it does not compute the offset - so proc operates on the third element in

<<"after proc $Z\n"

chkN(Z[1],47);

chkN(Z[6],28);

if ((Z[1] == 47)  && (Z[6] == 28)) {

<<"Z[1] and Z[6] correct \n"

}

if ((Z[1] == 47) ) {
 <<"Z correct \n"
}
else {
 <<"Z wrong \n"
}

<<"return vec $Y\n"


chkN(Y[1],47)
chkN(Y[6],28)

if ((Y[1] == 47)  && (Y[6] == 28)) {

<<"return of Y[1] and Y[6] is correct \n"

}
else {

<<" return vector incorrect !\n"

}






Y= foo(&W[2],4)  // TBD FIX it does not compute the offset - so proc operates on the third element in


chkOut()



stop!


if (Y[1] == 47) {
<<"Y correct \n"
}
else {
<<"Y wrong \n"

}

stop!


/////////////////////  simple scalar ///////////////////

proc doo(a,b)
{

  c= a + b
<<"%V$c\n"
  return c

}


  t=doo(3,4)
<<"$t\n"

  t=doo(7,8)
<<"$t\n"


  t=doo(27,35)
<<"$t\n"


stop!
