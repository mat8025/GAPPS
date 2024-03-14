/* 
 *  @script iproc.asl                                                   
 * 
 *  @comment test indirect call pr proc ()                              
 *  @release Boron                                                      
 *  @vers 1.5 B Boron [asl 5.87 : B Fr]                                 
 *  @date 03/14/2024 07:31:49                                           
 *  @cdate 1/1/2011                                                     
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2024 -->                               
 * 
 */ 


//----------------<v_&_v>-------------------------//;                  

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


 int Owl (int k, int m)
  {
    w= k * m;

    return w;
   }


 float Crow (float k, float m)
  {
   float  w= k / m;

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


   wc = Owl( 93,7)

<<" Owl  says $wc \n"

  cbname = "Owl"

   wc = $cbname(5,14);  

<<" Owl  says 5 * 14 = $wc \n"

   x = 6; y = 7;

   wc = $cbname(x,y);  

<<" Owl  says $x * $y = $wc \n"


  cbname = "Crow"

   wcf = $cbname(x,y);  

<<" Crow says $x / $y = $wcf \n"



   chkOut(1)
