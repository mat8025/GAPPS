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
  adjustQrt(-1)
  showWL()
}

void QRTI()
{

  adjustQrt(1)
  drawScreens()
  showWL()

}

//////////////////////////////////////////////////////////////////////////////////

void YRD()
{
  adjustYear(-1)
  drawScreens()
  showWL()
}
//--------------------------------------------------
void YRI()
{
    adjustYear(1)
}
//--------------------------------------------------


void QUIT()
{

  exitgs();

}
//===================================

void ZIN()
{
<<" In $_proc  $lcpx  $rcpx\n"


       sc_startday = lcpx;
       sc_endday = rcpx;

//sc_startday.pinfo();
//sc_endday.pinfo();

       
       sWo(wedwo,@xscales,sc_startday,sc_endday);

       sWo(gwo,@xscales,sc_startday,sc_endday);


       drawScreens();
       
//<<"calling showWL  $sc_startday   $sc_endday\n"

       showWL(sc_startday, sc_endday);

//<<"AFTER showWL  $sc_startday   $sc_endday\n"

sc_startday.pinfo();
sc_endday.pinfo();

//ans=query("?");

}
//--------------------------------------------------

void ZOUT()
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
void WTLB()
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

void setGoals()
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

void setCursors()
{
        sGl(lc_gl,@cursor,lcpx,0,lcpx,300)
         sGl(rc_gl,@cursor,rcpx,0,rcpx,300)

}


////////////////////////KEYW CALLBACKS///////////////////////////////////////
void EXIT()
{
  exit_gs()
}
//-------------------------------------------
void REDRAW()
{
  drawScreens()
}
//-------------------------------------------
void RESIZE()
{
  drawScreens()
}
//-------------------------------------------
void SWITCHSCREEN()
{
  if (_ename @= "SWITCHSCREEN") { 
     wScreen = atoi(_ewords[1])
    <<[_DB]"Setting %V$wScreen msgw[1]\n"
      drawScreens()
  }
}







///////////////////////////////////////////////////////////////////////////////////////
<<[_DB]"$_include \n"