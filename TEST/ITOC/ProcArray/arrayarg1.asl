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

filterfuncdebug(ALLOWALL_,"xxx");

filterfiledebug(ALLOWALL_,"proc_");


sdb (1, @pline, @~step, @trace) ;


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
//======================//

  t=doo(3,4)
<<"$t\n"
  checkNum(t,7);
  
  t=doo(7,8)
<<"$t\n"
checkNum(t,15);

  t=doo(27,35)
<<"$t\n"
checkNum(t,62);




proc voo(int vec[])
{
<<"$_proc IN $vec \n"

//<<"pa_arg2 %V$k\n"

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


proc zoo(ptr vec)
{
<<"$_proc IN $vec \n"

//<<"pa_arg2 %V$k\n"

  vecp = vec;

  vecp[1] = 47;
<<"add 47 $vec \n"  
  vecp[2] = 79;
<<"add 79 $vec \n"

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


//Z[0] = 37

//Y = foo(&Z,3)  // FIXED -------- Y is now created correctly with the return vector 

Y = voo(Z)  // FIXED -------- Y is now created correctly with the return vector 


<<"Y:: $Y\n"

checkNum(Z[0],36);

checkNum(Z[6],28);


//Y= foo(&Z[2],4)  // TBD FIX it does not compute the offset - so proc operates on the third element in

<<"after proc $Z\n"



checkNum(Y[1],47)
checkNum(Y[6],28)


W = vgen(INT_,10,0,-1)

<<"W $W\n"


U= voo(W)

<<"%V$U\n"

//ptr pv = &W
ptr pv ;

pv->info(1)

pv = &W[2];

pv->info(1)

<<"pv $pv\n"

//U= voo(&W[2],4)

T= zoo(pv)


// TBD FIX it does not compute the offset
// - so proc operates on the third element in


<<"%V$T\n"




checkOut()






if (Y[1] == 47) {
<<"Y correct \n"
}
else {
<<"Y wrong \n"

}


