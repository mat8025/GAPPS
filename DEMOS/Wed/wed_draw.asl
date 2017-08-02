///
///  wed_draw.asl
///


proc drawGoals(ws)
  {

   if (ws == 0) {
    Plot(gwo,@line,sc_startday,165,sc_endday,165, "green")
    Plot(calwo,@line,sc_startday,day_burn,sc_endday,day_burn, "green")
    Plot(calwo,@line,sc_startday,out_cal,sc_endday,out_cal, BLUE_)
    Plot(calwo,@line,sc_startday,in_cal,sc_endday,in_cal, RED_)

//    Plot(carbwo,@line,0,30,sc_endday,30, BLUE_)
//    Plot(carbwo,@line,0,55,sc_endday,55, RED_)

}

  if (ws == 1) {
DBPR"$ws $swo $kdays \n"

   Plot(swo,@line,0,150,kdays-10,250, BLUE_)
   }


  }
//---------------------------------------------------------
proc  drawMonths(ws)
 {
  // as either Months Jan,Feb, ... Dec  

  // or quarter and cross-quater days
  // Candlemass Feb 2
  // Lady Day   March 25
  // Beltane (may day) May 1
  // MidSummer   June 24
  // Lughnasaid  Aug 1
  // Michlemas   Sept 29
  // Samhain     Oct 31
  // Christmas   Dec 25
  //
  // Equinoxes Dec 21, March 21, June 21, Sep 21 - winter ,vernal, midsummer, fall

   int sd
   int k
   int yd
   int wd
   int wm = 0

   int wwo = gwo
   float lty = 0
   float qfwd = 0.0
 
   if (ws == 1) {
       wwo = swo
   }

   RS=wogetrscales(wwo)

// just plot at mid - the date

   mid_date = (RS[3] - RS[1])/2 + RS[1]
   q1_date = (RS[3] - RS[1])/4 + RS[1]
   q3_date = 3*(RS[3] - RS[1])/4 + RS[1]

   jd= mid_date +bday
   the_date = julmdy("$jd")

DBPR"%V$mid_date $jd $the_date \n"

   AxText(wwo, 1, the_date, mid_date, -0.25, BLUE_)

   jd= q1_date +bday
   the_date = julmdy("$jd")
   AxText(wwo, 1, the_date, q1_date, -0.25, BLUE_)
   jd= q3_date +bday
   the_date = julmdy("$jd")
   AxText(wwo, 1, the_date, q3_date, -0.25, BLUE_)

 }
//---------------------------------------------------------------

proc  drawGrids( ws )
{
// DBPR" $ws \n"

 if (ws == 0) {

 //DBPR"drawing Grids for screen 0 \n"

  //SetGwob(extwo,@axnum,1,0,kdays,7,1)

  //SetGwob(gwo,@axnum,2,155,205,10,5)

  axnum(gwo,2)

  //sWo(gwo,@axnum,4)
  //sWo(gwo,@axnum,1)

  //sWo(calwo,@axnum,2,500,5500,500,100)
  sWo(calwo,@axnum,2)
  sWo(extwo,@axnum,2)

  //sWo(extwo,@axnum,2,0,sc_endday,20,10)

  Text(gwo,  "Weight (lbs)",-4,0.7,4,-90)
  Text(extwo,"Exercise mins",-4,0.7,4,-90)
  Text(calwo,"Cals In/Out",-4,0.7,4,-90)

 }
 else {

  axnum(swo,2)

  //sWo(swo,@axnum,2,150,bp_upper,50,10)
  //sWo(carbwo,@axnum,2,0,carb_upper,50,10)

  //sWo(carbwo,@axnum,2)
  sWo(xwo,@clipborder,@save)

 }
  sWo(allwo,@showpixmap,@save)

  sWo(allwo,@clipborder)
}
//---------------------------------------------------------------------------------

#define ALL_LINES 1

