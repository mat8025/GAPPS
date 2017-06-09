
////////////////////////WED CALLBACKS///////////////////////////////////////

////////////////////////WONAME CALLBACKS///////////////////////////////////////
proc QRTD()
{
  adjustQrt(-1)

  showWL()

}

proc QRTI()
{
  adjustQrt(1)

  showWL()

}

//////////////////////////////////////////////////////////////////////////////////

proc YRD()
{
   adjustYear(-1)
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

       sWo(wedwo,@xscales,lcpx,rcpx) 

       sWo(swo,@xscales,lcpx,rcpx) 

       drawScreens()

       showWL()

}
//--------------------------------------------------

proc ZOUT()
{

float RS[10]

       RS=wogetrscales(gwo)

       rx = RS[1]
       rX = RS[3]
       rx /= 2.0
       rX *= 2.0

       if (rX > maxday) {
          Rx = maxday
       }

       sWo(gwo,@scales,rx,minWt,rX,topWt) 
       sWo(gwo,@redraw,@update)
       sWo(swo,@xscales,rx,rX) 

       DrawGline(wt_gl)

       showWL()


}

//---------------------------------------------
proc WTLB()
{

    DBPR" setting cursors $button $Rinfo\n"

       if (button == 1) {
         lcpx = Rinfo[1]
         sGl(lc_gl,@cursor,lcpx,0,lcpx,300)
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
