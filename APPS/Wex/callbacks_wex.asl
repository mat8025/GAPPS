/* 
 *  @script callbacks_wex.asl 
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
//----------------<v_&_v>-------------------------//;                                                                                              

/*
#if CPP
// needed ? -  asl will see this as replacement for drawScreens function
// not as declaration of prototype existing elsewhere in the code
 void drawScreens();
 void showWL(long ws, long we); // CPP
#endif
*/




  void getDay(long dayv)
  {

<<" $_proc   $dayv \n"

  //dayv.pinfo();
  
  long m_day;  // int ?;

  float cbm;

  float xtm;

  float wtm;

  float carb;

  int dt;
  int hit;



  m_day= dayv + Jan1  ;  // ? OBO;

  Str mdy = Julmdy(m_day);
 int dindex = dayv ;
 
<<"%V $dayv $m_day $Jan1 $mdy $dindex\n"


  
  //sWo(dtmwo,_WVALUE2 ,mdy,_WREDRAW );
  woSetValue(dtmwo,mdy);

// day of year is 0 or 1 for Jan1 ?
 

//<<"%V $dindex \n"

  wtm = WTVEC[dindex];
  cbm = CALSBURN[dindex];
  ccon = CALSCON[dindex];
  cexb = EXEBURN[dindex];
  cdef = CALSDEF[dindex];
  xtm = EXTV[dindex];
  carb= CARBSCON[dindex];
  prot= PROTCON[dindex];
  fat = FATCON[dindex];
  fiber = FIBRCON[dindex];
  glu = GLUCOSE[dindex];
  ket = KETONE[dindex];
  gki = GKI[dindex];
  bpm = BPVEC[dindex];
  hit = HITS[dindex];

//<<"%V $xtm \n"
  xtm = fround(xtm,1);
//<<"round %V $xtm \n"  


// ? set the wo up to display float  rather than string
  //  have XGS round the float ?


  woSetValue(wtmwo,"%6.1f$wtm");
  
  woSetValue(calburnwo,"%6.1f$cbm");

  woSetValue(calconwo,"%6.1f$ccon");

  woSetValue(caldwo,"%6.1f$cdef");

  woSetValue(calexbwo,"%6.1f$cexb");

  woSetValue(carbmwo,"%6.1f$carb");

  woSetValue(protmwo,"%6.1f$prot");

  woSetValue(fatmwo,"%6.1f$fat");


  woSetValue(fibmwo,"%6.1f$fiber");

  woSetValue(glumwo,"%6.1f$glu");

   woSetValue(ketmwo,"%6.1f$ket");

  woSetValue(gkimwo,"%6.1f$gki");


  woSetValue(xtmwo,"%6.1f$xtm");

  woSetValue(bpmwo,"%6.1f$bpm");


   woSetValue(hitmwo,"$hit");

for (i= 0; i< 18; i++) { 
   if (mwos[i] <0 ) { 
   break; 
   } 
 
    sWo(_woid,mwos[i],_wredraw,ON_); 
 
  }
  
  sWo(_woid,dtmwo,_wstrvalue ,mdy,_wredraw,1);

  // draw symbols into wo
          msymx = 0.8;
	  msymy = 0.3;
	  msize = 12;
          plotsymbol(wtmwo,DIAMOND_,msymx,msymy,BLUE_,msize);
          plotsymbol(xtmwo,STAR_,msymx,msymy,GREEN_,msize);	  
          plotsymbol(calexbwo,STAR_,msymx,msymy,RED_,msize);
          plotsymbol(caldwo,CROSS_,msymx,msymy,GREEN_,msize);	  
	            plotsymbol(calburnwo,DIAMOND_,msymx,msymy,RED_,msize);
	            plotsymbol(calconwo,TRI_,msymx,msymy,BLUE_,msize);		    

	  plotsymbol(protmwo,DIAMOND_,msymx,msymy,GREEN_,msize);
	  plotsymbol(fibmwo,ITRI_,msymx,msymy,BROWN_,msize,1);
	  plotsymbol(fatmwo,CROSS_,msymx,msymy,BLUE_,msize,1);	  
          plotsymbol(carbmwo,DIAMOND_,msymx, msymy,RED_,msize);
          plotsymbol(glumwo,CROSS_,msymx, msymy,GREEN_,msize);
          plotsymbol(ketmwo,DIAMOND_,msymx, msymy,BLUE_,msize);
          plotsymbol(gkimwo,STAR_,msymx, msymy,ORANGE_,msize);
          plotsymbol(bpmwo,STAR_,msymx, msymy,ORANGE_,msize);
          plotsymbol(hitmwo,DIAMOND_,msymx, msymy,INDIGO_,msize);	  	  	  	  	  
// could add to wo a sym ,x,y for a redraw name_sym box
    


  //  return m_day;
    
  }
