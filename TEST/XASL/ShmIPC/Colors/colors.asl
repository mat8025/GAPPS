//
// Show some colors
//

#include "debug"



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
 greenv = 0.5;
 bluev = 0.5;
 
#include "tbqrd"

    bvp = cWi("title","Button",_pixmapon,_drawon,"save",_bhue,WHITE_)

    txtwin = cWi("title","MC_INFO",_pixmapon,_drawon,"save","bhue","white")

    cvp = cWi("title","Colors",_pixmapon,_drawon,_save,_cbhue,"yellow")

    vp3 = cWi(_title,"HTML_Colors",_pixmapon,_drawon,"save",_bhue,"yellow")

  int allwins[] =  {cvp,bvp,vp3,txtwin}
  <<"$allwins\n"
  w_rctile(allwins,0.1,0.1,0.9,0.9,2,2,0);

  titleButtonsQRD(bvp);

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


  rwo=cWo(bvp,_BS,_name,"Red",_value,redv)

  //sWo(rwo,_color,r_index,_bhue,RED_)
  //sWo(rwo,_color,RED_,_bhue,r_index)    // bhue is main background fill hue --
  sWo(rwo,_color,RED_,_bhue,RED_)

  gwo=cWo(bvp,_BS,_clipbhue,GREEN_,_name,"Green",_value,greenv)

  sWo(gwo,_color,GREEN_)

  bwo=cWo(bvp,_BS,_bhue,BLUE_,_NAME,"Blue",_value,bluev)

  sWo(bwo,_color,BLUE_,_penhue,WHITE_)

  int rgbwo[] = { rwo, gwo, bwo };
  
  sWo(rgbwo,_style,"SVL",_drawon,_penhue,BLACK_,_symbol,TRI_,_eo)

  wo_vtile( rgbwo, cbx,cby,cbX,cbY,0.05)

   redv   = atof( wogetValue(rwo))
   greenv = atof ( wogetValue(gwo))
   bluev  =  atof ( wogetValue(bwo))

<<"%V $redv $greenv $bluev \n"

  qwo=cWo(bvp,_BN,_name,"QUIT?",_VALUE,"QUIT",_color,"orange",_resize_fr,bx,by,bX,bY,_eo)

  by = bY + 0.02
  bY = by + dY

  nxtcolwo=cWo(bvp,_BN,_name,"Next",_VALUE,"NextColor",_color,"cyan",_resize_fr,bx,by,bX,bY,_eo)

  sWo(qwo,_border,_drawon,_clipborder,_fonthue,BLACK_, _style, "SVB", _redraw)

  sWo(nxtcolwo,_border,_drawon,_clipborder,_fonthue,"black", _style, "SVB", _redraw)

  // these are a list of values that the color wo can have  - each click cycles thru them


  frgb = vgen(FLOAT_,20,0,0.05)

//<<"%(,,\,,)4.2f$frgb \n"

\{
  sWo(rgbwo,_CSV,"0,0.05,0.1,0.15,0.2,0.25,0.3,0.35,0.4,0.45,0.5,0.55,0.6,\
            0.65,0.7,0.75,0.8,0.85,0.9,0.95,1.0", _REDRAW)
\}

  sWo(rgbwo,_CSV,"%(,,\,,)4.2f$frgb",10,_REDRAW)

  setgwin(bvp,"woredrawall")

 two=cWo(txtwin,"TEXT",_name,"Text",_VALUE,"howdy",_color,"orange",_resize,0.1,0.1,0.9,0.9,_eo)

 sWo(two,_border,_drawon,_clipborder,_fonthue,"black", _redraw,_pixmapoff)


int awo[4]

     index = 150;

     for (k = 0; k < 4; k++) { 
        awo[k]=cWo(cvp,_GRAPH,_name,"${k}_col",_color,index,_value,k)
        index++
     }


<<"%V$awo \n"

  sWo(awo,_border,_drawon,_CLIPBORDER)

  wo_vtile(awo,0.1,0.1,0.9,0.9)


  // contrast ?
  // make smaller clip area for awo[0]
  //sWo(awo[0],_cbhue,152)
  //sWo(awo[0],_clip,0.1,0.1,0.5,0.5)

int htwo[3]

     index = 1;

     for (k = 0; k < 3; k++) { 
      htwo[k]=cWo(vp3,_GRAPH,_name,"${k}_col",_color,index,_value,k)
      index++
     }


<<"%V$htwo \n"

  sWo(htwo,_border,_drawon,_clipborder)

  wo_vtile(htwo,0.1,0.1,0.9,0.9)


   redv   = atof( wogetValue(rwo))
   greenv = atof ( wogetValue(gwo))
   bluev  =  atof ( wogetValue(bwo))

<<"%V $redv $greenv $bluev \n"

 redv = 0.5;
 greenv = 0.5;
 bluev = 0.5;

<<"%V $redv $greenv $bluev \n"

 swo(rgbwo,_value,0.6,_redraw);

   redv   = atof( wogetValue(rwo))
   greenv = atof ( wogetValue(gwo))
   bluev  =  atof ( wogetValue(bwo))

<<"%V $redv $greenv $bluev \n"





//////////////////// BKG LOOP ////////////////////////////////
// Event vars
<<"include gevent?\n"

include "gevent"


bctx=0.4;
   wctx =0.6
   
   while (1) {

    eventWait()

     redv   = atof( wogetValue(rwo))
     greenv = atof ( wogetValue(gwo))
     bluev  =  atof ( wogetValue(bwo))

<<" $redv $bluev $greenv \n"

   if (_ewoid == nxtcolwo) {
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

    cindex = getColorIndexFromRGB(redv,greenv,bluev)
   
   }

   sWo(rgbwo,_redraw)

   sWo(two,_clear,_textr,"$_emsg %V $_ebutton $redv $greenv $bluev",0,0.5,_eo)

   //sWo(awo,_bhue,cindex,_clear,_clipborder,_redraw)  // clears repaints
   sWo(awo,_clearclip,_redraw)  // clears repaints

   sWo(htwo[0],_bhue,cindex,_texthue,"black",_clearclip,cindex,_clipborder,"black", _redraw)


   cname = getColorName(cindex);
   sWo(two,_textr,"%V $cname $cindex ",0,0.4,_eo);
   sWo(htwo[0],_texthue,"black",_textr,"$cname",bctx,0.52,_eo);
   sWo(htwo[0],_texthue,"white",_textr,"$cname",wctx,0.5,_eo);

   icindex = getColorIndexFromRGB(1-redv,1-greenv,1-bluev)


<<"%V $icindex \n";

   sWo(htwo[1],_bhue,icindex,_texthue,"black",_clearclip,icindex,_clipborder,"red", _redraw);
   
   icname = getColorName(icindex)

   sWo(htwo[1],_texthue,"black",_textr,"$icname",bctx,0.5,_eo);
   sWo(htwo[1],_texthue,"white",_textr,"$icname",wctx,0.52,_eo);
   
   // swap red & blue
   scindex = getColorIndexFromRGB(bluev,greenv,redv)
   scname = getColorName(scindex)

   sWo(htwo[2],_bhue,scindex,_texthue,"black",_clearclip,scindex,_clipborder,"red", _redraw)
   sWo(htwo[2],_texthue,"black",_textr,"$scname",bctx,0.51,_eo);
   sWo(htwo[2],_texthue,"white",_textr,"$scname",wctx,0.5,_eo);

   //cname = getColorName(windex)

   //windex++

   if (_ewoid== qwo) {
       break
   }
  }


 exit_gs()




;