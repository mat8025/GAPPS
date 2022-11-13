//
// Show some colors
//

#include "debug"

#define ASL 1

Graphic = checkGWM()

  if (!Graphic) {
    Xgm = spawnGWM()
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


 redv = 0.5;
 greenv = 0.45;
 bluev = 0.75;
 
#include "tbqrd"

  //  bvp = cWi("title","Button",_pixmapon,_drawon,"save",_bhue,WHITE_)

  bvp = cWi("Button")
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
  w_rctile(allwins,0.1,0.1,0.9,0.9,2,2,0);

  titleButtonsQRD(bvp);

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


  bwo=cWo(bvp,WO_BS_);

  sWo(_WOID,bwo,_WNAME,"Blue",_WVALUE,bluev,_WBHUE,BLUE_);

 // rwo=cWo(bvp,_BS,_name,"Red",_value,redv)

    rwo=cWo(bvp,WO_BS_);

    sWo(_WOID,rwo,_WNAME,"Red",_WVALUE,redv,_WHUE,RED_);

  //sWo(rwo,_color,r_index,_bhue,RED_)
  //sWo(rwo,_color,RED_,_bhue,r_index)    // bhue is main background fill hue --
  //sWo(rwo,_color,RED_,_bhue,RED_)

//  gwo=cWo(bvp,_BS,_clipbhue,GREEN_,_name,"Green",_value,greenv)

//  sWo(gwo,_color,GREEN_)

  gwo=cWo(bvp,WO_BS_);

  sWo(_WOID,gwo,_WNAME,"Green",_WVALUE,greenv,_WHUE,GREEN_);


 // bwo=cWo(bvp,_BS,_bhue,BLUE_,_NAME,"Blue",_value,bluev)

  //sWo(bwo,_color,BLUE_,_penhue,WHITE_)







  int rgbwo[] = { rwo, gwo, bwo,  -1 };
  
 // sWo(rgbwo,_style,"SVL",_WDRAWON,_penhue,BLACK_,_symbol,TRI_,_eo)

  wovtile( rgbwo, cbx,cby,cbX,cbY,0.05);
  i=0;
  while (rgbwo[i] >0 ) {
   sWo( _WOID, rgbwo[i++],_WSTYLE,"SVL",_WDRAW,ON_,_WHUE,BLACK_,_WSYMBOL,TRI_,_WREDRAW,ON_);
  }


   redv   = atof( wogetValue(rwo));
   greenv = atof ( wogetValue(gwo))
   bluev  =  atof ( wogetValue(bwo))

<<"%V $redv $greenv $bluev \n"

//  qwo=cWo(bvp,_BN,_name,"QUIT?",_VALUE,"QUIT",_color,"orange",_resize_fr,bx,by,bX,bY,_eo)

    qwo=cWo(bvp,WO_BN_);
    sWo(_WOID, qwo,_WNAME,"QUIT?",_WVALUE,"QUIT",_WCOLOR,ORANGE_,_WRESIZE_FR,wbox(bx,by,bX,bY));

  by = bY + 0.02
  bY = by + dY

  nxtcolwo=cWo(bvp,_BN,_name,"Next",_VALUE,"NextColor",_WCOLOR,CYAN_,_WRESIZE_FR,wbox(bx,by,bX,bY))

  sWo(_WOID,qwo,_WBORDER,_WDRAW,ON_,_WCLIPBORDER,BLACK_,_WFONTHUE,BLACK_, _WSTYLE, "SVB", _WREDRAW,ON_)

  sWo(_WOID,nxtcolwo,_WBORDER,ON_,_WDRAW,ON_,_WCLIPBORDER,ON_,_WFONTHUE,BLACK_, _WSTYLE, "SVB", _WREDRAW,ON_)

  // these are a list of values that the color wo can have  - each click cycles thru them


  frgb = vgen(FLOAT_,20,0,0.05)

<<"%(,,\,,)4.2f$frgb \n"


//  sWo(rgbwo,_CSV,"0,0.05,0.1,0.15,0.2,0.25,0.3,0.35,0.4,0.45,0.5,0.55,0.6,\
//           0.65,0.7,0.75,0.8,0.85,0.9,0.95,1.0", 20,_REDRAW)
     cvals= "0,0.05,0.1,0.15,0.2,0.25,0.3,0.35,0.4,0.45,0.5,0.55,0.6,0.65,0.7,0.75,0.8,0.85,0.9,0.95,1.0"

i=0;
    while (rgbwo[i] >0 ) {

//sWo(_WOID, rgbwo[i],_CSV,"%(,,\,,)4.2f$frgb",20,_WREDRAW,ON_)

sWo(_WOID,rgbwo[i++],_CSV,cvals,20,_WREDRAW);
      <<"%V$i $rgbwo[i]\n"

    }

//sWo(bwo,_CSV,"0,0.05,0.1,0.15,0.2,0.25,0.3,0.35,0.4,0.45,0.5,0.55,0.6,\
//            0.65,0.7,0.75,0.8,0.85,0.9,0.95,1.0", 20, _WREDRAW)



    
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

  wo_vtile(awo,0.1,0.1,0.9,0.9)


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


  wo_vtile(htwo,0.1,0.1,0.9,0.9)


   redv   = atof( wogetValue(rwo));
   greenv = atof ( wogetValue(gwo))
   bluev  =  atof ( wogetValue(bwo))

<<"%V $redv $greenv $bluev \n"

 redv = 0.5;
 greenv = 0.5;
 bluev = 0.5;

<<"%V $redv $greenv $bluev \n"
  i= 0;
  while (rgbwo[i] > 0) {
    sWo(_WOID,rgbwo[i++],_WVALUE,0.4,_WREDRAW,ON_);
//    i++;
  }
  
   redv   = atof( wogetValue(rwo));
   greenv = atof ( wogetValue(gwo))
   bluev  =  atof ( wogetValue(bwo))

<<"%V $redv $greenv $bluev \n"



//ask=query("where are we?");

//////////////////// BKG LOOP ////////////////////////////////
// Event vars
<<"include gevent?\n"

#include "gevent.asl"

Str icname = "blue";
Str cname = "red";

bctx=0.4;
   wctx =0.6
   
   while (1) {

    eventWait()

    rval   = wogetValue(rwo);
<<"%V$rval\n"

     redv   = atof( wogetValue(rwo))
<<"%V$rval  $redv\n"

     greenv = atof ( wogetValue(gwo))
     bluev  =  atof ( wogetValue(bwo))

<<" $redv $bluev $greenv \n"

   sWo(_WOID,rwo,_WBHUE,r_index,_WCLEARCLIP,r_index,_WCLIPBORDER,RED_);
   sWo(_WOID,rwo,_WBHUE,r_index,_WTEXTHUE,WHITE_,_WTEXTR,"%6.2f Red $redv ",0.1,0.21,_WCLIPBORDER,RED_);

   sWo(_WOID,gwo,_WBHUE,g_index,_WCLEARCLIP,g_index,_WCLIPBORDER,RED_);
   sWo(_WOID,gwo,_WBHUE,g_index,_WTEXTHUE,WHITE_,_WTEXTR,"%6.2f Green $greenv ",0.1,0.21,_WCLIPBORDER,RED_);

   sWo(_WOID,bwo,_WBHUE,b_index,_WCLEARCLIP,b_index,_WCLIPBORDER,RED_);
   sWo(_WOID,bwo,_WBHUE,b_index,_WTEXTHUE,WHITE_,_WTEXTR,"%6.2f Blue $bluev ",0.1,0.21,_WCLIPBORDER,RED_);


   if (Ev_woid == nxtcolwo) {
<<"just next $cindex \n"
    cindex++
    rgb = getRGB(cindex)
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

  // sWo(rgbwo,_redraw)
  // TBC ?
   sWo(_WOID,two,_WCLEAR,ON_,_WTEXTR," %V  $redv $greenv $bluev",0,0.5); 

   //sWo(awo,_bhue,cindex,_clear,_clipborder,_redraw)  // clears repaints
   //sWo(awo,_clearclip,_redraw)  // clears repaints

   sWo(_WOID,htwo[0],_WBHUE,cindex,_WTEXTHUE,BLACK_,_WCLEARCLIP,cindex,_WCLIPBORDER,BLUE_, _WREDRAW,ON_)


   cname = getColorName(cindex);
   <<"%V $cname $cindex \n"

   sWo(_WOID,two,_WTEXTR,"%V $cname $cindex ",0,0.4,_WCLIPBORDER,RED_);

   sWo(_WOID,htwo[0],_WTEXTHUE,BLACK_,_WTEXTR,"$cname",bctx,0.52,_WCLIPBORDER,RED_);
   sWo(_WOID,htwo[0],_WTEXTHUE,WHITE_,_WTEXTR,"$cname",wctx,0.5,_WCLIPBORDER,RED_);
   //sWo(_WOID,htwo[1],_texthue,"white",_textr,"$cname",wctx,0.5,_eo); //?

   icindex = getColorIndexFromRGB(1-redv,1-greenv,1-bluev)


<<"%V $icindex \n";

   sWo(_WOID,htwo[1],_WBHUE,icindex,_WTEXTHUE,BLACK_,_WCLEARCLIP,icindex,_WCLIPBORDER,RED_);
   
   icname = getColorName(icindex)
   
//ask=query("where are we? $icname");
   sWo(_WOID,htwo[1],_WTEXTHUE,BLACK_,_WTEXTR,"$icname",bctx,0.5,_WCLIPBORDER,RED_);
   sWo(_WOID,htwo[1],_WTEXTHUE,WHITE_,_WTEXTR,"$icname",wctx,0.52);

   <<"%V $icname $icindex \n"


   // swap red & blue
   scindex = getColorIndexFromRGB(bluev,greenv,redv)
   scname = getColorName(scindex)

   sWo(_WOID,htwo[2],_WBHUE,scindex,_WTEXTHUE,BLACK_,_WCLEARCLIP,scindex,_WCLIPBORDER,RED_);


   sWo(_WOID,htwo[2],_WTEXTHUE,BLACK_,_WTEXTR,"$scname ",bctx,0.51,_WCLIPBORDER,RED_);
   sWo(_WOID,htwo[2],_WTEXTHUE,WHITE_,_WTEXTR,"$scname ",wctx,0.5,_WCLIPBORDER,RED_);

   //cname = getColorName(windex)

   //windex++

   sWo(_WOID,htwo[3],_WBHUE,rgb_index,_WTEXTHUE,BLACK_,_WCLEARCLIP,rgb_index,_WCLIPBORDER,RED_);
   
     sWo(_WOID,awo[3],_WBHUE,rgb_index,_WTEXTHUE,BLACK_,_WCLEARCLIP,rgb_index,_WTEXTR,"%6.2f Red $redv Green $greenv Blue $bluev ",0.1,0.61,_WCLIPBORDER,RED_);
     sWo(_WOID,awo[3],_WTEXTHUE,WHITE_,_WTEXTR,"%6.2f Red $redv Green $greenv Blue $bluev ",0.1,0.21,_WCLIPBORDER,RED_);     

          sWo(_WOID,awo[0],_WBHUE,rg_index,_WTEXTHUE,BLACK_,_WCLEARCLIP,rg_index,_WCLIPBORDER,RED_);

     sWo(_WOID,awo[0],_WTEXTHUE,BLACK_,_WTEXTR,"%6.2f Red $redv Green $greenv  ",0.1,0.61,_WCLIPBORDER,RED_);
     sWo(_WOID,awo[0],_WTEXTHUE,WHITE_,_WTEXTR,"%6.2f Red $redv Green $greenv  ",0.1,0.21,_WCLIPBORDER,RED_);     


          sWo(_WOID,awo[1],_WBHUE,rb_index,_WTEXTHUE,BLACK_,_WCLEARCLIP,rb_index,_WCLIPBORDER,RED_);
     sWo(_WOID,awo[1],_WTEXTHUE,BLACK_,_WTEXTR,"%6.2f Red $redv Blue $bluev  ",0.1,0.61,_WCLIPBORDER,RED_);
     sWo(_WOID,awo[1],_WTEXTHUE,WHITE_,_WTEXTR,"%6.2f Red $redv Blue $bluev  ",0.1,0.21,_WCLIPBORDER,RED_);     

sWo(_WOID,awo[2],_WBHUE,gb_index,_WTEXTHUE,BLACK_,_WCLEARCLIP,gb_index,_WCLIPBORDER,RED_);	  
     sWo(_WOID,awo[2],_WTEXTHUE,BLACK_,_WTEXTR,"%6.2f Green $greenv Blue $bluev  ",0.1,0.61,_WCLIPBORDER,RED_);
     sWo(_WOID,awo[2],_WTEXTHUE,WHITE_,_WTEXTR,"%6.2f Green $greenv Blue $bluev  ",0.1,0.21,_WCLIPBORDER,RED_);     

   if (Ev_woid == qwo) {
       break
   }
  }


 exit_gs()




;