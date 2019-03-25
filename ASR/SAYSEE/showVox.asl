//  read a pcm, wav or vox file
//  swap these to switch  debug prints

  setdebug(0)

//#define DBPR  <<
#define DBPR  ~! 

Gain = 1.0
int mixfd = -1
int dspfd = -1

proc openAudio()
{
///////////////////////////  DSP AUDIO device SETUP ////////////////////////////// 

// get open dsp

   dspfd = dspopen("/dev/dsp1")

<<"%V$dspfd \n"

// get open  mixer

   mixfd = mixeropen()

<<"%V$mixfd \n"

// set dsp,mixer

<<"%V$dspfd $mixfd \n"

   ok = setSoundParams(dspfd,mixfd) 

   Gain = 1.0
}

proc closeAudio()
{
 if (dspfd != -1)
   close(dspfd)
 if (mixfd != -1)
   close(mixfd)
}



///////// Program Functions ////////////
proc computeSpec(stpi)
{
   spe = stpi + wlen -1

   real = YS[stpi:spe]
   imag[wlen] = 0
   imag = 0;

   real *= swin
 
   spec(real, imag, Fftsz, 0)

   sWo(spwo,@clearpixmap,@clear,@save)
   nyqpt = wlen/2 -1
   sreal = real[0:nyqpt]
}

proc do_wo_options(w_wo)
{

<<"OPTIONS $_proc  $w_wo \n"
        if ((w_wo == tagwo) || (w_wo == sgwo)) {
	    E->getEventRxy(trx,try)
<<"sslice @ $trx\n"
            showSlice (trx)
    
      }




}
//-----------------------------------
proc showSlice ( tx )
{

    //spi = Round(tx * Sfreq)
    spi = Round(tx ) // scale is in number of points
                     // probably should change to time
		     
<<" spec slice @ $tx $spi\n"
    computeSpec(spi)
    lcx = spi * 1.0
    rcx = spi + wlen
    sGl(lc_gl,@cursor, lcx,-Vamp, lcx, Vamp)
    sGl(rc_gl,@cursor, rcx,-Vamp, rcx, Vamp)    

    sWo(spwo,@clearpixmap,@clear,@save)
    sWo(spwo,@showPixMap,@save)
    sGl(specgl,@draw)


<<" spec cursor @ $spi\n"
    sWo(tagwo,@ShowPixMap,@save)
}

//////////////////////////////////////

 Sfreq = 16000.0

 Fftsz = 256
 

 int sb = 512

 fname = _clarg[1]

  if (fname @= "") {
  <<" need a speech file as input e.g a.vox a.wav a.pcm\n"
  <<" asl $_clarg[0] demo1.vox \n"
  exit()
  }


  DBPR"%V$fname $sb\n"

// create an audio buffer
  int sbn = -1

  sbn = createSignalBuffer()

  DBPR"%V$fname $sbn \n"

//  sbn1= createSignalBuffer()
//<<"%V$fname $sbn1 \n"


  ds = readsignal(sbn,fname)
  // find range of signal
  // just copy buffer back out so we can process it
  // we will add builtin processing later

  DBPR"%V$ds\n"

  VB = getSignalFromBuffer(sbn,0,ds)

  mm= minmax(VB)

<<"%V$mm \n"


<<"%(16,, ,\n)$VB[0:32] \n"
<<"%V$mm \n"



/////////////////////////////////////
  A=ofr(fname)

DBPR"$A\n"
//DBPR" $skp_head \n"

    hdr_size = getHdrSize(A)

DBPR"%V $hdr_size \n"

    if (hdr_size > 0) {
// does it have vox header - if so skip past it 
      DBPR" skipping hdr $hdr_size \n"
      fseek(A,hdr_size,0)
    }
    else {

     if (sb > 0) {
DBPR"no header seeking $sb \n"
      //fseek(A,sb,0)
      fseek(A,sb,0)
     }
   }

