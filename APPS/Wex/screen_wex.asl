/*  
 *  @script screen_wex.asl  
 *  
 *  @comment   
 *  @release CARBON  
 *  @vers 1.5 B 6.3.78 C-Li-Pt  
 *  @date 01/31/2022 08:58:38           
 *  @cdate Sun Dec 23 09:22:34 2018  
 *  @author Mark Terry  
 *  @Copyright © RootMeanSquare 2022 
 *  
 */  
//----------------<v_&_v>-------------------------//                                                                                                 
 
  
   
//////////////////  WED SCREEN --- WINDOWS //////////////// 
//ans=query("graphic?\n") 
int  do_keys = 0
 
  

//============================== 
 
here = 1; 
 
  Str vptitle = "Wex_V$Wex_Vers"; 

 ans = ask("$Wex_Vers    <|$vptitle|> ",0) 
 
 //wdb= DBaction(DBSTEP_,1)  // TBF 8/11/24 not stepping 
 
   vp =  cWi(vptitle); 
  
  sWi(_woid,vp,_wresize,wbox(0.01,0.05,0.90,0.95,0)  ); 
 
  sWi(_woid,vp,_wclip,wbox(0.1,0.05,0.9,0.95),_wpixmap,ON_,  _wredraw,ON_,_wsave,ON_,_wsavepixmap,ON_); 
 
//ans = ask("$(here++) $vp",1) 
 
  vp1 = cWi("XED"); 
 
  sWi(_woid,vp1,_wresize,wbox(0.01,0.05,0.90,0.95,1)  ); 
 
  sWi(_woid,vp1,_wclip,wbox(0.1,0.05,0.85,0.95),  _wredraw,ON_); 
 
 

cout<<"  titleButtonsQRD(vp);\n"; 
 
  titleButtonsQRD(vp); 
 
  int allwin[] = {vp,vp1,-1}; 
 
//ans = ask("$(here++)",1) 
 
  sWi(_woid,vp,_wdraw,ON_,_wpixmap,ON_,_wsave,ON_,_wbhue,WHITE_); 
 
  sWi(_woid,vp1,_wdraw,ON_,_wpixmap,ON_,_wsave,ON_,_wbhue,WHITE_); 
 
  Wex_CL_init = 1; 
 
  Wex_CR_init = 1; 
 
  cout<<"Wins done\n"; 
////////////////  WOBS /////////////// 
 
 
  wt_wo=cWo(vp,WO_GRAPH_); 
 
  sWo(_woid,wt_wo,_wname,"WTLB",_wvalue,0,_wclipborder,YELLOW_,_wpixmap,ON_); //   weight; 
 
  cal_wo=cWo(vp,WO_GRAPH_); 
 
   sWo(_woid,cal_wo,_wname,"CALS",_wvalue,0,_wclipborder,BLACK_,_wpixmap,ON_,_wdraw,ON_) ; // cals; 
 
  food_wo=cWo(vp,WO_GRAPH_); 
   
  sWo(_woid,food_wo,_wname,"FatProtFibr",_wvalue,0,_wclipborder,BLACK_,_wpixmap,ON_) ; // fat prtien fibre 
 
  carb_wo=cWo(vp,WO_GRAPH_); 
   
  sWo(_woid,carb_wo,_wname,"Carbs",_wvalue,0,_wclipborder,RED_,_wpixmap,ON_); // carbs
 
  int wedwos[] = { wt_wo, cal_wo,  food_wo, carb_wo,-1  }; 
//<<[_DB]"%V$wedwo \n" 
 
  cout<<" vtile before set clip!\n";   // _ASL_ defines cout as NOP
 
  wovtile(wedwos,0.1,0.08,0.99,0.99)   ; // vertically tile the drawing areas into the main window; 
    //cx = 0.05 ; cX = 0.95 ; cy = 0.2 ; cY = 0.97; 
 
 
 
 
 
  float CXY[4] = { 0.05 ,0.2,0.95 ,0.97}; 
