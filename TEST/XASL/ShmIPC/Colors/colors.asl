//
// Show some colors
//


Graphic = checkGWM()

  if (!Graphic) {
    Xgm = spawnGWM()
  }


 redv = 1.5
 greenv = 0.5
 bluev = 0.2
include "tbqrd"

    vp = cWi("title","Button",@resize,0.01,0.01,0.49,0.49,0)

    sWi(vp,@pixmapon,@drawon,"save","bhue","white")
  titleButtonsQRD(vp);
    txtwin = cWi("title","MC_INFO","resize",0.01,0.51,0.49,0.99,0)

    sWi(txtwin,@pixmapon,@drawon,"save","bhue","white")

    vp2 = cWi("title","Colors",@resize,0.51,0.51,0.99,0.99,0)

    sWi(vp2,@pixmapon,@drawon,@save,@cbhue,"yellow")

    vp3 = cWi(@title,"HTML_Colors",@resize,0.51,0.01,0.99,0.50,0)

    sWi(vp3,@pixmapon,@drawon,"save",@bhue,"yellow")

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


  rwo=cWo(vp,"BS",@resize,rx,cby,rX,cbY,@NAME,"Red",@VALUE,redv)

  sWo(rwo,@color,"red",@penhue,"black",@bhue,RED_,"symbol","tri",@style,"SVL","drawon")

  gwo=cWo(vp,"BS",@resize,gx,cby,gX,cbY,@clipbhue,GREEN_,@NAME,"Green",@VALUE,greenv)

  sWo(gwo,@color,"green",@penhue,"black","symbol","tri",@style,"SVL","drawon")

  bwo=cWo(vp,"BS",@resize,bx,cby,bX,cbY,@bhue,BLUE_,@NAME,"Blue",@VALUE,bluev)

  sWo(bwo,@color,BLUE_,@penhue,WHITE_,"symbol","tri",@style,"SVL",@drawon)

  qwo=cWo(vp,"BN",@name,"QUIT?",@VALUE,"QUIT",@color,"orange",@resize_fr,bx,by,bX,bY)

  by = bY + 0.02
  bY = by + dY

  cuwo=cWo(vp,"BN",@name,"Next",@VALUE,"NextColor",@color,"cyan",@resize_fr,bx,by,bX,bY)

  sWo(qwo,@border,@draw,@clipborder,@fonthue,"black", @style, "SVB", "redraw")

  sWo(cuwo,@BORDER,@DRAW,@CLIPBORDER,@FONTHUE,"black", @style, "SVB", "redraw")

  int rgbwo[] = { rwo, gwo, bwo }

  wo_vtile( rgbwo, cbx,cby,cbX,cbY,0.05)


  // these are a list of values that the color wo have can - each click cycles thru them


  frgb = vgen(FLOAT_,41,0,0.025)

//<<"%(,,\,,)4.2f$frgb \n"

\{
  sWo(rgbwo,@CSV,"0,0.05,0.1,0.15,0.2,0.25,0.3,0.35,0.4,0.45,0.5,0.55,0.6,\
            0.65,0.7,0.75,0.8,0.85,0.9,0.95,1.0", @REDRAW)
\}

  sWo(rgbwo,@CSV,"%(,,\,,)4.2f$frgb",@REDRAW)

  setgwin(vp,"woredrawall")

 two=cWo(txtwin,"TEXT",@name,"Text",@VALUE,"howdy",@color,"orange",@resize,0.1,0.1,0.9,0.9)

 sWo(two,@border,@drawon,@clipborder,@fonthue,"black", "redraw","pixmapoff")



int rgb_index =  150  // place this outside of most colors
int rgb_index2 = 151
int rgb_index3 = 152

int awo[3]

     index = 150

     for (k = 0; k < 3; k++) { 
        awo[k]=cWo(vp2,"GRAPH","name","${k}_col",@color,index,@value,k)
        index++
     }


<<"%V$awo \n"

  sWo(awo,@border,@drawon,@CLIPBORDER)

  wo_vtile(awo,0.1,0.1,0.9,0.9)

  // make smaller clip area for awo[0]

  sWo(awo[0],@cbhue,152)
  //sWo(awo[0],@clip,0.1,0.1,0.5,0.5)

int htwo[3]

     index = 1

     for (k = 0; k < 3; k++) { 
      htwo[k]=cWo(vp3,"GRAPH","name","${k}_col",@color,index,@value,k)
      index++
     }


<<"%V$htwo \n"

  sWo(htwo,@border,@drawon,@clipborder)

  wo_vtile(htwo,0.1,0.1,0.9,0.9)

//////////////////// BKG LOOP ////////////////////////////////
// Event vars
include "gevent"
   bctx=0.4;
   wctx =0.6
   
   while (1) {

    eventWait()

   redv   = atof( wogetValue(rwo))
   greenv = atof ( wogetValue(gwo))
   bluev  =  atof ( wogetValue(bwo))

<<" $redv $bluev $greenv \n"

   if (_ewoid == cuwo) {
<<"just next $cindex \n"
    cindex++
    rgb = getRGB(cindex)
    redv = rgb[0]
    greenv = rgb[1]
    bluev = rgb[2]
   setRGB(rgb_index,redv,greenv,bluev)
   setRGB(rgb_index2,1-redv,1-greenv,1-bluev)
   setRGB(rgb_index3,bluev,greenv,redv) // swop red & blue
   }
   else {

   setRGB(rgb_index,redv,greenv,bluev)
   setRGB(rgb_index2,1-redv,1-greenv,1-bluev)
   setRGB(rgb_index3,bluev,greenv,redv) // swop red & blue

   cindex = getColorIndexFromRGB(redv,greenv,bluev)
   
   }

   sWo(two,@clear,@textr,"$msg %V$redv $greenv $bluev",0,0.5)


   sWo(awo,@bhue,cindex,@clear,@clipborder,@redraw)  // clears repaints
   sWo(awo[0],@clearclip,@redraw)  // clears repaints



   sWo(htwo[0],@bhue,cindex,@texthue,"black",@clearclip,cindex,@clipborder,"black", @redraw)


   cname = getColorName(cindex)
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