DBPR"%V$dsz $npts $hdr_size\n"

    B=rdata(A,SHORT)

    ba = Cab(B)
    
    <<"%V$ba \n"
    

    asz = Caz(B)

    <<"%V$asz \n"

    int dsz = Csz(B)

  <<"%V$dsz \n"

    mm= minmax(B)

//DBPR"%(10,, ,\n)$B[0:99] \n"
//DBPR"B $mm \n"


   npts = dsz/512 * 512

DBPR"%V$dsz $npts \n"

float YS[]
float Frv[]

  Df = 16000.0/Fftsz

  Frv = fgen(Fftsz/2,0,Df)
  //Frv = fgen(128,0,Df)

//<<"%V$Frv\n"


      YS= B 

  mm= minmax(YS)

//DBPR"%(10,, ,\n)$B[0:99]\n"

DBPR"$mm \n"

///////////////////////////////////////////////////

  Graphic = CheckGwm()
   
  if (!Graphic) {
     X=spawngwm()
  }



int allwins[]
int nw = 0

Vamp = 28000.0 // this needs to extracted from signal


 DBPR" create TAW \n"

 taw = cWi(@title,"Signal",@scales,0,-Vamp,256,Vamp,@savescales,0)

 setgw("clear","redraw","save")
 allwins[nw++] = taw

 sWi(taw,@resize,0.1,0.02,0.95,0.95,0)
 sWi(taw,@drawon,@hue,"red",@clip,0.01,0.01,0.99,0.99)

 setgw(@clear,@redraw,@save)

 DBPR"%V$tw $nw $allwins \n"


        SR = YS[0:32000]
        mm = minmax(SR)

        nsr = Caz(SR)


//DBPR"%(10,, ,\n)6.0f$SR[0:99]\n"

DBPR"%V$nsr $mm \n"

  tagwo=cWo(taw,"GRAPH",@resize,0.02,0.55,0.6,0.90)
  sgwo=cWo(taw,"GRAPH",@resize,0.02,0.05,0.6,0.52)
  spwo=cWo(taw,"GRAPH",@resize,0.61,0.05,0.95,0.90)

  sWo(tagwo,@drawon,@pixmapon,@penhue,BLUE)
  sWo(tagwo,@clip,0.02,0.1,0.98,0.99)
  sWo(tagwo,@clear,"orange")
  sWo(tagwo,@clipborder,"black",@redraw)


  //sWo(spwo,@drawon,@pixmapon,@penhue,"blue")
  sWo(spwo,@drawoff,@pixmapon,@penhue,"blue")
  sWo(spwo,@clip,0.02,0.1,0.98,0.99)
  sWo(spwo,@clear,BLUE)
  sWo(spwo,@clipborder,"black",@redraw,@savepixmap)

  sWo(sgwo,@pixmapon,@drawon,@penhue,"blue")
  sWo(sgwo,@clip,0.02,0.1,0.98,0.99)
  sWo(sgwo,@clear,BLUE)
  sWo(sgwo,@clipborder,"black",@redraw,@savepixmap)

/////////////////////////////////////////////

