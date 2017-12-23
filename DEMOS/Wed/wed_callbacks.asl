///
////////////////////////WED CALLBACKS///////////////////////////////////////
///


////////////////////////WONAME CALLBACKS///////////////////////////////////////
proc QRTD()
{
  adjustQrt(-1)

 
  showWL()

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

       sc_startday = lcpx;
       sc_endday = rcpx;
       
       sWo(wedwo,@xscales,lcpx,rcpx);

       sWo(swo,@xscales,lcpx,rcpx);

       drawScreens()

       showWL()

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

       DBPR" setting cursors $button $Rinfo\n"

       if (button == 1) {
         lcpx = Rinfo[1];
	 <<"%V $lcpx\n"
         sGl(lc_gl,@cursor,lcpx,0,lcpx,300)
         getDay(lcpx);

        }

       if (button == 3) {
         rcpx = Rinfo[1]
         sGl(rc_gl,@cursor,rcpx,0,rcpx,300)
       }

}
//=========================================




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
  if (msgw[0] @= "SWITCHSCREEN") { 
     wScreen = atoi(msgw[1])
    DBPR"Setting %V$wScreen msgw[1]\n"
      drawScreens()
  }
}
///////////////////////////////////////////////////////////////////////////////////////
