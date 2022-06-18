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

char TPname[32];
 
int  Graphic = checkGWM();


 printf(" Graphic %d\n", Graphic);

int Xgm;

  if (!Graphic) {
    Xgm = spawnGWM("ShowTask");
  }

// create window and scales

#include "tbqrd.asl"


  Vp = cWi("Vp");

// VCOUT(Xgm,"\n");

 VCOUT(Xgm,Vp);
  
//ans=query("?1","goon",__LINE__,__FILE__);

  //sWi(Vp,_WSCALES,wbox(-200,-200,200,200,0), _WDRAWON,_WPIXMAPON,_WSAVE,_WBHUE,WHITE_,_WRESIZE,0.1,0.01,0.9,0.95,0);

  sWi(_WOID,Vp,_WSCALES,wbox(-200,-200,200,200,0), _WDRAWON,_WPIXMAPON,_WSAVE,_WBHUE,WHITE_,_WRESIZE,wbox(0.1,0.01,0.9,0.95,0));
  // but we don't draw to a window! = draw to Wob in a Window

  sWi(_WOID,Vp,_WCLIP,wbox(0.01,0.1,0.95,0.99));



  titleButtonsQRD(Vp);

  

//ans=query("?2","goon",__LINE__,__FILE__);

  tdwo = cWo(Vp, WO_BV_);

  sWo(_WOID,tdwo,_WRESIZE,wbox(0.01,0.01,0.14,0.1,0),_WNAME,"TaskDistance");

//ans=query("?3","goon",__LINE__,__FILE__);

  sWo(tdwo,_WCOLOR,WHITE_,_WSTYLE,"SVB");

  sawo= cWo(Vp, WO_BV_);
  VCOUT(Vp,sawo);
  
//ans=query("?4","goon",__LINE__,__FILE__);

  //float rsz[5] = wbox(0.15,0.01,0.54,0.1);

  //<<"%V $rsz\n";
  //rsz.pinfo();


 sWo(_WOID,sawo,_WRESIZE, wbox (0.15,0.01,0.54,0.1));
  //sWo(sawo,_WRESIZE, rsz);

  sWo(_WOID,sawo,_WCOLOR,WHITE_,_WSTYLE,"SVB");


  vvwo= cWo(Vp, WO_GRAPH_);

  sWo(_WOID,vvwo,_WNAME,"ALT",_WCOLOR,WHITE_);

// printargs(vvwo,_WRESIZE, wbox(1,2,3,4,5));



 sWo(_WOID,vvwo,_WRESIZE,wbox(0.2,0.11,0.95,0.25));

  //ans=query("?5","goon",__LINE__,__FILE__);

  sWo(_WOID,vvwo, _WSCALES, wbox(0, 0, 100, 6000), _WSAVEPIXMAP, _WREDRAW, _WDRAWON, _WPIXMAPON);

  mapwo= cWo(Vp,WO_GRAPH_);

  sWo(_WOID,mapwo,_WRESIZE,wbox(0.30,0.26,0.95,0.95),_WNAME,"MAP",_WCOLOR,WHITE_);

//<<"%V $mapwo $LongW $LatS \n"

  sWo(_WOID,mapwo, _WSCALES, wbox(LongW, LatS, LongE, LatN), _WSAVE, _WREDRAW, _WDRAWON, _WPIXMAPON,_WSAVEPIXMAP);

  LastTP = 12; 


  VCOUT(vvwo,mapwo);
 
  //tpwo = -1;
  
  //int legwo[MaxLegs+1];

  //legwo = -1;

  tpwo[0]=cWo(Vp,WO_BV_);
  
  sWo(_WOID,tpwo[0],_WNAME,"_Start_",_WSTYLE,"SVR",_WDRAWON);


  for (i= 1; i <= MaxLegs ; i++) {

   tpwo[i] =cWo(Vp,WO_BV_);
   
   sprintf(TPname,"_TP%d_",i);

 //  sWo(tpwo[i],_WNAME,"_TP${i}_",_WSTYLE,"SVR",_WDRAWON,_WCOLOR,BLUE_,_WFONTHUE,BLACK_);
   sWo(_WOID,tpwo[i],_WNAME,TPname,_WSTYLE,SVR_,_WDRAWON,_WCOLOR,BLUE_,_WFONTHUE,BLACK_);

  }
 
  finish_wo = tpwo[2];
  
  //tpwos = tpwo[0:MaxLegs];

  MaxSelTps = MaxLegs;
  
 // <<"%V $tpwos\n"
  
 // wovtile(tpwo, 0.02, 0.4, 0.14, 0.95,12);
 wovtile(tpwo, 0.02, 0.4, 0.14, 0.95);


  legwo[0] = -1;

  for (i= 0; i < MaxLegs ; i++) {
     legwo[i] = cWo(Vp,WO_BV_);
  sprintf(TPname,"LEG_%d_",i+1);  // asl vers needs to supress DQ expansion

     sWo(_WOID,legwo[i],_WNAME,TPname,_WSTYLE,SVR_,_WDRAWON,_WCOLOR,BLUE_,_WFONTHUE,BLACK_);
  }

 // wovtile(legwo, 0.15, 0.4, 0.29, 0.95,12);
  wovtile(legwo, 0.15, 0.4, 0.29, 0.95);

  titleVers();
  gflush();
  
  sWo(_WOID,tpwo,_WCOLOR,ORANGE_,_WFONTHUE,BLACK_,_WFONT,F_TINY_,_WREDRAW);
  sWo(_WOID,legwo,_WCOLOR,BLUE_,_WFONTHUE,BLUE_,_WFONT,F_TINY_,_WREDRAW);

  TASK_wo=cWo(Vp,WO_BV_);
  sWo(_WOID,TASK_wo, _WRESIZE,wbox(0.05,0.25,0.15,0.34));
  
//<<"%V$TASK_wo\n"

  sWo(_WOID,TASK_wo, _WHELP, "Set Task Type", _WNAME, "TaskType", _WFUNC,  "wo_menu",  _WMENU, "SO,TRI,OAR,W,MT",  _WVALUE, "TRI");

  TASK_menu_wo=cWo(Vp,WO_BV_);

  sWo(_WOID, TASK_menu_wo,_WRESIZE,wbox(0.05,0.12,0.15,0.24));

  sWo(_WOID,TASK_menu_wo, _WHELP, "Set Task Type", _WNAME, "TaskMenu");

  gflush();
  
  vptxt= cWo(Vp, WO_TEXT_);
  
  sWo(_WOID,vptxt,_WRESIZE,wbox(0.55,0.01,0.85,0.1),_WNAME,"TXT");
  sWo(_WOID,vptxt,_WCOLOR,WHITE_,_WSAVE,_WDRAWON,_WPIXMAPOFF);


  ZOOM_wo=cWo(Vp,WO_BV_);
  
  sWo(_WOID,ZOOM_wo,  _WNAME, "ZOOM",_WRESIZE,wbox(0.86,0.04,0.95,0.1),_WCOLOR,RED_);


//  CURSORS
 // TBC cursor opt?
  lc_gl   = cGl(vvwo);
  
//  sGl(lc_gl,_GLTYPE,XY_,_GLHUE,BLACK_,_GLLTYPE,CURSOR_,_GLEO);

  sGl(_GLID.lc_gl,_GLTYPE,"XY" ,_GLHUE,BLACK_);

  rc_gl   = cGl(vvwo);
  
  sGl(_GLID,rc_gl,_GLTYPE,"XY",_GLHUE,BLUE_);

//<<" DONE SCREEN %V $lc_gl $rc_gl $mapwo $vvwo  $sawo \n";
