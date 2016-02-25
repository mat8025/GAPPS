#/* -*- c -*- */
# "$Id: pulseScreen.g,v 1.1 2003/06/25 07:08:30 mark Exp mark $"



proc SetBDwin(title)
{

  cwx = 0.07
  cwX = 0.93
  cwy = 0.1
  cwY = 0.88

  awin= W_Create(0,0)
  W_title(awin,title)
  W_Map(awin)
  W_SetClip(awin,cwx,cwy,cwX,cwY) 

 return awin
}

proc ResizeBDwin(twx,twX)
{
  srysp = 0.01
  sryh = 1.0/10.0
  sry = 0.05
  srY = sry + sryh
  srx= twx
  srX = twX

    // for all args

  W_resize(vp,srx,sry,srX,srY,0)
  sry = srY + srysp
  srY = sry + sryh
  W_resize(srw,srx,sry,srX,srY,0)

  sry = srY + srysp
  srY = sry + sryh
  W_resize(tdf,srx,sry,srX,srY,0)

  sry = srY + srysp
  srY = sry + sryh

  W_resize(psw,srx,sry,srX,srY,0)

  sry = srY + srysp
  srY = sry + sryh

  W_resize(fdw,srx,sry,srX,srY,0)

  sry = srY + srysp
  srY = sry + sryh

  W_resize(cdw,srx,sry,srX,srY,0)

  sry = srY + srysp
  srY = sry + sryh

  W_resize(tdw,srx,sry,srX,srY,0)

    <<" $srY \n"

    return srY

}

int vp
int srw  // spikeremoval
int fdw
int rrw
int stw
int csw
int mew
int prw
int ccw
int tdf
int cdw
int prwo
int o2w
int o2cw
int o2sw
int tdw
int spvw
int psw

int spiw
int prew

int allwin[]

int cprwo
int fprwo
int spiwo
int dco2wo
int mno2wo
int acdcwo
int timewo
int obtwo

int cfwo

int sswo
int aveewo
int sprwo
int fpo2wo
int tmewo
int smewo
int cmewo
int gacwo

int runwo
int stepwo
int mswo

// ::o2sw - global create not working

  msx = 0.05
  msX = 0.8





