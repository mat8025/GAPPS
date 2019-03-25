#/* -*- c -*- */
// must specifically open libraries if compiled version is used

OpenDll("audio","image","plot","math","stat")


PI_ = 4.0 * atan(1.0)



proc Prop( what )
{
 <<" /////////////////////////////////////////// \n"
 <<" // setting up $what    \n" 
 <<" /////////////////////////////////////////// \n"
}



Graphic = CheckGwm()
// overide with command line
 if (! Graphic) {

   SpawnGWM()

  }

Graphic = CheckGwm()
SetDebug(1)


int Freq  = 12000
float Sfactor = 1.0

nsecs = 20

int Nsamps = nsecs * Freq

// make this multiple of 512

vsamps = Nsamps * 2
short Sbuf[]

// filtered version
float Dfbuf[]


int RbKey[]   // ringbuffer status use to keep track of recording and filter threads

// recording thread will alloc buffers - error return - not valid
float Fir[]
// should be a define

int RBOP = 8


//   Fir[0] = 5
//   Fir[1:5] = 0.2
//   Fir[] = {5,2.0,1.5,0.0,0.2,0.2}
//   Fir[] = {5,0.0,0.0,0.0,0.0,0.0}
//    Fir[] = {5,2.0,1.0,0.0,-1.0,-2.0}
//    Fir[] = {5,0.2,0.2,0.2,0.2,0.2}
//    Fir[] = {5,0.0,0.0,1.2,0.0,0.0}

  Fir[] = {5,-0.25,-0.25,1.0,-0.25,-0.25}
<<" $Fir \n"
  Fir[128] = 0.0



//////////////////// Feature Tracks //////////////////////////////
float RmsTrk[50]
float ZxTrk[50]

RmsTrk = 1.0
ZxTrk = 1.0
<<" $(Caz(RmsTrk)) \n"


//ttyin()

//////////////////////////////////////////////////////////

float Gain = 2.5;

last_rbv = 0

int recblksz = 256
int mvt

proc RecVox( mv, spi )
{

int wb

  dorec = 0
  mvt = 0
//<<" %V $mv $spi \n"


  if (mv > SpeechThres) {

   SetGwob(st_wo,"color","yellow","value","%6.2f$mv","redraw")

   wb = spi / recblksz

   hmb = wb - last_rbv

//<<" %V $wb $hmb $recblksz \n" 
// want to record this block - plus upto 3? prior unrecorded blocks

     dorec = 1
     mvt = 1

    if (hmb > 0 ) {

       nb2r = hmb

//      if (hmb > 3) {
//         nb2r = 3
//      }


    wbs = (wb - hmb +1) * recblksz

    wbe = wbs + nb2r * recblksz -1

    w_data(voxfd,Sbuf[wbs:wbe])

<<"\n $dorec  $mv $wb  $wbs $wbe ---> vox \n"

    }

    last_rbv = wb

  }
  else {
   SetGwob(st_wo,"color","blue")
   SetGwob(st_wo,"value","%6.2f$mv","redraw")
   SetGwob(rt_wo,"color","blue")
   SetGwob(rt_wo,"value",Tim->rsecs,"redraw")
  }

//<<" return %v $dorec \n"

     return dorec
}



proc RecBuff()
{
// recording thread

   tid = GthreadGetId()

<<" Start Recording ! session fd $pcmfd \n"

   dt=FineTimeSince(T,1)

   SetSoundParams(dspfd, mixfd, Freq, 1 )

// set recordstart time

     eret = RecordBuffer(Sbuf, dspfd, Nsamps, 1,  RbKey , pcmfd)

//   eret = RecordBuffer(Sbuf, dspfd, Nsamps, 1,  RbKey )


   if (eret < 0) {
     <<" Error in Record Setup !! \n"
   }

<<" Done Recording ! \n"
   
   GthreadExit(tid)

}


