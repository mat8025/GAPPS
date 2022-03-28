/* 
 *  @script wex_screen.asl 
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

  ;
//////////////////  WED SCREEN --- WINDOWS ////////////////
//ans=query("graphic?\n")


  Str vptitle = "Wex";

  vp =  cWi("Wex");

  vp1 = cWi("XED");

  sWi(vp1,_WRESIZE,wbox(0.01,0.05,0.90,0.95,1),  _WEO);

  sWi(vp1,_WCLIP,wbox(0.1,0.05,0.85,0.95),  _WREDRAW,_WEO);

  sWi(vp,_WCLIP,wbox(0.1,0.05,0.9,0.95), _WEO);

  int allwin[] = {vp,vp1};

  //sWi(allwin,_WDRAWON,_WPIXMAPON,_WSAVE,_WBHUE,WHITE_,_WEO);
  sWi(vp,_WDRAWON,_WPIXMAPON,_WSAVE,_WBHUE,WHITE_,_WEO);

   sWi(vp1,_WDRAWON,_WPIXMAPON,_WSAVE,_WBHUE,WHITE_,_WEO);

  auto CL_init = 1;

  auto CR_init = 1;

cout<<"Wins done\n";
////////////////  WOBS ///////////////

  gwo=cWo(vp,WO_GRAPH);

  sWo(gwo,_WNAME,"WTLB",_WVALUE,0,_WCLIPBORDER,_WEO); //   weight;

  calwo=cWo(vp,WO_GRAPH);

   sWo(calwo,_WNAME,"CAL",_WVALUE,0,_WCLIPBORDER,BLACK_) ; // cals;

  carbwo=cWo(vp,WO_GRAPH);
  
  sWo(carbwo,_WNAME,"CARB",_WVALUE,0,_WCLIPBORDER,BLACK_) ; // carbs;

  extwo=cWo(vp,WO_GRAPH);
  
  sWo(extwo,_WNAME,"XT",_WVALUE,0,_WCLIPBORDER,BLACK_,_WEO); // exercise time;

  int wedwos[] = { gwo, calwo,  carbwo, extwo,-1  };
//<<[_DB]"%V$wedwo \n"

cout<<" vtile before set clip!\n";

  wovtile(wedwos,0.1,0.08,0.99,0.99)   ; // vertically tile the drawing areas into the main window;
    //cx = 0.05 ; cX = 0.95 ; cy = 0.2 ; cY = 0.97;

  float CXY[4] = { 0.05 ,0.2,0.95 ,0.97};
//<<"%V$CXY\n"
//cout<<"  titleButtonsQRD(vp);\n";
  //titleButtonsQRD(vp);
  
//cout <<"aftertitleButtons\n";
 //////////////////////////////// TITLE BUTTON QUIT ////////////////////////////////////////////////
//<<"after proc - next statement missed? \n" // MUST FIX



  sc_end = sc_endday+10;

  sc_zend = sc_end;   // for zooming;

  sc_zstart = sc_startday;

//  <<"%V $sc_startday $sc_endday $sc_end \n";
COUT(sc_zstart);
 //  _WFONT arg wfont(char*) wfont(int) --- 

  sWo(calwo,_WCLIP,CXY,_WCOLOR,MAGENTA_,_WCLIPBHUE,LILAC_,_WBHUE,WHITE_,_WFONT,F_SMALL_,_WEO);

COUT(calwo);
 for (int i= 0; wedwos[i]> 0;i++) 
  sWo(wedwos[i],_WCLIP,CXY,_WCOLOR,LILAC_,_WCLIPBHUE,WHITE_,_WBHUE,WHITE_,_WFONT, F_SMALL_,_WSAVE,_WSAVEPIXMAP,_WEO);



  sWo(carbwo,_WCLIP,CXY,_WCOLOR,WHITE_,_WCLIPBHUE,ORANGE_,_WBHUE,WHITE_,_WFONT,F_SMALL_,_WFONTHUE,WHITE_,_WEO);

  sWo(extwo,_WCLIP,CXY,_WCOLOR,YELLOW_,_WCLIPBHUE,RED_,_WBHUE,WHITE_,_WFONT,F_SMALL_,_WEO);

 for (int i= 0; wedwos[i]> 0;i++) 
  sWo(wedwos[i],_WBORDER,_WCLIPBORDER,BLACK_,_WDRAWON,_WEO);

  sWo(extwo,_WSCALES,wbox(sc_startday,0,sc_end,250),_WEO);
//<<"SCALES %V$sc_startday $sc_end \n"

//  sWo(extwo,_WSAVESCALES,0,_WEO);

  sWo(calwo,_WSCALES,wbox(sc_startday,0,sc_end,CalsY1),_WSAVESCALES,0,_WEO);
   //sWo(calwo,_WSCALES,sc_startday,0,sc_end,carb_upper,_WSAVESCALES,1)
    //sleep(0.1)
COUT(calwo);
COUT(vp1);

  swo= cWo(vp1,WO_GRAPH);
COUT(swo);

//  sWo(swo,_WNAME,"BenchPress",_WCOLOR,WHITE_,_WEO);

COUT(swo);
  int swos[] = { swo,-1 };

//  wovtile(swos,0.01,0.05,0.97,0.97)   ; // vertically tile the drawing areas into the main window;

//  sWo(swos[0],_WCLIP,CXY,_WCOLOR,WHITE_,_WCLIPBORDER,BLACK_,_WEO);
///  measurement

  tw_wo= cWo(gwo,WO_BS);
  sWo(tw_wo,_WRESIZE,wbox(0.1,0.1,0.15,0.25,0),_WNAME,"TW",_WVALUE,"175",_WEO);
COUT(tw_wo);
//  sWo(tw_wo,_WVHMOVE,ON,_WSYMBOL,STAR_,_WPIXMAPON,_WREDRAW,_WEO);
//////////////////////////// SCALES //////////////////////////////////////////
//<<[_DB]" Days $k \n"

  float bp_upper = 400.0;
   //  defaults are ?  _save,_WREDRAW,_WDRAWON,_WPIXMAPON

  float wt_upper = 220;

  sWo(swo,_WSCALES,wbox(sc_startday,110,sc_end,bp_upper),_WEO);

cout<<"scales \n";
  //<<"SCALES %V$sc_startday $sc_endday $bp_upper\n";

  sWo(carbwo,_WSCALES,wbox(sc_startday,0,sc_end,carb_upper),_WEO);

  //<<"SCALES %V$sc_startday $sc_endday $carb_upper\n";

  sWo(gwo,_WSCALES,wbox(sc_startday,160,sc_end,wt_upper),_WEO);
//    sWo(gwo,_WSAVESCALES,0,_WFONT,F_SMALL_)

  //<<"SCALES %V$sc_startday $sc_endday $wt_upper\n";

  int allwo[] = {gwo,swo, calwo,  extwo , carbwo,-1};
//<<"%V $allwo \n"
 for (int i= 0; allwo[i]> 0;i++) 
  sWo(allwo[i],_WDRAWON,_WPIXMAPON,_WREDRAW,_WSAVE,_WSAVEPIXMAP,_WEO);
  
//sleep(0.2)
///////////////////////////////////////////////////////////
  //quitwo=cWo(vp,WO_BN,_WNAME,"QUIT",_WCOLOR,"red")

  zinwo=cWo(vp,WO_BN);
  sWo(zinwo,_WNAME,"ZIN",_WCOLOR,PINK_,_WHELP," zoom in on selected days ",_WEO);

  zoomwo=cWo(vp,WO_BN);
  sWo(zoomwo,_WNAME,"ZOUT",_WCOLOR,BLUE_,_WEO);
 // yrdecwo= cWo(vp,WO_BN,_WNAME,"YRD",_WCOLOR,"violetred",_WHELP," show previous Year  ")
//  yrincwo= cWo(vp,WO_BN,_WNAME,"YRI",_WCOLOR,"purple",_WHELP," show next Year  ")
//  qrtdwo=  cWo(vp,WO_BN,_WNAME,"QRTD",_WCOLOR,"violetred",_WHELP," show previous Qtr period ")
//  qrtiwo=  cWo(vp,WO_BN,_WNAME,"QRTI",_WCOLOR,"purple",_WHELP," show next Qtr period ")
 // int fewos[] = {zinwo,zoomwo, yrdecwo, yrincwo, qrtdwo, qrtiwo }

  int fewos[] = {zinwo,zoomwo, -1 };
COUT(fewos);

  wohtile( fewos, 0.03,0.01,0.43,0.07);

  nobswo= cWo(vp,WO_BV);
  
  sWo(nobswo,_WNAME,"Nobs",_WCOLOR,"Cyan",_WVALUE,0,_WEO);

  xtwo= cWo(vp,WO_BV);
  sWo(xtwo,  _WNAME,"xTime",_WCOLOR,"violetred",_WVALUE,0,_WEO);

  xbwo= cWo(vp,WO_BV);
  sWo(xbwo,_WNAME,"xBurn",_WCOLOR,"violetred",_WVALUE,0,_WEO);

  xlbswo= cWo(vp,WO_BV);
  sWo(xlbswo,_WNAME,"xLbs",_WCOLOR,"violetred",_WVALUE,0,_WEO);

  dlbswo= cWo(vp,WO_BV);

 sWo(dlbswo,_WNAME,"dLbs",_WCOLOR,YELLOW_,_WVALUE,0,_WEO);

  int xwos[] = { nobswo, xtwo, xbwo, xlbswo, dlbswo ,-1};

  wohtile( xwos, 0.45,0.01,0.83,0.07,5);

  for (int j= 0; xwos[j]>0; j++) 
   sWo(xwos[j],_WSTYLE,WO_SVB,_WREDRAW,_WEO);


  sWo(gwo,_WSHOWPIXMAP,_WSAVE,_WEO);

  sWo(calwo,_WSHOWPIXMAP,_WSAVE,_WEO);
  //sleep(0.1)
  // Measure WOBS

  dtmwo=cWo(vp,WO_BV);
  sWo(dtmwo,_WNAME,"DAY",_WCOLOR,RED_,_WHELP," date on day ",_WEO);

  obswo=cWo(vp,WO_BV);
  sWo(obswo,_WNAME,"OBS",_WCOLOR,YELLOW_,_WHELP," obs day ",_WEO);

  wtmwo=cWo(vp,WO_BV);
  sWo(wtmwo,_WNAME,"WTM",_WCOLOR,RED_,_WHELP," wt on day ",_WEO);

  cbmwo=cWo(vp,WO_BV);
  
  sWo(cbmwo,_WNAME,"CBM",_WCOLOR,BLUE_,_WFONTHUE,WHITE_,_WHELP," cals burnt on day ",_WEO);

  xtmwo=cWo(vp,WO_BV);
  sWo(xtmwo,_WNAME,"EXT",_WCOLOR,GREEN_,_WHELP," xtime on day ",_WEO);

  int mwos[] = { dtmwo, obswo, wtmwo, cbmwo, xtmwo,-1};

  wovtile( mwos, 0.02,0.5,0.08,0.9);
  for (int j= 0; mwos[j]>0; j++)
     sWo(mwos[j],_WSTYLE,WO_SVB,_WREDRAW,_WEO);
//  Goal WOBS

  sdwo=cWo(vp,WO_BV);
  sWo(sdwo,_WNAME,"StartDay",_WCOLOR,RED_,_WVALUE,"$Goals[0]",_WHELP,"   startday ",_WEO);

  gdwo=cWo(vp,WO_BV);
  sWo(gdwo,_WNAME,"GoalDay",_WCOLOR,RED_,_WVALUE,"$Goals[1]",_WHELP," goalday ",_WEO);

  gwtwo=cWo(vp,WO_BV);
  sWo(gwtwo,_WNAME,"WtGoal",_WVALUE,"$Goals[2]",_WCOLOR,BLUE_,_WFONTHUE,WHITE_,_WHELP," next goal wt ",_WEO);

  int  goalwos[] = { sdwo, gdwo, gwtwo, -1};

  wovtile( goalwos, 0.02,0.1,0.08,0.45);

for (int j= 0; goalwos[j]>0; j++)
  sWo(goalwos[j],_WSTYLE,WO_SVB,_WREDRAW,_WEO);

cout<<"Screen DONE\n";

 // titleVers();
//sleep(0.1)
//======================================//
//<<[_DB]"$_include \n"

;//==============\_(^-^)_/==================//;
