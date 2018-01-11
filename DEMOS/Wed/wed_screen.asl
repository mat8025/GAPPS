/// wed_screen

//////////////////  WED SCREEN --- WINDOWS ////////////////

    vptitle = "Wed_$vers"

    vp =  cWi(@title, "$vptitle",@resize,0.1,0.1,0.9,0.9,0,@pixmapon,@save,@savepixmap);

    vp1 = cWi(@title,"XED",@resize,0.01,0.05,0.90,0.9,1)

    sWi(vp,@clip,0.1,0.1,0.9,0.9,@redraw)

    int allwin[] = {vp,vp1}

    sWi(allwin,@drawon,@pixmapoff,@save,@bhue,"white")


////////////////  WOBS ///////////////

    sc_startday = sc_endday - 90;   // last three months

    gwo=cWo(vp,@graph,@name,"WTLB",@value,0,@clipborder)

    calwo=cWo(vp,@graph,@name,"CAL",@value,0,@clipborder,"black")

//    extwo=cWo(vp,@graph,@name,"EXT",@value,0,@clipborder,"black")

    //carbwo=createGWOB(vp,@type,"GRAPH",@name,"CARB_COUNT",@color,"white")

    //int wedwo[] = { gwo, extwo, calwo, carbwo }

    //  int wedwo[] = { gwo, calwo, extwo  }

   int wedwo[] = { gwo, calwo  }

DBPR"%V$wedwo \n"

    // vtile before set clip!

    wo_vtile(wedwo,0.03,0.08,0.97,0.97,0.01)   // vertically tile the drawing areas into the main window

    cx = 0.08 ;    cX = 0.95 ; cy = 0.2 ; cY = 0.97;

 //////////////////////////////// TITLE BUTTON QUIT ////////////////////////////////////////////////
 tbqwo=cWo(vp,@TB,@name,"tb_q",@color,WHITE_,@value,"QUIT",@func,"window_term",@resize,0.97,0,0.99,1);
 sWo(tbqwo,@drawon,@pixmapon,@fonthue,RED_, @symbol,X_, @symsize,45,   @clip,0,0,1,1,@redraw);

 tbrszwo=cWo(vp,@TB,@name,"tb_2",@color,WHITE_,@VALUE,"RESIZE",@func,"window_resize",@resize,0.94,0,0.96,1)
 sWo(tbrszwo,@DRAWON,@PIXMAPON,@FONTHUE,RED_, @symbol,PLUS_,  @symsize, 45, \
 @clip,0,0,1,1,@redraw)


 tbrdrwo=cWo(vp,@TB,@name,"tb_3",@color,WHITE_,@VALUE,"REDRAW",@func,"window_redraw",@resize,0.92,0,0.938,1)
 sWo(tbrdrwo,@DRAWON,@PIXMAPON,@FONTHUE,RED_, @symbol,DIAMOND_,  @symsize, 45, \
 @clip,0,0,1,1,@redraw)


extwo = calwo;


    sWo(wedwo,@clip,cx,cy,cX,cY, @color,"white")

    sWo(wedwo,@border,@clipborder,"black",@drawon)

    sWo(gwo,@scales,sc_startday,160,sc_endday+10,220,@savescales,0) 

    sWo(extwo,@rhtscales,sc_startday,0,sc_endday+10,600,@savescales,1);

    sWo(extwo,@usescales,1,@axnum,3);

    sWo(calwo,@scales,sc_startday,0,sc_endday+10,4500,@savescales,0)

//    sWo(carbwo,@scales,sc_startday,0,sc_endday+10,1200)
//    sWo(extwo,@axnum,1,sc_startday,sc_endday,7,1)



    swo= cWo(vp1,@type,"GRAPH",@name,"BenchPress",@color,"white");
    
    int xwo[] = { swo }

    wo_vtile(xwo,0.01,0.05,0.97,0.97)   // vertically tile the drawing areas into the main window

    sWo(xwo,@clip,cx,cy,cX,cY,@color,WHITE_, @clipborder,BLACK_)

//DBPR" $DVEC[0:10] \n"

//DBPR" %5\s\nR$WTVEC \n"

//DBPR" %5\s->\s,\s<-\nR$CARBV \n"

//DBPR" %10\s\nr$WTPMV \n"

///  measurement




//////////////////////////// SCALES //////////////////////////////////////////
DBPR" Days $k \n"

    bp_upper = 400.0
    carb_upper = 400
 
   //  defaults are ?  @save,@redraw,@drawon,@pixmapon

    sc_startday = sc_endday - 90;

    sWo(swo,@scales,sc_startday,110,sc_endday,bp_upper)

DBPR"SCALES %V$sc_startday $sc_endday $bp_upper\n"

    //sWo(carbwo,@scales,sc_startday,0,sc_endday,carb_upper)

DBPR"SCALES %V$sc_startday $sc_endday $carb_upper\n"

    //int allwo[] = {gwo,swo,carbwo,calwo,extwo}
//    int allwo[] = {gwo,swo,calwo,extwo}
    int allwo[] = {gwo,swo,calwo}

//<<"%V $allwo \n"

    sWo(allwo,@save,@redraw,@drawon,@pixmapon)


///////////////////////////////////////////////////////////

  //quitwo=cWo(vp,@BN,@name,"QUIT",@color,"red")
  zinwo=cWo(vp,@BN,@name,"ZIN",@color,"hotpink",@help," zoom in on selected days ")
  zoomwo=cWo(vp,@BN,@name,"ZOUT",@color,"cadetblue")

  yrdecwo= cWo(vp,@BN,@name,"YRD",@color,"violetred",@help," show previous Year  ")
  yrincwo= cWo(vp,@BN,@name,"YRI",@color,"purple",@help," show next Year  ")
  qrtdwo=  cWo(vp,@BN,@name,"QRTD",@color,"violetred",@help," show previous Qtr period ")
  qrtiwo=  cWo(vp,@BN,@name,"QRTI",@color,"purple",@help," show next Qtr period ")


  int fewos[] = {zinwo,zoomwo, yrdecwo, yrincwo, qrtdwo, qrtiwo }

  wo_htile( fewos, 0.03,0.01,0.43,0.08,0.05)

  nobswo= cWo(vp,@BV,@name,"Nobs",@color,"Cyan",@value,0)

  xtwo= cWo(vp,@BV,@name,"xTime",@color,"violetred",@value,0)

  xbwo= cWo(vp,@BV,@name,"xBurn",@color,"violetred",@value,0)

  xlbswo= cWo(vp,@BV,@name,"xLbs",@color,"violetred",@value,0)
  
  int xwos[] = { nobswo, xtwo, xbwo, xlbswo };
  
  wo_htile( xwos, 0.45,0.01,0.83,0.08,0.05);

  sWo(xwos,@style,"SVB",@redraw);
  sWo(gwo,@showpixmap,@save);
  sWo(calwo,@showpixmap);
  sWo(tbqwo,@redraw);

  dtmwo=cWo(vp,@BV,@name,"DAY",@color,RED_,@help," date on day ")
  wtmwo=cWo(vp,@BV,@name,"WTM",@color,RED_,@help," wt on day ")
  cbmwo=cWo(vp,@BV,@name,"CBM",@color,BLUE_,@fonthue,WHITE_,@help," cals burnt on day ")
  xtmwo=cWo(vp,@BV,@name,"ETM",@color,GREEN_,@help," xtime on day ")

  int mwos[] = { dtmwo, wtmwo, cbmwo, xtmwo};

  wo_vtile( mwos, 0.02,0.5,0.08,0.9,0.05);

  sWo(mwos,@style,"SVB",@redraw);