proc FiltBuff()
{

// init filter thread

   tid = GthreadGetId()

// default -- copy/convert Sbuf to Dfbuf
// monitor lag

// check RbKey -- if setup
// alloc Dfbuf and proceed

   int wbfilt =0
   int lrec = 0
   int trec = 0
   mode = 2

       //  RbKey[RBOP] = 1

   RbKey[RBOP] = 0 // just copy

   retok = RingBufferSp(Sbuf,Dfbuf,RbKey, mode, "FIR", Fir )

// toggle - FIR onoff via element int RbKey

   <<" Done Filtering \n"


   GthreadExit(tid)
}

proc MixSignal()
{
      Ysig = Fgen(npts,0,dft)

//  <<" $Ysig[0:10] \n"

       Ysig = Sin(Ysig * cf * 2.0 * PI_ ) * 500

//  <<" $Ysig[0:10] \n"

        YS += Ysig

//  <<" $YS[0:10] \n"
//<<" %6.4f %v $YS[0:10] \n"
//<<" $(typeof(YS)) $(Cab(YS)) \n"

       cf += cf_inc
       if ((cf > 4000) || (cf < 100)) {
          cf_inc *= -1
       }
}



// use FineTime to pick where to display
// circular buffer

int ncb = 96 //  each as a vertical pixel in SG window

uchar pixstrip[4][ncb]


int sgx = 50



float SpeechThres = 2.0

float cf = 440
cf_inc = -2.0
int  iend = 0


Class Timekeeper 
 {

  public:
   float skipsig;
   float rsecs;
   float dsecs;
   float hrti;
   float last_t;
   float hl;
   float syncsecs;
   float lags;
   float catchup;

  CMF Timekeeper()
    {
     skipsig = 0.0
     rsecs = 0
     dsecs = 0.0;
     syncsecs = 0.0;
     last_t = 0.0;
     hrti = 1.0/Freq * (2 * wlen)
//  <<" $hrti \n"
  
    }
   
  CMF update()
   {

   dt=FineTimeSince(T)
   dsecs = dt /1000000.0

   syncsecs = last_t + hrti
   lags = syncsecs - dsecs   

   catchup = (dsecs - syncsecs)

   if (dsecs < syncsecs) {
//<<" ahead by $lags \n"
     setgwob(CU_wo,"color","green","penhue","yellow","redraw")
     sleep(lags * 0.8)
     dsecs = syncsecs
   }

     if ( catchup < 5.5) {
          dsecs = syncsecs
//<<"%V $catchup \n" 
     }
     else {
       skipsig += catchup
       setgwob(CU_wo,"color","red","redraw")
//<<" skip ahead $skipsig \n"
     }

   hl = dsecs - last_t
   last_t = dsecs

   st = ( (last_t - 0.5) * Freq) % (nsecs * Freq)

   return st

   }

  CMF Print()
   {
    <<"%V $rsecs $dsecs $lags $catchup $skipsig\n"
   }

  CMF Rec()
   {

        rsecs += 0.04          

   }

 }



 Timekeeper Tim


short powxyvec[8]
short zxxyvec[8]
short taxyvec[16]

int Zxthres = 50

float zxv[4]
float dbv[4]

float powspec[]


int ScrollX = 600


