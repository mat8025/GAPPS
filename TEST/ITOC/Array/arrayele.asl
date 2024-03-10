/* 
 *  @script arrayele.asl                                                
 * 
 *  @comment test array vec and ele use                                 
 *  @release Boron                                                      
 *  @vers 1.43 Tc Technetium [asl 5.85 : B At]                          
 *  @date 03/10/2024 10:44:17                                           
 *  @cdate 1/1/2007                                                     
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2024 -->                               
 * 
 */ 

//----------------<v_&_v>-------------------------//                                  

#include "debug"

   if (_dblevel >0) {

     debugON();

     }


int db_allow = 0; // set to zero for internal debug print

   chkIn (_dblevel);

if (db_allow) {
 allowDB("spe,opera_,array_parse,parse,rdp_,ds,pex")
}

   int main_chk = 0;

   <<"%V $(main_chk++) $_scope $_cmfnest $_proc $_pnest\n";

   float f= 3.142;

   f.pinfo();

   <<"$f \n";

   int p = 1234567;

   p.pinfo();

   Str sv ="buen dia";

   asv = sv;

   sv.pinfo();

   asv.pinfo();

   Real1 = vgen (FLOAT_, 10, 0, 1);

   Real1.pinfo();

   <<"%V$Real1\n";

   <<"%V $(main_chk++) $_scope $_cmfnest $_proc $_pnest\n";


   j= 5;

   <<"$j $Real1[j]\n";

   float array_asg (float rl[])
   {

     <<"In $_proc \n";
     float val;
     rl.pinfo();

     int kp = 3;

     int kp2 = 5;

     kp.pinfo();
//ans=query()

     rl[1] = 77;
     rl.pinfo();
     
<<"%V %6.2f $rl\n";
      //allowDB("array,spe,parse,ic")
     rl[kp] = 67;
     rl.pinfo();
<<"%V %6.2f $rl\n";

     rl[kp2] = 14;
     rl.pinfo();
 <<"%V %6.2f $rl\n";

     val = rl[1];
     chkR (rl[1],77);
     rl.pinfo();

 <<"%V $kp $val %6.2f $rl\n";

    val = rl[3];
     
     chkR (rl[3],67);

<<"%V $val $rl\n";
     chkR (rl[kp2],14);
     val = rl[kp2];
     
<<"%V$val $rl\n";

     t3 = rl[8];

     return t3;

     }
