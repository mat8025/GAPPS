/// 
/// 
/// 
 
 
 
int two; 
int txtwin; 
int vp; 
int vp2 = -1; 
int vp3 = -1 
int lwo; 
 
 
 
int bsketchwo; 
int boatwo; 
int grwo; 
 
int hwo 
int gwo; 
 
int rwo; 
int qwo; 
int gvwo; 
 
 
   float xp = 0.1 
   float yp = 0.5 
#if 0 
void processKeys(int key) 
{ 
       
<<" key $key \n" 
 
       switch (key) { 
 
       case 'R': 
       { 
     //  sWo(_woid,symwo,_wmove,wpt(0,2),_WREDRAW) 
       sWo(_woid,two,_wtextr,"R RMOVE 2 ",0.1,0.2) 
       } 
       break; 
 
       case 'T': 
       { 
     //  sWo(_woid,symwo,_wmove,wpt(0,-2),_WREDRAW) 
       sWo(_woid,two,_wtextr,"T RMOVE -2 ",0.1,0.2) 
       } 
       break; 
 
       case 'Q': 
       { 
      // sWo(_woid,symwo,_wmove,wpt(-2,0),_WREDRAW) 
       sWo(_woid,two,_wtextr,"Q RMOVE -2 ",0.1,0.2) 
       } 
       break; 
 
       case 'S': 
       { 
       //sWo(_woid,symwo,_wmove,wpt(2,0,)_wredraw,ON_) 
       sWo(_woid,two,_wtextr,"S RMOVE 2 ",0.1,0.2) 
       } 
       break; 
 
       case 'h': 
       { 
       //sWo(_woid,symwo,_whide,ON_) 
       sWi(vp2,_WREDRAW) 
       } 
       break; 
 
       case 's': 
       { 
    //   sWo(_woid,symwo,_wshow,ON_) 
      sWi(vp2,_WREDRAW) 
       } 
       break; 
 
      } 
} 
//--------------------------------------------------------------------- 
 
 
 
void do_sketch() 
{ 
   sWo(_woid,bsketchwo,_wclear,ON_,_wline,wbox(0.1,0.1,0.8,yp,RED_)) 
   sWo(_woid,bsketchwo,_wline,wbox(0.1,yp,0.8,0.1,BLUE_)) 
 
 
   //axnum(bsketchwo,1)    // TBF 
   //axnum(bsketchwo,2) 
 
   sWo(_woid,grwo,_wclearclip,ON_,_wclipborder,ON_,_wline,wbox(xp,0.1,0.5,0.5,GREEN_)) 
   sWo(_woid,grwo,_wline,wbox(xp,0.5,0.5,0.1,BLACK_)) 
 
   xp += 0.05   
   yp += 0.05  
 
   //zp = xp + yp 
 
   if (xp > 0.7) {  
       xp = 0.1  
   } 
 
   if (yp > 0.9) { 
      yp = 0.1  
   } 
 }  
//------------------------------------------------------- 
#endif 
 
int FRUIT(int val) 
{ 
 
  <<"want a fruit? $val\n" 
 
} 
 
 
 
 
int BOATS(int val) 
{ 
  if (val == 1)   <<"want to sail a boat? $val\n" 
 
   if (val == 3)   <<"want to buy a boat? $val\n" 
 
} 
 
 
 
 
 
int  QUIT(int val) 
{ 
 //exitgs(); 
 <<"$val kill xgs now exit!\n"; 
  exit(-1) 
 
} 
 
void tb_q() 
{ 
<<"expecting sig1 signal\n"; 
} 
 
//////////////////////////////// 
 