//<<"%V$CXY\n" 
 
   
cout <<"aftertitleButtons\n"; 
 //////////////////////////////// TITLE BUTTON QUIT //////////////////////////////////////////////// 
//<<"after proc - next statement missed? \n" // MUST FIX 
 
//ans=query("?#?"); 
 
  sc_end = sc_endday+10; 
 
  sc_zend = sc_end;   // for zooming; 
 
  sc_zstart = sc_startday; 
 
<<"%V $sc_startday $sc_endday $sc_end \n"; 
COUT(sc_zstart); 
 //  _WFONT arg wfont(char*) wfont(int) ---  
 
  sWo(_woid,food_wo,_wclip,CXY,_wcolor,WHITE_,_wclipbhue,WHITE_,_wbhue,WHITE_,_wfont,F_SMALL_,_wredraw,ON_,_wsavepixmap,ON_); 
 
 
 // sWo(food_wo,_wclip,CXY,_wcolor,WHITE_,_wclipbhue,RED_,_wbhue,RED_  ,_wfont,F_SMALL_,_wfonthue,WHITE_,_WEO); 
  sWo(_woid,cal_wo,_wclip,CXY,_wcolor,WHITE_,_wclipbhue,WHITE_,_wbhue,WHITE_  ,_wfont,F_SMALL_,_wredraw,ON_,_wsavepixmap,ON_); 
 
  sWo(_woid,carb_wo,_wclip,CXY,_wcolor,YELLOW_,_wclipbhue,GREEN_,_wbhue,YELLOW_,_wfont,F_SMALL_,_wredraw,ON_,_wsavepixmap,ON_); 
 
  sWo(_woid,wt_wo,_wclip,CXY,_wcolor,ORANGE_,_wclipbhue,WHITE_,_wbhue,WHITE_,_wfont,F_SMALL_,_wredraw,ON_,_wsavepixmap,ON_); 
 
  //sWo(_WOID,wt_wo,_WRHTSCALES,wbox(rx,0,rX,300),_WSAVESCALES,1);
 // sWo(_WOID,cal_wo,_WRHTSCALES,wbox(sc_startday,0.0, sc_end,300.0,0));
//  ok =ask("RHTSCALES ?",1)
// margin codes ?
//!b


 
  COUT(sc_end); 
 
  sWo(_woid,carb_wo,_wscales,wbox(sc_startday,-5,sc_end,200),_wsavescales,0); 
 
//cout <<"SCALES " << sc_startday << " sc_end " <<sc_end << endl; 
 
//ans=query("Scales ?"); 
 
//  sWo(carb_wo,_wsavescales,0,_WEO); 
 
  sWo(_woid,cal_wo,_wscales,wbox(sc_startday,-1000,sc_end,CalsY1),_wsavescales,0);
  

 
  COUT(cal_wo); 
 
 
  swo= cWo(vp1,WO_GRAPH_); 
 
 
//  sWo(swo,_wname,"BenchPress",_wcolor,WHITE_,_WEO); 
 
COUT(swo); 
  int swos[] = { swo,-1 }; 
 
//  wovtile(swos,0.01,0.05,0.97,0.97)   ; // vertically tile the drawing areas into the main window; 
 
//  sWo(swos[0],_wclip,CXY,_wcolor,WHITE_,_wclipborder,BLACK_,_WEO); 
///  measurement 
 
  tw_wo= cWo(wt_wo,WO_BS_); 
   
  sWo(_woid,tw_wo,_wresize,wbox(0.1,0.1,0.15,0.25,0),_wname,"TW",_wvalue,"175"); 
 
  COUT(tw_wo); 
 
