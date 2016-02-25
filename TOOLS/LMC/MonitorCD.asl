#/* -*- c -*- */
# "$Id: MonitorCD,v 1.3 2004/05/19 03:48:07 mark Exp mark $"
// 

spanwgwm()

include tools/PULSE/SeeLib

    //SetDebug(0,"pline")

// needs a seek to current time

SetMemOption(1)

doGUI = 1

 float RI[10+]
 float RIV[10+]

CLASS vec {

  public:

  float Y[]

  float z = 67

  int vk = 0
    // do an append
  int last_fc = 0

 CMF set (fc, fval)
 {
  
   //   <<" set $fc $last_fc $vk $fval  \n"

   if (fc > last_fc) {

       Y[vk] = fval

       sz = Caz(Y)

       //  <<" $vk  set $fval $sz \n"
       vk++
   }

    last_fc = fc

 }

 CMF get (int k)
 {
    w = Y[k]     
    return w
 }

 CMF printY()
 {
    sz = Caz(Y)
    dmn = Cab(Y)
          <<" %v $sz $dmn  %v $Y[*] \n"
      //    <<" %v $sz $dmn  %v $Y[sz-1] \n"
 }

 CMF drawY(aw,col)
 {
   sz= Caz(Y)
   //<<" drawY $sz $aw $col \n"
   //    <<" %v $sz   %v $Y[*] \n"

  W_SetPen(aw,col)
  DrawY(aw,Y)
     //  W_ShowPixMap(aw)
 }

 CMF printz()
 {
    <<" %v $z \n"
 }

 CMF vec() {
   Y[10] = 1
 }

}


 float Rednd[]
 float IRnd[]
 float Stddir[]

proc TDD(twlen )
{

  // last nsecs
  sz = Caz(Wred)

  // n pts  @ 50 hz
  
  tdw = twlen * 50

  s1 = 0
  s2 = s1 + 1

  e1 = tdw -2
  e2 = e1 + 1


  if (sz > (3*tdw)) {
     tdw = sz - 2*tdw
  s1 += tdw
  s2 += tdw
  e1 += tdw
  e2 += tdw
    }


  MM = Stats( Wred[s1; e1] )

  Tme2 = MM[4]

  nTme2 = Tme2/MM[1]

  Tddr = Wred[s1; e1] - Wred[ s2 ;e2] 

  // get normalised version

  Rednd = Tddr/ ( Wred[s1; e1] + Wred[ s2 ;e2] )

    // repeat for IR

  Tddir = (Wir[s1; e1] - Wir[ s2 ;e2] )

  IRnd = Tddir / ( Wir[s1; e1] + Wir[ s2 ;e2] )

  MM = Stats( Tddir)


    //<<" $_cproc $MM \n"

  ymax = MM[6]

  Stddir = Tddir   


}


proc RtoSpo2( r)

{
  //    sz= Caz(r)
  //     <<" %V $sz $r \n"

    rspo2 = -8.5 * r * r -14.6 * r + 108.25

    sz= Caz(rspo2)

	// <<" %V $sz $rspo2 \n"

    return rspo2
}



proc spO2()

{
   // use red/Ir to compute regression slope
  // normalised delta

    Rres = rpc(IRnd,Rednd)

    rval = Rres[0]

    ro2 =  RtoSpo2(rval)

#{
    CCws[nloop] = Rres[1]
    VVws[nloop] = Rres[4]
    VVwsp = Rres[4]
#}


    //   <<" $nloop $rval  $ro2 \n"

    RI[nloop] = rval

       //  <<" $RI \n"

    return ro2
}





proc Riv()
{
  riv = 0.0

  // get variance of RI over 10 sec window

  jj = nloop - 5

    if (jj >= 0) {

      //      <<"$_cproc $jj \n"
      //      <<" $RI \n"

      kk = jj+4

      MM =  Stats(RI[jj; kk])

      riv = MM[4]

   }

     return riv
}

proc GUI_Screen()
{
      ws=GetScreen()

     if (ws != ows) {

  

       W_SetClip(prw,cwx,cwy,cwX,cwY)
       W_SetClip(piw,cwx,cwy,cwX,cwY)
       W_SetClip(o2w,cwx,cwy,cwX,cwY)

      if (ws == 1) {

	W_DrawON(o2w,prw,piw)
  
        W_Redraw(piw,prw,o2w)

	W_DrawOFF(o2w,prw,piw)

      }

      if (ws == 2) {

	W_DrawON(riw)
        W_Redraw(riw)
	W_DrawOFF(riw)

      }

    }

     ows = ws
 }


