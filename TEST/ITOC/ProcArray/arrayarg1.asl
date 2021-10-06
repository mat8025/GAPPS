/* 
 *  @script arrayarg1.asl 
 * 
 *  @comment test proc array args 
 *  @release CARBON 
 *  @vers 1.39 Y Yttrium [asl 6.3.38 C-Li-Sr] 
 *  @date 06/28/2021 22:10:34 
 *  @cdate 1/1/2005 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
/ 
                                                                     

<|Use_=
Demo  of args  ;
///////////////////////
|>


#include "debug"
#include "hv.asl"

<<"%V $_dblevel\n"

if (_dblevel >0) {
   debugON()
    <<"$Use_\n"   
}

ignoreErrors()

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





int voo(int vect[])
{
<<"$_proc IN $vect \n"
//Z->info(1)
//<<"pa_arg2 %V$k\n"

  
  vect[1] = 47;
<<"add 47 $vect \n"  
  vect[2] = 79;
<<"add Au $vect \n"

  vect[3] = 80
  vect[4] = 78
  vect[5] = 50
  z= vect[5]
<<"OUT $vect \n"

  return z;
}
//============================
int voo2(int vect[])
{
<<"$_proc IN $vect \n"
//Z->info(1)
//<<"pa_arg2 %V$k\n"

  vect->info(1)
  vect[1] = 47;
<<"add Ag vect: $vect \n"
<<"add Ag U: $U \n"  
  vect[2] = 79;
<<"add Au vect: $vect \n"

  vect[3] = 80
  vect[4] = 78
  vect[5] = 50
  z= vect[1]

<<"$z\n"
vect->info(1)
<<"OUT vect: $vect \n"
U->info(1)
<<"OUT U: $U \n"

  return z;
}
//============================

int roo(int vect[])
{
<<"$_proc IN $vect \n"
//Z->info(1)
//<<"pa_arg2 %V$k\n"

  vecp = vect;  // creates local copy of vect
  vecp[1] = 47;
  
<<"add 47 $vect \n"  
  vecp[2] = 79;
<<"add Au $vect \n"

  vecp[3] = 80
  vecp[4] = 78
  vecp[5] = 50

<<"OUT $vecp \n"

<<"OUT orig entry $vect \n"

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

y = voo(Z) 

<<"%V $y \n"

chkN(Z[1],47);
chkN(Z[5],50);
chkN(Z[6],28);




// reset

U = Vgen(INT_,10,0,1)


W = U



<<"pre proc call $U\n"


 // TBD FIX it does not compute the offset - so proc operates on the third element in

<<"//////////////////////////////////\nB4 $U\n"

y = voo2(&U[3]) 

<<"after $U\n"

uv= U[4]

<<"%V $uv $U[4]\n"

chkN(U[4],47);

chkN(U[7],78);


chkN(U[8],50);

 voo2(W) 


chkOut();

exit()


//Y = foo(&Z,3)  // FIXED -------- Y is now created correctly with the return vector 

 // FIXED ?-------- Y is now created correctly with the return vector 


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

//T= zoo(pv)


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