//======================================//

   int SA =0;

   float array_sub (float rl[])
   {

     <<"In $_proc   $rl\n";

 <<"PROC %V $(main_chk++) $_scope $_cmfnest $_proc $_pnest\n";

     rl.pinfo();

//ans=ask("rl ?",1)

     <<"PROC after pinfo %V  $_scope $_cmfnest $_proc $_pnest\n";
 //SA = SA + 1;

     SA++;

     float t1;

     float t2;
     float t3;
     
//  <<"%V$rl \n";
     int jj = 0;
     t1 = rl[2];

     t1.pinfo();


     t1 = rl[4];

//  <<"%6.2f%V$t1\n";

     <<"$(Caz(t1))\n";

     int k = 5;

     t2 = rl[k];

     <<"%V$t2\n";

     <<"$(Caz(t2))\n";

     j1 = 4;

     j2 = 6;

     rl.pinfo()
     j1.pinfo()
     
     t3 = rl[j1] ;

     t3.pinfo()
     <<"%V $j1   \n";
     <<"%V %6.2f $t3  \n";
     chkR (t3, 4);

     t3 = rl[j2] ;

     <<"%V $j2 %6.2f $t3  \n";

     chkR (t3, 6);




     t3 = rl[j1] - rl[j2];

     <<"%V %6.2f $t3  \n";

     <<"$(Caz(t3))\n";

     chkR (t3, -2);

     t4 = rl[j1 + 1];

     <<"%V $t4  \n";

     <<"$(Caz(t4))\n";

     <<"rl $rl \n";
     <<"%V $k $j1 $j2 \n";
     <<"%6.2f$rl \n";
     kp = 3;
    <<"%V $rl[j1] \n";     

    <<"%V $rl[j2] \n";
 Real2.pinfo();

  if (db_allow) {
      allowDB("array,spe,parse,ic,pex")
  }

<<"%V $rl[j1]    $rl[j2] \n";
 Real2.pinfo();


//ans=ask(" $rl[j2]  ",1)


     rj1 = rl[j1];

     rj1.pinfo();

     <<"%V $SA\n";


     <<"%V $rj1\n";

     rj2 = rl[j2];

     rj2.pinfo();

     <<"%V $rj2\n";

     wrl = rj1 -rj2;

     <<"%V $wrl $rj1 $rj2\n";

     wrl.pinfo();

     chkR (wrl, -2);




 Real2.pinfo();

//ans=ask("Real2?",1)
    <<"%V $kp  $j2 $j1 \n";

     <<"rl $rl \n";

     rl[kp] = rl[j1] - rl[j2];

     <<"rl $rl \n";
     <<"$rl[kp] -2\n";
     <<"%V $rl[kp] 3 -2\n";
     <<"%V $rl[j1]  4 \n";
     <<"%V $rl[j2]  6 \n";
      <<"%V $rl[4]  $rl[6] \n";

     <<"%V $rl[kp] $rl[j1]  $rl[j2] \n";

     <<"rl $rl \n";





//<<"%6.2f$rl \n";
//  <<"%V $rl[kp] \n";

     wrl = rl[kp];

     <<"%V $wrl  $rl[kp] = $rl[j1] - $rl[j2]\n";

     chkR (wrl, -2);

     <<"%V $wrl  $rl[kp] \n";

     rl[0] = 47;

     <<"%V $rl \n";

     <<"%V $wrl \n";

     <<"%V $kp $rl[kp] \n";

     jj = rl[kp];

     <<"%V $jj $kp $rl[kp] \n";

     <<"%V $rl \n";

     chkR (jj, -2);

     <<"%V $rl\n";


     <<"%V $j1  $rl[j1] \n";

     rl.pinfo();

     TA=testargs(rl[j1],rl[j2],jj,kp);

     <<"%(1,,,\n)$TA\n";

     <<"%V $j1   \n";

     <<"%V $rl[j1] \n";

     res= rl[j1];

     <<"%V $res \n";

     chkR (res, 4.0);

     chkR (res, rl[j1]);

     chkR (rl[j1], 4.0);

     ff= rl[j1];

     <<" $ff   \n";

     <<" $rl[j1]  5 \n";
//<<"$rl\n"   // FIX does not parse rl here why?

     chkR (rl[4], 4);

     <<"rl vec $rl[0:-1]\n";

     chkR (rl[5], 5);

     t6 = rl[5];

     chkR (t6, 5);

     <<"%V$t6\n";

     <<"$(Caz(t6))\n";

     <<"$rl\n";

//     <<"PROC_OUT %V $(main_chk++) $_scope $_cmfnest $_proc $_pnest\n";

     return t3;

     }
//////////////////////////////////////////////////////////////////////////////////////

   chkR (Real1[2],2);

   Real2 = vgen (FLOAT_, 10, 0, 1);

 //  <<"%V $(main_chk++) $_scope $_cmfnest $_proc $_pnest\n";



   val = array_sub (Real2);

 //  <<"%V $(main_chk++) $_scope $_cmfnest $_proc $_pnest\n";

   <<"%V$Real2\n";

   val = array_asg (Real1);

   <<"%V $val\n";

ans=ask("2 $val ?",0)





   <<"%V$Real1\n";

   val = array_asg (Real2);


ans=ask("2 $val ?",0)

   //ans= query("xic")

   <<"%V $val\n";

   <<"%V$Real2\n";



   float mt1;

   mt1 = Real1[4];

   chkR (mt1, 4);

   <<"%V $mt1 \n";

   Real1[0] = 74.47;

   <<"%V$Real1\n";

//   <<"%V $(main_chk++) $_scope $_cmfnest $_proc $_pnest\n";

   <<"%V  $_scope $_cmfnest $_proc $_pnest\n";

   Real3 = vgen (FLOAT_, 10, 0, 1);

   val = array_sub (Real3);

 //  <<"%V $(main_chk++) $_scope $_cmfnest $_proc $_pnest\n";
//chkStage()
////////////////////
//double Real[10];

   Real = vgen (DOUBLE_,10, 0, 1);

   <<"Real %6.2f $Real \n";

   Real.pinfo();

   val = array_sub (Real);