proc  GUI_interact()
{
   if (!doGUI) return

    w_activate(plw)

    msg = MessageRead(Minfo)

   if ( ! (msg @= "NO_MSG")) {

    zmn = msg 
    winid = Minfo[2]

    if ( (msg @= "PRINT") ) {
     open_laser(pfname)
     scr_laser(plw)

     Gsync!

    }

    if ((msg @= "RED")) {
          do_Red = ! do_Red
	  //     <<" %v $do_Red \n"
    }

    if ((msg @= "IR")) {
          do_IR = ! do_IR
    }


    if ((msg @= "AP")) {
          do_AP = ! do_AP
    }


    if ((msg @= "SYNB")) {
      SyncBaud(pid)
    }

    if ((msg @= "CS")) {
      SendCS(cs++)
    }

    if ((msg @= "INDEX")) {
     <<" Which Index ? \n"
     <<" $Minfo \n"

    }


    if ( (msg @= "REDRAW") || (msg @= "RESIZE") || (msg @= "PRINT")) {
      RedrawStuff()

    }


    WoGetValue(inwo, newindex)

    //  <<" new %v $index  $newindex\n"

    index = newindex
    if (index > 7) index = 7
      }
}

proc GUI_DrawOxyP()
{


        if (!doGUI) return

         if (disp_reset) {

         W_ClearPixMap(prw)
         W_ClearPixMap(o2w)
         W_ClearPixMap(piw)
         W_ClearPixMap(riw)

         }

	 //	 <<" %v koxy $o2v $pr\n"

         // option to plot all in same window

         W_SetRS(o2w,0,80,fadc,105)

	 Besto2[koxy]->drawY(o2w, col)

         W_SetRS(prw,0,30,fadc,350)

	 Bestpr[koxy]->drawY(prw ,col)


         W_SetRS( piw,0,0,fadc,5.0)

	 Bestpi[koxy]->drawY(piw ,col)


         W_SetRS(riw,0,-2,fadc,20)

	 Bestri[0]->drawY(riw ,col)

	   //         col++
         
         if (disp_reset) {
         DrawPoxAxis(o2w)

         DrawPoxAxis(prw)

         DrawPoxAxis(piw)
         DrawPoxAxis(riw)
	   }
	 
        W_ShowPixMap(prw)
        W_ShowPixMap(o2w)
        W_ShowPixMap(piw)
        W_ShowPixMap(riw)
 }

 vec Bestpr[10]

 vec Besto2[10]

 vec Bestpi[10]

 vec Bestri[10]

float Wred[]
float Wir[]

float Rred[]
float Rir[]


float IR1[]
float IR2[]
float Red1[]
float Red2[]

float Red[]
float IR[]


float XV[]

float AP[]

int index = 7

int npts
int aprw[]
int ao2w[]

int kprw[]

lstem = ""


proc SyncBaud(pid)
{
  SendSig(pid, 2, 96 )
}

proc SendCS(val)
{
  SendSig(pid, 34, val )
}

float rs[]

t1 = 0
t2 = 10

dotail = 1
normalize = 1

// seek to last two mins (x bytes) of a b50 file
// convert to dat
// read and display
// do this for a list of b50 files
// each in different window


proc RedrawTheLines()
{

      rs = w_getRS(plw)

      //  <<" $_cproc $plw $rs \n"

      rx = rs[1] 
      ry = rs[2]
      rX = rs[3] 
      rY = rs[4]


    W_SetRS(plw,rx,0,rX,10)


   if (doRedDrive) {
    DrawGline(refrdgl)
   }


   if (doIRDrive) {
    DrawGline(refirgl)
   }

   W_SetRS(plw,rx,ymin,rX,ymax)

     if (do_Red) {
    DrawGline(refgl)
      }

     if (do_IR) {
    DrawGline(irgl)
     }

     if (do_AP) {
    DrawGline(apgl)
     }

}

proc RedrawStuff()
      {

	if (!doGUI) return

      W_ClearPixMap(plw)

      W_clear(plw)

	Gsync()

      Xaxis2pts(plw)

      // gline to use left or right axis - top or bottom

      RedrawTheLines()

      Xaxis2secs(plw)

      w_clipborder(plw)

	  //      DrawAxis(plw,0)

      DrawLabels(plw)

      ShowFileN(plw, ctname)

      W_ShowPixMap(plw)
   
      w_store(plw)

	Gsync()
	//      Gsync!
      }


