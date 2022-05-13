///
///  Screen setup for showtask
///
;


A=ofw("MENUS/TP.m")
<<[A],"title TP-Choice\n"
<<[A],"type CHOICE\n"
<<[A],"item Replace M_VALUE R\n"
<<[A],"item Delete M_VALUE D\n"
<<[A],"item Insert M_VALUE I\n"
<<[A],"item InsertName M_VALUE N\n"
<<[A],"item Name? C_INTER ?\n"
<<[A],"help  replace via name"
cf(A)

A=ofw("MENUS/STP.m")
<<[A],"title Start-Choice\n"
<<[A],"type CHOICE\n"
<<[A],"item ReplaceViaMouse M_VALUE R\n"
<<[A],"item Name? C_INTER ?\n"
<<[A],"help  replace via name"
cf(A)




  Graphic = CheckGwm();

<<"%V $Graphic\n"



  if (!Graphic) {
    Xgm = spawnGwm("ShowTask")
  }

// create window and scales

#include "tbqrd"



void updateLegs()
{

 str val;
 float lfga
   for (i = 0; i < Ntaskpts ; i++) {

    lwo = legwo[i+1];
    lfga =  Wleg[i].fga;
    msl =  Wleg[i].msl;
     dist =  Wleg[i].dist;
     val = "%6.0f$fga"
     
    <<"leg $i %6.1f $msl $dist  $lfga <|$val|> \n"

     sWo(lwo,_Wvalue,val.cptr(),_WREDRAW);

  }
 
}
//======================================//



  vp = cWi("vp");
  

  sWi(vp,_Wscales,wbox(-200,-200,200,200,0), _WDRAWON,_WPIXMAPON,_WSAVE,_WBHUE,WHITE_,_Wresize,0.1,0.01,0.9,0.95,0)
  // but we don't draw to a window! = draw to Wob in a Window

  sWi(vp,_Wclip,0.01,0.1,0.95,0.99);

  titleButtonsQRD(vp);


  tdwo= cWo(vp, WO_BV_);

  sWo(tdwo,_Wresize_fr,0.01,0.01,0.14,0.1,_Wname,"TaskDistance",_WEO);
  
  sWo(tdwo,_Wcolor,WHITE_,_Wstyle,"SVB");

  sawo= cWo(vp, WO_BV_);

  rsz= wbox(0.15,0.01,0.54,0.1);

  <<"%V $rsz\n";
  rsz.pinfo();


 // sWo(sawo,_WRESIZE, wbox (0.15,0.01,0.54,0.1),_WEO);
  sWo(sawo,_WRESIZE, rsz,_WEO);

  sWo(sawo,_Wcolor,WHITE_,_Wstyle,"SVB");


  vvwo= cWo(vp, WO_GRAPH_);

  sWo(vvwo,_WName,"ALT",_Wcolor,WHITE_);

// printargs(vvwo,_WRESIZE, wbox(1,2,3,4,5),_WEO);



 sWo(vvwo,_WRESIZE,wbox(0.2,0.11,0.95,0.25),_WEO);

  <<"did wbox all float ?\n";


  

  sWo(vvwo, _Wscales, wbox(0, 0, 100, 6000), _Wsavepixmap, _Wredraw, _Wdrawoff, _Wpixmapon);

  mapwo= cWo(vp,WO_GRAPH_);
  sWo(mapwo,_WRESIZE,wbox(0.30,0.26,0.95,0.95),_Wname,"MAP",_Wcolor,WHITE_);

<<"%V $mapwo $LongW $LatS \n"

  sWo(mapwo, _WSCALES, wbox(LongW, LatS, LongE, LatN), _WSAVE, _WREDRAW, _WDRAWON, _WPIXMAPON,_WSAVEPIXMAP,_WEO);

  int LastTP = 12; 
  int tpwo[12];
  int ltpwo[12];
  

  tpwo[0]=cWo(vp,WO_BV_);
  
  sWo(tpwo[0],_WNAME,"_Start_",_Wstyle,"SVR",_Wdrawon);

  tpwo[1] =cWo(vp,WO_BV_);

   sWo(tpwo[1],_Wname,"_TP1_",_Wstyle,"SVR",_Wdrawon);

