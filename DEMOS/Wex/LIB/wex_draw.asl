//%*********************************************** 
//*  @script wex_draw.asl 
//* 
//*  @comment  
//*  @release CARBON 
//*  @vers 1.3 Li Lithium                                                 
//*  @date Tue Jan  1 09:48:31 2019 
//*  @cdate Fri Jan  1 08:00:00 2010 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2014,2018 --> 
//* 
//***********************************************%


proc drawGoals(int ws)
  {

   if (ws == 0) {
    Plot(gwo,@line,sc_startday,165,sc_endday,165, GREEN_)
    Plot(calwo,@line,sc_startday,day_burn,sc_endday+10,day_burn, GREEN_)
    Plot(calwo,@line,sc_startday,out_cal,sc_endday+10,out_cal, BLUE_)
    Plot(calwo,@line,sc_startday,in_cal,sc_endday+10,in_cal, RED_)
    Plot(calwo,@line,sc_startday,50,sc_endday+10,50, GREEN_)    

   }

  if (ws == 1) {
<<[_DB]"$ws $swo $kdays \n"

   Plot(swo,@line,0,150,kdays-10,250, BLUE_)
   }


  }
//---------------------------------------------------------
proc  drawMonths(int wwo)
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

   float lty = 0
   float qfwd = 0.0
 

   RS=wogetrscales(wwo)

// just plot at mid - the date

   mid_date = (RS[3] - RS[1])/2 + RS[1];
   q1_date = (RS[3] - RS[1])/4 + RS[1];
   q3_date = 3*(RS[3] - RS[1])/4 + RS[1];

   jd= mid_date +bday
   the_date = julmdy("$jd")

<<[_DB]"%V$mid_date $jd $the_date \n"

   //AxText(wwo, 1, the_date, mid_date, -0.25, BLUE_)

   jd= RS[1] +bday
   the_date = julmdy("$jd");
//  AxText(wwo, 1, the_date, q1_date, -0.25, BLUE_);
   wdate = RS[1];
   sWo(wwo,@font,"small")
 //  AxText(wwo, 1, the_date, wdate, 0.25, BLUE_);
  int draw_months =1;
  while (draw_months <= 12) {
   jd += 7;
   wdate += 7;
   if (wdate >= RS[3]) {
      break;
   }
   the_date = julmdy("$jd");
   mday = spat(the_date,"/",-1,-1)
   AxText(wwo, 1, mday, wdate, 0.25, BLUE_);
 //  <<"%V $jd $wdate $RS[3] $the_date\n"
    draw_months++;
   }

}
//---------------------------------------------------------------

proc  drawGrids(int  ws )
{
// <<[_DB]" $ws \n"

 if (ws == 0) {

  //<<[_DB]"drawing Grids for screen 0 \n"
  //sWo({extwo,calwo,gwo},@font,"small");
  sWo(extwo,@font,"small");
  
  axnum(gwo,AXIS_LEFT_);

  //sWo(gwo,@axnum,4)
  //sWo(gwo,@axnum,1)

  //sWo(calwo,@axnum,2,500,5500,500,100)


  sWo(calwo,@axnum,AXIS_LEFT_);
  sWo(calwo,@yscales,0,carb_upper,@savescales,1);

  sWo(calwo,@usescales,1,@axnum,AXIS_RIGHT_);
//  sWo(carbwo,@axnum,2);
  
  sWo(extwo,@yscales,0,250,@savescales,1);
  sWo(extwo,@axnum,2);

  //sWo(extwo,@axnum,2,0,sc_endday,20,10)
  //Text(gwo, "Weight (lbs)",-4,0.7,4,-90)

   AxLabel(gwo,AXIS_BOTTOM_,"Weight (lbs)",0.5,1.5)
   AxLabel(calwo,AXIS_BOTTOM_,"Calories and Carbs",0.5,1.5)
   AxLabel(extwo,AXIS_BOTTOM_,"Exercise Time (mins)",0.5,1.5)

  //Text(calwo,"Cals In/Out",-4,0.7,4,-90)

 }
 else {

  axnum(swo,2)

  //sWo(swo,@axnum,2,150,bp_upper,50,10)

  sWo(xwo,@clipborder,@save);

 }
  sWo(allwo,@showpixmap,@save)

  sWo(allwo,@clipborder)
}
//---------------------------------------------------------------------------------

