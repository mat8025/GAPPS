
// test spectral processing of vox file

setdebug(0,"~trace") // should be 0 level

// has to use xgs

 Graphic = CheckGwm()
   
  if (!Graphic) {
     X=spawngwm()
  }


include "seespec_audio.asl"   ;  ///    audio mic/spkr  setup

include "seespec_compute.asl" ;  ///  spectrum compute and SG display

include "seespec_io.asl"      ;  ///  read and write audio files

//////////////////////////////////////////////////////////////////////

int sb = 0
int sbn = -1

fname = _clarg[1]

 //sb = atoi(_clarg[2])

<<"%V$fname $sb\n"

sbn = createSignalBuffer() ; // create an audio buffer

<<"%V$sbn \n"

float Freq = 16000.0;
int SampFreq = Freq;

float SYS[];

short YS[];

//short SB[]; //signal buffer -- do we need local copy instead of using sbn?

int ds;
int npts;
float y0;
float y1;
float mm[];
float vox_tX; 
int nbp = 0;
int frames = 0;

int bufend;
int nf;
int nxpts;

 Sf = Freq
 dt = 1.0/Sf

 FFTSZ = 256
 fftend = FFTSZ -1

 wlen = FFTSZ

 hwlen = wlen/2
 qwlen = wlen/4
 owlen = wlen/8

 int wshift = hwlen

 swin = Fgen(wlen,0.5,0)

 Swindow(swin,wlen,"Hamming")

 int st = 0
 end = st + wlen - 1

float real[wlen]
float imag[wlen]

float RmsTrk[]
float ZxTrk[]
int Zxthres = 10

int xp = 0;
float tx = 0.0
float txa = 0.0;
float txb = 0.0;
float tx_shift;


RmsTrk = 1.0
ZxTrk = 1.0


 //  displayComment("processing $fname \n")

   ds = voxFileRead( fname)
   
   setUpNewVoxParams()

/////////////////////////////////////////


include "seespec_ws.asl"  ; ////  WINDOW - GRAPH SETUP ///

include "seespec_selshow.asl" ;  ///  select and show 

include "seespec_wko.asl" ; //// Wo and Key callbacks ////

////////////////////////////////////////////////////////////////////////////

// file read 

// work through buffer and produce spec-slice , rms and zx tracks
// cepstral track
// can we do a spec class ?



<<" $(Caz(RmsTrk)) \n"


// real input --- simple version
// real - swin of buffer
// imag is zeroed
// real buffer on output of spec contains the power spectrum
// overlap smoothing by half shift 

///////////////////////////////////////////////////////////////////////////////////////////////////////

  getNpixs()

  displayComment("processing $fname ")
  


//  tx_shift = samp2time(wshift/2)
//  tx_shift = samp2time(wshift)

   tx_shift = 0.0125;
   <<"%V$nxpts\n"

   if (nxpts < npts) {
     SYS = YS[0:nxpts];  // Need about 3 secs worth
   }
   else {
     SYS = YS ; // Need about 3 secs worth
     bufend = npts - FFTSZ
   }

//iread()

    tasX = nxpts/ Sf 

    sWo(taswo,@scales,0,mm[0],tasX,mm[1])

    drawSignal(voxwo, sbn, 0, npts)
 
    drawSignal(taswo, sbn, 0, nxpts)

    // I think drawSignal should update the xscales --- according to the number of signal points it plots

   show_tas = 1
   show_spec = 1
  
   old_end = 0

// compute sg in one shot

   st = 0

   T = FineTime()

  xp = 0
  st = 0
  frames = 0

   RP = wogetrscales(voxwo)

   float rx = RP[1]
   float ry = RP[2]
   float rX = RP[3]
   float rY = RP[4]

  // axnum(voxwo,1,rx,rX,1.0,-1,"g")

   axnum(voxwo,-1)


   //<<"%V%6.2f$RP\n"
   <<"%V$tx $y0 $y1\n"

   displayComment("%6.2f$RP \n")

   //openAudio()

   //computeSpecandPlot(0)

   sleep(1)

//  sWo({taswo,sgwo,voxwo},@save)

   tx = RP[3]/2

//selSection (tx)
//showSlice (tx)
//showSelectRegion()
//tx_shift = samp2time(wshift)
//<<"%V$wshift $tx_shift \n"


/////////////////  MAIN INTERACTIVE LOOP///////////


Svar msg
Svar msgw

int Minfo[]
float Rinfo[]

wScreen = 0

int do_loop = 1
int w_wo = 0
int button = 0
int keyc = 0
float btn_rx = 0
float btn_ry = 0


E =1; // event handle


   sGl(co2_gl,@cursor,0,y0,0,y1)
   sGl(co3_gl,@cursor,10,y0,10,y1)  

//   sWo({taswo,sgwo,voxwo},@showpixmap)
int kloop = 0
int last_evid = -1;

   while (do_loop) {

    kloop++;
    
    button = 0

    msg = E->waitForMsg()
    keyc = E->getEventKey()
    button = E->getEventButton()
    evid = E->getEventID()

// <<"%V$msg \n"

     msgw = split(msg)

//    <<"%V$msg $msgw[0] $msgw[1] $Minfo\n"
//     <<"%V6.2f$Rinfo \n"

        //m_wo = Minfo[3]
      
        E->geteventrxy(btn_rx,btn_ry)
	
        etype = E->getEventType()
	
<<"%V$kloop $etype $button $evid\n"

       if ( etype @= "PRESS" ) {
         //  if (evid != last_evid) {
            Woid = E->getEventWoId()
            do_wo_options(Woid)
	//    }
        }
       
        if ( etype @= "KEYPRESS" ) {
           do_key_options(keyc)
        }


       if ( scmp(msg,"SWITCHSCREEN",12)) {
                  wScreen = atoi(msgw[1])
       }
	     
       last_evid = evid;

//     sWo({taswo,sgwo,voxwo},@showpixmap)
//  sleep(0.1)

   }

// close up

closeAudio()

exitgs(1)


/////////////////////////////////////////////////////////////////////////


/{

 record into buffer -kinda
 write selected region to file
 rms track
 zx  track
 cep pitch track
 format extraction
 phoneme label from database
 wo cursors
  
 A B comparisons with another vox


 a -c option to concatenate files ?

 2BFIXED
 
     ta draw clears clipborder
     cursor lines - need to be re-inited after a redraw
     crash on FPE errors?

/}