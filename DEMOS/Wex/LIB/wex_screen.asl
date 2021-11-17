//%*********************************************** 
//*  @script wex_screen.asl 
//* 
//*  @comment  
//*  @release CARBON 
//*  @vers 1.4 Be Beryllium                                                
//*  @date Tue Mar  3 08:00:19 2020 
//*  @cdate Sun Dec 23 09:22:34 2018 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2014,2018 --> 
//* 
//***********************************************%


//////////////////  WED SCREEN --- WINDOWS ////////////////

_DB = -1
    vptitle = "Wex"

    vp =  cWi(@title,"$vptitle");

    vp1 = cWi(@title,"XED",@resize,0.01,0.05,0.90,0.9,1)

    sWi(vp,@clip,0.1,0.1,0.85,0.9,@redraw)

    sWi(vp,@resize,0.05,0.1,0.8,0.9,0);
    sWi(vp,@clip,0.1,0.1,0.9,0.9)

    int allwin[] = {vp,vp1}

    sWi(allwin,@drawon,@pixmapoff,@save,@bhue,WHITE_)

    CL_init = 1;
    CR_init = 1;    

////////////////  WOBS ///////////////



    gwo=cWo(vp,@graph,@name,"WTLB",@value,0,@clipborder); //   weight

    calwo=cWo(vp,@graph,@name,"CAL",@value,0,@clipborder,BLACK_) ; // cals 

    carbwo=cWo(vp,@graph,@name,"CARB",@value,0,@clipborder,BLACK_) ; // carbs

    extwo=cWo(vp,@graph,@name,"XT",@value,0,@clipborder,BLACK_); // exercise time


   int wedwo[] = { gwo, calwo,  carbwo, extwo  };

<<[_DB]"%V$wedwo \n"

    // vtile before set clip!

    wo_vtile(wedwo,0.1,0.08,0.99,0.97,0.01)   // vertically tile the drawing areas into the main window

    //cx = 0.05 ; cX = 0.95 ; cy = 0.2 ; cY = 0.97;
    float CXY[4] = { 0.05 ,0.2,0.95 ,0.97};
//<<"%V$CXY\n"

    titleButtonsQRD(vp)
//<<"aftertitleButtons\n"
 //////////////////////////////// TITLE BUTTON QUIT ////////////////////////////////////////////////

//<<"after proc - next statement missed? \n" // MUST FIX


     CalsY1 = 5000.0;


    carb_upper = 250;

    ok=sWo(wedwo,@clip,CXY, @color,LILAC_,@clipbhue,WHITE_,@bhue,WHITE_,@font,F_SMALL_,@save,@savepixmap)

    ok=sWo(calwo,@clip,CXY, @color,MAGENTA_,@clipbhue,LILAC_,@bhue,WHITE_,@font,F_SMALL_)

    sWo(carbwo,@clip,CXY, @color,WHITE_,@clipbhue,ORANGE_,@bhue,WHITE_,@font,F_SMALL_,@fonthue,WHITE_)

    sWo(extwo,@clip,CXY, @color,YELLOW_,@clipbhue,RED_,@bhue,WHITE_,@font,F_SMALL_)

    sWo(wedwo,@border,@clipborder,BLACK_,@drawon)

    sWo(gwo,@scales,sc_startday,160,sc_endday+10,220,@savescales,0,@font,F_SMALL_)

    ok=sWo(extwo,@scales,sc_startday,0,sc_endday+10,250,@savescales,0);


    sWo(calwo,@scales,sc_startday,0,sc_endday+10,CalsY1,@savescales,0)

   //sWo(calwo,@scales,sc_startday,0,sc_endday+10,carb_upper,@savescales,1)
    //sleep(0.1)

    swo= cWo(vp1,@type,"GRAPH",@name,"BenchPress",@color,"white");
    
    int xwo[] = { swo }

    wo_vtile(xwo,0.01,0.05,0.97,0.97)   // vertically tile the drawing areas into the main window

    sWo(xwo,@clip,CXY,@color,WHITE_, @clipborder,BLACK_)


///  measurement
     tw_wo= cWo(gwo,@symbol,@resize,0.1,0.1,0.15,0.25,0,@name,"TW",@value,185)
     sWo(tw_wo,@vhmove,ON_,@symbol,STARDAVID_,@pixmapon,@redraw)


