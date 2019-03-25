///
/// SAYSEE
///
///


version = "1.1" ; 
<<"$_clarg[0] $version\n"


// swap these to switch  debug prints
//#define DBPR  <<
#define DBPR  ~! 


int see_ta_wave = 1
int see_spec_slice = 1
int see_features = 0
int see_sg = 1
int do_fir = 0
int see_ta_env = 0
int mix_signal = 0
int sp_process = 1


float last_secs = 0.0;

setPrintGwm(0)


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
   Graphic = 1;
  }



SetDebug(0)


int FFTSZ = 256
int Wlen = FFTSZ
 
int Freq  = 16000
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
DBPR" $Fir \n"
  Fir[128] = 0.0



//////////////////// Feature Tracks //////////////////////////////
float RmsTrk[50]
float ZxTrk[50]

RmsTrk = 1.0
ZxTrk = 1.0
DBPR" $(Caz(RmsTrk)) \n"


//ttyin()

//////////////////////////////////////////////////////////

float Gain = 1.0;

last_rbv = 0

int recblksz = 256

//int mvt
int mvt = 0

proc RecVox( mv, spi )
{

int wb

  dorec = 0
  mvt = 0

DBPR" %V $mv $spi \n"
  
  if (mv > SpeechThres) {

   SWo(st_wo,"color","yellow","value","%6.2f$mv",@redraw)

   wb = spi / recblksz

   hmb = wb - last_rbv

//DBPR" %V $wb $hmb $recblksz \n" 
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

DBPR"\n $dorec  $mv $wb  $wbs $wbe ---> vox \n"

    }

    last_rbv = wb

  }
  else {
   SWo(st_wo,"color","blue")
   SWo(st_wo,"value","%6.2f$mv",@redraw)
   SWo(rt_wo,"color","blue")
   SWo(rt_wo,"value",Tim->rsecs,@redraw)
  }

//DBPR" return %v $dorec \n"

     return dorec
}
//======================================================================
//Tengo que esforzarse más para avanzar hacia mi objetivo
int smic_factor = 0x5a5a // ? alters mic gain via mixer device /dev/mixer1

proc RecBuff()
{
// recording thread

   tid = GthreadGetId()

<<" Start Recording ! session fd $pcmfd \n"

   dt=FineTimeSince(T,1)

   SetSoundParams(dspfd, mixfd, Freq, 1 );
   getSoundParams(dspfd,mixfd);

<<"setRecord\n"
   setRecordParams(dspfd,mixfd, Freq,1, smic_factor);
   getSoundParams(dspfd,mixfd);

// set recordstart time
// this record forever routine
// has to periodically
// allow other threads to run


  eret = RecordBuffer(Sbuf, dspfd, Nsamps, 1,  RbKey , pcmfd)


   if (eret < 0) {
     DBPR" Error in Record Setup !! \n"
   }

   DBPR" Done Recording ! \n"
   
   GthreadExit(tid)

}
//============================================

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

   DBPR" Done Filtering \n"


   GthreadExit(tid)
}
//====================================================

proc MixSignal()
{
      Ysig = Fgen(npts,0,dft)

//  DBPR" $Ysig[0:10] \n"

       Ysig = Sin(Ysig * cf * 2.0 * _PI) * 500

//  DBPR" $Ysig[0:10] \n"

        YS += Ysig

//  DBPR" $YS[0:10] \n"
//DBPR" %6.4f %v $YS[0:10] \n"
//DBPR" $(typeof(YS)) $(Cab(YS)) \n"

       cf += cf_inc
       if ((cf > 4000) || (cf < 100)) {
          cf_inc *= -1
       }
}
//====================================================


// use FineTime to pick where to display
// circular buffer

int ncb = 128 // was 96 each as a vertical pixel in SG window

uchar pixstrip[4][ncb]


int sgx = 50


float SpeechThres = 1.0 // adaptive?


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
     hrti = 1.0/Freq * (2 * Wlen)
