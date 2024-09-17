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


int db_allow = 1; // set to 1 for internal debug print
int db_ask = 0
db_ask_yes = 1
db_ask_no = 0
<<"%V $db_ask $db_allow\n"
 db_ask.pinfo()
ans= ask("%V $db_ask $db_allow",0)

   chkIn (_dblevel);



   allowDB("spe_proc",1)

  // rejectDB("pex,spe_state,spe_proc,ds_storestr,spe_print",1)


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

<<"%V $rl[1] \n"
     rl.pinfo();


<<"%V %6.2f $rl\n";
ans= ask(" $rl ",db_ask)

     rl[kp] = 67;
     rl.pinfo();

<<"%V %6.2f $rl\n";

     chkR (rl[kp],67);

ans= ask(" $rl[1] ",db_ask)


     rl[kp2] = 14;

     rl.pinfo();
     
 <<"%V %6.2f $rl\n";

     val = rl[1];

 <<"$rl[1]  $val\n";

     chkR (rl[1],77);

ans= ask(" $rl[1] ",db_ask)



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
// TBF 7/27/24  rl[]  bad proc arg? float rl[]   use float* rl   Siv* rl
   float array_sub (float rl[])
   {

     <<"In %V $_proc   $rl\n";

 <<"PROC %V $(main_chk++) $_scope $_cmfnest $_proc $_pnest\n";
     //Svar TA;
     rl.pinfo();
     db_ask.pinfo()
ans=ask("%V $rl ? $db_ask", db_ask)

     <<"PROC after pinfo %V  $_scope $_cmfnest $_proc $_pnest\n";
 //SA = SA + 1;

     SA++;

     float t1;

     float t2;
     float t3;
     
//  <<"%V$rl \n";
     int jj = 0;
     
     t1 = rl[2];

ans=ask("%V$t1 $rl[2] ?",db_ask_no)     
     t1.pinfo();

 


     t1 = rl[4];

     rl.pinfo()
ans=ask("%V$t1  $rl[4] ?",db_ask_no)     

//  <<"%6.2f%V$t1\n";

     <<"$(Caz(t1))\n";

     int k = 5;

     t2 = rl[k];

     <<"%V$t2\n";

     <<"$(Caz(t2))\n";

     rl.pinfo()

ans=ask("%V $k  $rl[k] $t2 ?", db_ask_no)     


     j1 = 5;

     j2 = 6;

     rl.pinfo()
     j1.pinfo()
     
     t3 = rl[j1] ;

     t3.pinfo()
     <<"%V $j1   \n";
     <<"%V %6.2f $t3  \n";
     chkR (t3, 5);


      j1 = 4   



     t3 = rl[j2] ;

     <<"%V $j2 $rl[j2] $t3  \n";

     chkR (t3, 6);

     rl.pinfo()

     //rejectDB("spe,array",1)   

    <<"%V $j1 $j2 \n"

     rl4 = rl[j1]
     rl.pinfo()
<<"%V $rl4  \n"     
     rl6 = rl[j2]
     rl.pinfo()

<<"%V $rl4 $rl6 \n"

      <<"%V $rl[j1] \n"
     rl.pinfo()
      <<"%V $rl[j2] \n"
     rl.pinfo()
 chkN(rl4,4)
 chkN(rl6,6)


 rl.pinfo()

ans=ask("%V $rl ?",db_ask)


       
<<"%V $j1 $j2\n"

    <<"%V $rl[j2] \n"
     t3 = rl[j2] ;

  t3.pinfo()
    <<"%V $rl[j1] \n"

     t3 = rl[j1] ;

  t3.pinfo()


     t3 = rl[j1] - rl[j2];

    <<"%V $rl[j1] \n"

      <<"%V $rl[j2] \n"

     <<"%V %6.2f $t3  \n";

  t3.pinfo()

     <<"%V $(Caz(t3))\n";

 <<"%V $j1 $j2 \n"


ans=ask("%V $rl[j1]  $rl[j2]",db_ask)

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


<<"%V $rl[j1]    $rl[j2] \n";
 Real2.pinfo();



ans=ask(" $rl[j2]  ",db_ask)


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

ans=ask("Real2?",db_ask)
    <<"%V $kp  $j2 $j1 \n";

     <<"rl $rl \n";

rl.pinfo()

     rl[kp]   =  787;

ans=ask("%V $kp $rl[kp] == 787 ?",db_ask_no)     
 chkN(rl[kp],787)

     rl[kp] = rl[j1] - rl[j2];

rl.pinfo()

  <<"rl $rl \n";

ans=ask("%V $kp $j1 $j2 $rl[kp] == -2 ?",db_ask_no)     

   chkN(rl[kp],-2)
   
   
   
   fval = rl[1]
   
   ans=ask("%V $rl[1] $fval ?", db_ask_no)     

   fval = rl[j1]


   ans=ask("%V $rl[j1] $j1 $fval ?",db_ask_no)     

   fval = rl[kp]


ans=ask("rl[kp] $kp $fval ?",db_ask_no)     



 //wdb=DBaction((DBSTEP_),ON_)

     <<"%V -2.0 $kp   $rl[kp] \n";


     <<"%V $rl[kp] 3 -2\n";


     <<"%V $rl[j1]  4 \n";
     <<" should be array elements $rl[j1] \n"

    <<"%V $rl[j2]  6 \n";

    <<"%V $rl[j1]  $rl[j2] \n";

     kp.pinfo()
     
     //<<"%V $rl[kp] $rl[j2] \n";

    //<<"%V $rl[j2]  $rl[kp] $rl[j1] \n";
    //kp = j2
 //  <<"%V $rl[j2]  $rl[j1] $rl[6] $rl[5] $rl[kp] $rl[j1] \n";

  <<"%V $rl[j2]  $rl[j1] $rl[6] $rl[5]  $rl[j1] $rl[kp] \n";

  <<"rl $rl \n";

 <<"%V $rl[j2]  $rl[j1] $rl[6] $rl[5] $rl[kp] $rl[j1] \n";

 <<"%V $rl[kp] $rl[4]  $rl[6] \n";

   ans=ask("$rl[kp] $kp  ?",0)


//<<"%6.2f$rl \n";
  <<"rl $rl \n"
  
  <<"%V $rl[kp] \n";

     wrl = rl[kp];

ans=ask("%V $kp $rl[kp] $rwl  ?", db_ask_no)     


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

ans=ask(" $rl ?",0)

<<" %V $rl[j1] $rl[j2]  $jj $kp \n"

ans=ask(" $rl[1] prior testargs ?",db_ask_no)     

     TA = testargs(rl[j1],rl[j2],jj,kp);  // does not WIC create TA

     TA.pinfo()

ans=ask(" post testargs ?",db_ask_no)          

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

 //    <<"rl vec $rl[0:-1]\n";  // TBF 9/16/24

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

      j1 = 4
      j2 = 6

     t3 = Real1[j1] - Real1[j2];

    <<"%V $Real1[j1] \n"

      <<"%V $Real1[j2] \n"

     <<"%V %6.2f $t3  \n";

     chkR (t3, -2);

ans=ask("%V $Real1[j1]  $Real1[j2]",db_ask_no)     



     chkStage(" MAIN");

ans=ask("  where $__LINE__ ",db_ask_no)     

 chkStage(" PROC_DEF");
 ans=ask(" @ $__LINE__ ",db_ask_no)     

  chkR (Real1[2],2);

   Real2 = vgen (FLOAT_, 10, 0, 1);

 //  <<"%V $(main_chk++) $_scope $_cmfnest $_proc $_pnest\n";

   Real2.pinfo()

   val = array_sub (Real2);

 //  <<"%V $(main_chk++) $_scope $_cmfnest $_proc $_pnest\n";

   <<"%V $Real2\n";

   val = array_asg (Real1);

   <<"%V $val\n";

   ans=ask("2 $val ?",db_ask)





   <<"%V$Real1\n";

   val = array_asg (Real2);


ans=ask("2 $val ?", db_ask)

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

////////////////////
//double Real[10];

   //Real = fgen (10, 0, 1);

   Vec<double> Rvec(10,0,1)

   <<"Rvec %6.2f $Rvec \n";

   Rvec.pinfo();

   val = array_sub (Rvec);

//   <<"%V $(main_chk++) $_scope $_cmfnest $_proc $_pnest\n";

   val = Rvec[3];

   <<"%V$val \n";

   chkR (val, -2);

   k = 4;

   val = Rvec[k];

   <<"%V$val \n";

   chkR (val, 4);

   sz = Csz (Rvec);

   <<" done Caz %V$sz\n";

   double t1 = 4;

   sz = Csz (&t1);

   <<" done Caz %V$sz\n";

   <<"%V$t1  $(typeof(t1))\n";

   <<"$(Caz(t1))\n";

   <<" done Caz !\n";

   t1 = Rvec[4] ;

   <<"%V $t1  $(typeof(t1))\n";

   <<"$(Caz(t1))\n";

   <<" done Caz !\n";

   chkR (t1, 4);

   double t2;

   k = 5;

   t2 = Rvec[k];

   <<"%V$t2\n";

   <<"$(Caz(t2))\n";

   chkR (t2, 5);

   j1 = 4;

   j2 = 6;

   t3 = Rvec[j1] - Rvec[j2];

   <<"%V $t3  \n";

   <<"$(Caz(t3))\n";

   chkR (t3, -2);

   <<"$Rvec[j1]\n";

   t4 = Rvec[j1 + 1];

   chkT(1)
   chkStage(" Nearly Done ")
 ans=ask(" @ $__LINE__ ",db_ask_no)     

   <<"%V $t4  \n";

   <<"$(Caz(t4))\n";

   chkR (t4, 5);
   allowDB("spe,parse,rdp,ds",1)
  // rejectDB("array",1)   
   <<"%6.2f$Rvec \n";

   <<"%V $(main_chk++) $_scope $_cmfnest $_proc $_pnest\n";   // TBF ++



   diff = 52.3;

   Rvec[k] = diff;
 <<"%V $k $j1 $j2 $diff $Rvec[k] $Rvec[j1] $Rvec[j2]\n";

chkR (Rvec[k], 52.3);



   Rvec[k] = diff;

 <<"%V $k $j1 $j2 $diff $Rvec[k] $Rvec[j1] $Rvec[j2]\n";

    diff = Rvec[j1] - Rvec[j2];

 <<"%V $k $j1 $j2 $diff $Rvec[k] $Rvec[j1] $Rvec[j2]\n";

   chkR (diff, -2.0);

  

   <<"ele[${k}] %6.2f $Rvec[k] \n";

   Rvec[k] = Rvec[j1] - Rvec[j2];

   Rvec.pinfo();

   ans=ask("%V $diff $k $Rvec[k] ",db_ask_no)     

   <<"MAIN %V  $_scope $_cmfnest $_proc $_pnest\n";

   <<"%V $k \n";
   
   <<"%6.2f$Rvec \n";

   chkR (Rvec[k], -2);

   t2 = Rvec[k];

   <<"%V$t2\n";

   <<"$(Caz(t2))\n";

   chkR (t2, -2);
   ans=ask("%V $t2 -2",db_ask_no)     
   <<"$Rvec[0:3]\n";

   Rvec[j1] = Rvec[j1] - Rvec[j2];

   <<"$Rvec\n";

   <<"just Rvec[j1] $Rvec[j1]\n";

   chkR (Rvec[j1], -2);

   chkR (Rvec[4], -2);
////// Now inside proc -- with proc stack variables  //////////////////////////////

   Rvec2 = fgen (10, 0, 1);

   <<"%V$Rvec2\n";

   Rvec2.pinfo()




   val = array_sub (Rvec2);

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
     
    chkT(1)
    
    chkStage(" ...")
    
    ans=ask(" @ $__LINE__ ",db_ask_no)     


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

    chkStage(" END")

   chkOut (1);
   

////
