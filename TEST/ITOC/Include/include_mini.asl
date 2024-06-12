//%*********************************************** 
//*  @script include.asl 
//* 
//*  @comment test include refs 
//*  @release CARBON 
//*  @vers 1.11 Na Sodium                                                 
//*  @date Thu Jan 17 09:39:14 2019 
//*  @cdate 1/1/2008 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
   
                                                                                              
<|Use_=
Demo  of include - nest
///////////////////////
|>

/*
#include "debug"

if (_dblevel >0) {
   debugON()
   <<"$Use_\n"
}
*/
allowErrors();
   
   <<"does nested includes\n"; 
   
   chkIn(); 
   
   ws = getScript(); 
   
   <<"%V $ws\n"; 
   
   A= 1;
   
   int N = 0 ;
   
   na= argc();
   if (na >1) {
    N = atoi(_clarg[1])
    <<"$N set from command line\n";
   }

<<"%V$N\n";

int do_mini2 = 0;

if (N > 10) {
   do_mini2 = 1;
}

<<" before include mini0 \n"; 

#include "mini0"

   <<" before include wex_rates \n"; 

#include "wex_rates"

<<"%V$Mini0\n"

chkT(Mini0==0)

#include "miniX"

chkN(MiniX,10)

chkOut();

exit()

/*
if (do_mini2) {

<<" before include mini2 \n"; 



chkT(Mini2>0)
}
*/





