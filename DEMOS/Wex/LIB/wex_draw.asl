/* 
 *  @script wex_draw.asl 
 * 
 *  @comment  
 *  @release CARBON 
 *  @vers 1.4 Be 6.3.78 C-Li-Pt 
 *  @date 01/31/2022 09:08:26          
 *  @cdate Fri Jan 1 08:00:00 2010 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2022
 * 
 */ 
;//----------------<v_&_v>-------------------------//;                                                                                                


int symsz =5;


void drawGoals(int ws)
  {

   if (ws == 0) {
    Plot(gwo,@box,sc_startday,DX_NEW,sc_end,DX_NEW+20, ORANGE_,3) ; // never go above
    Plot(gwo,@box,sc_startday,DX_MEW,sc_end,DX_NEW, YELLOW_,3) ; // diet x max above
    Plot(gwo,@box,sc_startday,GoalWt-5,sc_end,GoalWt+5, LIGHTGREEN_,3) ; //

    Plot(calwo,@line,sc_startday,day_burn,sc_end,day_burn, GREEN_)
    Plot(calwo,@line,sc_startday,out_cal,sc_end,out_cal, BLUE_)
    Plot(calwo,@line,sc_startday,in_cal,sc_end,in_cal, RED_)
    Plot(calwo,@line,sc_startday,50,sc_end,50, GREEN_)
    // use todays date and wt to the intermediate short-term goal
    Plot(gwo,@line,last_known_day,last_known_wt,tday2,StGoalWt, RED_) ;  
   }

  if (ws == 1) {

<<[_DB]"$ws $swo $kdays \n"

   Plot(swo,@line,0,150,kdays-10,250, BLUE_)
   }


  }
//---------------------------------------------------------
void  drawMonths(int wwo)
 {
  // as either Months Jan,Feb, ... Dec  

  // or quarter and cross-quarter days
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

   jd= mid_date +Bday
   the_date = julmdy("$jd")

<<[_DB]"%V$mid_date $jd $the_date \n"

   //AxText(wwo, 1, the_date, mid_date, -0.25, BLUE_)

   jd= RS[1] + Jan1;
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
   AxText(wwo, 1, mday, wdate, 0.7, BLUE_);
 //  <<"%V $jd $wdate $RS[3] $the_date\n"
    draw_months++;
   }

}
//---------------------------------------------------------------