proc SetUpWin()
  {

   // all window handles have to global scope
  sipw = spi_w ("PULSE_") 

    // <<" %v $sipw return from wo here \n"

  title="PULSE"

  ysp = 5

  sx = get_sx()

  sy = get_sy()

  dx = sx * 0.65

  x = 10
  X = x + dx
  
  y =  ysp
  dy = sy/8

  Y =  y + dy

    //  <<" %v $x $y $X $Y \n"

  cwx = 0.07
  cwX = 0.93
  cwy = 0.1
  cwY = 0.98
  
    vp = SetBDwin("RPleth")

    srw = SetBDwin("SpikeRemoval")

    // time-domain features

    tdf = SetBDwin("TDD")

    // spectrum
  //  ::psw = SetBDwin("PwrSpec")

    psw = SetBDwin("PwrSpec")

    // log spectrum
  
    fdw = SetBDwin("LogSpec")

    // cepstrum
  cdw = SetBDwin("Cepstrum")

    // filtered pleth

  tdw = SetBDwin("FPleth")

  ymin = -3000
  ymax = 3000

  W_SetRS(tdw,0,ymin,256,ymax)

    // filtered pleth2
    ::tdw2 = -1
    //  ::tdw2 =SetBDwin("FPleth2")


  ymin = -3000
  ymax = 3000
  W_SetRS(tdw2,0,ymin,256,ymax)


  // SPO2 Win

  o2w = SetBDwin("SPO2")

  ty = ResizeBDwin(0.01,0.6)

  ty += 0.01

  W_resize(o2w,0.01,ty,0.3,0.99,0)

  W_SetRS(o2w,0,50,10,105)

  // Pulserate Win

  prw = SetBDwin("PulseRate")

  W_SetRS(prw,0,30,100,350)

  W_resize(prw,0.31,ty,0.6,0.99,0)

  wht = sy/7

  x = X + 4
  X = sx -10
  y = ysp
  Y = y + wht

  mew = W_Create(0,1,x,y,X,Y,"MotionEstimate")
  W_Map(mew)

  W_SetClip(mew,cwx,cwy,cwX,cwY) 

  W_SetRS(mew,0,0,10,100)

  y = Y + ysp
  Y = y + wht

  rrw = W_Create(0,1,x,y,X,Y,"Regression")
  W_Map(rrw)

  rrsc = 0.02
  W_SetClip(rrw,cwx,cwy,cwX,cwY) 
  W_SetRS(rrw,-rrsc,-rrsc,rrsc,rrsc)
    //    W_SetRS(rrw,-0.02,-0.02,rrsc,rrsc)

  y = Y + ysp
  Y = y + wht

  ccw = W_Create(0,1,x,y,X,Y,"Correlation")
  W_Map(ccw)

  W_SetClip(ccw,cwx,cwy,cwX,cwY) 
  W_SetRS(ccw,0,0,50,2.0)

  y = Y + ysp

  Y = y + 2.8 * wht

  <<" %v $sx $X \n"

  X += 50
  stw = W_Create(0,1,x,y,X,Y,"Status_of_${lstem}")
  W_Map(stw)

  W_SetClip(stw,0.05,cwy,0.99,cwY) 
  W_SetRS(stw,0,-2,50,2.0)

  y = Y + ysp
  Y = y +50
  
  w_redraw(stw)


  csw = W_Create(0,1,x,y,X,Y,"Control")
  W_Map(csw)

  W_SetClip(csw,0.05,cwy,0.99,cwY) 
  W_SetRS(csw,0,-2,50,2.0)

    stepwo=w_CreateWO(csw,"ONOFF","STEP",2,0.02,0.05,0.25,0.8,2,"blue","medium","white")

    runwo=w_CreateWO(csw,"ONOFF","RUN",2,0.8,0.1,0.95,0.8,2,"red","medium","white")

    woysp = 0.09

    woy = 0.03
    woY = woy + woysp

    woxwd = 0.29

    wox = 0.02
    woX = wox + woxwd

  ::prwo=w_CreateWO(stw,"SHOW_VALUE_RIGHT","BPR ",1,wox,woy,woX,woY,0,"blue")
    woy = woY + 0.01
    woY = woy + woysp

  ::tdprwo=w_CreateWO(stw,"SHOW_VALUE_RIGHT","TdP ",1,wox,woy,woX,woY,0,"blue")
    woy = woY + 0.01
    woY = woy + woysp

    sprwo=w_CreateWO(stw,"SHOW_VALUE_RIGHT","SpP ",1,wox,woy,woX,woY,0,"blue")
    woy = woY + 0.01
    woY = woy + woysp


  ::spr2wo=w_CreateWO(stw,"SHOW_VALUE_RIGHT","Sp2P ",1,wox,woy,woX,woY,0,"blue")
    woy = woY + 0.01
    woY = woy + woysp

    cprwo=w_CreateWO(stw,"SHOW_VALUE_RIGHT","CeP ",1,wox,woy,woX,woY,0,"blue")

    woy = woY + 0.01
    woY = woy + woysp

    fprwo=w_CreateWO(stw,"SHOW_VALUE_RIGHT","FcP ",1,wox,woy,woX,woY,0,"blue")

    woy = woY + 0.01
    woY = woy + woysp

    gacwo=w_CreateWO(stw,"SHOW_VALUE_RIGHT","GAC ",1,wox,woy,woX,woY,0,"yellow")


    woy = 0.03
    woY = woy + woysp

    wox = woX +0.02
    woX = wox + woxwd

  ::bo2wo=w_CreateWO(stw,"SHOW_VALUE_RIGHT","Bo2 ",1,wox,woy,woX,woY,0,"red")
    woy = woY + 0.01
    woY = woy + woysp

  ::o2wo=w_CreateWO(stw,"SHOW_VALUE_RIGHT","Reg ",1,wox,woy,woX,woY,0,"red")
    woy = woY + 0.01
    woY = woy + woysp

  ::specwo=w_CreateWO(stw,"SHOW_VALUE_RIGHT","Spec ",1,wox,woy,woX,woY,0,"red")
    woy = woY + 0.01
    woY = woy + woysp

  ::spec2wo=w_CreateWO(stw,"SHOW_VALUE_RIGHT","Spc2 ",1,wox,woy,woX,woY,0,"red")
    woy = woY + 0.01
    woY = woy + woysp

  //  ::fpo2wo=w_CreateWO(stw,"SHOW_VALUE_RIGHT","Freg ",1,wox,woy,woX,woY,0,"red")

    fpo2wo=w_CreateWO(stw,"SHOW_VALUE_RIGHT","Freg ",1,wox,woy,woX,woY,0,"red")
    woy = woY + 0.01
    woY = woy + woysp
    acdcwo=w_CreateWO(stw,"SHOW_VALUE_RIGHT","ACDC ",1,wox,woy,woX,woY,0,"red")

    woy = woY + 0.01
    woY = woy + woysp
    dco2wo=w_CreateWO(stw,"SHOW_VALUE_RIGHT","DCT ",1,wox,woy,woX,woY,0,"red")

    woy = woY + 0.01
    woY = woy + woysp
    mno2wo=w_CreateWO(stw,"SHOW_VALUE_RIGHT","Mn ",1,wox,woy,woX,woY,0,"red")


    woy = woY + 0.01
    woY = woy + woysp
    obtwo=w_CreateWO(stw,"SHOW_VALUE_RIGHT","OBT ",1,wox,woy,woX,woY,0,"red")

    woy = 0.03
    woY = woy + woysp

    wox = woX +0.02
    woX = wox + woxwd
    wocol = "green"

    timewo=w_CreateWO(stw,"SHOW_VALUE_RIGHT","SECS ",1,wox,woy,woX,woY,0,wocol)
    woy = woY + 0.01
    woY = woy + woysp

    aveewo=w_CreateWO(stw,"SHOW_VALUE_RIGHT","AveE ",1,wox,woy,woX,woY,0,wocol)
    woy = woY + 0.01
    woY = woy + woysp

    spiwo=w_CreateWO(stw,"SHOW_VALUE_RIGHT","SPI ",1,wox,woy,woX,woY,0,wocol)
    woy = woY + 0.01
    woY = woy + woysp

    cmewo=w_CreateWO(stw,"SHOW_VALUE_RIGHT","CME ",1,wox,woy,woX,woY,0,wocol)
    woy = woY + 0.01
    woY = woy + woysp

    smewo=w_CreateWO(stw,"SHOW_VALUE_RIGHT","SME ",1,wox,woy,woX,woY,0,wocol)
    woy = woY + 0.01
    woY = woy + woysp


    tmewo=w_CreateWO(stw,"SHOW_VALUE_RIGHT","TME ",1,wox,woy,woX,woY,0,wocol)
    woy = woY + 0.01
    woY = woy + woysp


    mswo=w_CreateWO(stw,"SHOW_VALUE_RIGHT","MS ",1,wox,woy,woX,woY,0,wocol)
    woy = woY + 0.01
    woY = woy + woysp

    cfwo=w_CreateWO(stw,"SHOW_VALUE_RIGHT","CF ",1,wox,woy,woX,woY,0,wocol)

    woy = woY + 0.01
    woY = woy + woysp

    sswo=w_CreateWO(stw,"SHOW_VALUE_RIGHT","ST ",1,wox,woy,woX,woY,0,wocol)

    wo_set({o2wo, acdcwo, fpo2wo, specwo,spec2wo, dco2wo} ,"penhue","white")

    wo_set({sprwo,cprwo,fprwo,prwo,tdprwo} ,"penhue","white")

    wo_set({gacwo,timewo,spiwo,aveewo,smewo,tmewo,cmewo,cfwo,sswo,mswo} ,"penhue","black")


    // need display wo's for SpecPir   motion lock


  y = Y + ysp
  Y = y + wht



  //  W_move(prw,1) // move to screen 1

  y = Y + ysp
  Y = y + wht

#{
  o2w = W_Create(0,0,x,y,X,Y,"SpO2_$lstem")
  W_Map(o2w)
  W_SetClip(o2w,cwx,cwy,cwX,cwY) 
  y = Y + ysp
  Y = y + wht
#}

  // O2 candidates

  o2cw = W_Create(0,0,x,y,X,Y,"SpO2C_$lstem")

  W_Map(o2cw)

  W_SetClip(o2cw,cwx,cwy,cwX,cwY) 

  W_SetRS(o2cw,0,70,10,100)

  W_resize(o2cw,msx,0.2,msX,0.95,2)


  // Spec peak variance

  spvw = W_Create(0,0,x,y,X,Y,"SPV")

  W_Map(spvw)

  W_SetClip(spvw,cwx,cwy,cwX,cwY) 

  W_SetRS(spvw,0,0,10,400)

  W_resize(spvw,msx,0.2,msX,0.95,9)

  W_title(spvw,"SPV")
  
  W_redraw(spvw)


  prew = W_Create(0,0,x,y,X,Y,"PRE")

  W_Map(prew)

  W_SetClip(prew,cwx,cwy,cwX,cwY) 

  W_SetRS(prew,0,70,10,100)

  W_resize(prew,msx,0.2,msX,0.95,3)


    //::o2sw = W_Create(0,0,x,y,X,Y,"O2spec")
  o2sw = W_Create(0,0,x,y,X,Y,"O2spec")
  W_Map(o2sw)

  W_SetClip(o2sw,cwx,cwy,cwX,cwY) 

  W_SetRS(o2sw,0,50,10,105)
    //  w_title(o2sw,"O2spec",1,1)

  W_resize(o2sw,msx,0.4,msX,0.7,6)

  spiw = W_Create(0,0,x,y,X,Y,"SpecPI")

  W_Map(spiw)

  W_SetClip(spiw,cwx,cwy,cwX,cwY) 

  W_SetRS(spiw,0,-5,10,5)

  W_resize(spiw,0.1,0.2,0.9,0.95,7)

  // fix main scope

  allwin = {vp,srw,tdf,fdw,psw,cdw,prw,rrw,o2w,mew,tdw,ccw,o2cw,prew,stw,o2sw,spiw, csw, spvw}

  //<<" %v $allwin \n"

  W_Clear(allwin)
  W_ClearClip( allwin)
  W_DrawOFF( allwin)
  W_PixMapDrawON( allwin)
  W_Redraw(allwin)
  W_Store(allwin)

  gsync()

    }



