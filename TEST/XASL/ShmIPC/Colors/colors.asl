/* 
 *  @script colors.asl                                                  
 * 
 *  @comment test color selection                                       
 *  @release Carbon                                                     
 *  @vers 1.11 Na Sodium [asl 6.50 : C Sn]                              
 *  @date 07/20/2024 15:13:32                                           
 *  @cdate Sun Mar 22 11:05:34 2020                                     
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2024 -->                               
 * 
 */ 

//-----------------<V_&_V>------------------------// 
 
 
 
 
#define __CPP__ 0 
//#define __ASL__ 0
 
#if __ASL__	
#include "debug.asl"  
 
  if (_dblevel >0) {  
   debugON()  
  }  
 
   allowErrors(-1); // set number of errors allowed -1 keep going  
 
 
 Svar argv = _argv;  // allows asl and cpp to refer to clargs 
 argc = argc(); 
 
 //ans=ask("debug inc?",1)
 
  chkIn(_dblevel) ; 
 
 
 

#endif 
 
 
#if __CPP__ 
#include <iostream> 
#include <ostream> 
 
using namespace std; 
#include "vargs.h" 
#include "utils.h" 
#include "vec.h" 
//#include "uac.h" 
#include "cppi.h" 
#include "consts.h" 
#define PXS  cout<< 
 
// GRAPHICS 
#include "gline.h" 
#include "glargs.h" 
#include "winargs_lc.h" 
#include "woargs_lc.h" 
 
#include "gevent.h" 
#include "event.h" 
#include  "textr.h" 
//#include "wevent.asl"

int Aslx =0;   // need a cpp holdall for any Asl only Globals? 

#endif 
 
Str Use_= " Demo  of test color selection "; 

// GLOBALS
 cindex = 0; // need to know where HTML starts
 cname = "limegreen"
 icindex,windex = 0
 html_index = 0

 srbindex = 0;
 sgbindex = 0;
 srbname = ""
 sgbname = ""

icname = "blue"; 
scname = "red"; 
txw =""; 


int rgb_index;  // place this outside of most colors 
int rg_index;
int rb_index; 
int gb_index;
int r_index;
int g_index;
int b_index;

Str bwoval
Str gwoval
Str rwoval

Str ctxt;

#include "wevent.asl" 


 //Vec rgb(<float>,4)  ; // trans needs to know float rgb[4]

 float rgb[4] ; // trans to Vec <float> rgb(4)
// this should be in an include file

///////////////////////////////////////////////////
#if __ASL__
   openDll("image"); 
#endif

void  setRGBfromCindex()
{
    if (cindex > 1000)
        cindex =0; // need to know where HTML sets ends 
    //rgb = getRGB(cindex) 
    rgb[0] = getRed(cindex)  ; // trans bad 7/25/24  ?? 
    rgb[1] = getGreen(cindex)     
    rgb[2] = getBlue(cindex)     
    <<"getRGB  $rgb[0] $rgb[1] $rgb[2] \n" 
 
    redv = rgb[0] 
    greenv = rgb[1] 
    bluev = rgb[2] 
 

   setRGB(rgb_index,redv,greenv,bluev) 
   setRGB(rg_index,redv,greenv,0) 
   setRGB(rb_index,redv,0,bluev) 
   setRGB(gb_index,0,greenv,bluev)

   setRGB(r_index,redv,0,0) 
   setRGB(g_index,0,greenv,0) 
   setRGB(b_index,0,0,bluev);        
}
//[EP]/////////////////////////////////////////////////////


