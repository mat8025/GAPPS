//
// Show some colors
//

opendll("image")

Graphic = checkGWM()

  if (!Graphic) {
    Xgm = spawnGWM()
  }


 redv = 1.5
 greenv = 0.5
 bluev = 0.2


    vp = CreateGwindow("title","Button",@resize,0.01,0.01,0.49,0.49,0)

    SetGwindow(vp,@pixmapon,@drawon,"save","bhue","white")

    txtwin = CreateGwindow("title","MC_INFO","resize",0.01,0.51,0.49,0.99,0)

    SetGwindow(txtwin,@pixmapon,@drawon,"save","bhue","white")

    vp2 = CreateGwindow("title","Colors",@resize,0.51,0.51,0.99,0.99,0)

    SetGwindow(vp2,@pixmapon,@drawon,@save,@cbhue,"yellow")

    vp3 = CreateGwindow(@title,"HTML_Colors",@resize,0.51,0.01,0.99,0.50,0)

    SetGwindow(vp3,@pixmapon,@drawon,"save",@bhue,"yellow")

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


  rwo=CreateGWOB(vp,"BS",@resize,rx,cby,rX,cbY,@NAME,"Red",@VALUE,redv)

  setGWOB(rwo,@color,"red",@penhue,"black","symbol","tri",@style,"SVL","drawon")

  gwo=CreateGWOB(vp,"BS",@resize,gx,cby,gX,cbY,@NAME,"Green",@VALUE,greenv)

  setGWOB(gwo,@color,"green",@penhue,"black","symbol","tri",@style,"SVL","drawon")


  bwo=CreateGWOB(vp,"BS",@resize,bx,cby,bX,cbY,@NAME,"Blue",@VALUE,bluev)

  setGWOB(bwo,@color,"blue","penhue","white","symbol","tri",@style,"SVL","drawon")




  qwo=createGWOB(vp,"BN",@name,"QUIT?",@VALUE,"QUIT",@color,"orange",@resize_fr,bx,by,bX,bY)

  by = bY + 0.02
  bY = by + dY

  cuwo=createGWOB(vp,"BN",@name,"Next",@VALUE,"NextColor",@color,"cyan",@resize_fr,bx,by,bX,bY)

  setgwob(qwo,@BORDER,@DRAW,@CLIPBORDER,@FONTHUE,"black", @style, "SVB", "redraw")

  setgwob(cuwo,@BORDER,@DRAW,@CLIPBORDER,@FONTHUE,"black", @style, "SVB", "redraw")

  int rgbwo[] = { rwo, bwo, gwo }

  wo_vtile( rgbwo, cbx,cby,cbX,cbY,0.05)


  // these are a list of values that the color wo have can - each click cycles thru them


  frgb = vgen(FLOAT_,41,0,0.025)

//<<"%(,,\,,)4.2f$frgb \n"

\{
  setGWOB(rgbwo,@CSV,"0,0.05,0.1,0.15,0.2,0.25,0.3,0.35,0.4,0.45,0.5,0.55,0.6,\
            0.65,0.7,0.75,0.8,0.85,0.9,0.95,1.0", @REDRAW)
\}

  setGWOB(rgbwo,@CSV,"%(,,\,,)4.2f$frgb",@REDRAW)

  setgwin(vp,"woredrawall")

 two=createGWOB(txtwin,"TEXT",@name,"Text",@VALUE,"howdy",@color,"orange",@resize,0.1,0.1,0.9,0.9)

 setgwob(two,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black", "redraw","pixmapoff")



int rgb_index =  150  // place this outside of most colors
int rgb_index2 = 151
int rgb_index3 = 152

int awo[3]

     index = 150

     for (k = 0; k < 3; k++) { 
        awo[k]=CreateGWOB(vp2,"GRAPH","name","${k}_col",@color,index,@value,k)
        index++
     }


<<"%V$awo \n"

  setgwob(awo,@BORDER,@DRAWON,@CLIPBORDER)

  wo_vtile(awo,0.1,0.1,0.9,0.9)

  // make smaller clip area for awo[0]

  setgwob(awo[0],@cbhue,152)
  setgwob(awo[0],@clip,0.1,0.1,0.5,0.5)

int htwo[3]

     index = 1

     for (k = 0; k < 3; k++) { 
      htwo[k]=CreateGWOB(vp3,"GRAPH","name","${k}_col",@color,index,@value,k)
      index++
     }


<<"%V$htwo \n"

  setgwob(htwo,@BORDER,@DRAWON,@CLIPBORDER)

  wo_vtile(htwo,0.1,0.1,0.9,0.9)

//////////////////// BKG LOOP ////////////////////////////////
// Event vars
Svar msg

E =1 // event handle
int evs[16];

Woid = 0
Woname = ""
Woproc = "foo"
Woval = ""
Evtype = ""
int Woaw = 0


windex = 0
cindex = 0


   while (1) {

   msg = E->waitForMsg()

   E->geteventstate(evs)

   Woname = E->getEventWoName()    
   Evtype = E->getEventType()    
   Woid = E->getEventWoId()
   Woproc = E->getEventWoProc()
   Woaw =  E->getEventWoAw()
   Woval = getWoValue(Woid)
   
<<"%V$Woproc \n"
<<"%V$Woname $Evtype $Woid $Woaw $Woval\n"
<<" callback ? $Woproc\n"

   redv   = atof( getWoValue(rwo))
   greenv = atof ( getWoValue(gwo))
   bluev  =  atof (getWoValue(bwo))

<<" $redv $bluev $greenv \n"

   if (Woid == cuwo) {
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

   setgwob(two,@clear,@textr,"$msg %V$redv $greenv $bluev",0,0.5)


   setgwob(awo,@bhue,cindex,@clear,@clipborder,@redraw)  // clears repaints
   setgwob(awo[0],@clearclip,@redraw)  // clears repaints



   setgwob(htwo[0],@bhue,cindex,@texthue,"black",@clearclip,cindex,@clipborder,"black", @redraw)


   cname = getColorName(cindex)
   setgwob(htwo[0],@texthue,"black",@textr,"$cname",0.51,0.52)
   setgwob(htwo[0],@texthue,"white",@textr,"$cname",0.5,0.5)

   icindex = getColorIndexFromRGB(1-redv,1-greenv,1-bluev)

   setgwob(htwo[1],@bhue,icindex,@texthue,"black",@clearclip,icindex,@clipborder,"red", @redraw)
   icname = getColorName(icindex)

   setgwob(htwo[1],@texthue,"black",@textr,"$icname",0.5,0.5)
   setgwob(htwo[1],@texthue,"white",@textr,"$icname",0.51,0.52)
   
   // swap red & blue
   scindex = getColorIndexFromRGB(bluev,greenv,redv)
   scname = getColorName(scindex)

   setgwob(htwo[2],@bhue,scindex,@texthue,"black",@clearclip,scindex,@clipborder,"red", @redraw)
   setgwob(htwo[2],@texthue,"black",@textr,"$scname",0.51,0.51)
   setgwob(htwo[2],@texthue,"white",@textr,"$scname",0.5,0.5)

   cname = getColorName(windex)

   windex++

   if (scmp(msg,"QUIT",4)) {
       break
   }
  }


 exit_gs()




;