//////////////////////////// SCALES ////////////////////////////////////////// 
//<<[_DB]" Days $k \n" 
 
  float bp_upper = 400.0; 
 
  float wt_upper = 205; 
 
  sWo(_woid,swo,_wscales,wbox(sc_startday,110,sc_end,bp_upper)); 
 
  cout<<"scales " << sc_startday << " sc_end " << sc_end << " bp_upper " << bp_upper << endl; 
  //<<"SCALES %V$sc_startday $sc_endday $bp_upper\n"; 
 
  sWo(_woid,food_wo,_wscales,wbox(sc_startday,-5,sc_end,120)); 
 
  //<<"SCALES %V$sc_startday $sc_endday $carb_upper\n"; 
 
  sWo(_woid,wt_wo,_wscales,wbox(sc_startday,minWt,sc_end,upperWt)); 
 
 
  int allwo[] = {wt_wo, cal_wo,  carb_wo , food_wo,swo,-1}; 

  <<"%V $allwo \n" 
 
 
   
//sleep(0.2) 
/////////////////////////////////////////////////////////// 
  //quitwo=cWo(vp,WO_BN,_wname,"QUIT",_wcolor,"red") 
 
  zinwo=cWo(vp,WO_BN_); 
   
  sWo(_woid,zinwo,_wname,"ZIN",_wcolor,PINK_,_whelp," zoom in on selected days "); 
 
  zoomwo=cWo(vp,WO_BN_); 
  sWo(_woid,zoomwo,_wname,"ZOUT",_wcolor,BLUE_); 
 // yrdecwo= cWo(vp,WO_BN,_wname,"YRD",_wcolor,"violetred",_whelp," show previous Year  ") 
//  yrincwo= cWo(vp,WO_BN,_wname,"YRI",_wcolor,"purple",_whelp," show next Year  ") 
//  qrtdwo=  cWo(vp,WO_BN,_wname,"QRTD",_wcolor,"violetred",_whelp," show previous Qtr period ") 
//  qrtiwo=  cWo(vp,WO_BN,_wname,"QRTI",_wcolor,"purple",_whelp," show next Qtr period ") 
 // int fewos[] = {zinwo,zoomwo, yrdecwo, yrincwo, qrtdwo, qrtiwo } 
 
  int fewos[] = {zinwo,zoomwo, -1 }; 
 
  //pa(fewos); 
 
  wohtile( fewos, 0.03,0.01,0.43,0.07); 
 
  nobswo= cWo(vp,WO_BV_); 
   
  sWo(_woid,nobswo,_wname,"Nobs",_wclipbhue,CYAN_,_wvalue,0,_wstyle,SVB_); 
 
  xtwo= cWo(vp,WO_BV_); 
  sWo(_woid,xtwo,  _wname,"xTime",_wclipbhue,ORANGE_,_wvalue,0); 
 
  xbwo= cWo(vp,WO_BV_); 
  sWo(_woid,xbwo,_wname,"xBurn",_wclipbhue,GREEN_     ,_wvalue,0); 
 
  xlbswo= cWo(vp,WO_BV_); 
  sWo(_woid,xlbswo,_wname,"xLbs",_wcolor,BLUE_ ); 
 
  dlbswo= cWo(vp,WO_BV_); 
 
 sWo(_woid,dlbswo,_wname,"dLbs",_wclipbhue,YELLOW_,_wvalue,0); 
 
  int xwos[] = { nobswo, xtwo, xbwo, xlbswo, dlbswo ,-1}; 
 
  wohtile( xwos, 0.45,0.01,0.83,0.07); 
 
 for (i= 0; i< 10; i++) { 
 
     if (xwos[i] <0 ){ 
      break; 
     } 
//   <<"$i SVB for $xwos[i] \n" 
     sWo(_woid,xwos[i],_wstyle,WS_SVB_,_wredraw,ON_); 
 
  } 
   
   //sWo(xwos,_wstyle,WS_SVB,_wredraw,_WEO); 
 
   sWo(_woid,wt_wo,_wshowpixmap,ON_,_wsave,ON_); 
 
 // sWo(cal_wo,_wshowpixmap,_wsave,_WEO); 
  //sleep(0.1) 
  // Measure WOBS 
 
  dtmwo=cWo(vp,WO_BV_); 
  sWo(_woid,dtmwo,_wname,"DAY",_wclipbhue,RED_,_whelp," date on day "); 
 
 // obswo=cWo(vp,WO_BV_); 