#define ALL_LINES 1

proc drawScreens()
{

<<" $_proc \n"

  if ( wScreen == 0) {

       sWo(wedwo,@clearclip,@save,@clearpixmap,@clipborder,BLACK_)

       //sWo(extwo,@clipborder,@save)
  
      //DrawGline(wedgl)
     
  if (ALL_LINES) {
  
  <<[_DB]" draw lines \n"

      sWo(extwo,@scales,sc_startday,0,sc_endday+10,250,@savescales,1);


      dGl(exgls)

      //dGl(cardio_gl);
      //dGl(strength_gl);
      
      sWo(calwo,@font,"small")
      /// these need to be a separate wo to contain key  symbol and text
     // plot(calwo,@keysymbol,0.78 ,0.9,DIAMOND_,symsz,BLUE_,1);
      sWo(calwo,@font,"small")
      //Text(calwo,"Calories Burnt", 0.8,0.9,1)      

     // plot(calwo,@keysymbol,0.78 ,0.8,DIAMOND_,symsz,RED_,1);      
      //Text(calwo,"Calories Ate", 0.8,0.82,1)

     // plot(calwo,@keysymbol,0.78 ,0.7,TRI_,symsz,RED_,1,@fonthue,WHITE_);      
      //Text(calwo,"Carbs Ate", 0.8,0.72,1)


      sWo(extwo,@font,"small")
      //plot(extwo,@keysymbol,0.78,0.7,TRI_,symsz,GREEN_,1);
      //Text(extwo,"Exercise Time (mins)", 0.8,0.7,1)
      

      dGl(gw_gl);

      
      sWo(calwo,@scales,sc_startday,0,sc_endday+10,carb_upper,@savescales,1)      
      dGl(carb_gl) ; //which scale is this going to use      


      sWo(calwo,@scales,sc_startday,0,sc_endday+10,CalsY1,@savescales,0)
      dGl(calc_gl)
      dGl(calb_gl)


      sWo(gwo,@scales,sc_startday,minWt,sc_endday+10,topWt,@savescales,0)

      dGl(wt_gl)
       }

      drawGoals(0);
      drawGrids(0);


      sWo(allwo,@clipborder,"black")

      drawMonths(gwo)
      drawMonths(calwo)
      //drawMonths(carbwo)
      drawMonths(extwo)      

      //Text(extwo,"Exercise mins",-4,0.5,4,-90)
      //Text(gwo,  "Weight (lbs)",0.8,0.8,1)

       //dGl(wt_gl)
   
       //dGl(wt_gl)

      showTarget();
     }

      if ( wScreen == 1) {

<<[_DB]" Drawscreen 1  BP!!\n"
 
      drawGoals(1);
      drawGrids(1);
      drawMonths(swo);

      DrawGline(bp_gl)

      sWo(swo,@showpixmap)
      sWo(allwo,@clipborder,"green")
      }

    sWo(fewos,@redraw)

    sWo(tw_wo,@move,targetday,NextGoalWt,gwo,@redraw);
    <<"leaving $_proc\n"
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

proc adjustYear(int updown)
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
//<<[_DB]"%V$jd $the_date $yrs $yrd \n"

//<<"%V$jd $the_date $yrs $yrd \n"


   if (updown > 0) {
    yrd++
   }
   
   if (updown < 0) {
    yrd--
  }
//  <<"%V  $yrd \n"


   st_jday = julian("01/01/$yrd")
   ed_jday = julian("12/31/$yrd")

  //<<"%V  $yrd  $st_jday $ed_jday\n"

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

proc adjustQrt(int updown)
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

  hlng = (last_known_wt - NextGoalWt) / 0.43; 
  if (hlng  > 0) {
 // <<"$_proc %v $hlng\n"
  plot(gwo,@symbol,last_known_day+hlng,GoalWt,"star",symsz, RED_);
  plot(gwo,@symbol,last_known_day+hlng,last_known_wt,"cross",symsz,GREEN_);
  }

  plot(gwo,@symbol,targetday,GoalWt,"star",symsz, LILAC_);
//  dGl(gw_gl);
}
//===========================
proc resize_screen()
{

  sWi(vp,@resize,0.05,0.1,0.95,0.9,@redraw)

}