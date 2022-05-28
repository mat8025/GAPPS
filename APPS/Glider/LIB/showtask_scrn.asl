///
///  Screen setup for showtask
///
;

/*
A=ofw("MENUS/TP.m")
<<[A],"title TP-Choice\n"
<<[A],"type CHOICE\n"
<<[A],"item Replace M_VALUE R\n"
<<[A],"item Delete M_VALUE D\n"
<<[A],"item Insert M_VALUE I\n"
<<[A],"item Add M_VALUE A\n"
<<[A],"help  replace via name"
cf(A)
*/


int CR_init = 0;
int CL_init = 0;


int lc_gl= -1;
int rc_gl = -1;
int Vp;
int MaxLegs = 12;
  Str TaskType = "MT";
   
int  Graphic = CheckGwm();


 printf(" $Graphic %d\n", Graphic);

int Xgm;

  if (!Graphic) {
    Xgm = spawnGWM("ShowTask");
  }

// create window and scales

#include "tbqrd.asl"

 int symsz = 2;
 int wfr = 0;




  Vp = cWi("Vp");
  

  sWi(Vp,_WSCALES,wbox(-200,-200,200,200,0), _WDRAWON,_WPIXMAPON,_WSAVE,_WBHUE,WHITE_,_Wresize,0.1,0.01,0.9,0.95,0)
  // but we don't draw to a window! = draw to Wob in a Window

  sWi(Vp,_WCLIP,0.01,0.1,0.95,0.99);

  titleButtonsQRD(Vp);


  int tdwo= cWo(Vp, WO_BV_);

  sWo(tdwo,_WRESIZE_fr,0.01,0.01,0.14,0.1,_WNAME,"TaskDistance",_WEO);
  
  sWo(tdwo,_WCOLOR,WHITE_,_WSTYLE,"SVB");

  int sawo= cWo(Vp, WO_BV_);

  float rsz[5] = wbox(0.15,0.01,0.54,0.1);

  //<<"%V $rsz\n";
  //rsz.pinfo();


 // sWo(sawo,_WRESIZE, wbox (0.15,0.01,0.54,0.1),_WEO);
  sWo(sawo,_WRESIZE, rsz,_WEO);

  sWo(sawo,_WCOLOR,WHITE_,_WSTYLE,"SVB");


  int vvwo= cWo(Vp, WO_GRAPH_);

  sWo(vvwo,_WNAME,"ALT",_WCOLOR,WHITE_);

// printargs(vvwo,_WRESIZE, wbox(1,2,3,4,5),_WEO);



 sWo(vvwo,_WRESIZE,wbox(0.2,0.11,0.95,0.25),_WEO);

  <<"did wbox all float ?\n";


  

  sWo(vvwo, _WSCALES, wbox(0, 0, 100, 6000), _WSAVEPIXMAP, _WREDRAW, _WDRAWON, _WPIXMAPON);

  int mapwo= cWo(Vp,WO_GRAPH_);
  sWo(mapwo,_WRESIZE,wbox(0.30,0.26,0.95,0.95),_WNAME,"MAP",_WCOLOR,WHITE_);

//<<"%V $mapwo $LongW $LatS \n"

  sWo(mapwo, _WSCALES, wbox(LongW, LatS, LongE, LatN), _WSAVE, _WREDRAW, _WDRAWON, _WPIXMAPON,_WSAVEPIXMAP,_WEO);

  int LastTP = 12; 
  int tpwo[MaxLegs+1];
  tpwo = -1;
  int legwo[MaxLegs+1];
  legwo = -1;

  tpwo[0]=cWo(Vp,WO_BV_);
  
  sWo(tpwo[0],_WNAME,"_Start_",_WSTYLE,"SVR",_WDRAWON);


  for (i= 1; i <= MaxLegs ; i++) {

   tpwo[i] =cWo(Vp,WO_BV_);

   sWo(tpwo[i],_WNAME,"_TP${i}_",_WSTYLE,"SVR",_WDRAWON,_WCOLOR,BLUE_,_WFONTHUE,BLACK_,_WEO);

  }
 
  finish_wo = tpwo[2];
  
  //tpwos = tpwo[0:MaxLegs];

  MaxSelTps = MaxLegs;
  
 // <<"%V $tpwos\n"
  
  wovtile(tpwo, 0.02, 0.4, 0.14, 0.95);



  legwo[0] = -1;

  for (i= 0; i < MaxLegs ; i++) {
    legwo[i] = cWo(Vp,WO_BV_);
     sWo(legwo[i],_WNAME,"LEG_$(i+1) ",_WSTYLE,"SVR",_WDRAWON,_WCOLOR,BLUE_,_WFONTHUE,BLACK_,_WEO);
  }



  wovtile(legwo, 0.15, 0.4, 0.29, 0.95);


  titleVers();
  gflush();
  
  sWo(tpwo,_WCOLOR,ORANGE_,_WFONTHUE,BLACK_,_WFONT,F_TINY_,_WREDRAW,_WEO);
  sWo(legwo,_WCOLOR,BLUE_,_WFONTHUE,BLUE_,_WFONT,F_TINY_,_WREDRAW,_WEO);

  int TASK_wo=cWo(Vp,WO_BV_);
  sWo(TASK_wo, _WRESIZE,wbox(0.05,0.25,0.15,0.34),_WEO);
  
//<<"%V$TASK_wo\n"

  sWo(TASK_wo, _WHELP, "Set Task Type", _WNAME, "TaskType", _WFUNC,  "wo_menu",  _WMENU, "SO,TRI,OAR,W,MT",  _WVALUE, "TRI");


  int TASK_menu_wo=cWo(Vp,WO_BV_);

  sWo( TASK_menu_wo,_WRESIZE,wbox(0.05,0.12,0.15,0.24),_WEO);

  sWo(TASK_menu_wo, _WHELP, "Set Task Type", _WNAME, "TaskMenu",_WEO);


  gflush();
  
  int vptxt= cWo(Vp, WO_TEXT_);
  sWo(vptxt,_WRESIZE,wbox(0.55,0.01,0.95,0.1),_WNAME,"TXT", _WEO);
  sWo(vptxt,_WCOLOR,WHITE_,_WSAVE,_WDRAWON,_WPIXMAPOFF);


//  CURSORS
 // TBC cursor opt?
  lc_gl   = cGl(vvwo);
  
  sGl(lc_gl,_GLtype,XY_,_GLHUE,BLACK_,_GLltype,CURSOR_,_GLEO);

  rc_gl   = cGl(vvwo);
  
  sGl(rc_gl,_GLtype,XY_,_GLHUE,BLUE_,_GLltype,CURSOR_,_GLEO);



//<<" DONE SCREEN %V $lc_gl $rc_gl $mapwo $vvwo  $sawo \n";