proc ClearWindows()
 {
          W_ClearPixMap(allwin)
 }



proc SaveWindows()
   {
    W_Redraw(allwin)
    W_ShowPixMap(allwin)
    W_Store(allwin)
    gsync()
  }


proc Redisplay()
{

   w_drawON(o2w)   
  
   laser = 0

   w_move(o2w,1)

   W_resize(o2w,msx,0.5,msX,0.95,1)

   w_move(prw,1)

   W_resize(prw,msx,0.05,msX,0.49,1)

 // for largescale drawing
 ks = 7
 w_move(vp,ks)
 w_resize(vp,0.1,0.1,0.9,0.7,ks)
 w_border(vp)

 ks++
 w_move(tdf,ks)
 w_resize(tdf,0.1,0.1,0.9,0.7,ks)
 w_border(tdf)
     gsync()
 ks++

 w_move(fdw,ks)
 w_resize(fdw,0.1,0.1,0.9,0.7,ks)
 w_border(fdw) 
     gsync()
 ks++
 w_move(psw,ks)
 w_resize(psw,0.1,0.1,0.9,0.7,ks)
 w_border(psw)
     gsync()
 ks++
 w_move(cdw,ks)
 w_resize(cdw,0.1,0.1,0.9,0.7,ks)
 w_border(cdw)
     gsync()
 ks++
 w_move(tdw,ks)
 w_resize(tdw,0.1,0.1,0.9,0.7,ks)
 w_border(tdw)
     gsync()
}

