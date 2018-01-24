///
///  wed_draw.asl
///


proc drawGoals(ws)
  {

   if (ws == 0) {
    Plot(gwo,@line,sc_startday,165,sc_endday,165, GREEN_)
    Plot(calwo,@line,sc_startday,day_burn,sc_endday,day_burn, GREEN_)
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
  // Equinoxes Dec 21, March 21, June 21, Sep 21 -
  // winter ,vernal, midsummer, fall

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

  axnum(gwo,2);

  //sWo(gwo,@axnum,4)
  //sWo(gwo,@axnum,1)

  //sWo(calwo,@axnum,2,500,5500,500,100)
  
  sWo(calwo,@axnum,2);
  sWo(extwo,@yscales,0,600,@savescales,1);
  sWo(extwo,@axnum,4);

  //sWo(extwo,@axnum,2,0,sc_endday,20,10)

  Text(gwo,  "Weight (lbs)",-4,0.7,4,-90)

  Text(calwo,"Cals In/Out",-4,0.7,4,-90)

 }
 else {

  axnum(swo,2)

  //sWo(swo,@axnum,2,150,bp_upper,50,10)
  //sWo(carbwo,@axnum,2,0,carb_upper,50,10)

  //sWo(carbwo,@axnum,2)

  sWo(xwo,@clipborder,@save);

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

       //sWo(extwo,@clipborder,@save)
  
      //DrawGline(wedgl)
     
  if (ALL_LINES) {
  
  DBPR" draw lines \n"

      sWo(extwo,@scales,sc_startday,0,sc_endday+10,600,@savescales,1);


      dGl(ext_gl)
      
      plot(extwo,@keysymbol,0.78 ,0.9,DIAMOND_,symsz,BLUE_,1);
      plot(extwo,@keysymbol,0.78,0.8,TRI_,symsz,GREEN_,1);
      Text(extwo,"Exercise Time (mins)", 0.8,0.8,1)
      Text(calwo,"Calories Burnt", 0.8,0.9,1)
      





      //sWo(extwo,@symbol,sc_startday,2000,"diamond",5);
//<<" draw gw_gl\n"
      dGl(gw_gl);



      sWo(calwo,@scales,sc_startday,0,sc_endday+10,4500,@savescales,0)

      //plot(extwo,@symbol,sc_endday -10 ,300,TRI_,symsz,BLACK_);
      dGl(calc_gl)
      dGl(calb_gl)

     // DrawGline(carb_gl)
     // DrawGline(ave_ext_gl)

      dGl(wt_gl)
   }

      drawGoals(0);

      drawGrids(0);


      sWo(allwo,@clipborder,"black")

      drawMonths(0)

      Text(extwo,"Exercise mins",-4,0.5,4,-90)
      Text(gwo,  "Weight (lbs)",0.8,0.8,1)

       dGl(wt_gl)
   
       dGl(wt_gl)

      showTarget();
     }

      if ( wScreen == 1) {

DBPR" Drawscreen 1  BP!!\n"
 
      drawGoals(1);
      drawGrids(1);
      drawMonths(1);

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

       rx = RS[1];
       rX = RS[3];
       
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
   yrs = sele(the_date,-4,4)
   
   yrd = atoi(yrs)
//DBPR"%V$jd $the_date $yrs $yrd \n"

<<"%V$jd $the_date $yrs $yrd \n"


   if (updown > 0) {
    yrd++
   }
   
   if (updown < 0) {
    yrd--
  }
  <<"%V  $yrd \n"


   st_jday = julday("01/01/$yrd")
   ed_jday = julday("12/31/$yrd")

  <<"%V  $yrd  $st_jday $ed_jday\n"

   rx = st_jday - bday
  rX = ed_jday - bday

     // rx = st_jday 
    //  rX = ed_jday 

       sc_startday = rx;
       sc_endday = rX;

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

       sc_startday = rx;
       sc_endday = rX;

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

//  <<"$_proc $gday $NextGoalWt $last_known_day\n"
  
//  plot(gwo,@symbol,gday,NextGoalWt, "triangle",1, YELLOW_);
//  plot(gwo,@symbol,gday-1,NextGoalWt, 3,1,GREEN_);
  symsz =5;
  
  plot(gwo,@symbol,gday,NextGoalWt,"diamond",symsz,BLUE_);
  plot(gwo,@symbol,last_known_day,NextGoalWt,2,symsz,RED_,1);

  hlng = (last_known_wt - NextGoalWt) / 0.43; 
  if (hlng  > 0) {
//  <<"$_proc %v $hlng\n"
  plot(gwo,@symbol,last_known_day+hlng,NextGoalWt,"star",symsz, BLUE_);
  plot(gwo,@symbol,last_known_day+hlng,last_known_wt,"cross",symsz,GREEN_);
  }

  hlng = (last_known_wt - GoalWt) / 0.43; 
  if (hlng  > 0) {
 // <<"$_proc %v $hlng\n"
  plot(gwo,@symbol,last_known_day+hlng,GoalWt,"star",symsz, RED_);
  plot(gwo,@symbol,last_known_day+hlng,last_known_wt,"cross",symsz,GREEN_);
  }

  plot(gwo,@symbol,targetday,GoalWt,"star",symsz, LILAC_);
  
}
//===========================
proc resize_screen()
{

  sWi(vp,@resize,0.1,0.1,0.9,0.9,@redraw)

}