///    screen_buttons 
   void setScreen() 
   { 
    int i; 
 
<<"  setScreen() \n" 
 
    vp = cWi("Buttons1") 
 
<<" created window $vp\n" 
 
    sWi(_woid,vp,_wpixmap,ON_,_wdraw,ON_,_wsave,ON_,_wbhue,BLUE_) 
 
    sWi(_woid,vp,_wclip,wbox(0.1,0.2,0.9,0.9)) 
 
 
    txtwin = cWi("Info_text_window") 
 
    sWi(_woid,txtwin,_wpixmap,OFF_,_wdraw, ON_ , _wsave,ON_,_wbhue,MAGENTA_,_wsticky,ON_)  
 
<<"$txtwin \n" 
 
    vp2 = cWi("Buttons2") 
 
    sWi(_woid,vp2,_wpixmap,ON_,_wsave,ON_,_wbhue,YELLOW_) 
 
    sWi(_woid,vp2,_wclip,wbox(0.1,0.2,0.9,0.9)) 
 
<<"%V $vp2 \n" 
 
     vp3 = cWi("Buttons3")   
 
    sWi(_woid,vp3,_wpixmap,ON_,_wsave,ON_,_wbhue,GREY_) 
 
    sWi(_woid,vp3,_wclip,wbox(0.1,0.2,0.9,0.9)) 
 
<<"%V $vp3 \n" 
 
       int fswins[] =  {vp,vp2,vp3,txtwin,-1}; 
 
//       wrctile( {txtwin,vp,vp2,vp3}, 0.05,0.05,0.95,0.95, 2, 2,-1,0) // tile windows in 2,2 matrix on  screen zero 
       wrctile( fswins, 0.05,0.05,0.95,0.95, 2, 2) // tile windows in 2,2 matrix on  current screen  
 
      for(i = 0; i < 10; i++) { 
     
       if (fswins[i] < 0) { 
            break 
       } 
        
      sWi(_woid, fswins[i], _wredraw,ON_) 
 
       } 
 
  //     vp4= -1; 
       //? puts this on screen 1? 
      // vp4 = cWi("Buttons4") 
      // sWi(vp4,_wresize,0.1,0.1,0.8,0.8,1)// on screen 1 
     //<<"%V$vp4 \n" 
//       wrctile(vp1, 0.05,0.05,0.95,0.95, 1, 1,1,0)  
 
 
 
//////// Wob ////////////////// 
//   TBF - does wbox cpp work with doubles instead of floats 
  
  bx = 0.1 
  bX = 0.4 
   yht = 0.2 
  ypad = 0.05 
 
  bY = 0.95 
  by = bY - yht 
 
 two= cWo(txtwin,WO_TEXT_) 
 
<<"%V $txtwin $two \n" 
ans=ask("$two ¿Es eso correcto?  [y,n,q]",0); 

sWo(_woid,two,_wname,"Text",_wvalue,"howdy",_wcolor,GREEN_,_wresize,wbox(0.2,0.2,0.8,0.7)) 
sWo(_woid,two,_wborder,ON_,_wdraw,ON_,_wclipborder,BLACK_,_wfonthue,BLACK_,_wredraw,ON_) ; 
 
 sWo(_woid,two,_wscales,wbox(-1.0,-1.0,1.0,1.0),_wsavescales,0,_wsave,ON_) 
 sWo(_woid,two,_whelp," Mouse & Key Info ") 
 
 
 
 gwo=cWo(vp,WO_BV_) 
 
 sWo(_woid,gwo,_wname,"ColorTeal",_wcolor,GREEN_,_wresize,wbox(bx,by,bX,bY)) 
  
 sWo(_woid,gwo,_wborder,BLACK_,_wdraw,ON_,_wclipborder,PINK_,_wfonthue,RED_,_wvalue,"color is teal",_wstyle,SVB_) 
 sWo(_woid,gwo,_wbhue,TEAL_,_wclipbhue,BLUE_,_wfunc,"cycleHue",_wmessage,1,_wredraw,ON_) 
 
   bY = by - ypad // FIX no semi 
   by = bY - yht; 
  
 
 
 hwo=cWo(vp,WO_ONOFF_) 
 
 sWo(_woid,hwo,_wname,"ENGINE",_wvalue,"ON",_wcolor,RED_,_wresize,wbox(bx,by,bX,bY)) 
 
 sWo(_woid,hwo,_wborder,BLUE_,_wdraw,ON_,_wclipborder,RED_,_wstyle,SVR_,_wfonthue,WHITE_)  
 sWo(_woid,hwo,_wfhue,LILAC_,_wbhue,BLUE_,_wclipbhue,MAGENTA_,_wredraw,ON_); 
 
 <<"created ENGINE $hwo \n"  
 // GetValue after entering text 
 gvwo=cWo(vp,WO_BV_) 
 sWo(_woid,gvwo,_wname,"GMYVAL",_wvalue,"0",_wcolor,GREEN_,_wresize,wbox(0.5,by,0.9,bY)) 
  
 sWo(_woid,gvwo,_wborder,GREEN_,_wdraw,ON_,_wclipborder,PINK_,_wfonthue,BLACK_, _wstyle,SVR_) 
 sWo(_woid,gvwo,_wbhue,WHITE_,_wclipbhue,RED_,_wfunc,"inputValue",_wmessage,1,_wredraw,ON_) 
 <<"created GVWO $gvwo \n"  
 
 
 
 
 bY = by - ypad 
 by = bY - yht 
 
 lwo=cWo(vp,WO_ONOFF_) 
 
 sWo(_woid,lwo,_wname,"PLAY",_wvalue,"ON",_wcolor,RED_,_wresize,wbox(bx,by,bX*0.85,bY)) 
 sWo(_woid,lwo,_wborder,BLUE_,_wdraw,ON_,_wclipborder,RED_,_wstyle,SVR_,_wfonthue,WHITE_)  
 sWo(_woid,lwo,_wfhue,TEAL_,_wclipbhue,PINK_, _wredraw,ON_) 
 
 <<"created PLAY $lwo $bx $by $bX $bY \n"  
 
//<<"%V$two $hwo $gwo $gvwo $lwo\n" 
 
 bY = 0.95  
 by = bY - yht 
 
 grwo=cWo(vp2,WO_GRAPH_) 
 
 sWo(_woid,grwo,_wname,"pic",_wcolor,YELLOW_,_wresize,wbox(bx,by,bX,bY)) 
 sWo(_woid,grwo,_wfonthue,RED_, _wredraw,ON_ ) 
 sWo(_woid,grwo,_wscales,wbox(0.0,0.0,1.0,1.0)) 
 
<<"%V$grwo \n" 
 
 
 
 boatwo=cWo(vp3,WO_BS_) 
 sWo(_woid,boatwo,_wname,"BOATS",_wcolor,YELLOW_,_wresize,wbox(bx,by,bX,bY)); 
 sWo(_woid,boatwo,_wcsv,"sloop,yacht,catamaran,cruiser,trawler,ketch"); 
 sWo(_woid,boatwo,_wfonthue,RED_,_wstyle,SVR_, _wredraw,ON_); 
 sWo(_woid,boatwo,_whelp," click to choose a boat "); 
 
 bY = by - ypad ; 
 by = bY - yht ; 
 
<<"%V$boatwo \n" 
 
 bsketchwo=cWo(vp3,WO_GRAPH_) 
 sWo(_woid,bsketchwo,_wname,"sketch",_wcolor,YELLOW_,_wresize,wbox(bx,0.1,0.9,bY)) 
 sWo(_woid,bsketchwo,_wborder,ON_,_wdraw,ON_,_wclipborder,ON_,_wfonthue,RED_, _wredraw,ON_ ) 
 sWo(_woid,bsketchwo,_wclip,wbox(0.1,0.15,0.95,0.85),_wbhue,CYAN_) 
 sWo(_woid,bsketchwo,_wscales,wbox(-1.0,-1.0,1.0,1.0)) 
 
<<"%V$bsketchwo \n" 
 
 rwo=cWo(vp2,WO_BS_) 
  
// sWo(_woid,rwo,_wname,"FRUIT",_wcolor,YELLOW_,_wresize,wbox(bx,by,bX,bY)) 
sWo(_woid,rwo,_wname,"FRUITS",_wcolor,YELLOW_,_wresize,wbox(bx,by,bX,bY)); 
 
 sWo(_woid,rwo,_wcsv,"mango,cherry,apple,banana,orange,peach,pear,lime,lemon"); 
   
 
 sWo(_woid,rwo,_wtype, WO_BS_,_wfonthue,RED_,_wstyle,SVR_, _WREDRAW ,ON_) 
 //sWo(_woid,rwo,_wfhue,ORANGE_,_wclipbhue,BLUE_) 
sWo(_woid,rwo,_whelp," click to choose a fruit "); 
 
 
 bY = by - ypad ; 
 by = bY - yht ; 
 
 
 qwo=cWo(vp2,WO_BN_) 
 sWo(_woid,qwo,_wname,"QUIT",_wvalue,"QUIT",_wcolor,MAGENTA_,_wresize,wbox(bx,by,bX,bY)) 
 sWo(_woid,qwo,_whelp," click to quit") 
 sWo(_woid,qwo, _wfonthue,BLUE_, _WREDRAW ,ON_) 
 
 
 
 
 
  titleButtonsQRD(vp); 
 
 
 //int allwins[] = {vp,vp2,vp3,txtwin,-1}; 
  
 //omy = sWi( {vp,vp2,vp3,txtwin} ,_WWOREDRAWALL) 
// BUG anonymous array as func argument 
// sWi( {vp,vp2,vp3,txtwin} ,_WWOREDRAWALL) 
 
//  sWi( allwins ,_wworedrawall,ON_) 
 
} 
 
 
 
 
 
/* 
//   plotline(vp2,0,0,1,1,"blue") 
 
*/ 
 
 
//--------------------------------------------------------------------- 