//[EM]=================================//



  void adjustQrt(int updown)
  {
// find mid-date 
// adjust to a 90 day resolution
// shift up/down by 30
   int wedwos[] = { wt_wo, cal_wo,  food_wo, carb_wo,-1  };
   float rx,ry,rX,rY;

   RS=wgetrscales(wt_wo);
// just plot at mid - the date

  mid_date = (RS[3] - RS[1])/2 + RS[1];

  jd= mid_date +Bday;

  the_date = Julmdy(jd);

  if (updown > 0) {

  rx = mid_date -30;

  rX = mid_date +60;

  }

  if (updown < 0) {

  rx = mid_date -60;

  rX = mid_date +30;

  }

  sc_startday = rx;

  sc_endday = rX;

  //sWo(wedwos,_wxscales,wpt(rx,rX),_wsavescales,0);

  sWo(_woid,wt_wo,_wscales,wbox(rx,minWt,rX,upperWt),_wsavescales,0);

  sWo(_woid,bpwo,_wxscales,wpt(rx,rX),_wsavescales,0);

  drawScreens();

  }
//========================================================

int ExTim (int wb)
{
<<"$_proc $wb\n"
     return 1
}

 void EXIT()
  {
   << "exit ?\n";
   exit_si();
    // exit_gs();
  }


  void QRTD()
  {
//<<" In $_proc\n"

      adjustQrt(-1);

       showWL(sc_zstart, sc_zend);

  }

  void QRTI()
  {

    adjustQrt(1);

    drawScreens();

     showWL(sc_zstart, sc_zend);

  }
//////////////////////////////////////////////////////////////////////////////////

  void YRD()
  {

  adjustYear(-1);

  drawScreens();

     showWL(sc_zstart, sc_zend);
  }
  
//--------------------------------------------------

  void YRI()
  {

  adjustYear(1);
  }
//--------------------------------------------------

  void QUIT()
  {

  exit_si();

  }
//===================================

  int ZIN(int wb)
  {
  
  //<<" In $_proc  $lcpx  $rcpx\n";
  //cout <<"In ZIN " << lcpx  << endl;
  <<"In ZIN  $ewoname_  $ebutton_   $wb  cursor @ $lcpx \n"      
   sc_zstart = lcpx;

   sc_zend = rcpx;

  <<"In ZIN  $sc_zstart $sc_zend \n"

 // sc_startday = sc_zstart
 // sc_end = sc_zend

   //sWo(wedwos,_wxscales,wpt(sc_zstart,sc_zend),_wsavescales,0);
  sWo(_woid,ket_wo,_wscales,wbox(sc_zstart,0.0, sc_zend,12.5),_wsavescales,1);
      sWo(_woid,food_wo,_wscales,wbox(sc_zstart,-5, sc_zend,120),_wsavescales,0);
   drawScreens();

   showWL(sc_zstart, sc_zend);
   return 1;
  }