//////////////////////////// SCALES //////////////////////////////////////////
<<[_DB]" Days $k \n"

    bp_upper = 400.0
 
 
   //  defaults are ?  @save,@redraw,@drawon,@pixmapon



    sWo(swo,@scales,sc_startday,110,sc_endday,bp_upper)

<<[_DB]"SCALES %V$sc_startday $sc_endday $bp_upper\n"

    sWo(carbwo,@scales,sc_startday,0,sc_endday+10,carb_upper)

<<[_DB]"SCALES %V$sc_startday $sc_endday $carb_upper\n"


    int allwo[] = {gwo,swo, calwo,  extwo , carbwo}

//<<"%V $allwo \n"

    sWo(allwo,@drawon,@pixmapon,@redraw,@save,@savepixmap)
//sleep(0.2)

///////////////////////////////////////////////////////////

  //quitwo=cWo(vp,@BN,@name,"QUIT",@color,"red")
  zinwo=cWo(vp,@BN,@name,"ZIN",@color,"hotpink",@help," zoom in on selected days ")
  zoomwo=cWo(vp,@BN,@name,"ZOUT",@color,"cadetblue")

 // yrdecwo= cWo(vp,@BN,@name,"YRD",@color,"violetred",@help," show previous Year  ")
//  yrincwo= cWo(vp,@BN,@name,"YRI",@color,"purple",@help," show next Year  ")
  qrtdwo=  cWo(vp,@BN,@name,"QRTD",@color,"violetred",@help," show previous Qtr period ")
  qrtiwo=  cWo(vp,@BN,@name,"QRTI",@color,"purple",@help," show next Qtr period ")


 // int fewos[] = {zinwo,zoomwo, yrdecwo, yrincwo, qrtdwo, qrtiwo }
  int fewos[] = {zinwo,zoomwo, qrtdwo, qrtiwo }

  wo_htile( fewos, 0.03,0.01,0.43,0.08,0.05)

  nobswo= cWo(vp,@BV,@name,"Nobs",@color,"Cyan",@value,0)

  xtwo= cWo(vp,@BV,@name,"xTime",@color,"violetred",@value,0)

  xbwo= cWo(vp,@BV,@name,"xBurn",@color,"violetred",@value,0)

  xlbswo= cWo(vp,@BV,@name,"xLbs",@color,"violetred",@value,0)
  
  int xwos[] = { nobswo, xtwo, xbwo, xlbswo };
  
  wo_htile( xwos, 0.45,0.01,0.83,0.08,0.05);

  sWo(xwos,@style,"SVB",@redraw);
  sWo(gwo,@showpixmap,@save);
  sWo(calwo,@showpixmap,@save);
  //sleep(0.1)
  // Measure WOBS
  dtmwo=cWo(vp,@BV,@name,"DAY",@color,RED_,@help," date on day ")
  wtmwo=cWo(vp,@BV,@name,"WTM",@color,RED_,@help," wt on day ")
  cbmwo=cWo(vp,@BV,@name,"CBM",@color,BLUE_,@fonthue,WHITE_,@help," cals burnt on day ")
  xtmwo=cWo(vp,@BV,@name,"EXT",@color,GREEN_,@help," xtime on day ")

  int mwos[] = { dtmwo, wtmwo, cbmwo, xtmwo};

  wo_vtile( mwos, 0.02,0.5,0.08,0.9,0.05);

  sWo(mwos,@style,"SVB",@redraw);

//  Goal WOBS

  sdwo=cWo(vp,@BIV,@name,"StartDay",@color,RED_,@value,"$Goals[0]",@help,"   startday ")
  gdwo=cWo(vp,@BIV,@name,"GoalDay",@color,RED_,@value,"$Goals[1]",@help," goalday ")
  gwtwo=cWo(vp,@BIV,@name,"WtGoal",@value,"$Goals[2]",@color,BLUE_,@fonthue,WHITE_,@help," next goal wt ")

  int  goalwos[] = { sdwo, gdwo, gwtwo};

  wo_vtile( goalwos, 0.02,0.1,0.08,0.45,0.05);



  sWo(goalwos,@style,"SVB",@redraw);


  titleVers();

//sleep(0.1)


//======================================//
<<[_DB]"$_include \n"