/*

  tpwo[2] =cWo(vp,WO_BV_,_Wname,"_TP2_",_Wstyle,"SVR", _Wdrawon)

  tpwo[3] =cWo(vp,WO_BV_,_Wname,"_TP3_",_Wstyle,"SVR", _Wdrawon,_Wcolor,BLUE_,_Wfonthue,BLACK_)

  tpwo[4] =cWo(vp,WO_BV_,_Wname,"_TP4_",_Wstyle,"SVR", _Wdrawon,_Wcolor,BLUE_,_Wfonthue,BLACK_)

  tpwo[5] =cWo(vp,WO_BV_,_Wname,"_TP5_",_Wstyle,"SVR", _Wdrawon,_Wcolor,ORANGE_,_Wfonthue,BLACK_)

  tpwo[6] =cWo(vp,WO_BV_,_Wname,"_TP6_",_Wstyle,"SVR", _Wdrawon)

  tpwo[7] =cWo(vp,WO_BV_,_Wname,"_TP7_",_Wstyle,"SVR", _Wdrawon)

  tpwo[8] =cWo(vp,WO_BV_,_Wname,"_TP8_",_Wstyle,"SVR", _Wdrawon)

  tpwo[9] =cWo(vp,WO_BV_,_Wname,"_TP9_",_Wstyle,"SVR", _Wdrawon)

  tpwo[10] =cWo(vp,WO_BV_,_Wname,"_TP10_",_Wstyle,"SVR", _Wdrawon)

  tpwo[11] =cWo(vp,WO_BV_,_Wname,"_TP11_",_Wstyle,"SVR", _Wdrawon)

  tpwo[12] =cWo(vp,WO_BV_,_Wname,"_TP12_",_Wstyle,"SVR", _Wdrawon)

*/

  finish_wo = tpwo[2]
  
  tpwos = tpwo[0:2];

  MaxSelTps = 13;
  
  <<"%V $tpwos\n"
  
  wovtile(tpwos, 0.02, 0.4, 0.14, 0.95)

  int legwo[12];

  legwo[0] = -1;

  legwo[1] = cWo(vp,WO_BV_,_Wname,"_LEG1_",_Wstyle,"SVR",_Wdrawon)

  legwo[2] = cWo(vp,WO_BV_,_Wname,"_LEG2_",_Wstyle,"SVR", _Wdrawon)

  legwo[3] = cWo(vp,WO_BV_,_Wname,"_LEG3_",_Wstyle,"SVR", _Wdrawon,_Wcolor,BLUE_,_Wfonthue,BLACK_)

  legwo[4] = cWo(vp,WO_BV_,_Wname,"_LEG4_",_Wstyle,"SVR", _Wdrawon,_Wcolor,BLUE_,_Wfonthue,BLACK_)

  legwo[5] = cWo(vp,WO_BV_,_Wname,"_LEG5_",_Wstyle,"SVR", _Wdrawon,_Wcolor,ORANGE_,_Wfonthue,BLACK_)

  legwo[6] = cWo(vp,WO_BV_,_Wname,"_LEG6_",_Wstyle,"SVR", _Wdrawon)

  legwo[7] = cWo(vp,WO_BV_,_Wname,"_LEG7_",_Wstyle,"SVR", _Wdrawon)

  legwo[8] = cWo(vp,WO_BV_,_Wname,"_LEG8_",_Wstyle,"SVR", _Wdrawon)

  legwo[9] = cWo(vp,WO_BV_,_Wname,"_LEG9_",_Wstyle,"SVR", _Wdrawon)

  legwo[10] = cWo(vp,WO_BV_,_Wname,"_LEG10_",_Wstyle,"SVR", _Wdrawon)

  legwo[11] = cWo(vp,WO_BV_,_Wname,"_LEG11_",_Wstyle,"SVR", _Wdrawon)

  legwo[12] =cWo(vp,WO_BV_,_Wname,"_LEG12_",_Wstyle,"SVR", _Wdrawon)

  legwos = legwo[1:12];

  wovtile(legwos, 0.15, 0.4, 0.29, 0.90)


  titleVers();
  gflush();
  
  sWo(tpwos,_Wcolor,ORANGE_,_Wfonthue,BLACK_,_Wfont,F_TINY_,_Wredraw);
  sWo(legwos,_Wcolor,BLUE_,_Wfonthue,WHITE_,_Wfont,F_TINY_,_Wredraw);

  TASK_wo=cWo(vp,WO_BV_);
  sWo(TASK_wo, _WRESIZE,wbox(0.05,0.25,0.15,0.34),_WEO);
  
//<<"%V$TASK_wo\n"

  sWo(TASK_wo, _Whelp, "Set Task Type", _Wname, "TaskType", _Wfunc,  "wo_menu",  _Wmenu, "SO,TRI,OAR,W,MT",  _WVALUE, "TRI")


  TASK_menu_wo=cWo(vp,WO_BV_);

  sWo( TASK_menu_wo,_WRESIZE,wbox(0.05,0.12,0.15,0.24),_WEO);

  sWo(TASK_menu_wo, _Whelp, "Set Task Type", _Wname, "TaskMenu",_WEO)


  gflush()
  
  vptxt= cWo(vp, WO_TEXT_);
  sWo(vptxt,_WRESIZE,wbox(0.55,0.01,0.95,0.1),_WNAME,"TXT", _WEO);
  sWo(vptxt,_WCOLOR,WHITE_,_WSAVE,_WDRAWON,_WPIXMAPOFF);


<<" DONE SCREEN\n";