proc RedrawO2PR(laserprint)
{
	  gsync()

      if (laserprint) {
        <<"laser draw to ${lstem}O2PR.ps \n"
        open_laser("${lstem}O2PR.ps",0)
        scr_laser(o2w)
        scr_laser(prw)
      }

        DrawO2()
        DrawPR()

        ShowFileN(o2w, lstem)

       if (laserprint) {
        CloseLaser()
        laser_scr(o2w)
        laser_scr(prw)

        <" cat ${lstem}O2PR.ps | lpr "
	  }
        w_store(o2w)
	gsync()
}



laser = 0

proc DisplayLoop()
{

   while (1) {


    w_activate(vp,tdf,tdw2)

<<"waiting for msg from %V $o2w $prw $vp $mew \n"

    msg = MessageWait(Minfo)

   if ( ! (msg @= "NO_MSG")) {

    zmn = msg 
    winid = Minfo[2]

<<"%v $msg $Minfo \n"

    if (msg @= "PRINT") {
        laser = 1
<<" LASER ON \n"
    }

    if (msg @= "REDRAW") {
        laser = 0
    }

    if (msg @= "RESIZE") {
        laser = 0
    }

      if (winid == o2w) {
	RedrawO2PR(laser)
      }

      if (winid == vp) {
       

      if (laser) {
        open_laser("${lstem}_input.ps",0)
        scr_laser(vp)
      }
         DrawInput()

       if (laser) {
        close_laser()
        laser_scr(vp)
        gsync()
        <" cat ${lstem}_input.ps | lpr "
       }


      }

      if (winid == tdf) {
       
      if (laser) {
        open_laser("${lstem}_tdf.ps",0)
        scr_laser(tdf)
      }
 
        DrawTdd()

       if (laser) {
        close_laser()
        laser_scr(tdf)
       }

        gsync()

      }

      if (winid == fdw) {
       
      if (laser) {
        open_laser("${lstem}_logs.ps",0)
        scr_laser(fdw)
      }
 
        DrawLogSpec(0)
        DrawSAxis(fdw)
       if (laser) {
        close_laser()
        laser_scr(fdw)
       }

        gsync()

      }

      if (winid == psw) {
	// actually Energy Spec
      if (laser) {
        open_laser("${lstem}_es.ps",0)
        scr_laser(psw)
      }
 
        DrawPowerSpec()
        DrawSAxis(psw)

       if (laser) {
        close_laser()
        laser_scr(psw)
       }

        gsync()

      }

      if (winid == cdw) {

      if (laser) {
        open_laser("${lstem}_cep.ps",0)
        scr_laser(cdw)
      }
 
        DrawCepstrum(Fftsz)
        DrawSAxis(cdw)
       if (laser) {
        close_laser()
        laser_scr(cdw)
       }

        gsync()

      }

      if (winid == tdw) {

<<"laser draw to ${lstem}_fpleth.ps"

      if (laser) {
        open_laser("${lstem}_fpleth.ps",0)
        scr_laser(tdw)
      }

          DrawFPleth()

       if (laser) {
        close_laser()
        laser_scr(tdw)
       }

      }


      if (winid == prw) {
        DrawPR()
        DrawAxis(prw)
        gsync()
        w_store(prw)
       }


      if (winid == spiw) {
        DrawSpecPI()
        DrawAxis(spiw)
        gsync()
        w_store(spiw)
       }

      if (winid == o2cw) {
        if (laser) {
        open_laser("${lstem}O2C.ps")
        scr_laser(o2cw)
        }
        DrawO2C()
        DrawAxis(o2cw)
        if (laser) {
        close_laser()
        laser_scr(o2w)
        }
        gsync()
        w_store(o2cw)
       }

      if (winid == mew) {
	//<<" redrawing ME \n"
         DrawME()
        DrawAxis(mew)
    //        gsync()
       w_save(mew)
       }

    }
<<" checking msg \n"
   }
}


