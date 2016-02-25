// test spectral processing of vox file
// Nov 2009

 setdebug(0)



Gain = 1.0
int mixfd = -1
int dspfd = -1

float MaxTa = 33000

<<"%V$MaxTa \n"

float real[]
float imag[]

float SYS[]
float YS[]

int ds = 32000
int Zxthres = 10

float RmsTrk[]
float ZxTrk[]
RmsTrk = 1.0
ZxTrk = 1.0

 float Freq = 16000.0
 Sf = Freq
 dt = 1.0/Sf

 FFTSZ = 256
 fftend = FFTSZ -1

 wlen = FFTSZ

 hwlen = wlen/2
 qwlen = wlen/4
 owlen = wlen/8


 fname = _clarg[1]


   real[255] = 1
   imag[255] = 0

//<<"$real \n"
//<<"$imag \n"

//   spec(real, imag, FFTSZ,0)




////////////// READ FILE INTO BUFFER   ///////////////////////////

  int sbn = -1

// create an audio buffer
  sbn = createSignalBuffer()

<<"%V$fname $sbn \n"

  ds = readsignal(sbn,fname)

<<"%V $sbn $ds \n"

  npts = ds

  // find range of signal
  // just copy buffer back out so we can process it
  // we will add builtin processing later

 B = getSignalFromBuffer(sbn,0,ds)

 mm= minmax(B)

<<"%(16,, ,\n)$B[0:32] \n"
<<"%V$mm \n"

  YS= B 

  mm= minmax(YS)

<<"%(10,, ,\n)$B[0:99]\n"
<<"$mm \n"


  y0 = mm[0]
  y1 = mm[1]



Graphic = CheckGwm()
// overide with command line
 if (! Graphic) {
   SpawnGWM()
  }


// file read 

// work through buffer and produce spec-slice , rms and zx tracks
// cepstral track
   int nbp = 0
   int frames = 0

// can we do a spec class ?




 int wshift = hwlen

 swin = Fgen(wlen,0.5,0)

 Swindow(swin,wlen,"Hamming")

 int st = 0
 end = st + wlen - 1


//////////////////////////////////////////////////

include "audio.asl"

// just clear comment line
proc displayComment ( cmsg) 
{
    <<" $csmg "
    setgwob(commwo,@clipborder,@textr,"                                                               ",0.1,0.5)
    //setgwob(commwo,@clear,@clipborder,@textr,cmsg,0.1,0.5)
     setgwob(commwo,@clipborder,@textr,cmsg,0.1,0.5)
}

// just clear event line
proc displayEvent ( cmsg) 
{
    <<" $csmg "
    setgwob(commwo,@clear,@clipborder,@textr,cmsg,0.1,0.1)
}

proc samp2time( ns)
{
  float t 
  t =ns/ Sf
<<"%V$t \n"
 // float t = ns/ Sf
  return t

}

include "sgplot.asl"



proc getVoxTime()
{


}

include "sg_options.asl"




///////////////////////////////////////////////////////
/{
    A=ofr(fname)

<<"$A\n"
//<<" $skp_head \n"

    hdr_size = getHdrSize(A)

<<"%V $hdr_size \n"

    if (hdr_size > 0) {
// does it have vox header - if so skip past it 
<<" skipping hdr $hdr_size \n"
      fseek(A,hdr_size,0)
    }

<<"%V$dsz $npts $hdr_size\n"

    B=rdata(A,SHORT)

    int dsz = Caz(B)
  


<<"%(10,, ,\n)$B[0:99] \n"

<<"B $mm \n"
/}


<<" $(Caz(RmsTrk)) \n"


// real input --- simple version
// real - swin of buffer
// imag is zeroed
// real buffer on output of spec contains the power spectrum
// overlap smoothing by half shift 


////////////////////////////////////////// GREY SCALE ////////////////////////////////////////////////
 ng = 128
 Gindex = 150  //  150 is just above our resident HTLM color map
 tgl = Gindex + ng

 SetGSmap(ng,Gindex)  // grey scale  



