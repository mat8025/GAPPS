//%*********************************************** 
//*  @script wex_callbacks.asl 
//* 
//*  @comment  
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                 
//*  @date Sat Dec 29 09:06:51 2018 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2014,2018 --> 
//* 
//***********************************************%



proc QRTD()
{
//<<" In $_proc\n"
  adjustQrt(-1)
  showWL()
  return;
}

proc QRTI()
{

  adjustQrt(1)
  drawScreens()
  showWL()

}

//////////////////////////////////////////////////////////////////////////////////

proc YRD()
{
  adjustYear(-1)
  drawScreens()
  showWL()
}
//--------------------------------------------------
proc YRI()
{
    adjustYear(1)
}
//--------------------------------------------------


proc QUIT()
{

  exitgs();

}
//===================================

proc ZIN()
{
<<" In $_proc\n"
       sc_startday = lcpx;
       sc_endday = rcpx;
       
       sWo(wedwo,@xscales,lcpx,rcpx);

       sWo(swo,@xscales,lcpx,rcpx);

       drawScreens();

       showWL();

}
//--------------------------------------------------

proc ZOUT()
{

float RS[10];

       RS=wogetrscales(gwo)

       rx = RS[1]
       rX = RS[3]

       rx -= 14.0;
       rX += 14.0;


       if (rX > maxday) {
          Rx = maxday;
       }

       if (rx < 0) {
          rx = 0;
       }
       

       sWo(gwo,@scales,rx,minWt,rX,topWt) 
       sWo(gwo,@redraw,@update)

       sWo(swo,@xscales,rx,rX) 
       sc_startday = rx;
       sc_endday = rX;
       sWo(swo,@redraw,@update)       

       dGl(wt_gl)

       drawScreens()

       showWL()
}

//---------------------------------------------
proc WTLB()
{
<<" $_proc \n"

       <<" setting cursors $button $Rinfo\n"

       if (_ebutton == 1) {
         lcpx = _erx;
	// <<"%V $lcpx\n"
         sGl(lc_gl,@cursor,lcpx,0,lcpx,300)
         getDay(lcpx);

        }

       if (_ebutton == 3) {
         rcpx = _erx
         sGl(rc_gl,@cursor,rcpx,0,rcpx,300)
	 getDay(_erx);
       }

}
//=========================================
///    WONAME PROCS ///

proc setGoals()
{

   wtv = getWoValue(gwtwo)
   NextGoalWt = atof(wtv);
   <<"%V$wtv $NextGoalWt\n"
   ssday = getWoValue(sdwo)
   sgday = getWoValue(gdwo)

   long lsday =julian(ssday) -bday // start date
   targetday = julian(sgday) -bday;


   <<"%V$wtv $NextGoalWt $ssday $sgday $lsday $targetday\n"
   computeGoalLine()
 //  sGl(gw_gl,@TXY,WDVEC,GVEC,@color,RED_)

   drawScreens();
   sWo(tw_wo,@moveto,targetday,NextGoalWt,gwo,@redraw);
}




////////////////////////KEYW CALLBACKS///////////////////////////////////////
proc EXIT()
{
  exit_gs()
}
//-------------------------------------------
proc REDRAW()
{
  drawScreens()
}
//-------------------------------------------
proc RESIZE()
{
  drawScreens()
}
//-------------------------------------------
proc SWITCHSCREEN()
{
  if (_ename @= "SWITCHSCREEN") { 
     wScreen = atoi(_ewords[1])
    <<[_DB]"Setting %V$wScreen msgw[1]\n"
      drawScreens()
  }
}







///////////////////////////////////////////////////////////////////////////////////////
<<[_DB]"$_include \n"