proc DisplayBuff()
{
// display thread

//  SetPCW("writepic")

  tid = GthreadGetId()
  slen = 4096
  sinc = 1000
  int st = 0
  int end = slen

  uint dt
  int jpx = 100
  uint dp_loop =0

  while (1) {

    st = Tim->update()
//<<" %v $st \n"
// this is real time - offset
// want to find out if we are keeping up

    fflush(1)

// need get correct blocks from ring buffer

   st -= slen

   if (st < 0) {
       st = 0
   }

   end = st + slen

   SetGwob(tt_wo,"value","%6.2f$Tim->dsecs","redraw")

// lets use RbKey - last Recorded buffer
// check has this time window been processed ??

//<<" %V $st $end \n"

    npts = end -st +1

//<<" $npts $dft \n"
    taend = st + (2*slen)

    YS = Dfbuf[st:end] * Gain  

//    rmsv = log10(RMS(YS))

    rmsv = RMS(YS)
    
    dbv[0] = 10*log10(rmsv) -20

    if (dbv[0] < 0.0) {
        dbv[0] = 0.0
    }

//  <<" $YS[0:10] \n"

    RmsTrk->ShiftL(dbv[0])

//<<" $(Caz(RmsTrk)) \n"

    zxv[0] = ZC(YS,Zxthres)

    ZxTrk->ShiftL(zxv[0])

    mv = Mean(RmsTrk)
    sz = Caz(RmsTrk)

//<<" %V     $sz  $mv \n"

//<<" $RmsTrk \n"
//  mix in signal

    if (mix_signal) {
       MixSignal()
    }


   fftend = FFTSZ-1
//<<"%V $wlen $iend $fftend \n"
//   real = YS[0:fftend] * swin

   real = YS[0:fftend] 
   zxv[0] = ZC(real,Zxthres)

   ti = 0
   tas = 0.004
   tac = 20
// need to add for  negative
    mm = MinMax(real * tas)

    taxyvec[0,4,8,12] = Igen(4,ScrollX,1)
    taxyvec[2,6,10,14] = Igen(4,ScrollX,1)
    taxyvec[1,3] = mm + tac


//<<"%v $taxyvec[*] \n"

    dbv[0] = 10*log10(Rms(real)) -20

   real *= swin

//<<" %6.4f$Tim->dsecs $lags $Tim->skipsig $hl $rmsv $dbv[0] Db $mv %d  << $RbKey[*] >>\r"

   end = st + wlen


//<<" imag sz $(Cab(imag)) \n"
   ist  = wlen/2 
   iend = ist + wlen -1

   imag = YS[ist:iend] 

   zxv[1] = ZC(imag,Zxthres)

   dbv[1] = 10*log10(Rms(imag)) -20


    mm = MinMax(imag  * tas)
    taxyvec[5,7] = mm + tac

    imag *=  swin

// <<"INSM %6.2f$real \n"
// <<"IN %6.3f$imag \n"

   specsz = FFTSZ/2
  
   spec(real,imag,FFTSZ,1)
  
  // FIX powspec= real[0:(specsz-1)]

   endspec = specsz -2

   powspec= real[1:endspec] 



//ttyin()
   if ((mv > SpeechThres) || ((dp_loop % 10) == 0)) {

   if (see_ta_wave) {
      setgwob(tagwo,"ClearPixMap")
      DrawY(tagwo,YS,0,1)
      setgwob(tagwo,"ShowPixMap")
   }


  if (see_spec_slice) {
      if ((dp_loop % 2 ) == 0) {
         setgwob(specwo,"ClearPixMap")
         DrawY(specwo,powspec,0)
         setgwob(specwo,"ShowPixMap")
      }
  }

  }

/////////////////  RECORD  ///////////////////////////////
  

   mvt = RecVox( mv, st) 

//  <<" %V $mvt  $Graphic $see_sg \r"

  if ( Graphic && mvt ) {

// make pixstrip [4][ncb]

   if (sp_process) {
   pixstrip[0][*] = round(v_range(v_zoom(powspec,ncb),20,100,8,tgl))

   powspec= imag[1:endspec] 

   pixstrip[1][*] = round(v_range(v_zoom(powspec,ncb),20,100,8,tgl))
  
   ki = iend
   ji = ki + FFTSZ-1
   wlm1 = wlen-1

   real[0:wlen-1] = YS[ki:ji] 

   zxv[2] = ZC(real,Zxthres)
   dbv[2] = 10*log10(Rms(real)) -20

   mm = MinMax(real  * tas)

   taxyvec[9,11] = mm + tac

   real *= swin

   ki = ki + wlen/2
   ji = ki + FFTSZ-1


   imag[0:wlen-1] = YS[ki:ji] 

   dbv[3] = 10*log10(Rms(imag)) -20

   zxv[3] = ZC(imag,Zxthres)

   mm = MinMax(imag  * tas)

   taxyvec[13,15] = mm + tac

   imag *= swin

   spec(real,imag,FFTSZ,1)

   pixstrip[2][*] = round(v_range(v_zoom(powspec,ncb),20,100,8,tgl))

   powspec= imag[1:endspec] 

   pixstrip[3][*] = round(v_range(v_zoom(powspec,ncb),20,100,8,tgl))


//   <<" $pixstrip \n"
// edge of clip --- specifies where to paint this update -- 700th pixel?

//  <<" %v $(Cab(pixstrip)) \n"

//FIXME  bad magic number ScrollX (was 697) -- work this out from clipsize
// needs to dCx - 4 ??

   }


   if (see_sg) {
//   PlotPixRect(sgwo, Transpose(pixstrip), ScrollX,97, 1)
   PlotPixRect(sgwo, pixstrip, ScrollX,0, 2,1)
   setgwob(sgwo,"scroll",4,0,"store")
   }

   if (see_ta_env) {
   setgwob(tawo,"hue","red","plotilines",taxyvec,"scroll",4,0,"store","pixmapon")
   }

// plotpoints

   dbvs = 2.0

   if (see_features ) {

   powxyvec[0,2,4,6] = Igen(4,ScrollX,1)

   powxyvec[1,3,5,7] = dbv * dbvs

//<<" $powxyvec[*] \n"

   setgwob(fewo,"hue","red","plotilines",powxyvec)

//   SetGwob(rms_wo,"move",0.1,dbv/20 )
//<<" %V $dbv1  \n"

   zxs = 50

   zxxyvec[0,2,4,6] = Igen(4,ScrollX,1)

   zxxyvec[1,3,5,7] = zxv * zxs

//<<" $(Caz(zxxyvec)) %V $zxxyvec \n"

   setgwob(fewo,"hue","blue","plotilines",zxxyvec)
   
// ok write out vox file

   setgwob(fewo,"scroll",4,0,"store","border")

   }

   Tim->Rec()

   SetGwob(rt_wo,"color","red","value",Tim->rsecs,"redraw")

   }

   dp_loop++
 }

   GthreadExit(tid)
}



