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
;


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
<<" In $_proc  $lcpx  $rcpx\n"


       sc_startday = lcpx;
       sc_endday = rcpx;
       
       
       sWo(wedwo,@xscales,sc_startday,sc_endday);

       sWo(gwo,@xscales,sc_startday,sc_endday);


       drawScreens();
<<"calling showWL  $sc_startday   $sc_endday\n"

       showWL(sc_startday, sc_endday);

}
//--------------------------------------------------

proc ZOUT()
{
/*
float RS[10];

       RS=wogetrscales(gwo)

       rx = RS[1]
       rX = RS[3]

<<"%V $rx rX\n"

       rx -= 14.0;
       rX += 14.0;


       if (rX > maxday) {
          Rx = maxday;
       }

       if (rx < 0) {
          rx = 0;
       }
       

       sWo(gwo,@scales,rx,minWt,rX,upperWt) 
       sWo(gwo,@redraw,@update)

       sWo(swo,@xscales,rx,rX) 
       sc_startday = rx;
       sc_endday = rX;
       sWo(swo,@redraw,@update)       
*/

       sc_startday -= 10;
       sc_endday  += 10;

       sWo(wedwo,@xscales,sc_startday,sc_endday);

       sWo(gwo,@xscales,sc_startday,sc_endday);

       dGl(wt_gl)

       drawScreens()

       showWL(sc_startday, sc_endday)
}

//---------------------------------------------
proc WTLB()
{
       <<"$_proc setting cursors $_ebutton \n"

       if (_ebutton == 1) {
         lcpx = _erx;
	<<"%V $lcpx\n"
         sGl(lc_gl,@cursor,lcpx,0,lcpx,300, CL_init)
	 CL_init = 0;
        getDay(lcpx);

        }

       if (_ebutton == 3) {
         rcpx = _erx
	<<"%V $rcpx\n"	 
         sGl(rc_gl,@cursor,rcpx,0,rcpx,300, CR_init)
         CR_init = 0;
         getDay(rcpx);
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

proc setCursors()
{
        sGl(lc_gl,@cursor,lcpx,0,lcpx,300)
         sGl(rc_gl,@cursor,rcpx,0,rcpx,300)

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