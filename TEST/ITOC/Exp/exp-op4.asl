

<|Use_=
Demo  of exp-sivs;
///////////////////////
|>

#include "debug"

if (_dblevel >0) {
   debugON()
   <<"$Use_\n"   
}

filterFileDebug(REJECT_,"scopesindex_e.cpp","scope_e.cpp","scope_findvar");
filterFileDebug(REJECT_,"ds_sivbounds","ds_sivmem","exp_lhs_e");


chkIn()

n_legs = 3;

  <<"$n_legs \n"

float totalD = 0;
float totalDur = 0.0



void  TPCUPset (svar awval) 
   {

     awval->info(1);

     val = scut(awval[0],1)
     
     Place=dewhite(scut(awval,-1)); // wayp 
    
     <<"%V$Place\n"


     Idnt =  awval[1];

<<"%V$Idnt\n"

totalD = 2;
totalD->info(1)



}


   str targ;

   targ = "task"

   targ->info(1);

   if ( targ @= "task") {

<<" $targ   @= task"

    chkStr(targ,"task")
   }
   else {
    chkT(0);
   }

targ = "CS"

  if (targ @= "CS") {

<<" $targ   @= CS"

    chkStr(targ,"CS")
  }
 else {
    chkT(0);
   }





svar wval;

wval[0] = "try a lot"
wval[1] = "harder"
wval[2] = "more exercise"

wval->info(1)
<<"$wval \n"


<<"$wval[0] \n"


val = scut(wval[0],1)

<<"$val \n"


TPCUPset(wval);


chkOut()
