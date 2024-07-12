/* 
 *  @script colors.asl                                                  
 * 
 *  @comment test color selection                                       
 *  @release Carbon                                                     
 *  @vers 1.7 N Nitrogen [asl 6.41 : C Nb]                              
 *  @date 07/04/2024 23:23:58                                           
 *  @cdate Sun Mar 22 11:05:34 2020                                     
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2024 -->                               
 * 
 */ 


//-----------------<V_&_V>------------------------//




#define __CPP__ 0

#if __ASL__
#include "debug" 

  if (_dblevel >0) { 
   debugON() 
  } 

   allowErrors(-1); // set number of errors allowed -1 keep going 


 Svar argv = _argv;  // allows asl and cpp to refer to clargs
 argc = argc();



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
#include "winargs.h"
#include "woargs.h"
#include "gevent.h"
#include "event.h"
#include  "textr.h"
#endif

Str Use_= " Demo  of test color selection ";

// goes after procs
#if __CPP__
int main( int argc, char *argv[] ) { // main start

   init_cpp();
   cout << "Running CPP  " << argv[0] << endl;
#endif       
//
// Show some colors
//


Graphic = checkGWM()

  if (!Graphic) {
    Xgm = spawnGWM("colors")
  }

  openDll("image");

int index = 150;
int rgb_index =  index++;  // place this outside of most colors
int rg_index = index++
int rb_index = index++
int gb_index = index++
int r_index = index++
int g_index = index++
int b_index = index++
int k = 0

 redv = 0.5;
 greenv = 0.45;
 bluev = 0.75;

     openDll("plot")

ask_here = 1

//#include "tbqrd.asl"  // 7/7/24 -- want a precompiled vers of this

  //  bvp = cWi("title","Button",_pixmapon,_drawon,"save",_bhue,WHITE_)

  bvp = cWi("Button") ; // TBF 7/6/24 should autodec int bvp FIXED
  
  sWi(_WOID,bvp,_WDRAW,ON_,_WPIXMAP,ON_,_WSAVE,ON_,_WBHUE,WHITE_);

 //   txtwin = cWi("title","MC_INFO",_pixmapon,_drawon,"save","bhue","white")

  txtwin= cWi("MC_INFO");

   sWi(_WOID,txtwin,_WDRAW,ON_,_WPIXMAP,ON_,_WSAVE,ON_,_WBHUE,WHITE_);


    //cvp = cWi("title","Colors",_pixmapon,_drawon,_save,_cbhue,"yellow")
    cvp = cWi("Colors")
sWi(_WOID,cvp,_WNAME,"Colors",_WDRAW,ON_,_WPIXMAP,ON_,_WSAVE,ON_,_WBHUE,YELLOW_);

//    vp3 = cWi(_title,"HTML_Colors",_pixmapon,_drawon,"save",_bhue,"yellow")

   vp3 = cWi("HTML_Colors")

  sWi(_WOID,vp3,_WDRAW,ON_,_WPIXMAP,ON_,_WSAVE,ON_,_WBHUE,YELLOW_);

  int allwins[] =  {cvp,bvp,vp3,txtwin,-1};
  <<"$allwins\n"

//  wrctile(allwins,0.1,0.1,0.9,0.9,2,2,0); // TBF 7/6/24 CPP

    wrctile(allwins,0.1,0.1,0.9,0.9,2,2);

 // titleButtonsQRD(bvp);  // TBF 7/6/24

  sWi(_WOID,vp3,_WREDRAW,ON_);

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

 // sWo(_WOID,bwo,_WNAME,"Blue",_WVALUE,bluev,_WBHUE,BLUE_);
  sWo(_WOID,bwo,_WNAME,"Blue",_WVALUE,bluev,_WBHUE,BLUE_);

 // rwo=cWo(bvp,_BS,_name,"Red",_value,redv)

    rwo=cWo(bvp,WO_BS_);

    sWo(_WOID,rwo,_WNAME,"RED",_WVALUE,redv,_WHUE,RED_);

  gwo=cWo(bvp,WO_BS_);

  sWo(_WOID,gwo,_WNAME,"Green",_WVALUE,greenv,_WHUE,GREEN_);



  int rgbwo[] = { rwo, gwo, bwo,  -1 };
  
 // sWo(rgbwo,_style,"SVL",_WDRAWON,_penhue,BLACK_,_symbol,TRI_,_eo)

  wovtile( rgbwo, cbx,cby,cbX,cbY,3);
  i=0;
  while (rgbwo[i] >0 ) {
   sWo( _WOID, rgbwo[i++],_WSTYLE,"SVL",_WDRAW,ON_,_WHUE,BLACK_,_WSYMBOL,TRI_,_WREDRAW,ON_);
  }




 


    qwo=cWo(bvp,WO_BN_);
    sWo(_WOID, qwo,_WNAME,"QUIT?",_WVALUE,"QUIT",_WCOLOR,ORANGE_,_WRESIZE,wbox(bx,by,bX,bY));

  by = bY + 0.02
  bY = by + dY

  nxtcolwo=cWo(bvp,WO_BN_)

  //sWo(_WOID,nxtcolwo,_WNAME,"Next",_WVALUE,"NextColor",_WCOLOR,CYAN_,_WRESIZE_FR,wbox(bx,by,bX,bY))

  //_WRESIZE_FR not recognized CPP TBF 7/6/24
  // TBF missing tag,val pair  show ERROR CPP compile will fail! --- shows error(glitch)  marks statement as SBAD continues

  sWo(_WOID,nxtcolwo,_WNAME,"Next",_WVALUE,"NextColor",_WCOLOR,CYAN_,_WRESIZE,wbox(bx,by,bX,bY))

  sWo(_WOID,qwo,_WBORDER,ON_,_WDRAW,ON_,_WCLIPBORDER,BLACK_,_WFONTHUE,BLACK_, _WSTYLE, "SVB", _WREDRAW,ON_)

  sWo(_WOID,nxtcolwo,_WBORDER,ON_,_WDRAW,ON_,_WCLIPBORDER,ON_,_WFONTHUE,BLACK_, _WSTYLE, "SVB", _WREDRAW,ON_)

  // these are a list of values that the color wo can have  - each click cycles thru them


 // frgb = vgen(FLOAT_,20,0,0.05)

     Vec frgb(<float>,20,0,0.05)
     
//<<"%(,,\,,)4.2f$frgb \n"



     cvals= "0,0.05,0.1,0.15,0.2,0.25,0.3,0.35,0.4,0.45,0.5,0.55,0.6,0.65,0.7,0.75,0.8,0.85,0.9,0.95,1.0"

     i=0;

    while (rgbwo[i] >0 ) {

//sWo(_WOID, rgbwo[i],_CSV,"%(,,\,,)4.2f$frgb",20,_WREDRAW,ON_)

     sWo(_WOID,rgbwo[i],_WCSV,cvals,_WREDRAW,ON_);

    // ans=ask("%V$i $rgbwo[i]",1)
     i++;

    }


    
 // setgwin(bvp,"woredrawall")

   two=cWo(txtwin,WO_TEXT_);
   
    sWo(_WOID,two,_WNAME,"Text",_WVALUE,"howdy",_WCOLOR,ORANGE_,_WRESIZE,wbox(0.1,0.1,0.9,0.9));

    sWo(_WOID,two,_WBORDER,BLACK_,_WDRAW, ON_,_WCLIPBORDER,BROWN_,_WFONTHUE,BLUE_, _WREDRAW,ON_);

 // ?  _pixmapoff ?


     int awo[4]

     index = 150;

     for (k = 0; k < 4; k++) { 
  //      awo[k]=cWo(cvp,_GRAPH,_name,"${k}_col",_color,index,_value,k)
             awo[k]=cWo(cvp,WO_GRAPH_)
	     sWo(_WOID,awo[k],_WNAME,"${k}_col",_WCOLOR,index,_WVALUE,k);
        index++;
     }


<<"%V$awo \n"

  //sWo(awo,_border,_drawon,_CLIPBORDER)

  wovtile(awo,0.1,0.1,0.9,0.9,4)


  // contrast ?
  // make smaller clip area for awo[0]
  //sWo(awo[0],_cbhue,152)
  //sWo(awo[0],_clip,0.1,0.1,0.5,0.5)

int htwo[4]

     index = 1;

     for (k = 0; k < 4; k++) { 
      htwo[k]=cWo(vp3,WO_GRAPH_)
      sWo(_WOID,htwo[k],_WNAME,"${k}_col",_WCOLOR,index,_WVALUE,k,_WBORDER,BLACK_,_WREDRAW,ON_);
      index++;
     }


<<"%V$htwo \n"


  wovtile(htwo,0.1,0.1,0.9,0.9, 4)



 redv = 0.52;
 greenv = 0.63;
 bluev = 0.74;

  //redv.pinfo();
  
<<"%V $redv $greenv $bluev \n"

  sWo(_WOID,rwo,_WVALUE,redv)
  sWo(_WOID,bwo,_WVALUE,bluev)
    sWo(_WOID,gwo,_WVALUE,greenv)
  
      rwoval = woGetValue(rwo)
      gwoval = woGetValue(gwo)
      bwoval = woGetValue(bwo)      

   redv   = satof( woGetValue(rwo));
   greenv = satof ( woGetValue(gwo))
   bluev  =  satof ( woGetValue(bwo))

<<"%V $redv $greenv $bluev \n"
// rwoval.pinfo()
<<"%V $rwoval $gwoval $bwoval \n"
 //ans = ask("$redv $rwoval ",1)


  i= 0;
  while (rgbwo[i] > 0) {
    sWo(_WOID,rgbwo[i++],_WVALUE,0.4,_WREDRAW,ON_);
//    i++;
  }
  


//ask=query("where are we?");

//////////////////// BKG LOOP ////////////////////////////////
// Event vars



  Gevent Gev ;

  Gev.pinfo();



Str icname = "blue";
Str cname = "red";
Str scname = "red";
Str txw;

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

  txw = txr.getTxt() ;  // want this to go to a str
  
  <<"%V $txw \n"
  

//ans= ask("%V $txw ?",1)  // TBF 7/6/24 need an CPP trans
///////////////////////////////////////////////////// interactive loop ////
Vec<float> rgb(4);

// easy ref  items 
int button;
int woid;



   int ke=0;

while (1) {

    Gev.eventWait()
    ke++;

      button=Gev.getEventButton();
      woid = Gev.getEventWoid();


      rwoval = woGetValue(rwo)
      gwoval = woGetValue(gwo)
      bwoval = woGetValue(bwo)      

<<"GOT EVENT %V $ke  $button $woid $rwoval $gwoval $bwoval \n"

   sWo(_WOID,rwo,_WBHUE,r_index,_WCLEARCLIP,r_index,_WCLIPBORDER,RED_);
     ctxt=<<" Red $redv "
     
   sWo(_WOID,rwo,_WBHUE,r_index,_WTEXTHUE,WHITE_,_WTEXTR,txr.setTextr(ctxt,0.1,0.21,GREEN_),_WCLIPBORDER,RED_);

   sWo(_WOID,gwo,_WBHUE,g_index,_WCLEARCLIP,g_index,_WCLIPBORDER,RED_);  
ctxt = <<"Green  $greenv "
sWo(_WOID,gwo,_WBHUE,g_index,_WTEXTHUE,WHITE_,_WTEXTR,txr.setTextr(ctxt,0.1,0.21,RED_),_WCLIPBORDER,RED_);
ctxt = <<"%V $bluev "
   sWo(_WOID,bwo,_WBHUE,b_index,_WCLEARCLIP,b_index,_WCLIPBORDER,RED_);
txr.setTextr( ctxt,  0.1,0.21,WHITE_)
sWo(_WOID,bwo,_WBHUE,b_index,_WTEXTHUE,WHITE_,_WTEXTR,txr,_WCLIPBORDER,RED_);

    //ans= ask("check stack $(txr.getTxt())",0) // TBF vmf in pex ?


 
  bluev= satof ( woGetValue(bwo))
  redv= satof ( woGetValue(rwo))
  greenv= satof ( woGetValue(gwo))

 <<" %V $bluev $redv $greenv" 

   
 
 if (woid == nxtcolwo) {

    cindex++
 <<"just next $cindex \n"
    //rgb = getRGB(cindex)
    rgb[0] = getRed(cindex)
    rgb[1] = getGreen(cindex)    
    rgb[2] = getBlue(cindex)    
    <<"getRGB  $rgb[0] $rgb[1] $rgb[2] \n"

    redv = rgb[0]
    greenv = rgb[1]
    bluev = rgb[2]

   setRGB(r_index,redv,0,0)
   setRGB(rgb_index,redv,greenv,bluev)
   setRGB(rg_index,redv,greenv,0)
   setRGB(rb_index,redv,0,bluev)
   setRGB(gb_index,0,greenv,bluev) 
   }
   else {
   setRGB(r_index,redv,0,0)
   setRGB(rgb_index,redv,greenv,bluev)
   setRGB(rg_index,redv,greenv,0)
   setRGB(rb_index,redv,0,bluev)
   setRGB(gb_index,0,greenv,bluev)
      setRGB(g_index,0,greenv,0)
      setRGB(b_index,0,0,bluev);       

    cindex = getColorIndexFromRGB(redv,greenv,bluev)
   
   }

  sWo(_WOID,rwo,_WVALUE,redv)
  sWo(_WOID,bwo,_WVALUE,bluev)
  sWo(_WOID,gwo,_WVALUE,greenv)
  

  // sWo(rgbwo,_redraw)
  // TBC ?tr
 //   ctxt= <<" RGB %V %6.2f $redv $greenv $bluev"
    ctxt= <<" RGB %V $redv $greenv $bluev"
txr.setTextr(ctxt,0,0.5)
    <<"%V $ctxt\n"

    sWo(_WOID,two,_WCLEAR,ON_,_WTEXTR,txr); 
 //  sWo(_WOID,two,_WCLEAR,ON_,_WTEXTR,txr.setTextr(ctxt,0,0.5)); 

   //sWo(awo,_bhue,cindex,_clear,_clipborder,_redraw)  // clears repaints
   //sWo(awo,_clearclip,_redraw)  // clears repaints

   sWo(_WOID,htwo[0],_WBHUE,cindex,_WTEXTHUE,BLACK_,_WCLEARCLIP,cindex,_WCLIPBORDER,BLUE_, _WREDRAW,ON_)


   cname = getColorName(cindex);
   //<<"%V $cname $cindex \n"

    ctxt= <<"CN %V $cname $cindex" 
   txr.setTextr(ctxt,0,0.4)
   sWo(_WOID,two,_WTEXTR,txr,_WCLIPBORDER,RED_);

  // sWo(_WOID,htwo[0],_WTEXTHUE,BLACK_,_WTEXTR,txr.setTextr("$cname",bctx,0.52),_WCLIPBORDER,RED_)); // TBF should be flagged as SBAD -- extra )
    ctxt= <<"$cname" 
   txr.setTextr(ctxt,bctx,0.52)
   sWo(_WOID,htwo[0],_WTEXTHUE,BLACK_,_WTEXTR,txr,_WCLIPBORDER,RED_);
   txr.setTextr(ctxt,wctx,0.52)
txr.setXY(0.1, 0.21);  txr.setHue(WHITE_);
   sWo(_WOID,htwo[0],_WTEXTHUE,WHITE_,_WTEXTR,txr,_WCLIPBORDER,RED_);
   //sWo(_WOID,htwo[1],_texthue,"white",_textr,"$cname",wctx,0.5,_eo); //?

   icindex = getColorIndexFromRGB(1-redv,1-greenv,1-bluev)


   //<<"%V $icindex \n";

   sWo(_WOID,htwo[1],_WBHUE,icindex,_WTEXTHUE,BLACK_,_WCLEARCLIP,icindex,_WCLIPBORDER,RED_);
   
   icname = getColorName(icindex)
   ctxt= <<"$icname" 
//ask=query("where are we? $icname");

   txr.setTextr(ctxt,bctx,0.52)
   sWo(_WOID,htwo[1],_WTEXTHUE,BLACK_,_WTEXTR,txr,_WCLIPBORDER,RED_);
   txr.setTextr(ctxt,wctx,0.52,WHITE_)
   sWo(_WOID,htwo[1],_WTEXTHUE,WHITE_,_WTEXTR,txr);

   //<<"%V $icname $icindex \n"


   // swap red & blue
   scindex = getColorIndexFromRGB(bluev,greenv,redv)
   scname = getColorName(scindex)

   sWo(_WOID,htwo[2],_WBHUE,scindex,_WTEXTHUE,BLACK_,_WCLEARCLIP,scindex,_WCLIPBORDER,RED_);

ctxt= <<"$scname"

txr.setTextr(ctxt,bctx,0.51)
   sWo(_WOID,htwo[2],_WTEXTHUE,BLACK_,_WTEXTR,txr,_WCLIPBORDER,RED_);
   txr.setTextr(ctxt,wctx,0.5)
   sWo(_WOID,htwo[2],_WTEXTHUE,WHITE_,_WTEXTR,txr,_WCLIPBORDER,RED_);
 // swap green & blue
   scindex = getColorIndexFromRGB(redv,bluev,greenv)
   scname = getColorName(scindex)

ctxt= <<"$scname"

txr.setTextr(ctxt,bctx,0.51)
    sWo(_WOID,htwo[3],_WBHUE,scindex,_WTEXTHUE,BLACK_,_WCLEARCLIP,scindex,_WCLIPBORDER,RED_);

   sWo(_WOID,htwo[3],_WTEXTHUE,BLACK_,_WTEXTR,txr,_WCLIPBORDER,RED_);
   txr.setTextr(ctxt,wctx,0.5)
   sWo(_WOID,htwo[3],_WTEXTHUE,WHITE_,_WTEXTR,txr,_WCLIPBORDER,RED_);

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

    sWo(_WOID,awo[0],_WBHUE,rg_index,_WTEXTHUE,BLACK_,_WCLEARCLIP,rg_index,_WCLIPBORDER,RED_);

  txw = txr.getTxt()
//  ans= ask("%V $txw ?",0)
   txr.setHue(BLACK_);
  sWo(_WOID, awo0, _WTEXTHUE, BLACK_, _WTEXTR, txr, _WCLIPBORDER, RED_);

  txr.setXY(0.1, 0.21);  txr.setHue(WHITE_);

   sWo(_WOID, awo[0], _WTEXTHUE, WHITE_, _WTEXTR, txr, _WCLIPBORDER, RED_);     

    awo1 = awo[1]
     ctxt = <<"%6.2f Red $redv + Blue $bluev " 
     txr.setTextr(ctxt, 0.1, 0.61, BLACK_, 0)

    sWo(_WOID, awo[1], _WBHUE, rb_index, _WTEXTHUE, BLACK_, _WCLEARCLIP, rb_index, _WCLIPBORDER, RED_);

    blk= WHITE_;

   sWo(_WOID, awo[1], _WTEXTHUE, blk, _WTEXTR,  txr , _WCLIPBORDER,  RED_);

   txr.pinfo()
   txw = txr.getTxt()
 //  ans= ask("%V $txw ?", 0)
   txr.setXY(0.1, 0.21);
   txr.setHue(WHITE_);


    sWo(_WOID, awo[1], _WTEXTHUE, WHITE_, _WTEXTR, txr, _WCLIPBORDER, RED_);     

     //sWo(_WOID,awo[2],_WTEXTR,txr,_WCLIPBORDER,RED_);

    ctxt= <<"%6.2f Green $greenv + Blue $bluev  "

    <<"%V $ctxt\n"


    txr.setTextr( ctxt , 0.1, 0.61, 1, 0)
     
     sWo(_WOID, awo[2], _WBHUE, gb_index, _WTEXTHUE, BLACK_, _WCLEARCLIP, gb_index, _WCLIPBORDER, RED_);
     txr.setHue(WHITE_); txr.setXY(0.1, 0.61);

     // TBF 7/8/24 can't do txr.setTextr( ctxt , 0.1, 0.61, 1, 0) as an arg ASL?
     
     sWo(_WOID, awo[2], _WTEXTHUE, WHITE_, _WTEXTR, txr, _WCLIPBORDER, RED_);

     txr.setXY(0.1, 0.21); txr.setHue(BLACK_);
  
    //sWo(_WOID,awo[2],_WTEXTHUE,BLACK_,_WTEXTR,txr_WCLIPBORDER,RED_);  // bad parse detected labelled SBAD no XIC 
    sWo(_WOID, awo[2], _WTEXTHUE, BLACK_, _WTEXTR, txr, _WCLIPBORDER, RED_);     

     ctxt= <<"%6.2f Red $redv + Green $greenv + Blue $bluev"

     txr.setTextr(ctxt, 0.1, 0.61, BLACK_, 0)


     sWo(_WOID, awo[3], _WBHUE, rgb_index, _WTEXTHUE, BLACK_, _WCLEARCLIP, rgb_index, _WCLIPBORDER, RED_);
     
 //    txr.setHue(BLACK_); txr.setXY(0.1,0.61);


     sWo(_WOID,  awo[3],  _WTEXTHUE,  BLACK_,  _WTEXTR,  txr,  _WCLIPBORDER,  RED_);
      // txr.setXY((0.1,0.21);
      txr.setXY(0.1, 0.21); txr.setHue(LILAC_);
     sWo(_WOID, awo[3], _WTEXTHUE, WHITE_, _WTEXTR, txr, _WCLIPBORDER, RED_);     

     // use Textr asl function to process the text parameters during the sWo call --  compatible with  cpp version
     // which uses a Textr object and passes that via this pointer
     //   so this still looks like and tag, value pair to both asl and cpp

 

    //<<"%V $woid  $qwo \n"

   if (woid == qwo) {
       break
   }



  }


// exit_gs() // TBF 7/6/24

   chkOut(1);

#if __CPP__
  exit_cpp();
  exit(-1); 
  }  /// end of C++ main 
#endif     


//==============\_(^-^)_/==================//
