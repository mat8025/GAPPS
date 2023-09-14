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
//----------------<v_&_v>-------------------------//                                                                                                


  void showTarget()
  {
// target wt and date
//  <<"$_proc $gday $NextGoalWt $last_known_day\n"
//  plot(gwo,_Wsymbol,gday,NextGoalWt, TRI_,1, YELLOW_);
//  plot(gwo,_Wsymbol,gday-1,NextGoalWt, 3,1,GREEN_);

  //<<"%V $last_known_day $PWT $PWT7 $PWT14  $tday2 $FirstGoalWt \n";



  
  plotSymbol(wtwo,tday2,FirstGoalWt,TRI_,Symsz,BLACK_,1);



  plotSymbol(wtwo,gday,NextGoalWt,DIAMOND_,Symsz,BLUE_, 1);

  plotSymbol(wtwo,last_known_day,NextGoalWt,DIAMOND_,Symsz,RED_,1);

  plotSymbol(wtwo,last_known_day+2,PWT,DIAMOND_,Symsz,GREEN_,1);

  plotSymbol(wtwo,last_known_day+8,PWT7,DIAMOND_,Symsz,LILAC_,1);

  plotSymbol(wtwo,last_known_day+15,PWT14,DIAMOND_,Symsz,PINK_,1);

  hlng = (last_known_wt - NextGoalWt) / 0.43;

  if (hlng  > 0) {

 // <<"%v $hlng\n";

  plotSymbol(wtwo,last_known_day+hlng,NextGoalWt,STAR_,Symsz, BLUE_);

  plotSymbol(wtwo,last_known_day+hlng,last_known_wt,CROSS_,Symsz,GREEN_);
 // <<"$_proc %v $hlng\n"

  plotSymbol(wtwo,last_known_day+hlng,GoalWt,STAR_,Symsz, RED_);

  plotSymbol(wtwo,last_known_day+hlng,last_known_wt,CROSS_,Symsz,GREEN_);

  }

 sWo(_WOID,wtwo,_WSHOWPIXMAP,ON_);


  //plotSymbol(wtwo,targetday,GoalWt,STAR_,Symsz, LILAC_);
//  dGl(gw_gl);
//sc_startday.pinfo();

  }
//===========================

  void showCompute()
  {


<<"  %V $Nxy_obs $Nsel_exeburn $Nsel_lbs $Ndiet_lbs $xhrs \n"

  //sWo(_WOID,nobswo,_WVALUE,"%d $Nxy_obs",_WUPDATE,ON_) ;// need pex

 sWo(_WOID,nobswo,_WVALUE,Nxy_obs,_WUPDATE,ON_) ;// need pex

  sWo(_WOID,xtwo,_WVALUE,xhrs,_WREDRAW,ON_)

  sWo(_WOID,xbwo,_WVALUE,Nsel_exeburn,_WREDRAW,ON_)

  //sWo(_WOID,xlbswo,_WVALUE,"%4.1f$Nsel_lbs",_WUPDATE,ON_)
  sWo(_WOID,xlbswo,_WVALUE,Nsel_lbs,_WUPDATE,ON_)

  sWo(_WOID,dlbswo,_WVALUE,Ndiet_lbs,_WUPDATE,ON_)

  }