int ows = 0

char wotxt[32]

int Minfo[]

stepthru = 0

proc CheckMsg(msg)
{

    winid = Minfo[2]

<<"%V $msg $winid $Minfo \n"


     if (msg @= "SWITCHSCREEN") {
       // redraw

     }

     if (msg @= "STEP") {
        stepthru = 1
     }

     if (msg @= "RUN") {
        stepthru = 0
     }

     if (msg @= "PRINT") {

      if (winid == o2w) {
	RedrawO2PR(1)
      }

     }


}

proc ConfigScreen()
{

   msg = MessageRead(Minfo)

    if ( ! (msg @= "NO_MSG")) {

    woid = Minfo[3]
    CheckMsg(msg)

    }

      ws=GetScreen()

      W_Redraw(csw)


    if (ws != ows) {

      if (ws == 1) {
       W_resize(o2w,msx,0.5,msX,0.95,1)

       W_resize(prw,msx,0.05,msX,0.49,1)
      }

      if (ws == 4) {

       w_resize(vp,msx,0.1,msX,0.3,ws)

       w_resize(psw,msx,0.32,msX,0.65,ws)

       w_resize(fdw,msx,0.66,msX,0.95,ws)

      }

      if (ws == 5) {

       w_resize(vp,msx,0.1,msX,0.4,ws)
       w_resize(fdw,msx,0.42,msX,0.6,ws)
       w_resize(cdw,msx,0.62,msX,0.95,ws)

      }

      if (ws == 6) {

        W_resize(o2w,msx,0.55,msX,0.95,ws)
        W_resize(o2sw,msx,0.42,msX,0.53,ws)
        w_resize(psw,msx,0.25,msX,0.4,ws)
        w_resize(vp,msx,0.02,msX,0.2,ws)

      }

      if (ws == 0) {

         ty = ResizeBDwin(0.01,0.6)

         ty += 0.01

         W_resize(prw,0.31,ty,0.6,0.99,0)

         W_resize(o2w,0.01,ty,0.3,0.99,0)

      }

      //<<" CurrentScreen $ws $ows\n"

      W_resize(csw,0.82,0.95,0.99,0.99,ws)
      W_Redraw(csw)
      gsync()
      ows = ws
    }


   if (stepthru) {

    <<" Waiting for button \n"

    msg = MessageWait(Minfo)
    CheckMsg(msg)

   }


}

# end pulse window routines
