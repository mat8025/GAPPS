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


    vptitle = "Wex"

    vp =  cWi("Wex");

    vp1 = cWi("XED",_Wresize,0.01,0.05,0.90,0.95,1)

    sWi(vp,_Wclip,0.1,0.05,0.85,0.95,_Wredraw)

    sWi(vp,_Wresize,0.05,0.01,0.9,0.98,0);
    sWi(vp,_Wclip,0.1,0.05,0.9,0.95)

    int allwin[] = {vp,vp1}

    sWi(allwin,_Wdrawon,_Wpixmapon,_Wsave,_Wbhue,WHITE_)

    CL_init = 1;
    CR_init = 1;    

////////////////  WOBS ///////////////



    wtwo=cWo(vp,WO_GRAPH_,_Wname,"WTLB",_Wvalue,0,_Wclipborder,BLACK_,_WEO); //   weight

    calwo=cWo(vp,WO_GRAPH_,_Wname,"CAL",_Wvalue,0,_Wclipborder,BLACK_,_WEO) ; // cals 

    carbwo=cWo(vp,WO_GRAPH_,_Wname,"CARB",_Wvalue,0,_Wclipborder,BLACK_,_WEO) ; // carbs

    extwo=cWo(vp,WO_GRAPH_,_Wname,"XT",_Wvalue,0,_Wclipborder,BLACK_,_WEO); // exercise time

<<" %V $wtwo, $calwo,  $carbwo, $extwo  \n";

   int wedwo[] = { wtwo, calwo,  carbwo, extwo  };

<<[_DB]"%V$wedwo \n"

    // vtile before set clip!

    wo_vtile(wedwo,0.1,0.08,0.99,0.99,0.01)   // vertically tile the drawing areas into the main window

    //cx = 0.05 ; cX = 0.95 ; cy = 0.2 ; cY = 0.97;
    float CXY[4] = { 0.05 ,0.2,0.95 ,0.97};
//<<"%V$CXY\n"

    titleButtonsQRD(vp)
//<<"aftertitleButtons\n"
 //////////////////////////////// TITLE BUTTON QUIT ////////////////////////////////////////////////

//<<"after proc - next statement missed? \n" // MUST FIX


     CalsY1 = 5000.0;


    carb_upper = 250;
    
    int sc_end = sc_endday+10;
    long sc_zend = sc_end;   // for zooming
    long sc_zstart = sc_startday;

<<"%V $sc_startday $sc_endday $sc_end \n" 


    ok=sWo(wedwo,_Wclip,CXY, _Wcolor,LILAC_,_Wclipbhue,WHITE_,_Wbhue,WHITE_,_Wfont,F_SMALL_,_Wsave,_Wsavepixmap)

    ok=sWo(calwo,_Wclip,CXY, _Wcolor,MAGENTA_,_Wclipbhue,LILAC_,_Wbhue,WHITE_,_WFONT,F_SMALL_,_WEO)

    sWo(carbwo,_Wclip,CXY, _Wcolor,WHITE_,_Wclipbhue,ORANGE_,_Wbhue,WHITE_,_Wfont,F_SMALL_,_Wfonthue,WHITE_)

    sWo(extwo,_Wclip,CXY, _Wcolor,YELLOW_,_Wclipbhue,RED_,_Wbhue,WHITE_,_WFONT,F_SMALL_,_WEO)

    sWo(wedwo,_Wborder,_Wclipborder,BLACK_,_Wdrawon)


    float exer_upper = 300.0;
    
    ok=sWo(extwo,_Wscales,sc_startday,0,sc_end,exer_upper,_WEO);

//<<"SCALES %V$sc_startday $sc_end \n"
     ok=sWo(extwo,_Wsavescales,0,_WEO);


    sWo(calwo,_Wscales,sc_startday,0,sc_end,CalsY1,_Wsavescales,0,_WEO)

   //sWo(calwo,_Wscales,sc_startday,0,sc_end,carb_upper,_Wsavescales,1)
    //sleep(0.1)

    swo= cWo(vp1,WO_GRAPH_,_Wname,"BenchPress",_Wcolor,"white",_WEO);
    
    int xwo[] = { swo }

    wo_vtile(xwo,0.01,0.05,0.97,0.97)   // vertically tile the drawing areas into the main window

    sWo(xwo,_Wclip,CXY,_Wcolor,WHITE_, _WCLIPBORDER,BLACK_,_WEO);


///  measurement
     tw_wo= cWo(wtwo,WO_SYM_,_Wresize,0.1,0.1,0.15,0.25,0,_Wname,"TW",_Wvalue,175)
     sWo(tw_wo,_Wvhmove,ON_,_Wsymbol,STARDAVID_,_Wpixmapon,_Wredraw)


//////////////////////////// SCALES //////////////////////////////////////////
//<<[_DB]" Days $k \n"

    bp_upper = 400.0
 
 
   //  defaults are ?  _Wsave,_Wredraw,_Wdrawon,_Wpixmapon

    wt_upper = 220;

    sWo(swo,_WSCALES,sc_startday,110,sc_end,bp_upper,_WEO)

<<"SCALES %V$sc_startday $sc_endday $bp_upper\n"

    sWo(carbwo,_Wscales,sc_startday,0,sc_end,carb_upper,_WEO)

