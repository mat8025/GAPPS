OpenDll("image")

//setdebug(0)
Pi = 4.0 * atan(1.0)

 redv = 0.5
 greenv = 0.5
 bluev = 0.5
Graphic = checkGWM()

  if (!Graphic) {
    Xgm = spawnGWM()
  }


    vp = CreateGwindow(@title,"Button",@resize,0.01,0.01,0.45,0.49,0)

    SetGwindow(vp,@pixmapon,@drawon,@save,@bhue,"white")
    SetGwindow(vp,"scales",0,-0.2,1.5,1.5)
    SetGwindow(vp,"clip",0.2,0.2,0.9,0.9)
    SetGwindow(vp,@clipborder,"black",@redraw,@save)

    vp2 = CreateGwindow(@title,"Colors","resize",0.51,0.1,0.99,0.99,0)
    SetGwindow(vp2,@pixmapon,@drawon,@save,@bhue,"white")


    txtwin = CreateGwindow("title","MC_INFO","resize",0.01,0.51,0.49,0.99,0)


  rx = 0.2
  rX = 0.3

  gx = 0.4
  gX = 0.5

  bx = 0.6
  bX = 0.7

  cby = 0.1
  cbY = 0.3

  cbx = 0.1
  cbX = 0.6


  rwo=CreateGWOB(vp,"BV",@name,"Red",@value,"$redv",@style,"SVB")

  setGWOB(rwo,@color,"red",@penhue,"black",@vmove,1)

  gwo=CreateGWOB(vp,"BV",@resize,gx,cby,gX,cbY,@NAME,"Green",@VALUE,"$greenv")

  setGWOB(gwo,@color,"green",@penhue,"black",@style,"SVB",@symbol,"tri")

  bwo=CreateGWOB(vp,"BV",@resize,bx,cby,bX,cbY,@NAME,"Blue",@VALUE,bluev)

  setGWOB(bwo,@color,"blue",@penhue,"black",@style,"SVB")


  int rgbwo[] = { rwo, gwo, bwo }

  wo_htile( rgbwo, cbx,cby,cbX,cbY,0.02)
  setGWOB( rgbwo, @vmove,1, "setmsg",1 )

  qwo=createGWOB(vp,"BV",@name,"QUIT?",@VALUE,"QUIT",@color,"orange",@resize,0.8,0.1,0.95,0.2)

  setgwob(qwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black", @redraw)

  setgwin(vp,"woredrawall")

 two=createGWOB(txtwin,"TEXT",@name,"Text",@VALUE,"howdy",@color,"orange",@resize_fr,0.1,0.1,0.9,0.9)

 setgwob(two,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black", "redraw",@pixmapon,@drawon)

 setgwob(two,@scales,-1,-1,1,1)

int awo[100]
k = 0

     index = 32

     for (k = 0; k < 100; k++) { 
   
      awo[k]=CreateGWOB(vp2,"GRAPH",@name,"${k}_col")
   
      setgwob(awo[k],@drawon,@color,index,@value,k)
      index++
     }

//<<"%v $awo \n"

     setgwob(awo,@BORDER,@DRAWON,@CLIPBORDER)

     worctile(awo,0.1,0.1,0.9,0.9,10,10)

     setgwin(vp,@redraw)
     setgwin(vp2,@redraw)



//  now loop wait for message  and print

int rgb_index = 32
float WXY[]


Svar msg

E =1 // event handle

int evs[16];
button = 0
Woid = 0
Woname = ""
Woproc = "foo"
Woval = ""
Evtype = ""
int Woaw = 0

 redv = 0.1
 greenv = 0.1
 bluev = 0.1
 dv = 0.01

   while (1) {

   msg = E->waitForMsg()

//<<"msg $msg \n"


   Mf = Split(msg)
   E->geteventstate(evs)

   Woname = E->getEventWoName()    
   Evtype = E->getEventType()    
   Woid = E->getEventWoId()
   Woproc = E->getEventWoProc()
   Woaw =  E->getEventWoAw()
   Woval = getWoValue(Woid)
   button = E->getEventButton()

//   redv = atof( getWoValue(rwo))
//   greenv = atof ( getWoValue(gwo))
//   bluev =  atof (getWoValue(bwo))
/{  
  if ( button == 3) {
      dv = 0.02
  }
  else 
      dv = -0.02

  if (Woname @= "Green") {
   greenv += dv
  }

  if (Woname @= "Red") {
   redv +=  dv
  }

  if (Woname @= "Blue") {
   bluev +=  dv
  }

//<<"%3.2f$bluev $greenv $redv\n"




   if (greenv > 1.0)
       greenv = 0.0

   if (bluev > 1.0)
       bluev = 0.0

   if (redv > 1.0)
       redv = 0.0

   if (greenv < 0.0)
       greenv = 1.0

   if (bluev < 0.0)
       bluev = 1.0

   if (redv < 0.0)
       redv = 1.0
/}

   WXY= getWoPosition(gwo)

  <<" $WXY \n"

  greenv = limitval(WXY[2],0,1)
  WXY= getWoPosition(rwo)
  redv = limitval(WXY[2],0,1)

   WXY= getWoPosition(bwo)
   bluev = limitval(WXY[2],0,1)

   setgwob(rwo,@value,"%3.2f$redv",@update)
   setgwob(gwo,@value,"%3.2f$greenv",@update)
   setgwob(bwo,@value,"%3.2f$bluev",@update)

   setRGB(rgb_index,redv,greenv,bluev)

   color_index = getColorIndexFromRGB(redv,greenv,bluev)

   cname = getColorName(color_index)


   c_index = 32

   setRGB(c_index++,redv,0,0)
   setRGB(c_index++,0,greenv,0)
   setRGB(c_index++,0,0,bluev)

   setRGB(c_index++,redv,greenv,bluev)
   setRGB(c_index++,redv,greenv,0)
   setRGB(c_index++,0,greenv,bluev)
   setRGB(c_index++,redv,0,bluev)

   setRGB(c_index++,1-redv,1-greenv,1-bluev)
   setRGB(c_index++,redv,1-greenv,1-bluev)

   setRGB(c_index++,1-redv,greenv,1-bluev)

   setRGB(c_index++,redv,greenv,1-bluev)

   setRGB(c_index++,1-redv,greenv,bluev)
   setRGB(c_index++,redv,1-greenv,bluev)



   rs = (Sin(redv * Pi) + 1.0) / 2.0
   bs = (Sin(bluev * Pi) + 1.0) / 2.0
   gs = (Sin(greenv * Pi) + 1.0) / 2.0
   rc = (Cos(redv * Pi) + 1.0) / 2.0
   bc = (Cos(bluev * Pi) + 1.0) / 2.0
   gc = (Cos(greenv * Pi) + 1.0) / 2.0

   setRGB(c_index++,rs,bs,gs)
   setRGB(c_index++,rs,bc,gc)
   setRGB(c_index++,rc,bc,gc)
   setRGB(c_index++,rs,bc,gs)
   setRGB(c_index++,rc,bc,gc)
   setRGB(c_index++,rs,bc,gs)
   setRGB(c_index++,rc,bs,gc)

   jdv = 1.0/9.0
   ki = c_index
   bv = 0.0
   bdv = 1.0/7.0

   for (rj = 0; rj < 8 ; rj++) {
   jv = 0.0
   for (j = 0; j < 10 ; j++) {

     if (Woname @= "Red") {
       setRGB(ki,redv,bv,jv)
     }

      elif (Woname @= "Blue") {
        setRGB(ki,bv,jv,bluev)
      }
      elif (Woname @= "Green") {
       setRGB(ki,bv,greenv,jv)
      }
      //<<"$ki $redv $bv $jv \n"
   ki++
   jv += jdv
   }
   bv += bdv
   }

  
   setGWOB(awo,@redraw)

   setGWOB(rwo,@VALUE,redv)
   setGWOB(bwo,@VALUE,bluev)
   setGWOB(gwo,@VALUE,greenv)

   setgwob(two,@clear,@texthue,"black",@textr,"$msg\n $cname\n%V$button \n %V3.2f$redv $greenv $bluev",-0.9,0)

   if (scmp(msg,"QUIT",4)) {
       break
   }

   sleep(0.05)

  }


 exit_gs()




;