//========================================================

  void drawGoals(int ws)
  {

//<<"drawGoals $ws\n"

  if (ws == 0) {
   // Plot(wtwo,_WBOX,sc_startday,DX_NEW,sc_end,DX_NEW+20, ORANGE_)  // never go above

  plotBox(wtwo,sc_zstart,DX_NEW,sc_zend,DX_NEW+20, RED_, FILL_)  

  plotBox(wtwo,sc_zstart,DX_MEW,sc_zend,DX_NEW, ORANGE_, FILL_)  

  plotBox(wtwo,sc_zstart,GoalWt-5,sc_zend,GoalWt+5, LIGHTGREEN_,FILL_)  //
    //Plot(calwo,_WLINE,sc_startday,day_burn,sc_end,day_burn, GREEN_)

  plotLine(calwo,sc_zstart,day_burn,sc_zend,day_burn, GREEN_)
//<<"plotLine calwo $sc_zstart $day_burn \n"
  plotLine(calwo,sc_startday,out_cal,sc_end,out_cal, BLUE_)

  plotLine(calwo,sc_startday,in_cal,sc_end,in_cal, RED_)

  plotLine(calwo,sc_startday,50,sc_end,50, GREEN_)

    plotLine(carbwo,sc_startday,30,sc_end,30, RED_)
  
    // use todays date and wt to the intermediate short-term goal

  plotLine(wtwo,last_known_day,last_known_wt,tday2,FirstGoalWt, RED_) 
//<<"plotLine $wtwo $last_known_day $last_known_wt $tday2 \n"
  }

  if (ws == 1) {

  //<<[_DB]"$ws $swo $kdays \n"

  plotLine(swo,0,150,kdays-10,250, BLUE_)

  }
//<<"Done drawGoals \n"
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

int match[2]


  int sd

  int k

  int yd

  int wd

  int wm = 0

  float lty = 0
//  Str wday = "Mon"
  
  float qfwd = 0.0

  RS=wgetrscales(wwo)
// just plot at mid - the date

  mid_date = (RS[3] - RS[1])/2 + RS[1]

  float q1_date = (RS[3] - RS[1])/4 + RS[1]

  float q3_date = 3*(RS[3] - RS[1])/4 + RS[1]

  long jd= mid_date +Bday

//  the_date = julmdy("$jd")
   the_date = Julmdy(jd)

   // use mondays as the date tick


   //AxText(wwo, 1, the_date, mid_date, -0.25, BLUE_)

  jd= RS[1] + Jan1

  the_date = Julmdy(jd)
  
  Str mday = spat(the_date, "/",-1,-1, match)
  
 // AxText(wwo, 1, mday, q1_date, -0.25, BLUE_)

  float wdate = RS[1]

  sWo(_WOID,wwo,_WFONT,"small")
 //  AxText(wwo, 1, the_date, wdate, 0.25, BLUE_)

  int draw_months =1

  int mon = (jd +1) % 7

  mon = 2 -mon
  jd -= mon
  wdate -= mon
  
  while (draw_months <= 12) {

  jd += 7

  wdate += 7

  if (wdate >= RS[3]) {

     break

  }

  the_date = Julmdy(jd)

 //wday = Julday(jd)
  
 // Str mday = spat(the_date, (char *)"/",-1,-1, match)
  mday = spat(the_date, "/",-1,-1, match)

 // axisLabel(wwo, 1, mday, wdate, 0.7, BLUE_)
  AxText(wwo, 1, mday, wdate, -0.25, MAGENTA_)
  
//   <<"%V $jd $wdate $RS[3] $the_date $mday $wday\n"

  draw_months++

  }

  }