<<"SCALES %V$sc_startday $sc_endday $carb_upper\n"

    sWo(wtwo,_Wscales,sc_startday,160,sc_end,wt_upper,_WEO)
    
//    sWo(wtwo,_Wsavescales,0,_Wfont,F_SMALL_)


<<"SCALES %V$sc_startday $sc_endday $wt_upper\n"

    int allwo[] = {wtwo,swo, calwo,  extwo , carbwo}

//<<"%V $allwo \n"

    sWo(allwo,_Wdrawon,_Wpixmapon,_Wredraw,_Wsave,_Wsavepixmap)
//sleep(0.2)

///////////////////////////////////////////////////////////

  //quitwo=cWo(vp,WO_BN_,_Wname,"QUIT",_Wcolor,"red")
  zinwo=cWo(vp,WO_BN_,_Wname,"ZIN",_Wcolor,"hotpink",_Whelp," zoom in on selected days ",_WEO)
  zoomwo=cWo(vp,WO_BN_,_Wname,"ZOUT",_Wcolor,"cadetblue")

 // yrdecwo= cWo(vp,WO_BN_,_Wname,"YRD",_Wcolor,"violetred",_Whelp," show previous Year  ")
//  yrincwo= cWo(vp,WO_BN_,_Wname,"YRI",_Wcolor,"purple",_Whelp," show next Year  ")
//  qrtdwo=  cWo(vp,WO_BN_,_Wname,"QRTD",_Wcolor,"violetred",_Whelp," show previous Qtr period ")
//  qrtiwo=  cWo(vp,WO_BN_,_Wname,"QRTI",_Wcolor,"purple",_Whelp," show next Qtr period ")


 // int fewos[] = {zinwo,zoomwo, yrdecwo, yrincwo, qrtdwo, qrtiwo }
  int fewos[] = {zinwo,zoomwo,  }

  wo_htile( fewos, 0.03,0.01,0.43,0.07,0.05)

  nobswo= cWo(vp,WO_BV_,_Wname,"Nobs",_Wcolor,"Cyan",_Wvalue,0,_WEO)

  xtwo= cWo(vp,WO_BV_,_Wname,"xTime",_Wcolor,"violetred",_Wvalue,0,_WEO)

  xbwo= cWo(vp,WO_BV_,_Wname,"xBurn",_Wcolor,"violetred",_Wvalue,0,_WEO)

  xlbswo= cWo(vp,WO_BV_,_Wname,"xLbs",_Wcolor,"violetred",_Wvalue,0,_WEO)

  dlbswo= cWo(vp,WO_BV_,_Wname,"dLbs",_Wcolor,YELLOW_,_Wvalue,0,_WEO)
  
  int xwos[] = { nobswo, xtwo, xbwo, xlbswo, dlbswo };
  
  wo_htile( xwos, 0.45,0.01,0.83,0.07,0.05);

  sWo(xwos,_Wstyle,"SVB",_Wredraw);
  sWo(wtwo,_Wshowpixmap,_Wsave);
  sWo(calwo,_Wshowpixmap,_Wsave);
  //sleep(0.1)
  // Measure WOBS
  dtmwo=cWo(vp,WO_BV_,_Wname,"DAY",_Wcolor,RED_,_Whelp," date on day ",_WEO)
  obswo=cWo(vp,WO_BV_,_Wname,"OBS",_Wcolor,YELLOW_,_Whelp," obs day ",_WEO)
  wtmwo=cWo(vp,WO_BV_,_Wname,"WTM",_Wcolor,RED_,_Whelp," wt on day ",_WEO)
  cbmwo=cWo(vp,WO_BV_,_Wname,"CBM",_Wcolor,BLUE_,_Wfonthue,WHITE_,_Whelp," cals burnt on day ",_WEO)
  xtmwo=cWo(vp,WO_BV_,_Wname,"EXT",_Wcolor,GREEN_,_Whelp," xtime on day ",_WEO)

  int mwos[] = { dtmwo, obswo, wtmwo, cbmwo, xtmwo};

  wo_vtile( mwos, 0.02,0.5,0.08,0.9,0.05);

  sWo(mwos,_Wstyle,"SVB",_Wredraw);

//  Goal WOBS

  sdwo=cWo(vp,WO_BV_,_Wname,"StartDay",_Wcolor,RED_,_Wvalue,"$Goals[0]",_Whelp,"   startday ",_WEO)
  gdwo=cWo(vp,WO_BV_,_Wname,"GoalDay",_Wcolor,RED_,_Wvalue,"$Goals[1]",_Whelp," goalday ",_WEO)
  gwtwo=cWo(vp,WO_BV_,_Wname,"WtGoal",_Wvalue,"$Goals[2]",_Wcolor,BLUE_,_Wfonthue,WHITE_,_Whelp," next goal wt ",_WEO)

  int  goalwos[] = { sdwo, gdwo, gwtwo};

  wo_vtile( goalwos, 0.02,0.1,0.08,0.45,0.05);



  sWo(goalwos,_Wstyle,"SVB",_Wredraw);


 // titleVers();

//sleep(0.1)


//======================================//
//<<[_DB]"$_include \n"