proc DrawPlethAxis(ww)
{
  //  SetDebug(0,"pline")
      rs = w_getRS(ww)

	//<<" $_cproc $ww $rs \n"
      
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

	     //        <<" $rx  $ry $rX $rY \n"

            int iry = ry/iy
            ry = iry * iy

            W_SetRS(ww,rx,ry,rX,rY)            

            W_SetPen(ww,"black")
            
	     //<<" %V $ix $iy \n"

            ticks(ww,1,rx,rX,ix,0.02)


	     //ticks(ww,2,ry,rY,iy,0.02)

	     //            axnum(ww,1,rx+ix,rX-ix,ix,-2.0,"3.0f")

	     //axnum(ww,1,rx+ix,rX-ix,ix,3.0,"3.0f")
		     // axnum title

	     //            axnum(ww,2,ry+iy,rY,iy,0.0,"g")
	     axnum(ww,2,ry+iy,rY,4*iy,-9.0,"g")

//		     text(ww,"SPO2",rx,ry,0,0)

        w_clipborder(ww)
  

}

proc DrawPoxAxis(ww)
{
  // should be in mins

      rs = w_getRS(ww)

	//<<" $_cproc $ww $rs \n"
      
      rx = rs[1] 
      ry = rs[2]
      rX = rs[3] 
      rY = rs[4]

	// may have to set to start_mins

      rx = Mn -10
      rX = Mn

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

	     axnum(ww,2,ry+iy,rY,4*iy,1.0,"g")

        w_clipborder(ww)

}


IRyo = 1.0
IRys = 1.0

float yirmin
float yirmax

proc DoScale()
{

  ysf = 10

  ymin = 0.0
  ymax = 1.0


      sz = Caz(Wred)
  if (sz >= 500) {
      Sred = Wred[sz-500;sz-1]
      Sir  = Wir[sz-500;sz-1]
  }
  else {
       Sred = Red
       Sir = IR
  }


  if (do_AP) {

    mm=Stats(AP)

    yirmin = mm[1] - ysf * mm[4]
    yirmax = mm[1] + ysf * mm[4]

    ymin = yirmin
    ymax = yirmax

  }


  if (do_IR) {

    mm=Stats(Sir)

    yirmin = mm[1] - ysf*mm[4]
    yirmax = mm[1] + ysf*mm[4]

    ymin = yirmin
    ymax = yirmax

  }

   if(do_Red) {

    mm=Stats(Sred)

    yrmin = mm[1] - ysf*mm[4]

    yrmax = mm[1] + ysf*mm[4]

        ymin = yrmin
        ymax = yrmax

   }


  if (do_Red && do_IR) {
  IRys = (yrmax-yrmin) / (yirmax-yirmin)
  IRyo = ((yrmax-yrmin) / 2.0 + yrmin) - ((yirmax -yirmin)/2.0 + yirmin)
  }
  else {
   IRys = 1
   IRyo = 0
  }

 
 if (ymin < 0) ymin = 0.0

 float maxy = 3.0E10

  if (ymax > maxy) {
    ymax = maxy
  }

//<<" %V $maxy $ymax\n"

}


proc Xaxis2time(ww)
{
      rs = w_getRS(ww)
      
	//<<" $_cproc $ww $rs \n"

      rx = rs[1] 
      ry = rs[2]
      rX = rs[3] 
      rY = rs[4]

 <<" %V $rx $rX \n"

// set rx and rX in mins

	rx /= (50*60)
            rX /= (50*60)

	if (Fabs(rX-rx) > 5) {
            int irx = rx/5
            rx = irx * 5
        }

 <<" %V $rx $rX \n"

       W_SetRS(ww,rx,ry,rX,rY)

}


proc Xaxis2secs(ww)
{
      rs = w_getRS(ww)
      
	//<<" $_cproc $ww $rs \n"

      rx = rs[1] 
      ry = rs[2]
      rX = rs[3] 
      rY = rs[4]

 <<" %V $rx $rX \n"

// set rx and rX in mins

	rx /= 50
            rX /= 50

	if (Fabs(rX-rx) > 5) {
            int irx = rx/5
            rx = irx * 5
        }

 <<" %V $rx $rX \n"

       W_SetRS(ww,rx,ry,rX,rY)

}



proc Xaxis2pts(ww)
{
      rs = w_getRS(ww)

	//<<" $_cproc $rs \n"      
      rx = rs[1] 
      ry = rs[2]
      rX = rs[3] 
      rY = rs[4]

      rx *= (50*60)
      rX *= (50*60)

     W_SetRS(ww,rx,ry,rX,rY)

}

proc  DrawLabels(ww, mn)
{

  //  im = Trunc(mn)
  //  scs = Trunc((mn - im) * 60)
  //  Text(ww,"Time ${im}:$scs (mins)", 0.3, 0.08,1)

  Text(ww,"Time ${Hr}:${Mn}:${Sc} ", 0.3, 0.08,1)

  Text(ww,"PLETH ", -0.15, 0.2,1, 90)

}



