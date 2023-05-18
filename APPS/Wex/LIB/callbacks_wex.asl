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

/*
#if CPP
// needed ? -  asl will see this as replacement for drawScreens function
// not as declaration of prototype existing elsewhere in the code
 void drawScreens();
 void showWL(long ws, long we); // CPP
#endif
*/

  void adjustQrt(int updown)
  {
// find mid-date 
// adjust to a 90 day resolution
// shift up/down by 30
   int wedwos[] = { wtwo, calwo,  carbwo, extwo,-1  };
   float rx,ry,rX,rY;

   RS=wgetrscales(wtwo);
// just plot at mid - the date

  mid_date = (RS[3] - RS[1])/2 + RS[1];

  jd= mid_date +Bday;

  the_date = Julmdy(jd);

  if (updown > 0) {

  rx = mid_date -30;

  rX = mid_date +60;

  }

  if (updown < 0) {

  rx = mid_date -60;

  rX = mid_date +30;

  }

  sc_startday = rx;

  sc_endday = rX;

  //sWo(wedwos,_WXSCALES,wpt(rx,rX),_WSAVESCALES,0);

  sWo(_WOID,wtwo,_WSCALES,wbox(rx,minWt,rX,upperWt),_WSAVESCALES,0);

  sWo(_WOID,swo,_WXSCALES,wpt(rx,rX),_WSAVESCALES,0);

  drawScreens();

  }
//========================================================



 void EXIT()
  {
   cout << "exit ?\n";
   exit_si();
    // exit_gs();
  }


  void QRTD()
  {
//<<" In $_proc\n"

      adjustQrt(-1);

       showWL(sc_zstart, sc_zend);

  }

  void QRTI()
  {

    adjustQrt(1);

    drawScreens();

     showWL(sc_zstart, sc_zend);

  }
//////////////////////////////////////////////////////////////////////////////////

  void YRD()
  {

  adjustYear(-1);

  drawScreens();

     showWL(sc_zstart, sc_zend);
  }
//--------------------------------------------------

  void YRI()
  {

  adjustYear(1);
  }
//--------------------------------------------------

  void QUIT()
  {

  exit_si();

  }
//===================================

  void ZIN()
  {

  //<<" In $_proc  $lcpx  $rcpx\n";
  //cout <<"In ZIN " << lcpx  << endl;
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


//pa("proc  setting cursors ", _proc, " Button", Button);

//printf("\n Ev_button %d    cursor @ Ev_rx %f\n",Ev_button,Ev_rx);      
 long wt_day = 0;
 
       if (Ev_button == 1) {

         lcpx = Ev_rx;

	 sGl(_GLID,lc_gl,_GLHUE,RED_,_GLCURSOR,rbox(lcpx,0,lcpx,300,Wex_CL_init),_GLDRAW,ON_);
	 
	 Wex_CL_init = 0;
	 wt_day = fround(lcpx,0);
	 
printf("\n day %f  %d\n",lcpx, wt_day);      
 // wt_day.pinfo();
  //lcpx.pinfo();

//DBA"%V $wt_day $lcpx \n";

         getDay(wt_day);

        }

       if (Ev_button == 3) {
       
         rcpx = Ev_rx;

      
	 sGl(_GLID,rc_gl,_GLHUE,BLUE_,_GLCURSOR,rbox(rcpx,0,rcpx,310,Wex_CR_init),_GLDRAW,ON_);
	 
         Wex_CR_init = 0;

       }



}
//=========================================

///    WONAME PROCS ///

  void setGoals()
  {
/*
  Str wtv = getWoValue(gwtwo);

  NextGoalWt = atof(wtv);

  <<"%V$wtv $NextGoalWt\n";

  ssday = getWoValue(sdwo);

  sgday = getWoValue(gdwo);

  long lsday =julian(ssday) -bday ; // start date;

  targetday = julian(sgday) -bday;

  //<<"%V$wtv $NextGoalWt $ssday $sgday $lsday $targetday\n";

  //computeGoalLine();
 //  sGl(gw_gl,@TXY,WDVEC,GVEC,@color,RED_)

  drawScreens();

  sWo(_WOID,tw_wo,_WMOVETO,targetday,NextGoalWt,wtwo,_WREDRAW,1);
*/
  }



void setCursors()
{
//<<"$_proc : $_lcpx\n"
        sGl(_GLID,lc_gl,_GLCURSOR, rbox(lcpx,0,lcpx,300));

        sGl(_GLID,rc_gl,_GLCURSOR, rbox(rcpx,0,rcpx,300));
	
}



////////////////////////KEYW CALLBACKS///////////////////////////////////////



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
/*
  void SWITCHSCREEN()
  {
  if (_ename _ == "SWITCHSCREEN") {

  wScreen = atoi(_ewords[1]);
    //<<[_DB]"Setting %V$wScreen msgw[1]\n"

  drawScreens();

  }

  }
*/
///////////////////////////////////////////////////////////////////////////////////////

;//==============\_(^-^)_/==================//;