//---------------------------------------------------------------

  void  drawGrids(int  ws )
  {
    int i,j

//<<"drawGrids ws  $ws \n"

  if (ws == 0) {

  //sWo({extwo,calwo,wtwo},_WFONT,"small")

  //sWo(extwo,_WFONT,"small",_WEO) // check font can accept a int or char *


  sWo(_WOID,carbwo,_WAXNUM,AXIS_LEFT_)

  sWo(_WOID,carbwo,_WYSCALES,wpt(-5,carb_upper),_WSAVESCALES,0)

  sWo(_WOID,calwo,_WUSESCALES,0,_WAXNUM,  AXIS_LEFT_)
//  sWo(carbwo,_WAXNUM,2)

  sWo(_WOID,extwo,_WYSCALES,wpt(0,upperWt),_WSAVESCALES,1)

  sWo(_WOID,extwo,_WAXNUM,AXIS_LEFT_)

  sWo(_WOID,wtwo,_WYSCALES,wpt(160,220))

    sWo(_WOID,wtwo,_WAXNUM,AXIS_LEFT_)


  //sWo(extwo,_WAXNUM,2,0,sc_endday,20,10)
  //Text(wtwo, "Weight (lbs)",0.1,1.0,RED_,0,0,2)

 // axisLabel(wtwo,AXIS_BOTTOM_,"Weight (lbs)",0.5,1.7)

 // axisLabel(calwo,AXIS_BOTTOM_,"Calories",0.5,1.7)
   //axisLabel(extwo,AXIS_LEFT_,"Exercise Time (mins)",0.1,0.7) // TBF

 // axisLabel(extwo,AXIS_LEFT_,"Mins",0.1,4.0) // TBF

 // axisLabel(carbwo,AXIS_LEFT_,"Carbs",0.1,4)
 

  }

  else {

  //axnum(swo,2)
  //sWo(swo,_WAXNUM,2,150,bp_upper,50,10)

  //sWo(xwo,_WCLIPBORDER,BLACK_,_WSAVE,_WEO)

  }
  
  int allwo[] = {wtwo,swo, calwo,  extwo , carbwo,-1}
  //<<" $allwo \n"
  
    for (i = 0; i< 10; i++) {
    //  <<" $i $allwo[i]\n"
     if (allwo[i] <=0) {
         break;
      }
      
      sWo(_WOID,allwo[i],_WSHOWPIXMAP,ON_,_WSAVE,ON_,_WCLIPBORDER,BLACK_)

    }
//<<"Done drawgrids\n"
}
//---------------------------------------------------------------------------------
#define ALL_LINES 1

  void drawScreens()
  {
  int i,j


//<<" $_proc \n"


<<"%V $sc_startday  $sc_end \n";


// sc_startday.pinfo()
 //sc_startday = (jtoday - Bday) - 20;
//<<"RESET? %V $sc_startday  $sc_end \n"


int wedwos[] = { wtwo, calwo,  carbwo, extwo,-1  }

//  Str ans;

//<<" $wedwos\n";

//<<" $wedwos[2]\n";



  if ( wScreen == 0) {

//<<"%V $sc_zstart $minWt $sc_zend $upperWt\n";

// sWo(wtwo,_WSCALES,wbox(rx,minWt,rX,upperWt),_WSAVESCALES,0,_WFLUSH);



       for (i = 0; i< 5; i++) {

      if (wedwos[i] <=0) {
         break;
	 }

       sWo(_WOID,wedwos[i],_WXSCALES, wpt(sc_zstart,sc_zend));


        sWo(_WOID,wedwos[i],_WCLEARCLIP,WHITE_,_WSAVE,ON_,_WCLEARPIXMAP,ON_,_WCLIPBORDER,BLACK_,_WREDRAW,ON_,_WSAVEPIXMAP,ON_);

//<<"wedwos[ $i ] $wedwos[i]\n"
}

  drawGoals( wScreen);

  drawGrids( wScreen);

 //sWo(wtwo,_WCLEARCLIP,CYAN_,_WSAVE,_WCLEARPIXMAP,_WCLIPBORDER,BLACK_,_WFLUSH);
// sWo(calwo,_WCLEARCLIP,YELLOW_,_WSAVE,_WCLEARPIXMAP,_WCLIPBORDER,BLACK_,_WFLUSH);
// sWo(wtwo,_WSCALES,wbox(sc_startday,150,sc_end,220),_WFLUSH);
 
  if (ALL_LINES) {

 //<<" draw all lines \n";

  //dGl(exgls);
      //dGl(cardio_gl);
      //dGl(strength_gl);

  sWo(_WOID,calwo,_WFONT,F_SMALL_);
      /// these need to be a separate wo to contain key  symbol and text
     // plot(calwo,_Wkeysymbol,0.78 ,0.9,DIAMOND_,Symsz,BLUE_,1);

      //Text(calwo,"Calories Burnt", 0.8,0.9,1)      

 // plotSymbol(calwo,_WKEYSYMBOL,wpt(0.78 ,0.8),DIAMOND_,Symsz,RED_,1);

//  sWo(_WOID,calwo,_WTEXTR,"Calories Ate", wpt(0.8,0.82),1,0,BLACK_);

    //Text(calwo,"Calories Ate", 0.8,0.82,1,0,BLACK_);


     // plot(calwo,_Wkeysymbol,0.78 ,0.7,TRI_,Symsz,RED_,1,_Wfonthue,WHITE_);      
      //Text(calwo,"Carbs Ate", 0.8,0.72,1)

  sWo(_WOID,extwo,_WFONT,F_SMALL_);

//plot(extwo,_Wkeysymbol,0.78,0.7,TRI_,Symsz,GREEN_,1);



//  sWo(_WOID,extwo,"Exercise Time (mins)",wpt( 0.8,0.7),1,0,RED_);
  // Text(extwo,"Exercise Time (mins)",0.8,0.7,1,0, LILAC_);

  int allgls[] = { wt_gl,  ext_gl, carb_gl,  fiber_gl,  fat_gl,  prot_gl,  calc_gl,  calb_gl,   -1}

  int foodgls[] = { carb_gl, fiber_gl,fat_gl, prot_gl, -1 }

  int calgls[] = { calb_gl, calc_gl, -1,-2 }

   // <<"%V $calc_gl $calb_gl $calgls  \n"
   // int allgls[] = {wt_gl2,wt_gl, wt_gl3,-1};

   int gi=0


 do_all_gls = 1;

  if (do_all_gls) {
  
  while ( 1) {

   //<<"%V $gi $allgls[gi] \n"

  sGl(_GLID,allgls[gi],_GLDRAW,ON_)
//ans=query(<<" gi $gi ?");  
  gi++

    if (allgls[gi] < 0)  {
             break;
    }
    
   if (gi > 7) {
     break;
   }
  }


  for (i = 0; i< 5; i++) {
//<<"wedwos[ $i ] $wedwos[i]\n"
   if (wedwos[i] <=0) {
         break;
	 }

     sWo(_WOID,wedwos[i],_WCLIPBORDER,BLACK_,_WPIXMAP,ON_,_WSAVEPIXMAP,ON_)
     // sWo(_WOID,wedwos[i],_WSHOWPIXMAP,ON_,_WCLIPBORDER,BLACK_);
   }


 }





//ans=query("proceed?");

  int allwo[] = {wtwo, swo, calwo,  extwo , carbwo,-1};
 // int allwo[] = {gwo,-1};
   
   
  drawMonths(wtwo)

  drawMonths(calwo)

  drawMonths(carbwo)

  drawMonths(extwo)
      //Text(extwo,"Exercise mins",-4,0.5,4,-90)
      //Text(wtwo,  "Weight (lbs)",0.8,0.8,1)
       //dGl(wt_gl)
       //dGl(wt_gl)

     showTarget()

   for (i = 0; i< 5; i++) {
        if (wedwos[i] <=0) {
         break;
	 }

     // sWo(_WOID,wedwos[i],_WCLIPBORDER,BLACK_,_WPIXMAP,ON_,_WREDRAW,ON_,_WSAVEPIXMAP,ON_);
     // sWo(_WOID,wedwos[i],_WCLIPBORDER,BLACK_,_WREDRAW,ON_);
     // sWo(_WOID,wedwos[i],_WSHOWPIXMAP,ON_,_WCLIPBORDER,BLACK_);
   }


 woSetValue(nobswo, Nobs)
 
 sWo(_WOID,nobswo,_WREDRAW,ON_)
  // <<"KEYS?\n"

////////////////////////////////////////// KEYS /////////////////////////////////////
int keypos[10]

//  keypos = woGetPosition (keycalwo)

    woGetPosition (keycalwo,keypos)


    sWo(_WOID,calwo,_WSHOWPIXMAP,ON_,_WCLIPBORDER,BLACK_)

    sWo(_WOID,keycalwo,_WSCALES,wbox(0.0,0.0,1.0,1.0))
    sWo(_WOID,keycalwo,_WCLIPBORDER,ON_,_WREDRAW,ON_,_WKEYGLINE,calgls)
    
    sWo(_WOID,carbwo,_WSHOWPIXMAP,ON_,_WCLIPBORDER,BLACK_)

  //womove(keywo,PANLEFT_,10);
    sWo(_WOID,carbwo,_WSHOWPIXMAP,ON_,_WCLIPBORDER,BLACK_)

   woGetPosition (keywo,keypos)

   sWo(_WOID,keywo,_WSCALES,wbox(0.0,0.0,1.0,1.0))
   sWo(_WOID,keywo,_WCLIPBORDER,ON_,_WREDRAW,ON_,_WKEYGLINE,foodgls)

  //keypos = woGetPosition (keywo)


//<<" $keypos \n";

<<"DONE draw \n"

}

  if ( wScreen == 1) {

 // <<[_DB]" Drawscreen 1  BP!!\n";

  drawGoals(1)

  drawGrids(1)

  drawMonths(swo)

  sGl(_GLID,bp_gl,_GLDRAW,ON_)  

  sWo(_WOID,swo,_WSHOWPIXMAP,1)

  //sWo(allwo,_WCLIPBORDER,GREEN_);



  }

  //sWo(fewos,_WREDRAW);

 // sWo(tw_wo,_WMOVE,wpt(targetday,NextGoalWt),wtwo,_WREDRAW); // ?? parent wo
  showCompute()
  Wex_CR_init = 1
  Wex_CL_init = 1
  sWo(_WOID,zoomwo,_WSTYLE,WO_SVB_,_WREDRAW,ON_);
  sWo(_WOID,zinwo,_WSTYLE,WO_SVB_,_WREDRAW,ON_);

 int xwos[] = { nobswo, xtwo, xbwo, xlbswo, dlbswo ,-1};
 for (i= 0; i< 10; i++) {

     if (xwos[i] <0 ){
      break
     }
//   <<"$i SVB for $xwos[i] \n"
     sWo(_WOID,xwos[i],_WSTYLE,WO_SVB_,_WREDRAW,ON_);

  }

 //sc_startday.pinfo();
//  <<"Done drawScreens\n";
  }
  
 }
 
