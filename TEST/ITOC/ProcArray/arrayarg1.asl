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

include "debug"

<<"%V $_dblevel\n"

if (_dblevel >0) {
   debugON()
}

chkIn(_dblevel)



/////////////////////  simple scalar ///////////////////

proc doo(int a,int b)
{
  c= a + b
<<"%V$c\n"
  return c
}
//======================//

  t=doo(3,4)
<<"$t\n"
  chkN(t,7);
  
  t=doo(7,8)
<<"$t\n"
chkN(t,15);

  t=doo(27,35)
<<"$t\n"
chkN(t,62);




proc voo(int vec[])
{
<<"$_proc IN $vec \n"
Z->info(1)
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

<<"%V $Z\n"
Z->info(1)
//Z[0] = 37

//Y = foo(&Z,3)  // FIXED -------- Y is now created correctly with the return vector 

Y = voo(Z)  // FIXED -------- Y is now created correctly with the return vector 


<<"Y:: $Y\n"

chkN(Z[0],36);

chkN(Z[6],28);


//Y= foo(&Z[2],4)  // TBD FIX it does not compute the offset - so proc operates on the third element in

<<"after proc $Z\n"



chkN(Y[1],47)

chkN(Y[6],28)


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




chkOut()






if (Y[1] == 47) {
<<"Y correct \n"
}
else {
<<"Y wrong \n"

}