exit_see_wave = 0

msg = "xx"

proc CheckMsg()
{

//  SetPCW("writepic")

 tid = GthreadGetId()
int mloop = 0
// 
    if (do_fir ) {
         do_fir = 0
         RbKey[RBOP] = 0
        } 

  while (1) {

     msg = MessageRead(Minfo)
     mloop++

     if ( !scmp(msg,"NO_MSG",6) ) {

       Mword=Split(msg)

       mlen = slen(msg)
     
       msg_name = Mword[0]
       msg_val = Mword[1]

     
      <<"%V $msg $mlen $Minfo $msg_name\n"

       if (scmp(msg_name,"t",1) || (msg_name @= "TA")) {

        if (see_ta_wave ) {
         see_ta_wave = 0
        }
        else { 
         see_ta_wave = 1
        }
          <<" toggle %v $see_ta_wave \n"
        }

       if (scmp(msg_name,"s",1) || (msg_name @= "SS")) {

        if (!see_spec_slice ) {
         see_spec_slice = 1
        }
        else { 
         see_spec_slice = 0
        }
         <<" toggle %v $see_spec_slice \n"
        }



       if ((msg_name @= "TF")) {

        if (do_fir ) {
         do_fir = 0
         RbKey[RBOP] = 0
        }
        else { 
         do_fir = 1
         RbKey[RBOP] = 1
        }
          <<" toggle %v $do_fir $RbKey[RBOP]\n"
        
        }

       if (scmp(msg_name,"g",1) || (msg_name @= "SG")) {

        if (see_sg ) {
         see_sg  = 0
        }
        else { 
         see_sg = 1
        }

//         see_sg =1   // always for now
          <<" toggle %v $see_sg \n"
        }

      if (scmp(msg_name,"SMW",3)) {
          Swindow(swin,wlen,msg_val)
        <<"Smoothing window type:  $msg_val  \n"
      }

       if (scmp(msg_name,"q",1)) {
         exit_see_wave = 1
         break
       }

         SetGwindow(tassw,"activate")
         SetGwindow(sgw,"activate")

       // CRASH SetGwindow({tassw,sgw},"activate")

     }
     else {
      sleep(1.5)
      yieldthread()
//      yieldthread()


      if ((mloop % 2 ) == 0) {
      SetGwob(msg_wo,"color","yellow","redraw")
<<"%v $mloop \n" 
      }  
      else {
      SetGwob(msg_wo,"color","red","redraw")
      }


     }

  }

   GthreadExit(tid)
}