//=================================================
void showWL(int ws, int we)
  {
//<<"$_proc $ws $we\n"
//<<"showWL int $ws $we\n"
  computeWL( ws, we)

  showCompute()

  }
//====
  void showWL(long ws, long we)
  {

//<<"showWL long  $ws $we\n"

  computeWL( ws, we)

  showCompute()

  }
//========================================================
//////////////////////// UTIL PROCS /////////////////////////////

  void adjustYear(int updown)
  {
// find current mid-year
// decrement - and set rx,RX to jan 1, dec 31 of that year
// then label 1/4 days
  int i,j
  int wedwos[] = { wtwo, calwo,  carbwo, extwo,-1  }
  double rx,ry,rX,rY
  RS=wgetrscales(wtwo);
// just plot at mid - the date

  mid_date = (RS[3] - RS[1])/2 + RS[1]

  jd= mid_date +Bday

  the_date = Julmdy(jd)
   // which year?

 // Str yrs = sele(the_date,-4,4);
  Str yrs = the_date(-4,-1,1)

  long yrd = atoi(yrs)
//<<[_DB]"%V$jd $the_date $yrs $yrd \n"
//<<"%V$jd $the_date $yrs $yrd \n"

  if (updown > 0) {

  yrd++

  }

  if (updown < 0) {

  yrd--

  }
//<<"%V  $yrd \n"

  long st_jday = Julian("01/01/$yrd");

  long ed_jday = Julian("12/31/$yrd");
  //<<"%V  $yrd  $st_jday $ed_jday\n"

  rx = st_jday - Bday;

  rX = ed_jday - Bday;
     // rx = st_jday 
    //  rX = ed_jday 

  sc_startday = rx

  sc_endday = rX
  for (i = 0; i< 5; i++) {

//<<"wedwos[ $i ] $wedwos[i]\n"
   if (wedwos[i] <=0) {
         break;
    }
  sWo(_WOID,wedwos[i],_WXSCALES,wpt(rx,rX),_WSAVESCALES,0)
  }
  sWo(_WOID,swo,_WXSCALES,wpt(rx,rX))

  sWo(_WOID,wtwo,_WSCALES,wbox(rx,minWt,rX,upperWt),_WSAVESCALES,0)

  drawScreens()

  }