//  sWo(_woid,obswo,_wname,"OBS",_wclipbhue,YELLOW_,_whelp," obs day "); 
 
  wtmwo=cWo(vp,WO_BV_); 
  sWo(_woid,wtmwo,_wname,"WTM",_wclipbhue,RED_,_whelp," wt on day "); 
 
  calburnwo=cWo(vp,WO_BV_); 

  sWo(_woid,calburnwo,_wname,"CBURN",_wclipbhue,CYAN_,_wfonthue,BLACK_,_whelp," cals burnt on day "); 


  calconwo=cWo(vp,WO_BV_); 
   
  sWo(_woid,calconwo,_wname,"CCON",_wclipbhue,CYAN_,_wfonthue,BLACK_,_whelp," cals consumed on day ");
 
  carbewo=cWo(vp,WO_BV_); 
   
  sWo(_woid,carbewo,_wname,"CARB",_wclipbhue,RED_,_wfonthue,BLACK_,_whelp," carbs eaten on day "); 

  protewo=cWo(vp,WO_BV_); 
   
  sWo(_woid,protewo,_wname,"PROT",_wclipbhue,GREEN_,_wfonthue,BLACK_,_whelp," protein eaten on day ");

  fatewo=cWo(vp,WO_BV_); 
   
  sWo(_woid,fatewo,_wname,"FAT",_wclipbhue,BLUE_,_wfonthue,WHITE_,_whelp," fat eaten on day ");

  fibewo=cWo(vp,WO_BV_); 
   
  sWo(_woid,fibewo,_wname,"FIBER",_wclipbhue,BROWN_,_wfonthue,BLACK_,_whelp," fiber eaten on day "); 
 
 
  xtmwo=cWo(vp,WO_BV_); 
  sWo(_woid,xtmwo,_wname,"ExTim",_wcolor,BLUE_,_whelp," xtime on day "); 
 
  int mwos[] = { dtmwo, wtmwo, calburnwo, calconwo, xtmwo, carbewo, protewo, fatewo, fibewo, -1}; 
 
   
  wovtile( mwos, 0.01,0.4,0.085,0.9); 
 
  for (i= 0; i< 10; i++) { 
   if (mwos[i] <0 ) { 
   break; 
   } 
 
    sWo(_woid,mwos[i],_wstyle,SVB_,_wredraw,ON_); 
 
  } 
 
                                                                                

 
/////////////////////////////////////////////  KEYS /////////////////////////////////////////// 
  //  keypos = wogetposition (food_wo); 
 //  <<"%V $keypos \n"; 
 
 float keyposr[10]; 
 
