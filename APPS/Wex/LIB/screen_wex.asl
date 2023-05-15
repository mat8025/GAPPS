/* 
 *  @script screen_wex.asl 
 * 
 *  @comment  
 *  @release CARBON 
 *  @vers 1.5 B 6.3.78 C-Li-Pt 
 *  @date 01/31/2022 08:58:38          
 *  @cdate Sun Dec 23 09:22:34 2018 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2022
 * 
 */ 
;//----------------<v_&_v>-------------------------//;                                                                                                 

 
  
//////////////////  WED SCREEN --- WINDOWS ////////////////
//ans=query("graphic?\n")


  

  Str vptitle = "Wex";

  vp =  cWi("Wex");

  sWi(_WOID,vp,_WRESIZE,wbox(0.01,0.05,0.90,0.95,0)  );

  sWi(_WOID,vp,_WCLIP,wbox(0.1,0.05,0.9,0.95),  _WREDRAW,ON_);



  vp1 = cWi("XED");

  sWi(_WOID,vp1,_WRESIZE,wbox(0.01,0.05,0.90,0.95,1)  );

  sWi(_WOID,vp1,_WCLIP,wbox(0.1,0.05,0.85,0.95),  _WREDRAW,ON_);


pa("$vp $vp1 ", vp, vp1);
cout<<"  titleButtonsQRD(vp);\n";

  titleButtonsQRD(vp);

  int allwin[] = {vp,vp1,-1};


  sWi(_WOID,vp,_WDRAW,ON_,_WPIXMAP,ON_,_WSAVE,ON_,_WBHUE,WHITE_);

  sWi(_WOID,vp1,_WDRAW,ON_,_WPIXMAP,ON_,_WSAVE,ON_,_WBHUE,WHITE_);

  Wex_CL_init = 1;

  Wex_CR_init = 1;

  cout<<"Wins done\n";
////////////////  WOBS ///////////////


  wtwo=cWo(vp,WO_GRAPH_);

  sWo(_WOID,wtwo,_WNAME,"WTLB",_WVALUE,0,_WCLIPBORDER,YELLOW_); //   weight;

  calwo=cWo(vp,WO_GRAPH_);

   sWo(_WOID,calwo,_WNAME,"CAL",_WVALUE,0,_WCLIPBORDER,BLACK_) ; // cals;

  carbwo=cWo(vp,WO_GRAPH_);
  
  sWo(_WOID,carbwo,_WNAME,"CARB",_WVALUE,0,_WCLIPBORDER,BLACK_) ; // carbs;

  extwo=cWo(vp,WO_GRAPH_);
  
  sWo(_WOID,extwo,_WNAME,"XT",_WVALUE,0,_WCLIPBORDER,RED_); // exercise time;

  int wedwos[] = { wtwo,calwo,  carbwo, extwo,-1  };
//<<[_DB]"%V$wedwo \n"

cout<<" vtile before set clip!\n";

  wovtile(wedwos,0.1,0.08,0.99,0.99)   ; // vertically tile the drawing areas into the main window;
    //cx = 0.05 ; cX = 0.95 ; cy = 0.2 ; cY = 0.97;

  float CXY[4] = { 0.05 ,0.2,0.95 ,0.97};
//<<"%V$CXY\n"

  
cout <<"aftertitleButtons\n";
 //////////////////////////////// TITLE BUTTON QUIT ////////////////////////////////////////////////
//<<"after proc - next statement missed? \n" // MUST FIX

//ans=query("?#?");

  sc_end = sc_endday+10;

  sc_zend = sc_end;   // for zooming;

  sc_zstart = sc_startday;

<<"%V $sc_startday $sc_endday $sc_end \n";
COUT(sc_zstart);
 //  _WFONT arg wfont(char*) wfont(int) --- 

  sWo(_WOID,calwo,_WCLIP,CXY,_WCOLOR,MAGENTA_,_WCLIPBHUE,WHITE_,_WBHUE,WHITE_,_WFONT,F_SMALL_);

COUT(calwo);




 // sWo(carbwo,_WCLIP,CXY,_WCOLOR,WHITE_,_WCLIPBHUE,RED_,_WBHUE,RED_  ,_WFONT,F_SMALL_,_WFONTHUE,WHITE_,_WEO);
  sWo(_WOID,carbwo,_WCLIP,CXY,_WCOLOR,WHITE_,_WCLIPBHUE,RED_,_WBHUE,RED_  ,_WFONT,F_SMALL_);

  sWo(_WOID,extwo,_WCLIP,CXY,_WCOLOR,YELLOW_,_WCLIPBHUE,GREEN_,_WBHUE,ORANGE_,_WFONT,F_SMALL_);

  sWo(_WOID,wtwo,_WCLIP,CXY,_WCOLOR,ORANGE_,_WCLIPBHUE,RED_,_WBHUE,ORANGE_,_WFONT,F_SMALL_);