proc  Plot_RIR(aw, npts, reset)
 {

  int doit = 0

    if (reset) {

    W_ClearPixMap(aw)

    }

    W_SetRS(aw,0,ymin,npts,ymax)

    XV= Fgen(npts,0,1)

     if (do_Red) {

       refgl=CreateGline("wid",aw,"type",2,"xvec",XV,"yvec",Rred,"color", col ,"name","RED")
       DrawGline(refgl)
       
       //       <<"drew REd \n"

      }

     if (do_IR) {

      W_SetRS(aw,0,yirmin,npts,yirmax)

      //      IRS = IR * IRys
      //      IRS += IRyo

      irgl=CreateGline("wid",aw,"type",2,"xvec",XV,"yvec",Rir,"color","blue","name","IR")
      DrawGline(irgl)
   
     }

     if (do_AP) {

       apgl=CreateGline("wid",aw,"type",2,"xvec",XV,"yvec",AP,"color","green","name","AP")
       DrawGline(apgl)

     }


     if (do_IR) 
    DeleteGline(irgl)

      if (do_Red)
    DeleteGline(refgl)

      if (do_AP)
    DeleteGline(apgl)

    if (reset) {
    W_SetRS(aw,0,ymin,npts,ymax)

    Xaxis2secs(aw)

    DrawPlethAxis(aw,0)

    DrawLabels(aw)

    ShowFileN(aw, ctname)
      }

    W_ShowPixMap(aw)

      Gsync()
    

 }



proc CheckMemUse( inwhere)
{
   mblks = CountMemBlocks()

   dmb = (mblks - lmblks)

     if (dmb > 0) {
  <<" %v $nloop  $inwhere %v $dmb %v $mblks \n\n"
     }
}



t_inmins = 0.0

last_secs = utime()

int atend = 0

seek_secs = 0

proc CheckData()
{

  // do we have data for next n secs ?

  return 1

}

// 

float PV[10000+]

wchan = 1

uchar C[10]
uchar channel
ushort nb
uchar UC[8192]

char tag
char rtype
float pr
float spo2
float pi
int ltime 

uint fadc
char redrv;
char irdrv
char led
char gain
ushort diag;
ushort sdflag;
uint unk = 0;

uint redv
uint irv
uint dmax
         

int Hr
int Mn
int Sc



proc CDF_SeekTime(tsecs)
{
    ntime = utime()

    nwhere= dcseektime(Acdf,ntime-tsecs)

      //<<" %V $ntime  $cwhere $nwhere \n"



}


proc  ShowTime() 
{

   bscan(UC[0],0,tag,ltime)
     ntime = utime()
     dtm = ntime - ltime
     if ( (dtm) < nsecs) {
      slptim = nsecs - dtm
<<" sleeping $slptim $ntime $ltime $dtm $nsecs \n"
       sleep(nsecs)
     }


   ttime = localtime(ltime)
     //   <<" Time is $ltime $ttime : $where \n"
   Hr = ttime[2]
   Mn = ttime[1]
   Sc = ttime[0]
}

// fadc global set by latest pleth

proc GetGOP(awc)
{
   bscan(UC[0],0,tag,pr,spo2,pi)
     //     <<"$channel $tag %f $pr $spo2 $pi \n"
   
   Bestpr[awc]->set(fadc,pr) 
   Besto2[awc]->set(fadc,spo2)
   Bestpi[awc]->set(fadc,pi) 

}

int pvi = 0;


proc ResetPlethBuf()
{
   pvi = 0
}


proc   GetPleth()
{

  //  si = pvi
  bunpack(UC[2],0,"I,C,C,C,C,I,I,I,",PV[pvi])
  fadc = PV[pvi]
  pvi += 8

    //     fi = pvi -1
    //     pvsub = PV[si;fi]
    //     <<" $si $fi :  %6.0f $pvsub \n"

}

int nrecs = 0
int where

int ping_pong = 1

  // this needs to ba much faster & parallel read for all channels