proc drawScreens()
{
//<<" $_proc \n"

  if ( wScreen == 0) {

       sWo(wedwo,@clearclip,@save,@clearpixmap,@clipborder,"black")

       sWo(extwo,@clipborder,@save)
  
      //DrawGline(wedgl)
     
  if (ALL_LINES) {
DBPR" draw lines \n"
      DrawGline(ext_gl)
      DrawGline(gw_gl)

      DrawGline(calc_gl)
      DrawGline(calb_gl)

     // DrawGline(carb_gl)
     // DrawGline(ave_ext_gl)

      DrawGline(wt_gl)
   }

      drawGoals(0);

      drawGrids(0);

   //   setgwob(wedwo,@showpixmap)

      sWo(allwo,@clipborder,"black")

      drawMonths(0)

      Text(gwo,  "Weight (lbs)",0.8,0.8,1)
      Text(calwo,"Calories", 0.8,0.8,1)
      Text(extwo,"Exercise Time (mins)", 0.8,0.8,1)

      //DrawGline(pwt_gl)

      DrawGline(wt_gl)
   
      //DrawGline(carb_gl)

       DrawGline(wt_gl)

      showTarget();
     }

      if ( wScreen == 1) {

DBPR" Drawscreen 1  BP!!\n"
 
      drawGoals(1)
      drawGrids(1)
      drawMonths(1)

      DrawGline(bp_gl)

      setgwob(swo,@showpixmap)
       sWo(allwo,@clipborder,"green")
//      sWo(swo,@clipborder,"green")
      }

    sWo(fewos,@redraw)

}
//=================================================

proc showWL()
{

       RS=wogetrscales(gwo)

       rx = RS[1]
       rX = RS[3]
long ws;
long we;

       ws = rx + bday
       we = rX + bday

       computeWL( ws, we);

       showCompute();
}
//========================================================



//////////////////////// UTIL PROCS /////////////////////////////

proc adjustYear(updown)
{

// find current mid-year
// decrement - and set rx,RX to jan 1, dec 31 of that year
// then label 1/4 days

   RS=wogetrscales(gwo)

// just plot at mid - the date
   mid_date = (RS[3] - RS[1])/2 + RS[1]

   jd= mid_date +bday
   the_date = julmdy("$jd")

   // which year?
   yrs = sele(the_date,-1,4)
   yrd = atoi(yrs)
//DBPR"%V$jd $the_date $yrs $yrd \n"
   if (updown > 0)
    yrd++

   if (updown < 0)
    yrd--

   st_jday = julday("01/01/$yrd")
   ed_jday = julday("12/31/$yrd")

   rx = st_jday - bday
   rX = ed_jday - bday

   sWo(wedwo,@xscales,rx,rX,@savescales,0)

   sWo(swo,@xscales,rx,rX) 

   sWo(gwo,@scales,rx,minWt,rX,topWt,@savescales,0)

   drawScreens()
}

//////////////////////////////////////////////////////////////////////

proc adjustQrt(updown)
{
// find mid-date 
// adjust to a 90 day resolution
// shift up/down by 30

   RS=wogetrscales(gwo)

// just plot at mid - the date
   mid_date = (RS[3] - RS[1])/2 + RS[1]

   jd= mid_date +bday
   the_date = julmdy("$jd")

   if (updown > 0) {
     rx = mid_date -30
     rX = mid_date +60
   }
   if (updown < 0) {
     rx = mid_date -60
     rX = mid_date +30
   }

   sWo(wedwo,@xscales,rx,rX,@savescales,0)

   sWo(gwo,@scales,rx,minWt,rX,topWt,@savescales,0)
 
   sWo(swo,@xscales,rx,rX,@savescales,0)
 
   drawScreens()
}
//========================================================

proc showCompute()
{
  sWo(nobswo,@value,Nxy_obs,@update)
  sWo(xtwo,@value,xhrs,@update)
  sWo(xbwo,@value,"%6.2f$Nsel_exeburn",@update)
  sWo(xlbswo,@value,"%4.1f$Nsel_lbs",@update)
}
//========================================================

proc showTarget()
{
// target wt and date

  <<"$_proc $gday $NextGoalWt $last_known_day\n"
  
//  plot(gwo,@symbol,gday,NextGoalWt, "triangle",1, YELLOW_);
//  plot(gwo,@symbol,gday-1,NextGoalWt, 3,1,GREEN_);
  plot(gwo,@symbol,gday,NextGoalWt,"diamond",1,BLUE_);
  plot(gwo,@symbol,last_known_day,NextGoalWt,2,1,RED_);

  hlng = (last_known_wt - NextGoalWt) / 0.43; 
  if (hlng  > 0) {
  <<"$_proc %v $hlng\n"
  plot(gwo,@symbol,last_known_day+hlng,NextGoalWt,"star",1, BLUE_);
  plot(gwo,@symbol,last_known_day+hlng,last_known_wt,"cross",1,GREEN_);
  }

  hlng = (last_known_wt - GoalWt) / 0.43; 
  if (hlng  > 0) {
  <<"$_proc %v $hlng\n"
  plot(gwo,@symbol,last_known_day+hlng,GoalWt,"star",1, RED_);
  plot(gwo,@symbol,last_known_day+hlng,last_known_wt,"cross",1,GREEN_);
  }

  plot(gwo,@symbol,targetday,GoalWt,"star",1, LILAC_);


  
}