short tvox[]

float YS[]

int vamp = 20000
float Amp = 0.9
int s1

 float swin[]

 float real[1024+]
 float imag[1024+]




//include SeeWaveDraw
//include SeeWaveCompute

 FFTSZ = 256

 wlen = FFTSZ

float hrti
hrti = 1.0/Freq * (2 * wlen)

  float dft = 1.0/Freq

<<" %V $wlen $hrti $dft \n"
//ttyin()

int see_spec_slice = 1
int see_features = 1
int see_ta_wave = 1
int see_sg = 1
int do_fir = 0
int see_ta_env = 1
int mix_signal = 0
int sp_process = 1
// 

swin = Fgen(wlen,0.5,0)
<<"%6.2f$swin \n"

<<" $(Cab(swin)) \n"

  Swindow(swin,wlen,"Hamming")
  Swindow(swin,wlen,"Kaiser")
<<"%6.2f$swin \n"
<<" $(Cab(swin)) \n"



 Sf = Freq

 dt = 1/Sf

 ng = 32

 Gindex = 8

 tgl = Gindex + ng
// grey scale
 SetGSmap(ng,Gindex)



 int nw = 0
 int allwins[]

 // Screen Setup - One time only

////////////////////////////////  WINDOW SETUP /////////////////////////////////////////////////////
 Prop("Windows")


 Vamp = 5000

     <<" create TAW \n"
 tassw = CreateGwindow(@title,"TimeAmp",@scales,0,-Vamp,256,Vamp,@savescales,0)


 allwins[nw++] = tassw
 SetGwindow(tassw,@resize,0.1,0.02,0.9,0.48,0)
 SetGwindow(@pixmapon,"drawoff",@hue,"blue",@clip,0.01,0.01,0.99,0.99)
 setgw("clear","redraw","save")

<<"%V$tw $nw $allwins \n"


     <<" create SGW \n"
 sgw = CreateGwindow(@title,"SG",@scales,0,0,800,140,@savescales,0)
 SetGwindow(@resize,0.1,0.50,0.9,0.95,0)
 SetGwindow("pixmapon","drawoff","clear","redraw","save")


 allwins[nw++] = sgw

<<"%V $sgw $nw $allwins \n"

     wo_wd = 0.2
     wox = 0.1
     woX = wox + wo_wd/3

     woy = 0.1
     woY = 0.9

  Prop("Window Objects")

  sgtogwo=CreateGWOB(sgw,"TB_BUTTON","resize",0,0.02,woy,0.07,woY,"name","SG","color","blue","penhue","red","symbol","triangle")
  SetGwob(sgtogwo,"help","toggle SG display","redraw","drawon")

  sgwo=CreateGwob(sgw,"GRAPH","resize",0,0.05,0.35,0.95,0.70,"scales",0,-Vamp,1024,Vamp)
  SetGwob(sgwo,"hue","black","name","sgraph","pixmapon","drawoff","redraw","save")
  SetGwob(sgwo,"clip",0.01,0.01,0.99,0.99, "clipborder","black")


  fewo=CreateGwob(sgw,"GRAPH","resize",0,0.05,0.05,0.95,0.33,"scales",0,-0.1,700,1.1)
  SetGwob(fewo,"hue","red","name","rmswave","redraw","save","drawoff","pixmapon")
  SetGwob(fewo,"clip",0.01,0.01,0.99,0.99, "clipborder","black")



  tawo=CreateGwob(sgw,"GRAPH","resize",0,0.05,0.71,0.95,0.99,"scales",0,-Vamp,1024,Vamp)
  SetGwob(tawo,"hue","black","name","tawave","drawoff","redraw","save")
  SetGwob(tawo,"clip",0.01,0.01,0.99,0.99, "clipborder","black")