//  sWo(wedwos,_WCLIP,CXY,_WCOLOR,RED_,_WCLIPBHUE,ORANGE_,_WBHUE,LILAC_,_WFONT, F_SMALL_,_WSAVE,_WSAVEPIXMAP,_WEO);



COUT(sc_end);

  sWo(_WOID,extwo,_WSCALES,wbox(sc_startday,10,sc_end,300),_WSAVESCALES,0);

cout <<"SCALES " << sc_startday << " sc_end " <<sc_end << endl;

//ans=query("Scales ?");

//  sWo(extwo,_WSAVESCALES,0,_WEO);

  sWo(_WOID,calwo,_WSCALES,wbox(sc_startday,0,sc_end,CalsY1),_WSAVESCALES,0);
   //sWo(calwo,_WSCALES,sc_startday,0,sc_end,carb_upper,_WSAVESCALES,1)

COUT(calwo);


  swo= cWo(vp1,WO_GRAPH_);


//  sWo(swo,_WNAME,"BenchPress",_WCOLOR,WHITE_,_WEO);

COUT(swo);
  int swos[] = { swo,-1 };

//  wovtile(swos,0.01,0.05,0.97,0.97)   ; // vertically tile the drawing areas into the main window;

//  sWo(swos[0],_WCLIP,CXY,_WCOLOR,WHITE_,_WCLIPBORDER,BLACK_,_WEO);
///  measurement

  tw_wo= cWo(wtwo,WO_BS_);
  
  sWo(_WOID,tw_wo,_WRESIZE,wbox(0.1,0.1,0.15,0.25,0),_WNAME,"TW",_WVALUE,"175");

  COUT(tw_wo);

//////////////////////////// SCALES //////////////////////////////////////////
//<<[_DB]" Days $k \n"

  float bp_upper = 400.0;


  float wt_upper = 220;

  sWo(_WOID,swo,_WSCALES,wbox(sc_startday,110,sc_end,bp_upper));

  cout<<"scales " << sc_startday << " sc_end " << sc_end << " bp_upper " << bp_upper << endl;
  //<<"SCALES %V$sc_startday $sc_endday $bp_upper\n";

  sWo(_WOID,carbwo,_WSCALES,wbox(sc_startday,0,sc_end,carb_upper));

  //<<"SCALES %V$sc_startday $sc_endday $carb_upper\n";

  sWo(_WOID,wtwo,_WSCALES,wbox(sc_startday,155,sc_end,250));


  int allwo[] = {wtwo, calwo,  extwo , carbwo,swo,-1};
//<<"%V $allwo \n"


  
//sleep(0.2)
///////////////////////////////////////////////////////////
  //quitwo=cWo(vp,WO_BN,_WNAME,"QUIT",_WCOLOR,"red")

  zinwo=cWo(vp,WO_BN_);
  
  sWo(_WOID,zinwo,_WNAME,"ZIN",_WCOLOR,PINK_,_WHELP," zoom in on selected days ");

  zoomwo=cWo(vp,WO_BN_);
  sWo(_WOID,zoomwo,_WNAME,"ZOUT",_WCOLOR,BLUE_);
 // yrdecwo= cWo(vp,WO_BN,_WNAME,"YRD",_WCOLOR,"violetred",_WHELP," show previous Year  ")
