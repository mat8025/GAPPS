//%*********************************************** 
//*  @script include_xic.asl 
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
   
/*                                                                                              
<|Use_=
Demo  of include - nest
///////////////////////
|>

#include "debug"

if (_dblevel >0) {
   debugON()
   <<"$Use_\n"
}

*/

allowErrors();
   

   
//   chkIn(); 
   
   ws = getScript(); 
   
   <<"%V $ws\n"; 
   
   A= 1;
   int N= 0;

   na= argc();
   if (na >1) {
   N = atoi(_clarg[1])
   <<"$N set from command line\n";
   }
   <<"%V$N\n";
 do_all =1;  


if (do_all) {

<<"doing some includes !\n"

#include "mini"
   <<"main sees globals %V $Mini $amin\n"; 
   
  // chkN(Mini,7)

/*
#include "mini2"

   <<"main sees globals %V $Mini2 $amin2\n"; 

#include "mini3"


<<"main sees globals %V $Mini3 $amin3\n"; 
*/

}

exit()

   //chkOut(); 
   
   
