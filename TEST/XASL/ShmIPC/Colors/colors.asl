//
// Show some colors
//

#include "debug"



Graphic = checkGWM()

  if (!Graphic) {
    Xgm = spawnGWM()
  }

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

    bvp = cWi("title","Button",@pixmapon,@drawon,"save",@bhue,WHITE_)

    txtwin = cWi("title","MC_INFO",@pixmapon,@drawon,"save","bhue","white")

    cvp = cWi("title","Colors",@pixmapon,@drawon,@save,@cbhue,"yellow")

    vp3 = cWi(@title,"HTML_Colors",@pixmapon,@drawon,"save",@bhue,"yellow")

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


  rwo=cWo(bvp,@BS,@name,"Red",@value,redv)

  //sWo(rwo,@color,r_index,@bhue,RED_)
  //sWo(rwo,@color,RED_,@bhue,r_index)    // bhue is main background fill hue --
  sWo(rwo,@color,RED_,@bhue,RED_)

  gwo=cWo(bvp,@BS,@clipbhue,GREEN_,@name,"Green",@value,greenv)

  sWo(gwo,@color,GREEN_)

  bwo=cWo(bvp,@BS,@bhue,BLUE_,@NAME,"Blue",@value,bluev)

  sWo(bwo,@color,BLUE_,@penhue,WHITE_)

  int rgbwo[] = { rwo, gwo, bwo };
  
  sWo(rgbwo,@style,"SVL",@drawon,@penhue,BLACK_,@symbol,TRI_)

  wo_vtile( rgbwo, cbx,cby,cbX,cbY,0.05)

   redv   = atof( wogetValue(rwo))
   greenv = atof ( wogetValue(gwo))
   bluev  =  atof ( wogetValue(bwo))

<<"%V $redv $greenv $bluev \n"

  qwo=cWo(bvp,@BN,@name,"QUIT?",@VALUE,"QUIT",@color,"orange",@resize_fr,bx,by,bX,bY)

  by = bY + 0.02
  bY = by + dY

  nxtcolwo=cWo(bvp,@BN,@name,"Next",@VALUE,"NextColor",@color,"cyan",@resize_fr,bx,by,bX,bY)

  sWo(qwo,@border,@drawon,@clipborder,@fonthue,BLACK_, @style, "SVB", @redraw)

  sWo(nxtcolwo,@border,@drawon,@clipborder,@fonthue,"black", @style, "SVB", @redraw)

  // these are a list of values that the color wo can have  - each click cycles thru them


  frgb = vgen(FLOAT_,20,0,0.05)

//<<"%(,,\,,)4.2f$frgb \n"

\{
  sWo(rgbwo,@CSV,"0,0.05,0.1,0.15,0.2,0.25,0.3,0.35,0.4,0.45,0.5,0.55,0.6,\
            0.65,0.7,0.75,0.8,0.85,0.9,0.95,1.0", @REDRAW)
\}

  sWo(rgbwo,@CSV,"%(,,\,,)4.2f$frgb",10,@REDRAW)

  setgwin(bvp,"woredrawall")

 two=cWo(txtwin,"TEXT",@name,"Text",@VALUE,"howdy",@color,"orange",@resize,0.1,0.1,0.9,0.9)

 sWo(two,@border,@drawon,@clipborder,@fonthue,"black", @redraw,@pixmapoff)


int awo[4]

     index = 150;

     for (k = 0; k < 4; k++) { 
        awo[k]=cWo(cvp,@GRAPH,@name,"${k}_col",@color,index,@value,k)
        index++
     }


<<"%V$awo \n"

  sWo(awo,@border,@drawon,@CLIPBORDER)

  wo_vtile(awo,0.1,0.1,0.9,0.9)


  // contrast ?
  // make smaller clip area for awo[0]
  //sWo(awo[0],@cbhue,152)
  //sWo(awo[0],@clip,0.1,0.1,0.5,0.5)

int htwo[3]

     index = 1;

     for (k = 0; k < 3; k++) { 
      htwo[k]=cWo(vp3,@GRAPH,@name,"${k}_col",@color,index,@value,k)
      index++
     }


<<"%V$htwo \n"

  sWo(htwo,@border,@drawon,@clipborder)

  wo_vtile(htwo,0.1,0.1,0.9,0.9)


   redv   = atof( wogetValue(rwo))
   greenv = atof ( wogetValue(gwo))
   bluev  =  atof ( wogetValue(bwo))

<<"%V $redv $greenv $bluev \n"

 redv = 0.5;
 greenv = 0.5;
 bluev = 0.5;

<<"%V $redv $greenv $bluev \n"

 swo(rgbwo,@value,0.6,@redraw);

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

   sWo(rgbwo,@redraw)

   sWo(two,@clear,@textr,"$_emsg %V $_ebutton $redv $greenv $bluev",0,0.5)

   //sWo(awo,@bhue,cindex,@clear,@clipborder,@redraw)  // clears repaints
   sWo(awo,@clearclip,@redraw)  // clears repaints

   sWo(htwo[0],@bhue,cindex,@texthue,"black",@clearclip,cindex,@clipborder,"black", @redraw)


   cname = getColorName(cindex)
   sWo(two,@textr,"%V $cname $cindex ",0,0.4)
   sWo(htwo[0],@texthue,"black",@textr,"$cname",bctx,0.52)
   sWo(htwo[0],@texthue,"white",@textr,"$cname",wctx,0.5)

   icindex = getColorIndexFromRGB(1-redv,1-greenv,1-bluev)

   sWo(htwo[1],@bhue,icindex,@texthue,"black",@clearclip,icindex,@clipborder,"red", @redraw)
   icname = getColorName(icindex)

   sWo(htwo[1],@texthue,"black",@textr,"$icname",bctx,0.5)
   sWo(htwo[1],@texthue,"white",@textr,"$icname",wctx,0.52)
   
   // swap red & blue
   scindex = getColorIndexFromRGB(bluev,greenv,redv)
   scname = getColorName(scindex)

   sWo(htwo[2],@bhue,scindex,@texthue,"black",@clearclip,scindex,@clipborder,"red", @redraw)
   sWo(htwo[2],@texthue,"black",@textr,"$scname",bctx,0.51)
   sWo(htwo[2],@texthue,"white",@textr,"$scname",wctx,0.5)

   //cname = getColorName(windex)

   //windex++

   if (_ewoid== qwo) {
       break
   }
  }


 exit_gs()




;