proc ReadCDFile( nwsecs)
{
  // input to R nsecs of pleth from desired channel

  pleth_n = Trunc (nwsecs * 50)

  //<<" $pleth_n \n"
  npleth = 0

  ResetPlethBuf()
  
   while (1) {
  
     //   where = ftell(Acdf)
     //        sz=v_read(Acdf,C,3)
     // if (sz != 3) break
     //bscan(C[0],0,channel,nb)

       sz= fscanv(Acdf,"C,S,",channel,nb)

        if (sz != 2) break

	  //<<" %V $sz $channel $nb \n"



     //   if (nb > 4096) <<" NB $nb \n"

    nir=v_read(Acdf,UC,nb)
 
       if (nir < nb ) {
<<" CDF READ ERROR \n"
         break

       }

   rectype = UC[0]

   if (channel == 255 && rectype == 1 ) {
        ShowTime()
   }
   else if (rectype == 1) {
                nrecs++
                GetGOP(wchan-1)
   }
   else if (rectype == 6) {

     if ( UC[1] == 24  && op_pleth) {
       if (channel == wchan) {
       npleth++
       //<<" $npleth \n"
       GetPleth()
       }
    }
    
   }

   if (npleth >= pleth_n)
       break

  }


<<" $pleth_n read %v $npleth \n"

  plethpts = npleth * 8 -1

  R= PV[0;plethpts]

  maxpts = Caz(R)

<<" $maxpts \n"

  Redimn(R,npleth,8)

  //<<" %6.0f $R \n"
  //<<"  PLETH BUF \n"


  maxpts = Caz(R)

  dmn = Cab(R)

  // <<" %6.0f $R[0][*] \n"



    if (normalize) {

    PG = R[*][3]

    PG = 4|^PG

  // either 0 ,1,2, or 3 indicating gain of 1 ,4 , 16 or 64

     RD = R[*][1]

     RedDrive = RD

     RD = 4|^RD

     IRD = R[*][2]

     IRDrive = IRD

     IRD = 4|^IRD
    }

     Red = R[*][5]

    //rsz = Caz(Red)

    //dmn = Cab(Red)

    // <<" %v $rsz $dmn\n"

  // apply normalization ?
  if (normalize) {
  Red = Red / PG 
  Red = Red / RD
  }

 Redimn(Red)

  dmn = Cab(Red)

   // <<" after Redimn $dmn \n"

  maxpts = Caz(Red)

  //  <<" %v $maxpts in Red array \n"

   IR = R[*][6]

  //   AP = R[*][index]

   // <<" $dmn $(typeof(IR))\n"

  Redimn(IR)

  if (normalize) {
   IR = IR /PG
   IR = IR/ IRD
  }

  maxirpts = Caz(IR)

  //<<" %6.0f $IR \n"

  <<" %v $maxirpts  \n"
   return maxirpts
}


doRespFeat = 1
kticks = 0

wsecs = 60

rindex = 0.0

proc Dodevice(wname, ww , do_reset)
   {

    ok = CheckData()

    if (ok > 0) {

    maxpts = ReadCDFile( nsecs)

  <<" %v $maxpts \n"

    if (maxpts <= 0) {
     <<" EOF no plot ! \n"
          return maxpts
     <<" EOF SHOULD NOT SEE \n"
    }

    maxpts = Caz(Red)

    //     <<" %v $maxpts \n"

    npts = maxpts

    kticks++

    ksecs = kticks * nsecs

    if (ksecs >= wsecs) {
        ksecs = wsecs
	Wred =  Wred[ipts;;] @+ Red
        Wir  =  Wir[ipts;;] @+ IR
      }
    else if (kticks <= 3) {
    Wred =  Red
    Wir  =  IR
    }
    else {
    Wred =  Wred @+ Red
    Wir  =  Wir @+ IR
    }



    wpts = Trunc ( ksecs * 50)

   <<" %V $ksecs  $wpts \n"

    if (ksecs < 60) {
      ppts = wpts
      Rred = Wred
      Rir  = Wir
    }
    else {
      // view 
      sz = Caz(Wred)
      ppts = sz - 100
      <<" $ksecs $sz $ppts \n"
      Rred = Wred[sz-ppts;sz-1]
      Rir  = Wir[sz-ppts;sz-1]
    }

    DoScale()



    ctname = wname

    if ( doGUI) 
      Plot_RIR(ww, ppts, do_reset)

    if (doRespFeat ) {
    
    tw_len = 2

    TDD(tw_len  )

    ndao2 = spO2()

    // DO RESPIRATION DSP

    rindex = Riv()
 
    rindex *= 100.0

    RIV[nloop] = rindex


<<" ri $fadc $rindex \n"



    Bestri[0]->set(fadc,rindex) 

    if (ksecs > 40) {

    SmWindow(cwlen)

    ComputeSpec()

    PlotSpec()
    }
    }


    }

   return ok

   }


float RedDrive[]
float IRDrive[]

itype = "float"

int ferr = 0

int o2

float ndao2


int OP[]

pid = 0

float real[]
float imag[]


proc PlotSpec()
{

  if (!doGUI) return

      W_ClearPixMap(spw)
      
      MM = Stats(Rlogspec)

      max = MM[6]
   
      W_SetRS(spw,0.01,0, resphz,max * 1.2)
   
      W_SetPen(spw,"red")

	DrawY(spw,Rlogspec,0,1,2,0,25)

      //      MM = Stats(IRlogspec)
      //      max = MM[6]
      //      W_SetRS(spw,0,0,hfftsz,max * 1.2)
   
      W_SetPen(spw,"blue")

	DrawY(spw,IRlogspec,0,1,2,0,25)

      //      W_SetPen(spw,"blue")

      W_ShowPixMap(spw)
}


  /////////////////////////////////////////////////////// ComputeParameters //////////////////////////////////////