//  DBPR" $hrti \n"
  
    }
   
  CMF update()
   {

   int st = 0;

   dt=FineTimeSince(T)

   dsecs = dt /1000000.0

   syncsecs = last_t + hrti
   lags = syncsecs - dsecs   
<
   catchup = (dsecs - syncsecs)

   if (dsecs < syncsecs) {
//DBPR" ahead by $lags \n"

     sWo(CU_wo,"color","green","penhue","yellow",@redraw);
//<<"%V$lags $(typeof(lags))\n"     

     sleep(lags * 0.8);
//<<"In update sleep $lags \n"


     dsecs = syncsecs;
   }

     if ( catchup < 5.5) {
          dsecs = syncsecs
//DBPR"%V $catchup \n" 
     }
     else {
       skipsig += catchup
       sWo(CU_wo,"color","red",@redraw)
//DBPR" skip ahead $skipsig \n"
     }

   hl = dsecs - last_t

   last_t = dsecs

//<<"%V$st $(typeof(st)) $nsecs $last_t $Freq\n"

   st = (round((last_t - 0.5) * Freq)) % (nsecs * Freq));
   
//<<"%V$st $(typeof(st)) $nsecs $last_t $Freq\n"

   return st

   }

  CMF Print()
   {
    DBPR"%V $rsecs $dsecs $lags $catchup $skipsig\n"
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
int ScrollY = 130





proc DisplayBuff()
{

// display thread


  tid = GthreadGetId()


  int slen = 4096 * 1;
  
  int sinc = 1000
  int st = 0;
  int end = slen

  uint dt
  int jpx = 100
  uint dp_loop =0

  while (1) {

    st = Tim->update()
    
    //st = 0
    
//DBPR" %v $st \n"
// this is real time - offset
// want to find out if we are keeping up

    fflush(1)

// need get correct blocks from ring buffer

   st -= slen
//<<"%V$st $(typeof(st)) \n"
   if (st < 0) {
       st = 0
   }

   end = st + slen

   sWo(tt_wo,"value","%6.2f$Tim->dsecs",@redraw)

// lets use RbKey - last Recorded buffer
// check has this time window been processed ??

//DBPR" %V $st $end \n"

    npts = end -st +1

DBPR"%V$npts $dft \n"

    taend = st + (2*slen)

DBPR"%V$st $end $Gain \n"

    YS = Dfbuf[st:end] * Gain  

//  rmsv = log10(RMS(YS))

    rmsv = RMS(YS)
    dbv[0] = 0.0
    
DBPR" %V$rmsv \n"

    if (rmsv > 0.0) {
      dbv[0] = 10*log10(rmsv) -20
    }

    if (dbv[0] < 0.0) {
        dbv[0] = 0.0
    }

//  DBPR" $YS[0:10] \n"

    RmsTrk->ShiftL(dbv[0])

//DBPR" $(Caz(RmsTrk)) \n"

    zxv[0] = ZC(YS,Zxthres)

    ZxTrk->ShiftL(zxv[0])

    mv = Mean(RmsTrk)*20.0
    sz = Caz(RmsTrk)

   if ((dp_loop % 4 ) == 0) {
    if (mv > 0.11) {
   sWo(fewo,@ClearPixMap)
     drawGline(rmsgl)
   sWo(fewo,@showPixMap)     
    }
//<<"$dp_loop %V   $sz  $mv $fewo\n"
//<<" $RmsTrk[0:10] \n"
    }

// DBPR" %V     $sz  $mv \n"
// DBPR" $RmsTrk \n"




//  mix in signal

    if (mix_signal) {
       MixSignal()
    }


   fftend = FFTSZ-1
//DBPR"%V $Wlen $iend $fftend \n"
//   real = YS[0:fftend] * swin

   real = YS[0:fftend]

////////////// RMS ////////////////////

   zxv[0] = ZC(real,Zxthres)
   ti = 0
   tas = 0.004
   tac = 20
// need to add for  negative
    mm = MinMax(real * tas)

    taxyvec[0,4,8,12] = Igen(4,ScrollX,1)
    taxyvec[2,6,10,14] = Igen(4,ScrollX,1)
    taxyvec[1,3] = mm + tac


//DBPR"%v $taxyvec[*] \n"
    rv = Rms(real)
    dbv[0] = 0
    if (rv > 0) {
    dbv[0] = 10*log10(rv) -20
    }

///////////////////////////////////////

   real *= swin

    if ((Tim->dsecs - last_secs)  > 0.25) {

<<" %6.4f$Tim->dsecs $lags $Tim->skipsig $hl $rmsv $dbv[0] Db $mv %d   $RbKey[*] >>\r"

    last_secs = Tim->dsecs ;
    }
   end = st + Wlen

//DBPR" imag sz $(Cab(imag)) \n"


   ist  = Wlen/2 
   iend = ist + Wlen -1

///////// ZC ///////////////////////////

    imag = YS[ist:iend] 
    zxv[1] = ZC(imag,Zxthres)

      iv = Rms(imag);
       dbv[1] = 0;
      
      if (iv > 0) {
       dbv[1] = 10*log10(iv) -20;
      }

    mm = MinMax(imag  * tas)
    taxyvec[5,7] = mm + tac

////////////////////////////////////////

    imag *=  swin

// DBPR"INSM %6.2f$real \n"
// DBPR"IN %6.3f$imag \n"

   specsz = FFTSZ/2
  
   spec(real,imag,FFTSZ,1)
  
  // FIX powspec= real[0:(specsz-1)]

   endspec = specsz -2

   powspec= real[1:endspec] 

//<<"$powspec \n"

//ttyin()


 //mv += 0.11;
//<<"%V$mv \n"

 mv += 0.001

 if ((mv >= SpeechThres) || ((dp_loop % 10) == 0)) {

   if (see_ta_wave) {
      sWo(tagwo,@ClearPixMap)
         DrawY(tagwo,YS,0,0.5)
      sWo(tagwo,@ShowPixMap)
   }


   if (see_spec_slice) {
     // if ((dp_loop % 2 ) == 0) {
         sWo(specwo,@ClearPixMap)
         DrawY(specwo,powspec,0)
         sWo(specwo,@ShowPixMap)
     // }
    }

  }

  ////////////  RECORD  ///////////////////////////////
  

   mvt = RecVox( mv, st) 

DBPR" %V$mvt   $see_sg \r"

//<<" %V$mvt $see_sg \r"


//<<"%V$sp_process $mvt $see_sg\n"

if (  mvt ) {

// make pixstrip [4][ncb]

   if (sp_process) {

     pixstrip[0][::] = Round(vRange(vZoom(powspec,ncb),20,100,0,tgl))

     powspec= imag[1:endspec] 

     pixstrip[1][::] = Round(vRange(vZoom(powspec,ncb),20,100,0,tgl))
  
   ki = iend
   ji = ki + FFTSZ-1
   wlm1 = Wlen-1

   real[0:Wlen-1] = YS[ki:ji] 

   zxv[2] = ZC(real,Zxthres)

   rv = Rms(real)
   dbv[2] = 0
   if (rv > 0) {
    dbv[2] = 10*log10(rv) -20
   }

   mm = MinMax(real  * tas)

   taxyvec[9,11] = mm + tac

   real *= swin

   ki = ki + Wlen/2
   ji = ki + FFTSZ-1


   imag[0:Wlen-1] = YS[ki:ji] 
   dbv[3] = 0
   iv = Rms(imag)
   if (iv > 0) {
   dbv[3] = 10*log10(iv) -20
   }
   zxv[3] = ZC(imag,Zxthres)

   mm = MinMax(imag  * tas)

   taxyvec[13,15] = mm + tac

   imag *= swin

   spec(real,imag,FFTSZ,1)

   powspec= real[1:endspec];   // CHECK --- orig did not do this

   pixstrip[2][::] = round(v_range(v_zoom(powspec,ncb),20,100,0,tgl))

   powspec= imag[1:endspec] ;

   pixstrip[3][::] = round(v_range(v_zoom(powspec,ncb),20,100,0,tgl))


//   DBPR" $pixstrip \n"
// edge of clip --- specifies where to paint this update -- 700th pixel?

//  DBPR" %v $(Cab(pixstrip)) \n"

//FIXME  bad magic number ScrollX (was 697) -- work this out from clipsize
// needs to dCx - 4 ??

   }


   if (see_sg) {

//<<"see_sg $pixstrip \n"

//<<"$pixstrip \n"

       //plotPixRect(sgwo, Transpose(pixstrip), Gindex,ScrollX, ScrollY, 1)

plotPixRect(sgwo, pixstrip, Gindex,ScrollX, 0, 2,1)


     //sWo(sgwo,@scroll,4,0,@store)

      sWo(sgwo,@scrollclip,1,4,@store)

   }

   if (see_ta_env) {
     //sWo(tawo,"hue","red","plotilines",taxyvec,"scroll",4,0,"store","pixmapon")
   }

// plotpoints

   dbvs = 2.0

   if (see_features ) {

   powxyvec[0,2,4,6] = Igen(4,ScrollX,1)

   powxyvec[1,3,5,7] = dbv * dbvs

//DBPR" $powxyvec[*] \n"

   //sWo(fewo,@hue,"red",@plotilines,powxyvec)

   //sWo(rms_wo,@move,0.1,dbv/20 )
   
//DBPR" %V $dbv1  \n"

   zxs = 50

   zxxyvec[0,2,4,6] = Igen(4,ScrollX,1)

   zxxyvec[1,3,5,7] = zxv * zxs

//DBPR" $(Caz(zxxyvec)) %V $zxxyvec \n"

   //sWo(fewo,"hue","blue",@plotilines,zxxyvec)
   
// ok write out vox file

   //sWo(fewo,@scrollclip,4,0,@store,"border")

   }

   Tim->Rec()

   SWo(rt_wo,"color","red","value",Tim->rsecs,@redraw)

   }

   dp_loop++
   
//   <<"%V$dp_loop \n"
   
 }

   GthreadExit(tid)

}
//=========================================


exit_see_wave = 0

msg = "xx"

proc CheckMsg()
{

// tid = GthreadGetId()

<<" $_proc $msg \n";


int mloop = 0;
// 
      if (do_fir ) {
         do_fir = 0
         RbKey[RBOP] = 0
        } 


       Mword=Split(msg)

<<"SplitMsg $Mword \n"


       mlen = slen(msg)
       msg_name = Mword[0]
       msg_val = Mword[1]

     
DBPR"%V $msg $mlen $Minfo $msg_name\n"

       if (scmp(msg_name,"t",1) || (msg_name @= "TA")) {

        if (see_ta_wave ) {
         see_ta_wave = 0
        }
        else { 
         see_ta_wave = 1
        }
          DBPR" toggle %v $see_ta_wave \n"
        }

       
       if ( Keyc == 's' ) {

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
          DBPR" toggle %v $do_fir $RbKey[RBOP]\n"
        
        }

       if ( Keyc == 'g' ) {
       
          <<" toggle %v $see_sg \n"

        if (see_sg ) {
         see_sg  = 0
        }
        else { 
         see_sg = 1
        }

         //see_sg =1   // always for now
          DBPR" toggle %v $see_sg \n"

      }

      if (scmp(msg_name,"SMW",3)) {
          Swindow(swin,Wlen,msg_val)
          DBPR"Smoothing window type:  $msg_val  \n"
      }


       if (scmp(msg_name,"q",1)) {
         exit_see_wave = 1
         break
       }

     if (scmp(msg_name,"QUIT",4)) {
         exit_see_wave = 1
	 <<"trying to QUIT!\n"
         break
       }

        if (Woid == qwo) {
         exit_see_wave = 1
	 <<"qwo trying to QUIT!\n"
         break
        }

         SetGwindow(tassw,"activate")
         SetGwindow(sgw,"activate")

       // CRASH SetGwindow({tassw,sgw},"activate")

  // GthreadExit(tid)
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



float Hrti
Hrti = 1.0/Freq * (2 * Wlen)

  float dft = 1.0/Freq

DBPR" %V $Wlen $Hrti $dft \n"
//ttyin()


// 

swin = Fgen(Wlen,0.5,0)
DBPR"%6.2f$swin \n"

DBPR" $(Cab(swin)) \n"

  Swindow(swin,Wlen,"Hamming")
  Swindow(swin,Wlen,"Kaiser")
DBPR"%6.2f$swin \n"
DBPR" $(Cab(swin)) \n"



 Sf = Freq

 dt = 1/Sf



////////////////////////////////////////// GREY SCALE ////////////////////////////////////////////////
 int tgl;
 ng = 128
 Gindex = 150  //  150 is just above our resident HTLM color map
 tgl = Gindex + ng
 SetGSmap(ng,Gindex)  // grey scale  





 // Screen Setup - One time only

////////////////////////////////  WINDOW SETUP /////////////////////////////////////////////////////
 Prop("Windows")

 include "saysee_ws.asl"



////////////////////////////////// GLINES for FEATURE TRACKS ///////////////////////////////////////

// RMS
rmsgl = CreateGline(fewo,@TY,RmsTrk,@color,RED_,@name,"RMS")

sGl(rmsgl,@scales,0,0,200,30,@ltype,1, @symbol,"diamond",@savescales,0,@usescales,0)

zxgl = CreateGline(fewo,@TY,ZxTrk,@color,BLUE_,"name","ZX")
setgline(zxgl,@scales,0,0,200,0.5,@ltype,1, @symbol,"diamond","savescales",0,"usescales",0)
//

<<"%V$rmsgl $fewo $zxgl\n"
//iread()

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
    dspfd = dspopen("/dev/dsp") // correct for mercury
    if (dspfd == -1) {
     dspfd = dspopen("/dev/dsp1") // correct for mars
    }
   
// look for sound devices
// get open  mixer

   mixfd = mixeropen("/dev/mixer")
   if (mixfd == -1) {
    mixfd = mixeropen("/dev/mixer1")
   }

   if (dspfd == -1) {
    <<"Error opening /dev/dsp?\n"
    <<" may need to load sound modules -- sudo modprobe snd-pcm-oss \n"
    <<" check with ls /dev/dsp*  and retry if /dev/dsp* is listed\n"
   }
   if (mixfd == -1) {
    <<"Error opening /dev/mixer?\n"
   }

   pcmfd = -1

   pcmfd = ofw("rb.vox")

   voxfd =ofw("session.vox")

   DBPR"%V $dspfd $mixfd \n"

   T=FineTime()

   recid = gthreadcreate("RecBuff")
<<"%V$recid \n"


   filtid = gthreadcreate("FiltBuff")  // has to operate even to just copy


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

      //Prop("MESSAGE THREAD")

      //msgid = gthreadcreate("CheckMsg")

   }

   Prop("MAIN THREAD WAITS")

   nt = gthreadHowMany()

  DBPR" WAITING for $(nt-1) other threads to finish \n"
//   DisplayBuff()

// main
// user control
    
      // CRASH ?
     // SetGwindow({tassw,sgw},"activate")


  RbKey[RBOP] = 0

E =1; // event handle
int w_wo = 0
int Button = 0
int Keyc = 0
int Woid;
etype = "";

 while (1)
 {
     // see_spec_splice = ! see_spec_splice
    //DBPR" %v $see_spec_splice \n"

    msg =  E->readMsg()  // are keyboard clicks quequed up ??
    Keyc = E->getEventKey()
    Button = E->getEventButton()
    evid = E->getEventID()
    etype = E->getEventType()

//<<"%V$msg \n"

    sleep(0.1)

    if ( etype @= "PRESS" ) {
            Woid = E->getEventWoId()
     }


    if ( !scmp(msg,"NO_MSG",6) ) {
 <<"Got    $msg \n"

       CheckMsg()

    }

   if (msg @= "q") {
  
      gthreadSetFlag(recid,1)

      gthreadExit(displayid)
      gthreadExit(msgid)

      Gthreadwait()
      break
   }

// yield _thread ??

   sleep(0.1);

   if (exit_see_wave) {
        break
   }

 }


exitgs()

 STOP!






#{
////////////////////////////////   TBD ////////////////////////// 
//

// dsp device locks up --- busy --- how do we grab it -- release it?

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

///////////////////////////////  FIX /////////////////////////
 numerical result out of range --- ignore this error



////////////////////////////////////////////////////////////////////////////////////
#}