//  yrincwo= cWo(vp,WO_BN,_WNAME,"YRI",_WCOLOR,"purple",_WHELP," show next Year  ")
//  qrtdwo=  cWo(vp,WO_BN,_WNAME,"QRTD",_WCOLOR,"violetred",_WHELP," show previous Qtr period ")
//  qrtiwo=  cWo(vp,WO_BN,_WNAME,"QRTI",_WCOLOR,"purple",_WHELP," show next Qtr period ")
 // int fewos[] = {zinwo,zoomwo, yrdecwo, yrincwo, qrtdwo, qrtiwo }

  int fewos[] = {zinwo,zoomwo, -1 };

  //pa(fewos);

  wohtile( fewos, 0.03,0.01,0.43,0.07);

  nobswo= cWo(vp,WO_BV_);
  
  sWo(_WOID,nobswo,_WNAME,"Nobs",_WCLIPBHUE,CYAN_,_WVALUE,0);

  xtwo= cWo(vp,WO_BV_);
  sWo(_WOID,xtwo,  _WNAME,"xTime",_WCLIPBHUE,ORANGE_,_WVALUE,0);

  xbwo= cWo(vp,WO_BV_);
  sWo(_WOID,xbwo,_WNAME,"xBurn",_WCLIPBHUE,GREEN_     ,_WVALUE,0);

  xlbswo= cWo(vp,WO_BV_);
  sWo(_WOID,xlbswo,_WNAME,"xLbs",_WCOLOR,BLUE_ );

  dlbswo= cWo(vp,WO_BV_);

 sWo(_WOID,dlbswo,_WNAME,"dLbs",_WCLIPBHUE,YELLOW_,_WVALUE,0);

  int xwos[] = { nobswo, xtwo, xbwo, xlbswo, dlbswo ,-1};

  wohtile( xwos, 0.45,0.01,0.83,0.07);

 for (i= 0; i< 10; i++) {
   if (xwos[i] <0 ) break;
   sWo(_WOID,xwos[i],_WSTYLE,WO_SVB_,_WREDRAW,ON_);

  }
  
   //sWo(xwos,_WSTYLE,WO_SVB,_WREDRAW,_WEO);

   sWo(_WOID,wtwo,_WSHOWPIXMAP,ON_,_WSAVE,ON_);

 // sWo(calwo,_WSHOWPIXMAP,_WSAVE,_WEO);
  //sleep(0.1)
  // Measure WOBS

  dtmwo=cWo(vp,WO_BV_);
  sWo(_WOID,dtmwo,_WNAME,"DAY",_WCLIPBHUE,RED_,_WHELP," date on day ",_WVALUE,1,_WSTYLE,SVB_);



 // obswo=cWo(vp,WO_BV_);
//  sWo(_WOID,obswo,_WNAME,"OBS",_WCLIPBHUE,YELLOW_,_WHELP," obs day ");

  wtmwo=cWo(vp,WO_BV_);
  sWo(_WOID,wtmwo,_WNAME,"WTM",_WCLIPBHUE,RED_,_WHELP," wt on day ",_WSTYLE,SVB_);

  cbmwo=cWo(vp,WO_BV_);
  
  sWo(_WOID,cbmwo,_WNAME,"CBM",_WCLIPBHUE,CYAN_,_WFONTHUE,BLACK_,_WHELP," cals burnt on day ",_WSTYLE,SVB_);

  xtmwo=cWo(vp,WO_BV_);
  sWo(_WOID,xtmwo,_WNAME,"EXT",_WCOLOR,BLUE_,_WHELP," xtime on day ");

  int mwos[] = { dtmwo, wtmwo, cbmwo, xtmwo,-1};

  
  wovtile( mwos, 0.01,0.5,0.085,0.9);

  for (i= 0; i< 10; i++) {
   if (mwos[i] <0 ) {
   break;
   }
   
   //sWo(_WOID,mwos[i],_WSTYLE,WO_SVB_,_WREDRAW,ON_);

    sWo(_WOID,mwos[i],_WSTYLE,SVB_,_WREDRAW,ON_);

  }
  
//  Goal WOBS

  sdwo=cWo(vp,WO_BV_);
  sWo(_WOID,sdwo,_WNAME,"StartDay",_WCLIPBHUE,RED_,_WVALUE,"$Goals[0]",_WHELP,"   startday ");

  gdwo=cWo(vp,WO_BV_);
  sWo(_WOID,gdwo,_WNAME,"GoalDay",_WCLIPBHUE,ORANGE_,_WVALUE,"$Goals[1]",_WHELP," goalday ");

  gwtwo=cWo(vp,WO_BV_);
  sWo(_WOID,gwtwo,_WNAME,"WtGoal",_WVALUE,"$Goals[2]",_WCLIPBHUE,BLUE_,_WFONTHUE,WHITE_,_WHELP," next goal wt ");

  int  goalwos[5] = { sdwo, gdwo, gwtwo, -1};

  wovtile( goalwos, 0.02,0.1,0.08,0.45 );
  i = 0;
  int kgoals = 0;
   while (goalwos[i] >= 0)  {
     sWo(_WOID,goalwos[i],_WREDRAW,ON_);
      i++;
  }


  //sWo(goalwos,_WSTYLE,WO_SVB,_WREDRAW,_WEO);
int zoomwos[] = {zoomwo, zinwo, -1};

// sWo(zoomwos,_WSTYLE,WO_SVB,_WREDRAW,_WEO);

sWo(_WOID,zoomwo,_WSTYLE,WO_SVB_,_WREDRAW,ON_);
sWo(_WOID,zinwo,_WSTYLE,WO_SVB_,_WREDRAW,ON_);

cout<<"Screen DONE\n";

 // titleVers();
//sleep(0.1)
//======================================//
//<<[_DB]"$_include \n"

;//==============\_(^-^)_/==================//;