if (do_keys ) { 
    keyret = wogetrxy (cal_wo,keyposr); 
    krx= keyposr[1]; 
    kry= keyposr[2]; 
   
    
    keycal_wo=cWo(vp,WO_BV_); 
    kcalx = keyposr[3] - 0.1; 
    kcalY= keyposr[4]-0.05; 
   sWo(_woid,keycal_wo,_wname,"KeyCals",_wclip,CXY,_wstyle,SVO_) 
 
   sWo(_woid,keycal_wo,_wresize,wbox(kcalx+0.02,kry+0.01,kcalx+0.09,kcalY,0),_wclipborder,ON_,_wredraw,ON_); 
 
  //  sWo(_woid,keycal_wo,_wresize,wbox(kcalx+0.03,kry+0.01,kcalx+0.11,keyposr[4]-0.05,0),_wpixmap,ON_,_wredraw,ON_); 
 
    keyret = wogetrxy (food_wo,keyposr); 
 
    keyposr.pinfo(); 
 
    krx= keyposr[1]; 
    kry= keyposr[2]; 
   
     
 
    keywo=cWo(vp,WO_BV_); 
    kcarbx = keyposr[3] - 0.11; 
    sWo(_woid,keywo,_wname,"KeyFood",_wstyle,SVO_,_wresize,wbox(kcarbx+0.02,kry+0.01,kcarbx+0.09,kcalY,0),_wclipborder,ON_,_wredraw,ON_); 
 
} 
 
 
//  Goal WOBS 
/* 
  sdwo=cWo(vp,WO_BV_); 
  sWo(_woid,sdwo,_wname,"StartDay",_wclipbhue,RED_,_wvalue,"$Goals[0]",_whelp,"   startday "); 
 
  gdwo=cWo(vp,WO_BV_); 
  sWo(_woid,gdwo,_wname,"GoalDay",_wclipbhue,ORANGE_,_wvalue,"$Goals[1]",_whelp," goalday "); 
 
  gwt_wo=cWo(vp,WO_BV_); 
  sWo(_woid,gwt_wo,_wname,"WtGoal",_wvalue,"$Goals[2]",_wclipbhue,BLUE_,_wfonthue,WHITE_,_whelp," next goal wt "); 
 
  int  goalwos[5] = { sdwo, gdwo, gwt_wo, -1}; 
 
  wovtile( goalwos, 0.02,0.1,0.08,0.45 ); 
  i = 0; 
  int kgoals = 0; 
   while (goalwos[i] >= 0)  { 
     sWo(_woid,goalwos[i],_wredraw,ON_); 
      i++; 
  } 
*/ 
 
  //sWo(goalwos,_wstyle,WS_SVB,_wredraw,_WEO); 
int zoomwos[] = {zoomwo, zinwo, -1}; 
 
// sWo(zoomwos,_wstyle,WS_SVB,_wredraw,_WEO); 
 
sWo(_woid,zoomwo,_wstyle,WS_SVB_,_wredraw,ON_); 
sWo(_woid,zinwo,_wstyle,WS_SVB_,_wredraw,ON_); 


//  check for lyo - layout file 

 lyo_ok=f_exist("${vptitle}.lyo",0,1)
float wrx,wry,wrX,wrY = 0;
 if (lyo_ok > 7) {
<<" have lyo file $lyo_ok %V $vp $vp1 \n"
    lyosv= readFile("${vptitle}.lyo")
    n2relay= Caz(lyosv)
    for (j=0;j< n2relay; j++) {
<<"$j :: $lyosv[j]\n"
 CA= split(lyosv[j])
 <<" $CA[0] $CA[1] $CA[2] $CA[3] $CA[4] $CA[5] $CA[6]\n"
  wid =atoi(CA[2])
  won = atoi(CA[1])
  wrx = atof(CA[4])
  wry = atof(CA[5])
 wrX = atof(CA[6])
  wrY = atof(CA[7])



  woid = ((wid<< 16) + won);

<<"%V $woid $wrx $wry $wrX $wrY\n"

  ret= wogetrxy (woid,keyposr);


//  ret= wogetrxy (xtmwo,keyposr); 
  
<<" $keyposr[1] $keyposr[2]  $keyposr[3]  $keyposr[4]\n"

ask("CA $j %V $woid $xtmwo $wid $won $wrx $wry $keyposr[1] $keyposr[2] \n",0)



 sWo(_woid,woid,_wresize,wbox(wrx,wry,wrX,wrY,0),_wattron,WOA_UMOD_,_wclipborder,ON_,_wredraw,ON_);

//sWo(_woid,woid,_wresize,wbox(wrx,wry,wrX,wrY,0),_wattron,4,_wclipborder,ON_,_wredraw,ON_); 

  ret=wogetrxy (woid,keyposr);
  <<" %V $woid $keyposr[1] $keyposr[2] \n"

  

  }
   sWi(_woid,vp,_wredraw,1);
 }

cout<<"Screen DONE\n"; 
 

 
//==============\_(^-^)_/==================// 
 
 