include "sgwindows.asl"

  gflush()
  gsync()
  sleep(1)
// wait till XGS responds ??

///////////////////////////////////////////////////////////////////////////////////////////////////////

  int bufend
  int nf
  int nxpts

  getNpixs()

  int xp = 0

  float tx = 0.0
  float txa = 0.0;
  float txb = 0.0;

  float tx_shift;

//  tx_shift = samp2time(wshift/2)
//  tx_shift = samp2time(wshift)


   tx_shift = 0.0125

   if (nxpts < npts) {
     SYS = YS[0:nxpts]  // want about 3 secs worth
   }
   else {
     SYS = YS  // want about 3 secs worth
     bufend = npts - FFTSZ
   }

    tasX = nxpts/ Sf 

    sWo(taswo,@scales,0,mm[0],tasX,mm[1])

    drawSignal(voxwo, sbn, 0, npts)
 
    drawSignal(taswo, sbn, 0, nxpts)

    // I think drawSignal should update the xscales --- according to the number of signal points it plots


//  DrawY(voxwo,YS,1,0.75)
//  DrawY(taswo,SYS,1,0.75)

  show_tas = 1
  show_spec = 0

   old_end = 0

// compute sg in one shot

   st = 0

   T = FineTime()

  xp = 0
  st = 0
  frames = 0

   RP = wogetrscales(voxwo)

<<"rscales %V$RP \n"

   float rx = RP[1]
   float ry = RP[2]
   float rX = RP[3]
   float rY = RP[4]

  // axnum(voxwo,1,rx,rX,1.0,-1,"g")

     axnum(voxwo,-1)


   //<<"%V%6.2f$RP\n"
   <<"%V$tx $y0 $y1\n"

   displayComment("%6.2f$RP \n")

   openAudio()

  // computeSpecandPlot(0)

   sleep(1)

//  sWo({taswo,sgwo,voxwo},@save)

// mid 
   

   tx = RP[3]/2

   selSection (tx)


   real[255] = 1
   imag[255] = 0

//<<"$real \n"
//<<"$imag \n"


   spec(real, imag, FFTSZ, 0)

   

//   showSlice (tx) // 
//   showSelectRegion()




//   tx_shift = samp2time(wshift)
//<<"%V$wshift $tx_shift \n"

include "sgevent.asl"

///////////////////////////////////  MAIN INTERACTIVE LOOP


wScreen = 0


int do_loop = 1
int w_wo = 0

//   sWo({taswo,sgwo,voxwo},@showpixmap)


int k_loop = 1
   while (do_loop) {

<<"waiting for message $k_loop\n"

 k_loop++;
 
        msg = E->waitForMsg()

        checkEvents()

<<" $k_loop  got $keyw\n"
        if ( keyw @= "GM_EVENT" ) {
            do_wo_options(Woid)
            showSlice (tx) 
           tx += 0.02
        }
        else if (keyw @= "GM_WOPRESS"  ) {
            do_wo_options(Woid)
        }
        else if (keyw @= "GM_KEYB") {
           do_key_options(keyc)
        }

           showSlice (tx) 
           tx += 0.02
	   
           computeSpecandPlot(tx)

//        if ( scmp(msg,"SWITCHSCREEN",12)) {
//                  wScreen = atoi(msgw[1])
//        }


//     sWo({taswo,sgwo,voxwo},@showpixmap) // {} array not working



     if (tx > 2.0) {
      //showSelectRegion()
     }
     
     sWo(taswo,@showpixmap)
     sWo(sgwo,@showpixmap)

     sleep(0.1)


   }


// close up

closeAudio()
exitgs(1)


/{
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///             TBD
 rms track
 zx  track
 cep pitch track
 format extraction
 phoneme label from database
 wo cursors
  
 A B comparisons with another vox






 FIX
     ta draw clears clipborder
     cursor lines - need to be re-inited after a redraw




/}