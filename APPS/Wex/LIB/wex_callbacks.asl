/* 
 *  @script wex_callbacks.asl 
 * 
 *  @comment  
 *  @release CARBON 
 *  @vers 1.2 He 6.3.78 C-Li-Pt 
 *  @date 01/31/2022 09:07:34          
 *  @cdate Sat Dec 29 09:06:51 2018 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2022
 * 
 */ 
;//----------------<v_&_v>-------------------------//;                                                                                              


  void QRTD()
  {
//<<" In $_proc\n"

  adjustQrt(-1);

  showWL();

  }

  void QRTI()
  {

  adjustQrt(1);

  drawScreens();

  showWL();

  }
//////////////////////////////////////////////////////////////////////////////////

  void YRD()
  {

  adjustYear(-1);

  drawScreens();

  showWL();
  }
//--------------------------------------------------

  void YRI()
  {

  adjustYear(1);
  }
//--------------------------------------------------

  void QUIT()
  {

  exitgs();

  }
//===================================

  void ZIN()
  {

  <<" In $_proc  $lcpx  $rcpx\n";

  sc_zstart = lcpx;

  sc_zend = rcpx;

  drawScreens();

  showWL(sc_zstart, sc_zend);

  }
//--------------------------------------------------

  void ZOUT()
  {

  sc_zstart -= 10;

  sc_zend  += 10;

  if (sc_zstart < sc_startday) {

  sc_zstart =  sc_startday;

  }

  if (sc_zend > sc_end) {

  sc_zend =  sc_end;

  }

  drawScreens();

  showWL(sc_zstart, sc_zend);

  }
//---------------------------------------------

  void WTLB()
  {

  <<"$_proc setting cursors $_ebutton \n";

  if (_ebutton == 1) {

  lcpx = _erx;

  <<"%V $lcpx\n";

  sGl(lc_gl,_WCURSOR,lcpx,0,lcpx,300, CL_init);

  CL_init = 0;

  getDay(lcpx);

  }

  if (_ebutton == 3) {

  rcpx = _erx;

  <<"%V $rcpx\n";

  sGl(rc_gl,_WCURSOR,rcpx,0,rcpx,300, CR_init);

  CR_init = 0;

  getDay(rcpx);

  }

  }
//=========================================
///    WONAME PROCS ///

  void setGoals()
  {

  wtv = getWoValue(gwtwo);

  NextGoalWt = atof(wtv);

  <<"%V$wtv $NextGoalWt\n";

  ssday = getWoValue(sdwo);

  sgday = getWoValue(gdwo);

  long lsday =julian(ssday) -bday ; // start date;

  targetday = julian(sgday) -bday;

  //<<"%V$wtv $NextGoalWt $ssday $sgday $lsday $targetday\n";

  computeGoalLine();
 //  sGl(gw_gl,@TXY,WDVEC,GVEC,@color,RED_)

  drawScreens();

  sWo(tw_wo,_WMOVETO,targetday,NextGoalWt,gwo,_WREDRAW,_WEO);

  }


  void setCursors()
  {

  sGl(lc_gl,_WCURSOR,lcpx,0,lcpx,300);

  sGl(rc_gl,_WCURSOR,rcpx,0,rcpx,300);

  }
////////////////////////KEYW CALLBACKS///////////////////////////////////////

  void EXIT()
  {

  exit_gs();
  }
//-------------------------------------------

  void REDRAW()
  {
   drawScreens();
  }
//-------------------------------------------

  void RESIZE()
  {
   drawScreens();
  }
//-------------------------------------------

  void SWITCHSCREEN()
  {
  if (_ename _ == "SWITCHSCREEN") {

  wScreen = atoi(_ewords[1]);
    //<<[_DB]"Setting %V$wScreen msgw[1]\n"

  drawScreens();

  }

  }
///////////////////////////////////////////////////////////////////////////////////////

;//==============\_(^-^)_/==================//;