proc SmWindow( cwlen)
{

  wlm1 = cwlen -1

  real = Fgen(Fftsz,0.0,0.0)

  image = real

  sreal = Wred[0;wlm1]

    //  <<" $real[0;16]  $dmn\n"

  simag = Wir[0;wlm1]

  Rdc = Rms(sreal)

  IRdc = Rms(simag)

    MM=Stats(sreal)

    //<<" %v $MM \n"
    Ravedc = MM[1]

    sreal = sreal -MM[1]

    // sreal = Dcfilter(sreal)

    MM=Stats(simag)

//    imag -= MM[1]

//   simag = simag - MM[1]


    //    simag = Dcfilter(simag)

   IRavedc = MM[1]

   sreal *= swin

   simag *= swin 

    //   <<" %V $Rdc  $IRdc $Ravedc $IRavedc \n"

    Rdc = Ravedc
    IRdc = IRavedc

    if (IRdc <=0) IRdc = 1.0

    if (Rdc <=0) Rdc = 1.0

    zplen = Fftsz - cwlen

     if (zplen > 0) {
    zp = Fgen((Fftsz-cwlen),0,0)

    real = sreal  @+ zp
    imag = simag @+ zp

    }
    else {
   // real = sreal // error in direct copy

    real = sreal * 1.0
    imag = simag * 1.0
   }
}

float Rpowspec[]
float Rlogspec[]
float IRpowspec[]
float IRlogspec[]


proc ComputeSpec()
{

   Fft(real,imag,Fftsz)

   // get Copy to perform FFT convolution

   // doing complex input RED in real IR in imag
   // have to decode if we want separate RED and IR spec

     // decode into red and IR
     Rreal = fftdecode(real,imag,1)
     //<<" %v $Rreal \n"
     Rimag = fftdecode(real,imag,2)

     IRreal = fftdecode(real,imag,3)
     IRimag = fftdecode(real,imag,4)


   //////////////////////

   Rreal = Rreal * Rreal + Rimag * Rimag

   IRreal = IRreal * IRreal + IRimag * IRimag

   // this is Power Spec

   Rreal  *=  PwrScale
   IRreal *= PwrScale

   Rlogspec = log10(Rreal[0 ; specsz ]) * 10.0
   IRlogspec = log10(IRreal[0 ; specsz ]) * 10.0

   Rpowspec = Rreal[0 ; specsz]

   IRpowspec = IRreal[0 ; specsz]
}





//////////////////////////////////////////////////////// MAIN //////////////////////////////////////////////
 
 narg = argc()

 // defaults

 noxy = 1

 nsecs = 1.0

  ipts = Trunc( nsecs * 50)
  // how many channel/devices in cdf file

 if (noxy <= 0) {
<<" no valid oxy files \n"
     STOP!
 }

   head_start_mins = 0

   fname = $2


   j = 0
   i = 3


   while (i < narg) {

    wd = $i

<<" $i $wd \n"
    if (wd @= "head") {
      dotail = 0
       i++
       head_start_mins = $i
    }
    else if (wd @= "secs") {
       i++
       wsecs = $i
    }
    else if (wd @= "nchan") {
       i++
       noxy = $i
    }
    else if (wd @= "pid") {
       i++
       pid = $i
    }
    else {
    fname = $i
     <<" $fname \n"
     j++
    }

    i++;

   }

 koxy = 0

 doRedDrive = 0
 doIRDrive = 0

 do_IR = 0
 do_Red = 1
 do_AP = 0

  // want to display all active units

 int wrc = 1

 ac = 3

 wo2 =""

 jfile = fname
 ctname = fname
 fstem = Spat(ctname,".","<","<")
 fextn = Spat(ctname,".",">","<")
  if ( fextn @= "cdf" ) {
<<" $fextn is cdf \n"
  }

  <<" %V $ctname $fstem  %v $fextn \n"

 if (fstem @= "") {
  fstem = ctname
 }

    Acdf = ofr(jfile)

    ok = fstat(jfile,"size")

<<" $jfile $Acdf size $ok \n"

  lstem = ""

  lstem = Spat(fstem,"/",">","<")

  <<" %V $ctname $fstem $lstem \n"

   ctname = lstem

    if (lstem @= "") {
     lstem = fstem
    }

   ctname = lstem

  <<" %V $ctname $fstem $lstem \n"

      i = 0