// goes after procs 
#if __CPP__ 
int main( int argc, char *argv[] ) { // main start 
 
   init_cpp(argv[0]); 
   cout << "Running CPP  " << argv[0] << endl; 
#endif        
// 
// Show some colors 
// 
 
 
  Graphic = checkGWM()  ; // trans bad fname ?? spil_dll
 
  if (!Graphic) { 
    Xgm = spawnGWM("colors") 
  }   

  openDll("plot")  // should add in plot funcs?? in trans 
 
  openDll("image"); 

  rainbow();  // update the XGS CMAP

  int k = 0 ;
 
  float redv =  0.5;
  float greenv =  0.45;
  float bluev =  0.75;

  float    iredv =  1.0 -redv ;
  float    igreenv =  1.0 -greenv ;
  float    ibluev =  1.0 - bluev ;
 int index = 2000; 
    rgb_index =  index;  // place this outside of most colors 
     rg_index = index++ ;
     rb_index = index++ ;
     gb_index = index++ ;
     r_index = index++ ;
     g_index = index++ ;
     b_index = index++ ;

 
 
  bvp = cWi("Button") ; // TBF 7/6/24 should autodec int bvp FIXED 
   
  sWi(_woid,bvp,_wdraw,ON_,_wpixmap,ON_,_wsave,ON_,_wbhue,WHITE_); 
 
 //   txtwin = cWi("title","MC_INFO",_pixmapon,_drawon,"save","bhue","white") 
 
  txtwin= cWi("MC_INFO"); 
 
   sWi(_woid,txtwin,_wdraw,ON_,_wpixmap,ON_,_wsave,ON_,_wbhue,WHITE_); 
 
 
    //cvp = cWi("title","Colors",_pixmapon,_drawon,_save,_cbhue,"yellow") 
    cvp = cWi("Colors") 
sWi(_woid,cvp,_wname,"Colors",_wdraw,ON_,_wpixmap,ON_,_wsave,ON_,_wbhue,YELLOW_); 
 
//    vp3 = cWi(_title,"HTML_Colors",_pixmapon,_drawon,"save",_bhue,"yellow") 
 
   vp3 = cWi("HTML_Colors") 
 
  sWi(_woid,vp3,_wdraw,ON_,_wpixmap,ON_,_wsave,ON_,_wbhue,YELLOW_); 
 
  int allwins[] =  {cvp,bvp,vp3,txtwin,-1}; 
  <<"$allwins\n" 
 
//  wrctile(allwins,0.1,0.1,0.9,0.9,2,2,0); // TBF 7/6/24 CPP 
 
    wrctile(allwins,0.1,0.1,0.9,0.9,2,2); 
 
 // titleButtonsQRD(bvp);  // TBF 7/6/24 
 
  sWi(_woid,vp3,_wredraw, ON_)
 
  rx = 0.2 
  rX = 0.3 
 
  gx = 0.4 
  gX = 0.5 
 
  bx = 0.8 
  bX = 0.95 
  by = 0.1 
  bY = 0.3 
  dY = bY -by 
  cby = 0.1 
  cbY = 0.5 
 
  cbx = 0.1 
  cbX = 0.5 
 
 
  bwo=cWo(bvp,WO_BS_); // TBF 7/6/24 should autodec bwo FIXED 
 
 // sWo(_woid,bwo,_wname,"Blue",_wvalue,bluev,_wbhue,BLUE_); 
  sWo(_woid,bwo,_wname,"Blue",_wvalue,bluev,_wbhue,BLUE_); 
 
 // rwo=cWo(bvp,_BS,_name,"Red",_value,redv) 
 
    rwo=cWo(bvp,WO_BS_); 
 
    sWo(_woid,rwo,_wname,"RED",_wvalue,redv,_whue,RED_); 
 
  gwo=cWo(bvp,WO_BS_); 
 
  sWo(_woid,gwo,_wname,"Green",_wvalue,greenv,_whue,GREEN_); 
 
 
 
  int rgbwo[] = { rwo, gwo, bwo,  -1 }; 
   
 // sWo(rgbwo,_style,"SVL",_wdrawon, 
 
  wovtile( rgbwo, cbx,cby,cbX,cbY,0.01); 
  i=0; 
  while (rgbwo[i] >0 ) { 
   sWo( _woid, rgbwo[i++],_wstyle,"SVL",_wdraw,ON_,_whue,BLACK_,_wsymbol,TRI_,_wredraw,ON_); 
  } 
 
 
 
 
  
 
 
    qwo=cWo(bvp,WO_BN_); 
    sWo(_woid, qwo,_wname,"QUIT?",_wvalue,"QUIT",_wcolor,ORANGE_,_wresize,wbox(bx,by,bX,bY)); 
 
  by = bY + 0.02 
  bY = by + dY 
 
  nxtcolwo=cWo(bvp,WO_BN_) 
 
  //sWo(_woid,nxtcolwo,_wname,"Next",_wvalue,"NextColor",_wcolor,CYAN_,_WRESIZE_FR,wbox(bx,by,bX,bY)) 
 
  //_WRESIZE_FR not recognized CPP TBF 7/6/24 
  // TBF missing tag,val pair  show ERROR CPP compile will fail! --- shows error(glitch)  marks statement as SBAD continues 
 
  sWo(_woid,nxtcolwo,_wname,"Next",_wvalue,"NextColor",_wcolor,CYAN_,_wresize,wbox(bx,by,bX,bY)) 
 
  sWo(_woid,qwo,_wborder,ON_,_wdraw,ON_,_wclipborder,BLACK_,_wfonthue,BLACK_, _wstyle, "SVB", _wredraw,ON_) 
 
  sWo(_woid,nxtcolwo,_wborder,ON_,_wdraw,ON_,_wclipborder,ON_,_wfonthue,BLACK_, _wstyle, "SVB", _wredraw,ON_) 


  cindexwo = cWo(bvp,WO_BV_) ;

     by = bY + 0.02 ;
     bY = by + dY ;

  sWo(_woid, cindexwo,_wname,"CINDEX",_wvalue,"1",_wcolor,LILAC_,_wresize,wbox(bx,by,bX,bY));


  cnamewo = cWo(bvp,WO_BV_) ;

     by = bY + 0.02 ;
     bY = by + dY ;
     bx = 0.6;
     bz = 0.1;
  sWo(_woid, cnamewo,_wname,"CNAME",_wvalue,"SkyBlue",_wcolor,LILAC_,_wresize,wbox(bx,by,bX,bY,bz));



   sWo(_woid,cindexwo,_wborder,ON_,_wdraw,ON_,_wfunc,"inputValue",_wclipborder,ON_,_wfonthue,BLACK_, _wstyle, "SVB", _wredraw,ON_) ;


     sWo(_woid,cnamewo,_wborder,ON_,_wdraw,ON_,_wfunc,"inputValue",_wclipborder,ON_,_wfonthue,BLACK_, _wstyle, "SVB", _wredraw,ON_) ;

  
  

  // these are a list of values that the color wo can have  - each click cycles thru them 
 
 
 // frgb = vgen(FLOAT_,20,0,0.05) 
 
     Vec frgb(<float>,20,0,0.05) 
      
//<<"%(,,\,,)4.2f$frgb \n" 
 
 
 
     cvals= "0,0.05,0.1,0.15,0.2,0.25,0.3,0.35,0.4,0.45,0.5,0.55,0.6,0.65,0.7,0.75,0.8,0.85,0.9,0.95,1.0" 
 
     i=0; 
 
    while (rgbwo[i] >0 ) { 
 
//sWo(_woid, rgbwo[i],_CSV,"%(,,\,,)4.2f$frgb",20,_wredraw, 
 
     sWo(_woid,rgbwo[i],_wcsv,cvals,_wredraw,ON_); 
 
    // ans=ask("%V$i $rgbwo[i]",1) 
     i++; 
 
    } 
 
 
     
 // setgwin(bvp,"woredrawall") 
 
   twot=cWo(txtwin,WO_TEXT_); 
    
    sWo(_woid,twot,_wname,"Text",_wvalue,"howdy",_wcolor,ORANGE_,_wresize,wbox(0.1,0.1,0.9,0.9)); 
 
    sWo(_woid,twot,_wborder,BLACK_,_wdraw, ON_,_wclipborder,BROWN_,_wfonthue,BLUE_, _wredraw,ON_); 
 
 // ?  _pixmapoff ? 
 
 





int awo[5] ;
  awo[4] = -1;
 
  index = 150;
 

     for (k =0  ; k  < 4 ; k++) {
  //      awo[k]=cWo(cvp,_GRAPH,_name,"${k}_col",_color,index,_value,k) 
             awo[k]=cWo(cvp,WO_GRAPH_) 
	     sWo(_woid,awo[k],_wname,"${k}_col",_wcolor,index,_wvalue,k); 
        index++; 
     } 
 
 
   <<"%V $awo \n" 
 
  //sWo(awo,_border,_drawon,_CLIPBORDER) 
 
   wovtile(awo,0.1,0.1,0.9,0.9,0.025) 
 
 
  // contrast ? 
  // make smaller clip area for awo[0] 
  //sWo(awo[0],_cbhue,152) 
  //sWo(awo[0],_clip,0.1,0.1,0.5,0.5) 
 
int htwo[5]  ; htwo[4] = -1; 
 
     index = 1; 
 
     for (k = 0; k < 4; k++) {  
      htwo[k]=cWo(vp3,WO_GRAPH_) 
      sWo(_woid,htwo[k],_wname,"${k}_col",_wcolor,index,_wvalue,k,_wborder,BLACK_,_wredraw,ON_); 
      index++; 
     } 
 
 
<<"%V$htwo \n" 
  
  wovtile(htwo,0.1,0.1,0.9,0.9,0.05) 
 
 
 
 redv = 1.0; 
 greenv = 0.0; 
 bluev = 0.0; 
 
  //redv.pinfo(); 
   
<<"%V $redv $greenv $bluev \n" 
 
  sWo(_woid,rwo,_wvalue, redv)
  sWo(_woid,bwo,_wvalue, bluev)
    sWo(_woid,gwo,_wvalue, greenv)
   
      rwoval = woGetValue(rwo) 
      gwoval = woGetValue(gwo) 
      bwoval = woGetValue(bwo)       

<<"%V $rwoval $gwoval $bwoval \n"

   redv   = satof( woGetValue(rwo)); 
   greenv = satof ( woGetValue(gwo)) 
   bluev  =  satof ( woGetValue(bwo)) 
 
<<"%V $redv $greenv $bluev \n" 
// rwoval.pinfo() 

 //ans = ask("$redv $rwoval ",1) 
 
 
  i= 0; 
  while (rgbwo[i] > 0) { 
    sWo(_woid,rgbwo[i++],_wvalue,0.4,_wredraw,ON_); 
//    i++; 
  } 
   
 /// setup cmap



 
//ask=query("where are we?"); 
 
//////////////////// BKG LOOP ////////////////////////////////


<<"//////////////////// BKG LOOP ////////////////////////////////\n"


// Event vars 

 

 
  cindex = 0; 
  icindex = 0; 
  scindex = 0; 
   
  bctx=0.4; 
 
  wctx =0.6; 
 //allowDB("vmf,plot,spe",1) 
  Textr txr; 
  ctxt=<<"Green $greenv Blue $bluev  " 
   
  txr.setTextr(ctxt,0.1,0.61,BLACK_,0) 
    
  txr.pinfo() 
 
//  txw = txr.getTxt() ;  // want this to go to a str 
   
  <<"%V $txw \n" 
   
 
//ans= ask("%V $txw ?",1)  // TBF 7/6/24 need an CPP trans 
///////////////////////////////////////////////////// interactive loop //// 
//Vec<float> rgb(4); 
 
 
   int ke=0; 

   while (1) {

          eventWait()
<<"GOT EVENT %V $eloop $ename  $ebutton $ewoid  $etype \n" 	  
	  if (ename == "PRESS" || ename == "KEYPRESS") {
               break;
          }

   }



while (1) { 
 
        eventWait()
	
<<"GOT EVENT %V $eloop $ename  $ebutton $ewoid $ename $etype \n"      
 if (ewoid == cindexwo) { 
    cindex  = satoi(woGetValue(cindexwo))
    setRGBfromCindex()
 }
  else if (ewoid == cnamewo) { 
    cname  = woGetValue(cnamewo)
    cindex = getCmapIndexFromName(cname);
     setRGBfromCindex()
 }


 else if (ewoid == nxtcolwo) { 
 
    cindex++

// cindex should be in the loaded base set
// or within the HTML range

    // need to number top of loaded CMAP
 <<"just next $cindex \n"
   setRGBfromCindex()

   } 
   else { 

  bluev= satof ( woGetValue(bwo)) 
  redv= satof ( woGetValue(rwo)) 
  greenv= satof ( woGetValue(gwo)) 

   setRGB(rgb_index,redv,greenv,bluev) 
   setRGB(rg_index,redv,greenv,0) 
   setRGB(rb_index,redv,0,bluev) 
   setRGB(gb_index,0,greenv,bluev) 
      setRGB(r_index,redv,0,0) 
      setRGB(g_index,0,greenv,0) 
      setRGB(b_index,0,0,bluev);        
 
    cindex = getColorIndexFromRGB(redv,greenv,bluev) 
    
   } 
 
<<"%V $redv $greenv $bluev \n"

  sWo(_woid,rwo,_wvalue, redv)
  sWo(_woid,bwo,_wvalue, bluev)
  sWo(_woid,gwo,_wvalue, greenv)
  sWo(_woid,cindexwo,_wvalue, cindex,_wupdate,ON_)

     rwoval = woGetValue(rwo)
     gwoval = woGetValue(gwo) 
     bwoval = woGetValue(bwo)


 <<"%V $rwoval $gwoval $bwoval \n"

   
   ctxt=<<" Red $redv " 
   sWo(_woid,rwo,_wbhue,r_index,_wclearclip,r_index,_wclipborder,RED_);
   txr.setTextr( ctxt,  0.1,0.21,WHITE_)       
   sWo(_woid,rwo,_wbhue,r_index,_wtexthue,WHITE_,_wtextr,txr,_wclipborder,RED_); 
   txr.setTextr( ctxt,  0.1,0.51,BLACK_)
   sWo(_woid,rwo,_wbhue,r_index,_wtextr,txr,_wclipborder,RED_);    

   
   ctxt = <<"Green  $greenv " 
   sWo(_woid,gwo,_wbhue,g_index,_wclearclip,g_index,_wclipborder,RED_);
   txr.setTextr( ctxt,  0.1,0.21,WHITE_)       
   sWo(_woid,gwo,_wbhue,g_index,_wtextr,txr,_wclipborder,RED_);
   txr.setTextr( ctxt,  0.1,0.51,BLACK_)
   sWo(_woid,gwo,_wbhue,g_index,_wtextr,txr,_wclipborder,RED_);


   ctxt = <<"Blue $bluev " 
   sWo(_woid,bwo,_wbhue,b_index,_wclearclip,b_index,_wclipborder,RED_); 
   txr.setTextr( ctxt,  0.1,0.21,WHITE_)       
   sWo(_woid,bwo,_wbhue,b_index,_wtextr,txr,_wclipborder,RED_); 
   txr.setTextr( ctxt,  0.1,0.51,BLACK_)
   sWo(_woid,bwo,_wbhue,b_index,_wtextr,txr,_wclipborder,RED_); 

    //ans= ask("check stack $(txr.getTxt())",0) // TBF vmf in pex ? 
 
  
 <<" %V $bluev $redv $greenv"  
 
 
  // sWo(rgbwo,_redraw) 
  // TBC ?tr 
 //   ctxt= <<" RGB %V %6.2f $redv $greenv $bluev" 

    ctxt= <<" RGB %V %6.2f $redv $greenv $bluev" 
    txr.setTextr(ctxt,0,0.9) 
    <<"%V $ctxt\n" 
     sWo(_woid,twot,_wclear,ON_,_wtextr,txr);  
   //sWo(awo,_bhue,cindex,_clear,_clipborder,_redraw)  // clears repaints 
   //sWo(awo,_clearclip,_redraw)  // clears repaints 
 
   sWo(_woid,htwo[0],_wbhue,cindex,_wtexthue,BLACK_,_wclearclip,cindex,_wclipborder,BLUE_, _wredraw,ON_) 
 
 
   cname = getColorName(cindex); 
   //<<"%V $cname $cindex \n" 
 

  // sWo(_woid,htwo[0],_wtexthue,BLACK_,_wtextr,txr.setTextr("$cname",bctx,0.52),_wclipborder,RED_)); // TBF should be flagged as SBAD -- extra ) 


   sWo(_woid,htwo[0],_wbhue,cindex,_wtexthue,BLACK_,_wclearclip,cindex,_wclipborder,RED_,_wredraw,ON_) 
   ctxt= <<"$cname"  
   txr.setTextr(ctxt,bctx,0.5,BLACK_) 

   sWo(_woid,htwo[0],_wtexthue,BLACK_,_wtextr,txr,_wclipborder,RED_); 
   txr.setTextr(ctxt,wctx,0.5,WHITE_) 

   sWo(_woid,htwo[0],_wtexthue,WHITE_,_wtextr,txr,_wclipborder,RED_); 
   //sWo(_woid,htwo[1],_texthue,"white",_textr,"$cname",wctx,0.5,_eo); //? 

   iredv = 1-redv
   igreenv = 1-greenv
   ibluev = 1-bluev
   
   icindex = getColorIndexFromRGB(iredv,igreenv,ibluev) 
   //<<"%V $icindex \n"; 

   fcv = getRGBfromIndex(icindex);

   fcv.pinfo()
   

   sWo(_woid,htwo[1],_wbhue,icindex,_wredraw,ON_) 
    
   icname = getColorName(icindex) 
   ctxt= <<"$icname"  

   windex = getCmapIndexFromName(icname);
   

   html_index = getHTMLindexFromName (icname)

<<"%V $windex $html_index \n"
   fhtmlv = getRGBfromHTMLindex(html_index);
   fhtmlv.pinfo()
   
//ask=query("where are we? $icname"); 


   txr.setTextr(ctxt,bctx,0.55,BLACK_)
   
   sWo(_woid,htwo[1],_wtextr,txr,_wclipborder,RED_); 

txr.setTextr(ctxt,wctx,0.5,WHITE_)
   
   sWo(_woid,htwo[1],_wtextr,txr); 

   //<<"%V $icname $icindex \n" 
 
 
   // swap red & blue

   srbindex = getColorIndexFromRGB(bluev,greenv,redv) 
   srbname = getColorName(srbindex) 

<<"%V $redv $greenv $bluev $srbindex\n"

sWo(_woid,htwo[2],_wbhue,srbindex,_wclearclip, srbindex, _wredraw,ON_) 
 
  ctxt= <<"$srbname" 
 
   txr.setTextr(ctxt,bctx,0.55,BLACK_)
   sWo(_woid,htwo[2],_wtexthue,BLACK_,_wtextr,txr,_wclipborder,RED_); 
   txr.setTextr(ctxt,wctx,0.5,WHITE_) 
   sWo(_woid,htwo[2],_wtexthue,WHITE_,_wtextr,txr,_wclipborder,RED_);  // wtextr is cleared by redraw
   
// swap green & blue

   sgbindex = getColorIndexFromRGB(redv,bluev,greenv) 
   sgbname = getColorName(sgbindex) 
<<"%V $redv $greenv $bluev $sgbindex\n"

    ctxt= <<"$sgbname" 
 

    sWo(_woid,htwo[3],_wbhue,sgbindex,_wtexthue,BLACK_,_wclearclip,sgbindex,_wclipborder,RED_,_wredraw,ON_) 
   txr.setTextr(ctxt,bctx,0.55,BLACK_)  
   sWo(_woid,htwo[3],_wtextr,txr,_wclipborder,RED_); 
   txr.setTextr(ctxt,wctx,0.5,WHITE_) 
   sWo(_woid,htwo[3],_wtextr,txr,_wclipborder,RED_) 

   gflush()
   
   ctxt= <<" CN   %6.2f R $redv G $greenv  B $bluev $cindex $cname"
   
   txr.setTextr(ctxt,0,0.5) 
  // sWo(_woid,twot,_wtextr,txr,_wclipborder,RED_);

   Text(twot,ctxt,0.1,0.5)

   ctxt= <<" ICN  %6.2f R $iredv G $igreenv  B $ibluev $icindex $icname "  

   Text(twot,ctxt,0.1,0.4)

   txr.setTextr(ctxt,0,0.4) 
   //sWo(_woid,twot,_wtextr,txr,_wclipborder,RED_);

   ctxt= <<" SRBN %6.2f R $bluev G $greenv  B $redv $srbindex $srbname "  
   txr.setTextr(ctxt,0,0.3) 
   //sWo(_woid,twot,_wtextr,txr,_wclipborder,RED_);
   Text(twot,ctxt,0.1,0.3)
   ctxt= <<" SGBN %6.2f R $redv G $bluev  B $greenv  $sgbindex $sgbname"  
   txr.setTextr(ctxt,0,0.2) 
   //sWo(_woid,twot,_wtextr,txr,_wclipborder,RED_); 
   Text(twot,ctxt,0.1,0.2)
   //cname = getColorName(windex) 
 
   //windex++ 
 
    awo0 = awo[0] 
    ctxt = <<"%6.2f Red $redv + Green $greenv  " 
    txr.setTextr(ctxt,0.1,0.61); 
    txw = txr.getTxt(); 
 
#if __ASL__ 
 ans= ask("%V $txw ?", 0) ; // want to kill ask if ans !c 
 if (ans == "!c") {  ask_here = 0; } 
#endif 
 
    sWo(_woid,awo[0],_wbhue,rg_index,_wtexthue,BLACK_,_wclearclip,rg_index,_wclipborder,RED_); 
 
  txw = txr.getTxt() 
//  ans= ask("%V $txw ?",0) 
   txr.setHue(BLACK_); 
  sWo(_woid, awo0, _wtexthue, BLACK_, _wtextr, txr, _wclipborder, RED_); 
 
  txr.setXY(0.1, 0.21);  txr.setHue(WHITE_); 
 
   sWo(_woid, awo[0], _wtexthue, WHITE_, _wtextr, txr, _wclipborder, RED_);      
 
    awo1 = awo[1] 
     ctxt = <<"%6.2f Red $redv + Blue $bluev "  
     txr.setTextr(ctxt, 0.1, 0.61, BLACK_, 0) 
 
    sWo(_woid, awo[1], _wbhue, rb_index, _wtexthue, BLACK_, _wclearclip, rb_index, _wclipborder, RED_); 
 
    blk= WHITE_; 
 
   sWo(_woid, awo[1], _wtexthue, blk, _wtextr,  txr , _wclipborder,  RED_); 
 
   txr.pinfo() 
   txw = txr.getTxt() 
 //  ans= ask("%V $txw ?", 0) 
   txr.setXY(0.1, 0.21); 
   txr.setHue(WHITE_); 
 
 
    sWo(_woid, awo[1], _wtexthue, WHITE_, _wtextr, txr, _wclipborder, RED_);      
 
     //sWo(_woid,awo[2],_wtextr,txr,_wclipborder,RED_); 
 
    ctxt= <<"%6.2f Green $greenv + Blue $bluev  " 
 
    <<"%V $ctxt\n" 
 
 
    txr.setTextr( ctxt , 0.1, 0.61, 1, 0) 
      
     sWo(_woid, awo[2], _wbhue, gb_index, _wtexthue, BLACK_, _wclearclip, gb_index, _wclipborder, RED_); 
     txr.setHue(WHITE_); txr.setXY(0.1, 0.61); 
 
     // TBF 7/8/24 can't do txr.setTextr( ctxt , 0.1, 0.61, 1, 0) as an arg ASL? 
      
     sWo(_woid, awo[2], _wtexthue, WHITE_, _wtextr, txr, _wclipborder, RED_); 
 
     txr.setXY(0.1, 0.21); txr.setHue(BLACK_); 
   
    //sWo(_woid,awo[2],_wtexthue,BLACK_,_wtextr,txr_wclipborder,RED_);  // bad parse detected labelled SBAD no XIC  
    sWo(_woid, awo[2], _wtexthue, BLACK_, _wtextr, txr, _wclipborder, RED_);      
 
     ctxt= <<"%6.2f Red $redv + Green $greenv + Blue $bluev" 
 
     txr.setTextr(ctxt, 0.1, 0.61, BLACK_, 0) 
 
 
     sWo(_woid, awo[3], _wbhue, rgb_index, _wtexthue, BLACK_, _wclearclip, rgb_index, _wclipborder, RED_); 
      
 //    txr.setHue(BLACK_); txr.setXY(0.1,0.61); 
 
 
     sWo(_woid,  awo[3],  _wtexthue,  BLACK_,  _wtextr,  txr,  _wclipborder,  RED_); 
      // txr.setXY((0.1,0.21); 
      txr.setXY(0.1, 0.21); txr.setHue(LILAC_); 
     sWo(_woid, awo[3], _wtexthue, WHITE_, _wtextr, txr, _wclipborder, RED_);      
 
     // use Textr asl function to process the text parameters during the sWo call --  compatible with  cpp version 
     // which uses a Textr object and passes that via this pointer 
     //   so this still looks like and tag, value pair to both asl and cpp 
  
    //<<"%V $woid  $qwo \n" 
 
   if (ewoid == qwo) { 
       break 
   } 

 
  } 
 
 

 
   chkOut();
   
   exitGWM() 

#if __CPP__ 
  exit_cpp(); 
  exit(-1);  
  }  /// end of C++ main  
#endif      
 
 
//==============\_(^-^)_/==================// 

/*
    TBD

    spacing in wovtile -- cpp version broke
    initial redraw waits for mouse movement
    exit to quit xgs
    
    initial R G B buttons at 0.5, 0.6, 0.7 -- and or take arg to set color via name
        



    Stretch goal Lets try for voice argument for color before 2025

*/