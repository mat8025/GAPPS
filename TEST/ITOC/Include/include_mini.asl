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

#include "debug"

if (_dblevel >0) {
   debugON()
   <<"$Use_\n"
}

allowErrors();
   
   <<"does nested includes\n"; 
   
   chkIn(_dblevel); 
   
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
   
   <<" before include\n"; 

#include "mini"

<<"%V$Mini\n"

chkT(Mini>0)

chkOut();

exit()