//////////// GUI  SETUP /////////////////////////////////

plw = -1


  if (doGUI) {

<<" doing GUI setup \n"

  // just one main graph for all oximeters
      i = 0
      kprw[i] = setupwin("PLETH_1 ",0,10000)

  <<" %V $kprw[i] PLETH$i \n"

      plw = kprw[i]

      w_redraw(plw)

      w_move(plw,0)

  

      W_PixMapDrawON(plw)

      W_resize(plw,0.1,0.5,0.9,0.99,0)

      i++




      kprw[i] = setupwin("PLETH_2 ",0,10000)

  <<" %V $kprw[i] PLETH$i \n"

      plw = kprw[i]

      w_redraw(plw)

      w_move(plw,0)


      W_resize(plw,0.1,0.01,0.9,0.49,0)

// two for comparison
//      W_DrawOFF(plw)

      W_PixMapDrawON(plw)


   prw=setupwin("PR",0,10000)

      //<<" PR window $aprw[i] \n"

    ptY = 0.49
    pty = 0.05
    ptx = 0.05
    ptX = 0.1

    W_resize(prw,ptx,pty,ptX,ptY,1)

    W_SetRS(prw,0,30,100,350)
      W_PixMapDrawON(prw)
      W_DrawOFF(prw)
    
    o2w=setupwin("02",0,10000)
    ptx = ptX + 0.01
    ptX = 0.75
    W_resize(o2w,ptx,pty,ptX,ptY,1)

    W_SetRS(o2w,0,80,100,105)

    W_PixMapDrawON(o2w)



    piw=setupwin("PI",0,10000)

    ptx = ptX + 0.01
    ptX = 0.98
    
    W_resize(piw,ptx,pty,ptX,ptY,1)

    W_SetRS( piw,0,0,100,5.0)

    W_PixMapDrawON(piw)

    W_DrawOFF(piw)

// Resp index window on screen 2


    riw=setupwin("RI",0,10000)

    ptY = 0.79
    pty = 0.05
    ptx = 0.05
    ptX = 0.8

    W_resize(riw,ptx,pty,ptX,ptY,2)

    W_SetRS(riw,0,-2,100,20)
    W_PixMapDrawON(riw)



// spec window on screen 3

    spw=setupwin("SPEC",0,10000)
 
    
    W_resize(spw,0.1,pty,0.98,0.75,3)

    W_SetRS( spw,0,0,1024,120)

    W_PixMapDrawON(spw)

    W_DrawOFF(spw)

    woysp = 0.03
    woht = 0.07

    woy = 0.8
    woY = woy + woht

    woxwd = 0.09

    wox = 0.9
    woX = wox + woxwd

    prwo=w_CreateWO(plw,"SHOW_VALUE_RIGHT","PR ",1,wox,woy,woX,woY,0,"blue")

    woY = woy - woysp
    woy = woY - woht

    o2wo=w_CreateWO(plw,"SHOW_VALUE_RIGHT","O2 ",1,wox,woy,woX,woY,0,"red")

    woY = woy - woysp
    woy = woY - woht

    piwo=w_CreateWO(plw,"SHOW_VALUE_RIGHT","PI ",1,wox,woy,woX,woY,0,"green")

    woY = woy - woysp
    woy = woY - woht

    redwo=w_CreateWO(plw,"ONOFF","RED",1,wox,woy,woX,woY,2,"red","medium","white")

    woY = woy - woysp
    woy = woY - woht

    irwo=w_CreateWO(plw,"ONOFF","IR",1,wox,woy,woX,woY,2,"blue","medium","white")

    woY = woy - woysp
    woy = woY - woht

    apwo=w_CreateWO(plw,"ONOFF","AP",1,wox,woy,woX,woY,2,"green","medium","white")

    woY = woy - woysp
    woy = woY - woht
    wox -= 0.03

    ::inwo=w_CreateWO(plw,"BUTTON_VALUE","INDEX",1,wox,woy,woX,woY,11,"blue","medium","white")

    woY = woy - woysp
    woy = woY - woht

    //   CONTROLS
    woysp = 0.03
    woht = 0.07

    woy = 0.8
    woY = woy + woht

    woxwd = 0.05

    wox = 0.05
    woX = wox + woxwd 

  //    baudwo=w_CreateWO(plw,"ONOFF","SYNB",1,wox,woy,woX,woY,2,"green","medium","white")

    woY = woy - woysp
    woy = woY - woht

    cswo=w_CreateWO(plw,"ONOFF","CS",1,wox,woy,woX,woY,2,"blue","medium","white")

    WoRedraw(plw)

    SwitchScreen(0)

  ymin = 0
  ymax = 1.0

    W_DrawOFF(plw)

    W_DrawON(riw)

               ws = 1
      wsx = 0.02
      wsX = 0.99
      wsY = 0.97
      wsy = 0.05
      cwx = 0.05
      cwy = 0.1
      cwY = 0.95
      cwX = 0.95

	       w_resize( o2w,wsx,0.56,wsX,wsY,ws)

	       w_resize( piw,wsx,0.46,wsX,0.55,ws)

	       w_resize( prw,wsx,wsy,wsX,0.45,ws)

  }

   ///////////////////////////////// END OF GUI SETUP //////////////////////////////////




  // head start

   lmblks = 0
   mblks = 0
   nloop = 0

   pfname =  "${ctname}_pleth.ps"


