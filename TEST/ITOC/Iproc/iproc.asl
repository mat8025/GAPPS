
#include "debug"

  if (_dblevel >0) {

  debugON();

  }

  chkIn (_dblevel);
  db_allow  =1;
  chkT(1)
  
  just_once = 0;

  LD_libs = 0;
//=======================//

  int Wolf (int k)
  {
    w= k * 7;

    return w;
   }

  //EP=====================//

 int Bear (int k)
  {
    w= k * 9;

    return w;
   }

  //EP=====================//


 int Fox ()
  {
    w= K * 80;

    return w;
   }

int K = 4;

if (db_allow) {
 allowDB("spe_proc,parse")
}

  wc = Wolf(80);

  <<" after direct call of Wolf returns $wc \n";

  wc = Fox();

  <<" after direct call of Fox returns $wc \n";
K= 5
  cbname = "Fox"

<<"indirect call of $cbname\n"


  wc = $cbname();  


  <<" after indirect call of Fox returns $wc \n";


  cbname = "Wolf"






  wc = $cbname(5);  

  <<" after Indirect call of Wolf returns $wc \n";



  wc = Bear(80);

  <<" after direct call of Bear returns $wc \n";

   chkN(wc,720)

   cbname = "Bear"

  wc = $cbname(5);  

    chkN(wc,45)



   for (i = 0 ; i < 5; i++) {

    if (i < 3) {
    <<" call Bear\n"
      cbname = "Bear"
    }
    else {
    <<" call Wolf\n"    
       cbname = "Wolf"
    }

    wc = $cbname(5);  

 <<"[$i] after Indirect call of $cbname returns $wc \n";

   }


   chkOut(1)