msg_wo=CreateGWOB(tassw,"TB_BUTTON","resize",0,0.97,0.1,0.99,0.25,"name","MSG","color","blue","penhue","red","symbol","triangle")

//rms_wo=CreateGWOB(tassw,"BUTTON_SYM","resize",0,0.1,0.1,0.13,0.25,"name","RMS","color","blue","penhue","red","symbol","triangle")

 SetGwob(msg_wo,"help","msg value","drawon","pixmapoff","redraw", "style", "SVO")


  tt_wo=CreateGWOB(tassw,"BV","resize",0,0.86,0.91,0.99,0.99,"name","TT","color","white","penhue","red","value",0)
  SetGwob(tt_wo,"help","total time","drawon","redraw","style", "SVO")

  rt_wo=CreateGWOB(tassw,"BV","resize",0,0.75,0.91,0.85,0.99,"name","RecordT","color","blue","penhue","black","value",0)
  SetGwob(rt_wo,"help","rec time","drawon","pixmapoff","redraw", "style", "SVO")

  st_wo=CreateGWOB(tassw,"BV","resize",0,0.65,0.91,0.73,0.99,"name","Power","color","blue","penhue","black","value",0)
  SetGwob(st_wo,"help","power","drawon","pixmapoff","redraw", "style", "SVO")

     wox = woX + 0.05
     woX = wox + wo_wd/3



  tagwo=CreateGwob(tassw,"GRAPH","resize",0,0.05,0.05,0.54,0.90,"scales",0,-Vamp,1024,Vamp)
  SetGwob(tagwo,"hue","blue","name","tawave","redraw","save","drawoff","pixmapon")
  SetGwob(tagwo,"clip",0.01,0.01,0.99,0.99, "clipborder","black")





  TF_wo=CreateGWOB(tassw,"TB_BUTTON","resize",0,0.8,woy,0.87,woY,"name","TF","color","blue","symbol","triangle")
  SetGwob(TF_wo,"help","toggle FIR convolve","redraw","pixmapon")

  TA_wo=CreateGWOB(tassw,"TB_BUTTON","resize",0,0.75,woy,0.79,woY,"name","TA","color","yellow","symbol","triangle")
  SetGwob(TA_wo,"help","toggle TA display","redraw")



  specwo=CreateGwob(tassw,"GRAPH","resize",0,0.55,0.05,0.95,0.90,"scales",0,-20,128,140)
  SetGwob(specwo,"hue","red","name","specslice","redraw","save","pixmapon")
  SetGwob(specwo,"clip",0.01,0.01,0.99,0.99, "clipborder","black")


     wox = woX + 0.05
     woX = wox + wo_wd/2

  FREQ_wo=CreateGwob(tassw,"TB_MENU","resize",0,0.1,woy,0.2,woY,  "color","yellow", "style", "SVO", "drawon")
  SetGwob(FREQ_wo,"help","Set Freq","name","Freq","penhue","black", "function", "wo_menu", "menu","8000,12000,16000", "value", "12000")

  smw_wo=CreateGwob(tassw,"TB_MENU","resize",0,0.21,woy,0.32,woY,"name","SMW", "color","yellow", "style", "SVO", "drawon")
  SetGwob(smw_wo,"penhue","black","help","smoothing window type","function","wo_menu","menu","Hanning,Kaiser,Hamming", "value", "Hanning",  "redraw")

     wox = woX + 0.05
     woX = wox + wo_wd



  CU_wo=CreateGWOB(tassw,"TB_BUTTON","resize",0,0.02,woy,0.08,woY,"name","CU","color","white","penhue","black","symbol","triangle")
  SetGwob(CU_wo,"help","toggle TA display","redraw")





  SS_wo=CreateGWOB(sw,"TB_BUTTON","resize",0,0.02,woy,0.07,woY,"name","SS","color","yellow","penhue","black","symbol","triangle")
  SetGwob(SS_wo,"help","toggle SS display","redraw")

  <<" $allwins[*] \n"
  SetGwindow(allwins,"woredrawall")



