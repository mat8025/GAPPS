/* 
 *  @script scrn_showtask.asl 
 * 
 *  @comment task-planner library 
 *  @release CARBON 
 *  @vers 4.3 Li 6.3.83 C-Li-Bi 
 *  @date 02/16/2022 09:34:44          
 *  @cdate 9/17/1997 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2022
 * 
 */ 
;//----------------<v_&_v>-------------------------//;                     
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




// printf(" Graphic %d\n", Graphic);

int Xgm;

  if (!Graphic) {
    Xgm = spawnGWM("ShowTask");
  }

// create window and scales

//#include "tbqrd.asl"




  Vp = cWi("Vp");

// VCOUT(Xgm,"\n");

  VCOUT(Xgm,Vp);


  //sWi(Vp,_WSCALES,wbox(-200,-200,200,200,0), _WDRAWON,_WPIXMAPON,_WSAVE,_WBHUE,WHITE_,_WRESIZE,0.1,0.01,0.9,0.95,0);

//  sWi(_WOID,Vp,_WSCALES,wbox(-200,-200,200,200,0), _WDRAW, ON,_WPIXMAP,ON_,_WSAVE,ON_,_WBHUE,YELLOW_,_WRESIZE,wbox(0.1,0.01,0.95,0.99,0));


  sWi(_WOID,Vp,_WSCALES,wbox(-200,-201,200,201,0),_WRESIZE,wbox(0.1,0.01,0.99,0.99,0));
  
  sWi(_WOID,Vp,_WDRAW, ON_,_WPIXMAP,ON_,_WSAVE,ON_,_WBHUE,YELLOW_);
  // but we don't draw to a window! = draw to Wob in a Window

  sWi(_WOID,Vp,_WRESIZE,wbox(0.1,0.01,0.98,0.99,0));

  sWi(_WOID,Vp,_WCLIP,wbox(0.01,0.01,0.98,0.98));

  //Text(Vp, "HEY", 0,5, 0.5);

  titleButtonsQRD(Vp);

  //  Text(Vp, "NOW", 0,5, 0.5,0);





  sawo= cWo(Vp, WO_BV_);
  


//VCOUT(Vp,sawo);
  


  //float rsz[5] = wbox(0.15,0.01,0.54,0.1);

  //<<"%V $rsz\n";



 sWo(_WOID,sawo,_WRESIZE, wbox (0.15,0.01,0.3,0.1));
  //sWo(sawo,_WRESIZE, rsz);

  sWo(_WOID,sawo,_WCOLOR,WHITE_,_WSTYLE,"SVB");


  vvwo= cWo(Vp, WO_GRAPH_);

  sWo(_WOID,vvwo,_WNAME,"ALT",_WCOLOR,WHITE_);

// printargs(vvwo,_WRESIZE, wbox(1,2,3,4,5));



 sWo(_WOID,vvwo,_WRESIZE,wbox(0.01,0.11,0.35,0.25));



  sWo(_WOID,vvwo, _WSCALES, wbox(0, 0, 100, 6000), _WSAVEPIXMAP,ON_, _WREDRAW,ON_, _WDRAW,ON_, _WPIXMAP,ON_);

  mapwo= cWo(Vp,WO_GRAPH_);

  sWo(_WOID,mapwo,_WRESIZE,wbox(0.34,0.01,0.99,0.99),_WNAME,"MAP",_WCOLOR,WHITE_);

