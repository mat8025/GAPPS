#! /usr/local/GASP/bin/spi -X
#/* -*- c -*- */
# 

include tools/PULSE/SeeLib

// shift args

// input a SatTrend 50 hz file 

NPV =10

float Red[]
float IR[]

lstem = ""

normalize = 1

float rs[]

t1 = 0
t2 = 10

proc DrawAxis(ww)
{
  // should be in mins

      rs = w_getRS(ww)
      
      rx = rs[1] 
      ry = rs[2]
      rX = rs[3] 
      rY = rs[4]

      //<<" $rs \n"

      if ((Fabs(rX -rx)) > 60)
           minx = 5
      else
           minx = 1


            dy = (rY - ry )

            ix = minx

            iy = get_incr ( dy)

            int irx = rx/minx
            rx = irx * minx
      //<<" $rx a$ry $rX $rY \n"
            int iry = ry/iy
            ry = iry * iy

            W_SetRS(ww,rx,ry,rX,rY)            

            W_SetPen(ww,"black")
            
            ticks(ww,1,rx,rX,ix,0.02)
            ticks(ww,2,ry,rY,iy,0.02)

            axnum(ww,1,rx+ix,rX-ix,ix,-2.0,"3.0f")
		     // axnum title

            axnum(ww,2,ry+iy,rY,iy,0.0,"g")

//		     text(ww,"SPO2",rx,ry,0,0)

        w_clipborder(ww)
        gsync()
 }

proc ZoomOutY(ww)
{

      rs = w_getRS(ww)
      
      rx = rs[1] 
      ry = rs[2]
      rX = rs[3] 
      rY = rs[4]

      ry *= 0.9
      rY *=1.2

       W_SetRS(ww,rx,ry,rX,rY)
       gsync()

}


proc ZoomInY(ww)
{

      rs = w_getRS(ww)
      
      rx = rs[1] 
      ry = rs[2]
      rX = rs[3] 
      rY = rs[4]

      ry *= 1.1
      rY *= 0.95

       W_SetRS(ww,rx,ry,rX,rY)
	 gsync()
}




proc Xaxis2time(ww)
{

      rs = w_getRS(ww)
      
      rx = rs[1] 
      ry = rs[2]
      rX = rs[3] 
      rY = rs[4]

// set rx and rX in mins

            rx /= (50*60)
            rX /= (50*60)

	if (Fabs(rX-rx) > 5) {
            int irx = rx/5
            rx = irx * 5
        }

       W_SetRS(ww,rx,ry,rX,rY)
	 gsync()
}



proc Xaxis2pts(ww)
{
      rs = w_getRS(ww)
      
      rx = rs[1] 
      ry = rs[2]
      rX = rs[3] 
      rY = rs[4]

      rx *= (50*60)
      rX *= (50*60)

     W_SetRS(ww,rx,ry,rX,rY)
	 gsync()
}


proc  DrawLabels(ww)
{

  Text(ww,"Time (mins)", 0.1, -0.05,1)

  Text(ww,"PLETH ", -0.15, 0.2,1, 90)

}



proc ReadPulseFile(fname)

{

  R = ReadAscii(A,"int",0,24,14)

  maxpts = Caz(R)

   dmn = Cab(R)

 <<" ascii read  R array  %v $maxpts  $dmn\n"

 PG = R[*][8]

    // <<" PG $PG[0;NPV] \n"

 PG = 4^PG

 <<" PG $PG[0;NPV] \n"
  // either 0 ,1,2, or 3 indicating gain of 1 ,4 , 16 or 64

 RD = R[*][6]

 RD = 4^RD

 IRD = R[*][7]

 IRD = 4^IRD

 Red = R[*][11]

 <<" preNorm $Red[0;NPV] \n"
 <<" PG $PG[0;NPV] \n"

 rsz = Caz(Red)

 dmn = Cab(Red)

 <<" %v $rsz $dmn\n"
  // apply normalization ?

  if (normalize) {
  Red = Red / PG 
  Red = Red / RD
  }

 <<" postNorm $Red[0;NPV] \n"

 Redimn(Red)

 dmn = Cab(Red)

 <<" after Redimn $dmn \n"

 maxpts = Caz(Red)

 <<" %v $maxpts in Red array \n"

 IR = R[*][12]

 <<" $dmn $(typeof(IR))\n"

  Redimn(IR)

  if (normalize) {
   IR = IR /PG
   IR = IR/ IRD
  }

 maxirpts = Caz(IR)

 <<" %v $maxirpts  \n"

   return maxpts
}


 fname = $2