//   <<"%V $(main_chk++) $_scope $_cmfnest $_proc $_pnest\n";

   val = Real[3];

   <<"%V$val \n";

   chkR (val, -2);

   k = 4;

   val = Real[k];

   <<"%V$val \n";

   chkR (val, 4);

   sz = Csz (Real);

   <<" done Caz %V$sz\n";

   double t1 = 4;

   sz = Csz (&t1);

   <<" done Caz %V$sz\n";

   <<"%V$t1  $(typeof(t1))\n";

   <<"$(Caz(t1))\n";

   <<" done Caz !\n";

   t1 = Real[4] ;

   <<"%V $t1  $(typeof(t1))\n";

   <<"$(Caz(t1))\n";

   <<" done Caz !\n";

   chkR (t1, 4);

   double t2;

   k = 5;

   t2 = Real[k];

   <<"%V$t2\n";

   <<"$(Caz(t2))\n";

   chkR (t2, 5);

   j1 = 4;

   j2 = 6;

   t3 = Real[j1] - Real[j2];

   <<"%V $t3  \n";

   <<"$(Caz(t3))\n";

   chkR (t3, -2);

   <<"$Real[j1]\n";

   t4 = Real[j1 + 1];




   <<"%V $t4  \n";

   <<"$(Caz(t4))\n";

   chkR (t4, 5);

   <<"%6.2f$Real \n";

   <<"%V $(main_chk++) $_scope $_cmfnest $_proc $_pnest\n";   // TBF ++

   Real[k] = Real[j1] - Real[j2];

   diff = Real[j1] - Real[j2];

   <<"%V $k $j1 $j2 $diff $Real[k] $Real[j1] $Real[j2]\n";
//ans=ask(DB_prompt,DB_action)

   <<"ele[${k}] %6.2f $Real[k] \n";

   Real.pinfo();

   <<"MAIN %V  $_scope $_cmfnest $_proc $_pnest\n";



<<"%V $k \n";
   <<"%6.2f$Real \n";

   chkR (Real[k], -2);

   t2 = Real[k];

   <<"%V$t2\n";
//!a
   <<"$(Caz(t2))\n";

   chkR (t2, -2);

   <<"$Real[0:3]\n";

   Real[j1] = Real[j1] - Real[j2];

   <<"$Real\n";

   <<"just Real[j1] $Real[j1]\n";

   chkR (Real[j1], -2);

   chkR (Real[4], -2);
////// Now inside proc -- with proc stack variables  //////////////////////////////

   Real2 = fgen (10, 0, 1);

   <<"%V$Real2\n";

   Real2.pinfo()


//ans=ask("real2?",1)

   val = array_sub (Real2);

   <<"%V  $_scope $_cmfnest $_proc $_pnest\n";

   <<"$val \n";

   N=10;

   void Foo(float rl[])
   {
     int j1;
     j1 =2;
     float rxp;

     <<"%V$rxp  $(typeof(rxp)) %i$rxp \n";

     rxp = rl[j1];

     <<" %V$j1 $rxp  $(cab(rxp))\n";

     rxp2 = rl[j1+1];

     <<" %V$j1 $rxp2  $(cab(rxp2))\n";

     j1 = 1;

     for (i = j1; i < N ; i++) {

       rxp = rl[j1];

       <<" %V $j1 $rxp  $(cab(rxp))\n";

       j1++;

       }

     }
//----------------------------

   void fooey(float rl[])
   {

     <<"%I$rl   $(Caz(rl))\n";

     rxp = rl[1];

     <<"$rxp\n";

     chkR (rxp,11);

     <<"$rl   $(Caz(rl))\n";

     j1 = 1;

     rxp = rl[j1];

     <<"$rxp\n";

     <<"$rl\n";

     <<"%I$rl   $(Caz(rl))\n";

     j2 = 2;

     rl[j2] = rl[j1];

     <<"%V$rl   $(Caz(rl))\n";

     <<"$rl\n";

     j3 = 3;

     rl[j1] = rl[j1] + rl[j2];
//<<"%I$rl \n"

     vsz = Caz(rl);

     <<"%V$vsz\n";

     <<"$rl\n";

     <<"%I$rl   $(Caz(rl))\n";

     <<"$rl\n";

     }
     //EP////////////////////////////////////////////

   Re = fgen(10,10,1);

   <<"%i $Re\n";

   <<"$Re\n";

   j =2;

   rxm = Re[j];

   <<" %V$j $rxm  %i$rxm\n";

   rxm = Re[j+1];

   <<" %V$j $rxm  %i$rxm\n";

   Foo(Re);

   fooey(Re);

   sz = Caz(Re);

   <<"%V$sz\n";

   chkN (sz,10);

   chkOut ();