//<<"%V $mapwo $LongW $LatS \n"

  sWo(_WOID,mapwo, _WSCALES, wbox(LongW, LatS, LongE, LatN), _WSAVE,ON_,  _WDRAW,ON_, _WPIXMAP,ON_,_WSAVEPIXMAP,ON_);

  LastTP = 12; 

  adbprintf(-1,"lastTP %d\n",LastTP);


  //VCOUT(vvwo,mapwo);
 
  //tpwo = -1;
  
  //int legwo[MaxLegs+1];

  //legwo = -1;

  tpwo[0]=cWo(Vp,WO_BV_);
  
  sWo(_WOID,tpwo[0],_WNAME,"_Start_",_WSTYLE,SVR_,_WDRAW,ON_);
  

  tpwo[MaxLegs] =-1;
  for (i= 1; i < MaxLegs ; i++) {

   tpwo[i] =cWo(Vp,WO_BV_);
   
   sprintf(TPname,"_TP%d_",i);

 //  sWo(tpwo[i],_WNAME,"_TP${i}_",_WSTYLE,"SVR",_WDRAWON,_WCOLOR,BLUE_,_WFONTHUE,BLACK_);
   sWo(_WOID,tpwo[i],_WNAME,TPname,_WSTYLE,SVR_,_WDRAW,ON_,_WCOLOR,BLUE_,_WFONTHUE,BLACK_);
  
   sWo(_WOID,tpwo[i],_WCOLOR,ORANGE_,_WFONTHUE,BLACK_,_WFONT,F_TINY_);
  }
 
  finish_wo = tpwo[2];
  
  //tpwos = tpwo[0:MaxLegs];

  MaxSelTps = MaxLegs;
  
 // <<"%V $tpwos\n"
  
 // wovtile(tpwo, 0.02, 0.4, 0.14, 0.95,12);
 wovtile(tpwo, 0.02, 0.38, 0.14, 0.89,-1);


  legwo[0] = -1;
  legwo[MaxLegs] =-1;
  for (i= 0; i < MaxLegs ; i++) {
     legwo[i] = cWo(Vp,WO_BV_);
  sprintf(TPname,"LEG_%d_",i+1);  // asl vers needs to supress DQ expansion

     sWo(_WOID,legwo[i],_WNAME,TPname,_WSTYLE,SVR_,_WDRAW,ON_,_WCOLOR,BLUE_,_WFONTHUE,BLACK_);
     sWo(_WOID,legwo[i],_WCOLOR,BLUE_,_WFONTHUE,BLUE_,_WFONT,F_TINY_);
}

 // wovtile(legwo, 0.15, 0.4, 0.29, 0.95,12);
  wovtile(legwo, 0.15, 0.38, 0.29, 0.89,-1);

  titleVers();
  
  adbprintf(-1,"titleVers %d\n",legwo);
  



  TASK_wo=cWo(Vp,WO_BV_);
  sWo(_WOID,TASK_wo, _WRESIZE,wbox(0.01,0.25,0.10,0.34));
  
//<<"%V$TASK_wo\n"

  sWo(_WOID,TASK_wo, _WHELP, "Set Task Type", _WNAME, "TaskType", _WFUNC,  "wo_menu",  _WMENU, "SO,TRI,OAR,W,MT",  _WVALUE, "TRI");

  tdwo = cWo(Vp, WO_BV_);


  sWo(_WOID,tdwo,_WRESIZE,wbox(0.11,0.25,0.21,0.34,0),_WNAME,"TaskDistance");



  sWo(_WOID,tdwo,_WCOLOR,WHITE_,_WSTYLE,SVB_);


//  TASK_menu_wo=cWo(Vp,WO_BV_);

//  sWo(_WOID, TASK_menu_wo,_WRESIZE,wbox(0.05,0.12,0.15,0.24));

//  sWo(_WOID,TASK_menu_wo, _WHELP, "Set Task Type", _WNAME, "TaskMenu");

 
  
  vptxt= cWo(Vp, WO_TEXT_);
  
  sWo(_WOID,vptxt,_WRESIZE,wbox(0.01,0.9,0.4,0.99),_WNAME,"TXT");
  sWo(_WOID,vptxt,_WCOLOR,WHITE_,_WSAVE,ON_,_WDRAW,ON_,_WPIXMAP,OFF_);




  ZOOM_wo=cWo(Vp,WO_BV_);
  
  sWo(_WOID,ZOOM_wo,  _WNAME, "ZOOM",_WRESIZE,wbox(0.22,0.25,0.32,0.34),_WCOLOR,RED_);

adbprintf(-1,"Zoom\n");

//  CURSORS
 // TBC cursor opt?
  st_lc_gl   = cGl(vvwo);
  
//  sGl(lc_gl,_GLTYPE,XY_,_GLHUE,BLACK_,_GLLTYPE,CURSOR_,_GLEO);

  sGl(_GLID,st_lc_gl,_GLTYPE,"XY" ,_GLHUE,BLACK_);



  st_rc_gl   = cGl(vvwo);
  
  sGl(_GLID,st_rc_gl,_GLTYPE,"XY",_GLHUE,BLUE_);



    Mapcoors= woGetPosition (mapwo);



//  pa(Mapcoors);



  dMx = Mapcoors[5];
  dMy = Mapcoors[6];

VCOUT(dMx,dMy);

//ans=query("?","screen OK?",__LINE__);

//<<" DONE SCREEN %V $lc_gl $rc_gl $mapwo $vvwo  $sawo \n";

adbprintf(-1,"DONE SCREEN\n");