<<" looking for $fname \n"

 A= ofr(fname)

 do_IR = 1
 do_Red = 1

 narg = argc()
 ac = 3
 wo2 =""


 int wrc = 1

 while (ac < narg) {

     wo2 = $ac

 // <<" $wo2 $(supper(wo2))\n"
     lwo2 = slower(wo2)
     
     if ( lwo2 @= "redonly") {
      do_IR = 0
      }

    if ( lwo2 @= "ironly") {
      do_Red = 0
      }


 }
     

  maxpts = ReadPulseFile(fname)

  ctname = fname

  fstem = Spat(ctname,".","<","<")

  if (fstem @= "")
      fstem = ctname

  lstem = Spat(fstem,"/",">","<")

  <<" $ctname $fstem $lstem \n"

  if (lstem @= "") 
     lstem = fstem

   ctname = lstem

// check Red &IR

   <<" OUT %v $Red[1000;1000+NPV] \n"

   X= Fgen(maxpts,0,1)

   <<" %v $maxpts \n"

  //  mm=MinMax(IR)

       irsz = Caz(IR)
       mm=Stats(IR[1000;irsz-1])

     // make sdsize arg

  ymin = mm[1] - 2 * mm[4]

  ymax = mm[1] + 2 * mm[4]

<<"%V %e $mm[1] $mm[4] \n"
<<"%V %e $ymin $ymax \n"

       mm=Stats(Red[1000;maxpts-1])

     // make sdsize arg

  yrmin = mm[1] - 2 * mm[4]

  if (yrmin < 0) yrmin = 0.0

  yrmax = mm[1] + 2 * mm[4]
  
  if (yrmin < ymin) ymin = yrmin

  if (ymin < 0) ymin = 0.0

  if (yrmax > ymax)
        ymax = yrmax

  float maxy = 1.0E8

  //  maxy = 1000000.0

<<"%V %e $mm[1] $mm[4] \n"

<<" %V %e $maxy $ymax\n"

  if (ymax > maxy) {
    ymax = maxy
<<" limiting \n"
  }
  else {
<<" %V $maxy >  $ymax \n"
   }
 
<<" %V $maxy $ymax\n"

   npts = maxpts

   Sred = Red[0;npts]

  //<<" %v $Sred[0;NPV] \n"

   X= Fgen(npts,0,1)

// plot

  plw=setupwin("PLETH",0,10000)


  // put some WOS - to control zooming

    woysp = 0.03
    woht = 0.07

    woy = 0.8
    woY = woy + woht

    woxwd = 0.09

    wox = 0.9
    woX = wox + woxwd

    zoywo=w_CreateWO(plw,"ONOFF","ZOY",1,wox,woy,woX,woY,2,"red","medium","white")

    woY = woy - woysp
    woy = woY - woht

    ziywo=w_CreateWO(plw,"ONOFF","ZIY",1,wox,woy,woX,woY,2,"blue","medium","white")

    woY = woy - woysp
    woy = woY - woht

    zoxwo=w_CreateWO(plw,"ONOFF","ZOX",1,wox,woy,woX,woY,2,"red","medium","white")

    W_SetRS(plw,0,ymin,npts,ymax)

     if (do_Red) {
    refgl=CreateGline("wid",plw,"type",2,"xvec",X,"yvec",Sred,"color","red","name","RED")
    DrawGline(refgl)
      }

     if (do_IR) {
    irgl=CreateGline("wid",plw,"type",2,"xvec",X,"yvec",IR,"color","blue","name","IR")
    DrawGline(irgl)
     }

    Xaxis2time(plw)

    DrawAxis(plw,0)

    DrawLabels(plw)

    ShowFileN(plw, ctname)

    gsync()

    pfname =  "${ctname}_pleth.ps"

   zoomit = 0

   while (1) {

    WoRedraw(plw)

    zoomit = 0

    w_activate(plw)

    msg = MessageWait(Minfo)

   if ( ! (msg @= "NO_MSG")) {

    zmn = msg 
    winid = Minfo[2]

    if ( (msg @= "PRINT") ) {
     open_laser(pfname)
     scr_laser(plw)
     gsync()
    }


    if ((msg @= "ZOY")) {
      ZoomOutY(plw)
<<" %V $ymax $ymin \n"
      zoomit = 1
    }

    if ((msg @= "ZIY")) {
      ZoomInY(plw)
<<" %V $ymax $ymin \n"
      zoomit = 1
    }


    if ( (msg @= "REDRAW") || (msg @= "RESIZE") ||  zoomit || (msg @= "PRINT")) {

      //      <<" RedrawGlines for $plw \n"

      W_ClearPixMap(plw)

      W_clear(plw)

      gsync()

      DrawAxis(plw,0)

      Xaxis2pts(plw)

      RedrawGlines(plw)

      Xaxis2time(plw)

      w_clipborder(plw)

      DrawLabels(plw)

      ShowFileN(plw, ctname)

      W_ShowPixMap(plw)
   
      w_store(plw)

      gsync()


    }


    if ( (msg @= "PRINT") ) {
          CloseLaser()
          laser_scr(plw)
          gsync()
              <<" cat $pfname | lpr "
              si_pause(5)
              <" cat $pfname | lpr "

    }

   }

   }


STOP!

