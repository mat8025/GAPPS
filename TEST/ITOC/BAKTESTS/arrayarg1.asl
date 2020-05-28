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

setdebug (1, @pline, @~step, @trace) ;


civ = 0;

cov= getEnvVar("ITEST")
if (! (cov @="")) {
civ= atoi(cov)
<<"%V $cov $civ\n"

}

checkIn(civ)



/////////////////////  simple scalar ///////////////////

proc doo(a,b)
{
  c= a + b
<<"%V$c\n"
  return c
}


  t=doo(3,4)
<<"$t\n"
  checkNum(t,7);
  
  t=doo(7,8)
<<"$t\n"
checkNum(t,15);

  t=doo(27,35)
<<"$t\n"
checkNum(t,62);





proc foo(int vec[],k)
//proc foo(vec,k)
{
<<"$_proc IN $vec \n"

<<"pa_arg2 %V$k\n"

  vecp = vec;

  vecp[1] = 47;
<<"add 47 $vec \n"  
  vecp[2] = 79;
<<"add Au $vec \n"

  vecp[3] = 80
  vecp[4] = 78
  vecp[5] = 50

<<"OUT $vecp \n"

<<"OUT orig entry $vec \n"

  return vecp
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
<<"Y:: $Y\n"
//Y=foo(Z,3)  // TBD FIX -- default array name is ref call

//Y= foo(&Z[2],4)  // TBD FIX it does not compute the offset - so proc operates on the third element in

<<"after proc $Z\n"

checkNum(Z[0],36);

checkNum(Z[6],28);


if ((Y[1] == 47) ) {
 <<"Z correct \n"
}
else {
 <<"Y wrong \n"
}

<<"return vec $Y\n"


checkNum(Y[1],47)
checkNum(Y[6],28)

if ((Y[1] == 47)  && (Y[6] == 28)) {

<<"return of Y[1] and Y[6] is correct \n"

}
else {

<<" return vector incorrect !\n"

}






U= foo(&W[2],4)  // TBD FIX it does not compute the offset
                 // - so proc operates on the third element in

<<"U:: $U\n"
<<"%V$U\n"
checkOut()



stop!


if (Y[1] == 47) {
<<"Y correct \n"
}
else {
<<"Y wrong \n"

}

stop!