//--------------------------------------------------

  int ZOUT(int wb)
  {
 <<"In $_proc  $ewoname_  $ebutton_  $wb   cursor @ $lcpx \n"      

  sc_zstart -= 10;

  sc_zend  += 10;

  if (sc_zstart < sc_startday) {

  sc_zstart =  sc_startday;

  }

  if (sc_zend > sc_end) {

  sc_zend =  sc_end;

  }
  
 // sc_startday = sc_zstart
 // sc_end = sc_zend

   sWo(wedwos,_wxscales,wpt(sc_zstart,sc_zend),_wsavescales,0);
   sWo(_woid,ket_wo,_wscales,wbox(sc_zstart,0.0, sc_zend,12.5),_wsavescales,1);
   sWo(_woid,food_wo,_wscales,wbox(sc_zstart,-5, sc_zend,120),_wsavescales,0);


   drawScreens();

   showWL(sc_zstart, sc_zend);
   return 1;
  }
//---------------------------------------------
int WTLB(int wb)
{

  <<"In WTLB  $ewoname_  $ebutton_     cursor @ $erx_ \n"      
   ans=ask(" $ewoname_  $ebutton_     cursor @ $erx_ ",0)
long wt_day = 0;
 
       if (ebutton_ == 1) {

         lcpx = erx_;

	 sGl(_GLID,lc_gl,_GLHUE,RED_,_GLCURSOR,wbox(lcpx,0,lcpx,300,Wex_CL_init),_GLDRAW,ON_);
	 
	 Wex_CL_init = 0;
	 
	 wt_day = fround(lcpx,0);
	 sel_day = wt_day;

  //wt_day.pinfo();
  //lcpx.pinfo();

<<"%V $wt_day $lcpx \n";

        // mday =getDay(wt_day);
	getDay(wt_day);

        }

       if (ebutton_ == 3) {
       
         rcpx = erx_;

      
	 sGl(_GLID,rc_gl,_GLHUE,BLUE_,_GLCURSOR,wbox(rcpx,0,rcpx,310,Wex_CR_init),_GLDRAW,ON_);
	 
         Wex_CR_init = 0;

       }

    return 1;


}
//=========================================

///    WONAME PROCS ///

  void setGoals()
  {
   <<"SetGoals ??\n"
  }

int FatProtFibr(int wb)
{
<<"In $_proc  $ewoname_  $ebutton_     cursor @ $erx $ery \n"      
 // display x,y
 <<"%V $erx $ery \n"

}
//=========================================
int Carbs(int wb)
{
<<"In $_proc  $ewoname_  $ebutton_     cursor @ $erx $ery \n"      
 // display x,y
 <<"$_proc day $erx  $ery \n"

}
//=========================================
int CALS(int wb)
{
<<"In $_proc  $ewoname_  $ebutton_     cursor @ $erx $ery \n"      
 // display x,y
 <<"$_proc day $erx   $ery \n"

}
//=========================================



void setCursors()
{
<<"$_proc : $_lcpx\n"
        sGl(_GLID,lc_gl,_GLCURSOR, wbox(lcpx,0,lcpx,300));

        sGl(_GLID,rc_gl,_GLCURSOR, wbox(rcpx,0,rcpx,300));
	
}



////////////////////////KEYW CALLBACKS///////////////////////////////////////

 void REDRAW()
  {
   drawScreens();
  }
//-------------------------------------------


  void RESIZE()
  {
   drawScreens();
  }
//-------------------------------------------

  void showWL(long ws, long we)
  {
//<<"$_proc $ws $we\n"

  computeWL( ws, we);

  showCompute();

  }
//========================================================




/*
  void SWITCHSCREEN()
  {
  if (_ename _ == "SWITCHSCREEN") {

  wScreen = atoi(_ewords[1]);
    //<<[_DB]"Setting %V$wScreen msgw[1]\n"

  drawScreens();

  }

  }
*/
///////////////////////////////////////////////////////////////////////////////////////

//==============\_(^-^)_/==================//