void  drawGrids(int  ws )
{
// <<[_DB]" $ws \n"

 if (ws == 0) {

  //<<[_DB]"drawing Grids for screen 0 \n"
  //sWo({extwo,calwo,gwo},@font,"small");
  sWo(extwo,@font,"small");
  
  axnum(gwo,AXIS_LEFT_);


  sWo(carbwo,@axnum,AXIS_LEFT_);
  sWo(carbwo,@yscales,0,carb_upper,@savescales);

  sWo(calwo,@usescales,0,@axnum,  AXIS_LEFT_);
//  sWo(carbwo,@axnum,2);
  
  sWo(extwo,@yscales,0,upperWt,@savescales,1);
  sWo(extwo,@axnum,AXIS_LEFT_);

  //sWo(extwo,@axnum,2,0,sc_endday,20,10)
  //Text(gwo, "Weight (lbs)",-4,0.7,4,-90)

   AxLabel(gwo,AXIS_BOTTOM_,"Weight (lbs)",0.5,1.7)
   AxLabel(calwo,AXIS_BOTTOM_,"Calories",0.5,1.7)
   //AxLabel(extwo,AXIS_LEFT_,"Exercise Time (mins)",0.1,0.7); // TBF
      AxLabel(extwo,AXIS_LEFT_,"Mins",0.1,4.0); // TBF
   AxLabel(carbwo,AXIS_LEFT_,"Carbs",0.1,4)
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

void drawScreens()
{

//<<" $_proc \n"
//<<"%V $sc_startday  $sc_end \n"

// sc_startday.pinfo()

 //sc_startday = (jtoday - Bday) - 20;

//<<"RESET? %V $sc_startday  $sc_end \n"

  if ( wScreen == 0) {

//<<"%V $sc_zstart $minWt $sc_zend $upperWt\n"

       sWo(wedwo,@xscales,sc_zstart,sc_zend);

       sWo(wedwo,@clearclip,@save,@clearpixmap,@clipborder,BLACK_)

      drawGoals( wScreen);

      drawGrids( wScreen);

     
  if (ALL_LINES) {
  
  <<[_DB]" draw lines \n"


      dGl(exgls)

      //dGl(cardio_gl);
      //dGl(strength_gl);
      
      sWo(calwo,@font,"small")
      /// these need to be a separate wo to contain key  symbol and text
     // plot(calwo,@keysymbol,0.78 ,0.9,DIAMOND_,symsz,BLUE_,1);
      sWo(calwo,@font,"small")
      //Text(calwo,"Calories Burnt", 0.8,0.9,1)      

      plot(calwo,@keysymbol,0.78 ,0.8,DIAMOND_,symsz,RED_,1);      
      Text(calwo,"Calories Ate", 0.8,0.82,1)

     // plot(calwo,@keysymbol,0.78 ,0.7,TRI_,symsz,RED_,1,@fonthue,WHITE_);      
      //Text(calwo,"Carbs Ate", 0.8,0.72,1)


      sWo(extwo,@font,"small")
      //plot(extwo,@keysymbol,0.78,0.7,TRI_,symsz,GREEN_,1);

       Text(extwo,"Exercise Time (mins)", 0.8,0.7,1);
      

      dGl(gw_gl);

      dGl(carb_gl) ; //which scale is this going to use LH
      
      dGl(fibre_gl) ;

      dGl(fat_gl) ;

      dGl(prot_gl) ;            

      dGl(calc_gl)
      
      dGl(calb_gl)

      dGl(wt_gl)


       }




      sWo(allwo,@clipborder,BLACK_)

      drawMonths(gwo)
      drawMonths(calwo)
      drawMonths(carbwo)
      drawMonths(extwo)      

      //Text(extwo,"Exercise mins",-4,0.5,4,-90)
      //Text(gwo,  "Weight (lbs)",0.8,0.8,1)

       //dGl(wt_gl)
   
       //dGl(wt_gl)

      showTarget();
 sWo(wedwo,@showpixmap,@clipborder,BLACK_)
     
     }

      if ( wScreen == 1) {

<<[_DB]" Drawscreen 1  BP!!\n"
 
      drawGoals(1);
      drawGrids(1);
      drawMonths(swo);

      dGl(bp_gl)

      sWo(swo,@showpixmap)
      sWo(allwo,@clipborder,GREEN_)
      }

    sWo(fewos,@redraw)

    sWo(tw_wo,@move,targetday,NextGoalWt,gwo,@redraw);

    CR_init = 1;
    CL_init = 1;

 //sc_startday.pinfo();

}
//=================================================


void showWL(long ws, long we)
{

//<<"$_proc $ws $we\n"

       computeWL( ws, we);

       showCompute();


}
//========================================================



//////////////////////// UTIL PROCS /////////////////////////////

void adjustYear(int updown)
{

// find current mid-year
// decrement - and set rx,RX to jan 1, dec 31 of that year
// then label 1/4 days

   RS=wogetrscales(gwo)

// just plot at mid - the date
   mid_date = (RS[3] - RS[1])/2 + RS[1]

   jd= mid_date +Bday
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

   rx = st_jday - Bday
  rX = ed_jday - Bday

     // rx = st_jday 
    //  rX = ed_jday 

       sc_startday = rx;
       sc_endday = rX;

   sWo(wedwo,@xscales,rx,rX,@savescales,0)

   sWo(swo,@xscales,rx,rX) 

   sWo(gwo,@scales,rx,minWt,rX,upperWt,@savescales,0)

   drawScreens()
}

//////////////////////////////////////////////////////////////////////

void adjustQrt(int updown)
{
// find mid-date 
// adjust to a 90 day resolution
// shift up/down by 30

   RS=wogetrscales(gwo)

// just plot at mid - the date
   mid_date = (RS[3] - RS[1])/2 + RS[1]

   jd= mid_date +Bday
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

   sWo(gwo,@scales,rx,minWt,rX,upperWt,@savescales,0)
 
   sWo(swo,@xscales,rx,rX,@savescales,0)
 
   drawScreens()
}
//========================================================

void showCompute()
{
//<<"$_proc %V $Nsel_exeburn $Nsel_lbs\n"
  sWo(nobswo,@value,Nxy_obs,@update)
  sWo(xtwo,@value,xhrs,@redraw)
  sWo(xbwo,@value,"%6.2f$Nsel_exeburn",@redraw)
  sWo(xlbswo,@value,"%4.1f$Nsel_lbs",@update)
  sWo(dlbswo,@value,"%4.1f$Ndiet_lbs",@update)  
  
}
//========================================================

void showTarget()
{


// target wt and date
//  <<"$_proc $gday $NextGoalWt $last_known_day\n"
  
//  plot(gwo,@symbol,gday,NextGoalWt, "triangle",1, YELLOW_);
//  plot(gwo,@symbol,gday-1,NextGoalWt, 3,1,GREEN_);

  <<"%V $last_known_day $PWT $tday2 $StGoalWt \n"
    plot(gwo,@symbol,tday2,StGoalWt,TRI_,symsz,BLACK_,1);
  plot(gwo,@symbol,gday,NextGoalWt,"diamond",symsz,BLUE_);
  plot(gwo,@symbol,last_known_day,NextGoalWt,DIAMOND_,symsz,RED_,1);
  plot(gwo,@symbol,last_known_day+2,PWT,DIAMOND_,symsz,GREEN_,1);
  plot(gwo,@symbol,last_known_day+8,PWT7,DIAMOND_,symsz,LILAC_,1);
  plot(gwo,@symbol,last_known_day+15,PWT14,DIAMOND_,symsz,PINK_,1);
  

  hlng = (last_known_wt - NextGoalWt) / 0.43; 
  if (hlng  > 0) {
<<"%v $hlng\n"
  plot(gwo,@symbol,last_known_day+hlng,NextGoalWt,"star",symsz, BLUE_);
  plot(gwo,@symbol,last_known_day+hlng,last_known_wt,"cross",symsz,GREEN_);
 // <<"$_proc %v $hlng\n"
  plot(gwo,@symbol,last_known_day+hlng,GoalWt,"star",symsz, RED_);
  plot(gwo,@symbol,last_known_day+hlng,last_known_wt,"cross",symsz,GREEN_);
  }

  sWo(gwo,@showpixmap);
  //plot(gwo,@symbol,targetday,GoalWt,"star",symsz, LILAC_);
//  dGl(gw_gl);

//sc_startday.pinfo();

}
//===========================


void resize_screen()
{

  sWi(vp,@resize,0.05,0.01,0.98,0.98,@redraw)

}


void getDay(long dayv)
{

 long m_day;  // int ?

 float cbm;
 float xtm;
 float wtm;
 int dt;
 str mdy;

    m_day= dayv + Jan1 -1;  // ? OBO

    mdy = julmdy(m_day);


    sWo(dtmwo,@value,mdy,@redraw);
    wtm = 0.0;
     sWo(wtmwo,@value,wtm,@redraw);
     sWo(cbmwo,@value,0,@redraw);
     sWo(xtmwo,@value,0,@redraw);
     sWo(obswo,@value,0,@redraw);
     
     i = dayv -1;

    xtm = EXTV[i]
    wtm  = WTVEC[i]
    cbm  = CALBURN[i]
 
     dt = dayv -Sday;
   //<<"%V $dayv  $Sday $mdy\n"
   //<<"FOUND $i %V $dayv $Sday $dt  $wtm $xtm $cbm\n"

     sWo(obswo,@value,dt+1,@redraw);
     sWo(xtmwo,@value,xtm,@redraw);
     sWo(wtmwo,@value,wtm,@redraw);
     sWo(cbmwo,@value,cbm,@redraw);


}


//[EM]=================================//





//===========//