//////////////////////////////////////////////////////////////////////



  void resize_screen()
  {

   // sWi(_WOID,vp,_WRESIZE,wbox(0.05,0.01,0.98,0.98),_WREDRAW,ON_)

  }
  
 //[EP]/////////////////////////////////////////////// 

  void getDay(long dayv)
//  long getDay(long dayv)
  {



  
  
  long m_day  // int ?;

  float cbm

  float xtm

  float wtm

  float carb

  float fiber
  float fat
  float prot

  int dt






  m_day= dayv + Jan1 -1  // ? OBO;

  Str mdy = Julmdy(m_day)
 int dindex = dayv -1
 
<<"%V $dayv $m_day $Jan1 $mdy $dindex\n"

  int calsin =  CALSCON[dindex]
  int calsout =  CALBURN[dindex]  
  //sWo(dtmwo,_WVALUE2 ,mdy,_WREDRAW );
  woSetValue(dtmwo,mdy)

// day of year is 0 or 1 for Jan1 ?
  fiber = FIBRCON[dindex]
 
  prot = PROTCON[dindex]

  fat = FATCON[dindex]
 
//<<"%V $dindex \n"

  wtm = WTVEC[dindex]
  cbm = CALBURN[dindex]
  xtm = EXTV[dindex]
  carb= CARBSCON[dindex]
//<<"%V $xtm \n"
  xtm = fround(xtm,1)
//<<"round %V $xtm \n"  


// ? set the wo up to display float  rather than string
  //  have XGS round the float ?
/*

  woSetValue(wtmwo,"$wtm")
  
  woSetValue(cbmwo,"$cbm")

  woSetValue(carbewo,carb)

  woSetValue(xtmwo,xtm)

  sWo(_WOID,cbmwo,_WREDRAW,1)
  sWo(_WOID,wtmwo,_WREDRAW,1)
  sWo(_WOID,xtmwo,_WREDRAW,1)
  sWo(_WOID,carbewo,_WREDRAW,1)
  
  sWo(_WOID,dtmwo,_WSTRVALUE ,mdy,_WREDRAW,1)
*/
// pex 

<<"Exercise time %6.1f $xtm   \n"

//cffp =vex(" %6.2f CARB $carb FIBER $fiber FAT $fat PROT $prot (g) ")

//<<"$cffp\n"

 Text(extwo,vex("Exercise time %6.1f $xtm   "),0.1,0.87)

//Text(extwo, vex(" Exercise time  $xtm   ") ,0.1,0.87)

// vex to translate to   to cpp version vex("Ex time %f",xtm)

//Text(carbwo,vex(" %6.2f CARB $carb FIBER $fiber FAT $fat PROT $prot (g) "),0.1,0.89)

Text(carbwo," %6.2f CARB $carb FIBER $fiber FAT $fat PROT $prot (g) ",0.4,0.89)

//Text(calwo,vex("CALS IN $calsin OUT $calsout "),0.1,0.89)

Text(wtwo,vex(" $mdy Weight  %6.1f  $wtm lbs   "),0.1,0.89)

<<"$mdy Weight  %6.1f  $wtm lbs   \n"

Text(wtwo," $mdy Weight  %6.1f  $wtm lbs   ",0.3,0.89)

  //  return m_day;
    
  }
//[EM]=================================//


//==============\_(^-^)_/==================//