/// Buttons for AUDIO ops

 bx = 0.2
 by = 0.1
 bX = 0.25
 bY = 0.14
 bwidth = 0.1
 bpad = 0.01


 qwo=createGWOB(taw,"BN",@name,"QUIT?",@VALUE,"QUIT",@color,"orange")
 setgwob(qwo,@help," click to quit")
 setgwob(qwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black")


 playsr_wo=createGWOB(taw,"BN",@name,"PLAY_SR",@VALUE,"ON",@color,"skyblue")
 setgwob(playsr_wo,@help," click to play selected region")
 setgwob(playsr_wo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black")


 playbc_wo=createGWOB(taw,"BN",@name,"PLAY_BC",@VALUE,"ON",@color,"magenta")
 setgwob(playbc_wo,@help," click to play between cursors")
 setgwob(playbc_wo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black")


 slicesr_wo=createGWOB(taw,"BN",@name,"SLICE_SR",@VALUE,"ON",@color,"green")
 setgwob(slicesr_wo,@help," click to show spec slice for region")
 setgwob(slicesr_wo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black")

 selectsr_wo=createGWOB(taw,"BN",@name,"SELECT_SR",@VALUE,"ON",@color,"teal")
 setgwob(selectsr_wo,@help," click to activate selected region")
 setgwob(selectsr_wo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black")

 res_wo=createGWOB(taw,"BS",@name,"RESOL",@VALUE,"ON",@color,"lime")
 setgwob(res_wo,@help," frame resolution ")
 setGWOB(res_wo,@STYLE,"SVR",@CSV,"low,med,high")
 setgwob(res_wo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black")


 int butawo[] = { playsr_wo, playbc_wo, slicesr_wo, selectsr_wo, res_wo, qwo }


 //int butawo[] = { playsr_wo, qwo }
<<"%V$butawo \n"

// do a htile
  //  wohtile(butawo, 0.2, 0.01, 0.9, 0.08, 0.1)
    wohtile(butawo, 0.2, 0.01, 0.9, 0.08)
    sWo(butawo,@redraw)

//////////////////////////////////




DBPR"%V$tagwo \n"

       SYS = YS[0:npts-1]

       sWo(tagwo,@scales,0,mm[0],npts,mm[1],@savescales,0)

       DBPR"%(10,, ,\n)6.0f$SYS[0:511]\n"

       sWo(tagwo,@ClearPixMap)

        n2 = npts/4

        SR = YS

        mm = minmax(SR)

        nsr = Caz(SR)
        
<<"%V$nsr\n"      

      sWo(tagwo,@scales,0,-Vamp,nsr,Vamp,@hue,"red")

      drawSignal(tagwo, sbn,256,npts)

      sWo(tagwo,@ShowPixMap,@save)

DBPR"%V$nsr $mm \n"
DBPR"%V$dsz $npts $hdr_size\n"



///// GREY SCALE /////////////////////////////////////////////
 ng = 128
 //ng = 64
 Gindex = 150  //  150 is just above our resident HTLM color map
//  Gindex = 32  //  150 is just above our resident HTLM color map
 tgl = Gindex + ng
 
  SetGSmap(ng,Gindex)  // grey scale  

 int ncb = 350  // this should be either related to sg window vertical pixel size
               // or a zoom draw should zoom ncb to vertical pixel size
	       

// how many Y pixels --- how many X pixels - so that zoom of image works

uchar pixstrip[2][ncb]

 xp = 0
/////////////////////////////////////////////////



/////////////////////////////////////////////////////////
// set up interactive loop to select sample for
// spectrum computation and display
//

// need a Gline for spectrum display


//  CURSORS


   lc_gl= cGl(tagwo,@type,"cursor",@color,RED,@ltype,"cursor")

   rc_gl= cGl(tagwo,@type,"cursor",@color,GREEN,@ltype,"cursor")


proc getNpixs()
{

   SGCL = wogetclip(sgwo)

   nxpixs = SGCL[3] -  SGCL[1]
   nypixs = SGCL[4] -  SGCL[2]

<<"%V$SGCL \n"
<<"%V$nxpixs \n"

//   CL = wogetclip(taswo)

//<<"%V$CL \n"

   return nxpixs
}
//-------------------------------------




// compute spectrum

float real[Fftsz]
float sreal[Fftsz/2]
float imag[]

   wlen = Fftsz

   int spi = 512

   spe = spi + wlen -1

   real = YS[spi:spe]

   imag[wlen-1] = 0
   imag = 0;

//<<"$real\n"
//<<"$imag\n"



 hwlen = wlen/2

 swin = Fgen(wlen,0.5,0)

//<<"%V$swin \n"

 Swindow(swin,wlen,"Hamming")
 // "Hanning", Kaiser, triangular

 spec(real, imag, Fftsz, 0)

 sWo(spwo,@scales,0,-10,8000,100,@savescales,0)  // N.B. save the scales for gline

  
  //specgl = cGl(spwo, @TXY, Frv, sreal,  @color, "red",@usescales,0)
  specgl = cGl(spwo, @TY, sreal,  @color, "red",@usescales,0)

   ssz = Csz(real)

<<"%V$ssz\n"

<<"compute mag \n"

//<<"$real\n"

   sWo(spwo,@penhue,"red",@name,"spectrum",@pixmapon,@drawon)
   sWo(spwo,@clearpixmap,@clear,@save)

//   sGl(specgl,@draw)
   sWo(spwo,@border)

   sWo(spwo,@ShowPixMap,@save,@savepixmap)

   //DrawY(spwo,real,0,1)

 //sWo(sgwo,@clear,RED,@clearclip,BLUE,@clearPixMap,GREEN,@save,@redraw)
 sWo(sgwo,@clear,WHITE,@clearclip,WHITE,@clearPixMap,GREEN,@save)
 setGwob(sgwo,@scales, 0,0, npts, 100)


// size of drawing area in pixels
  nsgpts = getNpixs()

 int winshift = 0
 
 winshift = npts / nsgpts

<<"%V$npts $nsgpts $winshift\n"

 while (spi < npts) {

   computeSpec(spi)

//   sGl(specgl,@draw)

//   sWo(spwo,@ShowPixMap,@save)

//   sWo(spwo,@penhue,"red","stuff")

   spix = ( spi * 1.0) /(wlen*2.0)


   if ((xp % 2) == 0) {
    pixstrip[0][::] = round(vRange(vZoom(sreal,ncb),-10,100,0,ng))
// plot(sgwo,@pixrect, pixstrip, Gindex, spix, 0,2,1)// DB
  //  <<"[0] $pixstrip[0][::] \n"
   }
   else {
     pixstrip[1][::] =  round(vRange(vZoom(sreal,ncb),-10,100,0,ng))
     plot(sgwo,@pixrect, pixstrip, Gindex, xp-1, 0,2,1)
   //  plot(sgwo,@pixrect, pixstrip, Gindex, spix, 0,2,1)
  //  <<"[1] $pixstrip[1][::] \n"
}


   sGl(rc_gl,@cursor, spi+100,-Vamp, spi+100, Vamp)
   //sGl(lc_gl,@cursor, spi+100,-Vamp, spi+100, Vamp)
   xp++

//<<"$spi $spix $xp\n"
 //  sleep(0.1)

  sWo(sgwo,@ShowPixMap,@save)

  spi += winshift
  
}
//---------------------------


   wkeep(taw)

E =1 // event handle

int do_loop = 1
int k_loop = 1
float trx;
float try;
char keyc;
keyw = ""
etype = ""

Woid = 0

 while (do_loop) {

    msg = E->waitForMsg()
    keyc = E->getEventKey()
    button = E->getEventButton()
   
<<"$k_loop  $msg $keyc $button\n"

    if (keyc == 'q' ) {
       <<"got quit char \n"
       break
    }
    
    keyw = E->getEventKeyW()

<<"$k_loop $keyw\n"

   etype = E->getEventType()

<<"$k_loop $keyw $etype\n"

    if ( etype @= "PRESS" ) {
            Woid = E->getEventWoId()
            do_wo_options(Woid)
    }


    k_loop++
 
   }
   






// TBD
//
// check full ta signal is shown
// show time of spectrum slice --- via label box
// show time of spectrum slice --- via cursor
//
// make interactive via event loop
// option for smoothing window type
// option for fftsize -- or freq resolution
// option for spec type mag,power, dB
// option for win_length, win-shift
// option to use asl Fft rather than C function
//
// add sgraph display - done
// add play