// setup DSP

Fftsz = 2048

hfftsz = Fftsz/2
Wlen = hfftsz
cwlen = Wlen
specsz = hfftsz -1

resphz =  0.5
resp_fpt = hfftsz/25.0 * resphz

  float cswin[hfftsz]
  float swin[Wlen]

  PwrScale = 1.0/ (Fftsz)

  Swindow(swin,Wlen,"Hanning")


   ////////////////////////////////////////////////


   int cs = 1

   int newindex
 
   ows = 0

   cwhere = ftell(Acdf)

    if (dotail)
   CDF_SeekTime(nsecs)   


   while (1) {

   // for each device 
       col = 2
	 fsize = fstat(fname,"size")

         tfn = fname

	 //<<" $tfn $fsize \n"

         // per chan have to reseek
         // should have a read that mulitplexes into each channel

          cwhere = ftell(Acdf)

     for (koxy = 0; koxy < noxy; koxy++) {

         s_file(Acdf,cwhere,0)

	 wchan = koxy + 1
         

         disp_reset = 0

         if (koxy == 0)
                   disp_reset = 1

         ret = Dodevice( tfn , plw, disp_reset)

         piv = pi * 0.001

 
             GUI_DrawOxyP()
     }

    nloop++

   ///////  MAIN GUI LOOP //////////////////////////////

    if (doGUI) {

      GUI_Screen()
    
     // if post - capture
     //   CheckMemUse("afterDoDdevice")

   wo_set(prwo,"value"," $pr")
   wo_set(o2wo,"value"," $spo2")
   wo_set(piwo,"value"," $pi")


//   lmblks = mblks
// sleep if necessary - if fsize not increased?

       GUI_interact()
    }

   }

     


STOP!

/////////////////////////////////////// TODO /////////////////////////////
//                
//
//                
//
//                ability to compare parameters on main graph
//
//
//
/////////////////////////////////////////////////////////////////////////


proc   GetPleth()
{
//<<" found 50Hz %x $UC \n"


//   bscan(UC[0],0,tag,rtype,fadc,redrv,irdrv,gain,led,redv,irv,dmax)
     //<<"$channel $tag $rtype $fadc $redrv $irdrv $gain $led %u $redv %u $irv %u $dmax :$where\n"
  // si = pvi
  //   pvi += packv(PV[pvi],fadc,redrv,irdrv,gain,led,redv,irv,dmax)
  // fi = pvi -1

     //  <<" %v $si $fi \n\n"
     // pvsub = PV[si;fi]
     //   <<" $si $fi :  %6.0f $pvsub \n"

          bunpack(UC[2],0,"I,C,C,C,C,I,I,I,",PV[pvi])
          pvi += 8


   if (pvi > 10000)
       pvi = 0

}




/////////////////////////////////////////////////////
#{
    if (ping_pong) {
        IR1= IR
        IR = IR2 @+ IR1
        Red1= Red
        Red = Red2 @+ Red1
        ping_pong = 0
	//<<" %6.0f $Red[0;9] \n"
    }
    else {
        IR2= IR
        IR = IR1 @+ IR2
        Red2= Red
        Red = Red1 @+ Red2
        ping_pong = 1
	//<<" %6.0f $Red[0;9] \n"

	//	M=GetMouseEvent()
	//     awd = ttyin()
	//        sleep(0.2)
    }
#}

#{

   iwhere = ftell(Acdf)

 while (1) {

     where = ftell(Acdf)

   sz=v_read(Acdf,C,3)

   if (sz != 3) break

      bscan(C[0],0,channel,nb)

    nir=v_read(Acdf,UC,nb)
 
   if (nir < nb ) break
   rectype = UC[0]

   if (channel == 255 && rectype == 1 ) {
           bscan(UC[0],0,tag,ltime)
<<" $ntime $ltime \n"
     if ( (ntime -ltime) < tsecs) {

<<" found tail end \n"

      return
     }
   }
 }
#}