////////////////////////////////// GLINES for FEATURE TRACKS ///////////////////////////////////////

// RMS
//rmsgl = CreateGline("wid",powwo,"type","Y","yvec",RmsTrk,"color","red","name","RMS")
//setgline(rmsgl,"scales",0,0,200,30,"ltype",1, "symbol","diamond","savescales",0,"usescales",0)

//zxgl = CreateGline("wid",zxwo,"type","Y","yvec",ZxTrk,"color","blue","name","ZX")
//setgline(zxgl,"scales",0,0,200,0.5,"ltype",1, "symbol","diamond","savescales",0,"usescales",0)
//  

 yfreq = 200
 zfreq = 660

 yamp = 0.5 
 zamp = 0.5
 tdelay = 2.0


 int Minfo[10+]
 float pwidth = 0.1

/////////////////  RECORD SETUP  /////////////////////////


// get/open dsp
 Prop("Recording Thread")
  dspfd = dspopen()
  pcmfd = -1


   pcmfd = ofw("rb.vox")

   voxfd =ofw("session.vox")


// get/open  mixer

  mixfd = mixeropen()

// set dsp,mixer

<<"%V $dspfd $mixfd \n"

   T=FineTime()

   recid = gthreadcreate("RecBuff")

   filtid = gthreadcreate("FiltBuff")


////////////////////////////////////////

//  Display thread

     Prop("DISPLAY THREAD")

//   sleep(5)

   displayid = gthreadcreate("DisplayBuff")



    if (do_fir ) {
         do_fir = 0
         RbKey[RBOP] = 0
        } 

   if (Graphic) {

      Prop("MESSAGE THREAD")

      msgid = gthreadcreate("CheckMsg")

   }

   Prop("MAIN THREAD WAITS")

   nt = gthreadHowMany()

  <<" WAITING for $(nt-1) other threads to finish \n"
//   DisplayBuff()

// main
// user control
    
      // CRASH ?
     // SetGwindow({tassw,sgw},"activate")


  RbKey[RBOP] = 0

 while (1)
 {
     // see_spec_splice = ! see_spec_splice
    //<<" %v $see_spec_splice \n"


  // CheckMsg()

   if (msg @= "q") {
      gthreadSetFlag(recid,1)

      gthreadExit(displayid)
      gthreadExit(msgid)

      Gthreadwait()
      break
   }

// yield _thread ??
   yieldthread()
   sleep(0.25)

   if (exit_see_wave) {
        break
   }

 }




 STOP!






#{
////////////////////////////////   TBD ////////////////////////// 
//

 key-board control over processing & display
 wo control over processing & display
 see_spec_splice s
 see_spectrogram g
 smoothing-window -choice k Kaiser h Hamming r rectangular
 mic_amp_boost
 musical scale

 visible indicators of all relevant parameters

 construct and apply Digital filter to  Sbuf

 table and/or apprx function FFT

 one point in - one point out FFT slide

 wavelet FB

 auditory model FB

 pitch 
 speech features
 lpc
 cepstrum

 recognition stream



///////////////////////////////////////////////////////////////

///////////////////////////////  FIX /////////////////////////
//

////////////////////////////////////////////////////////////////////////////////////
#}




