// test spectral processing of vox file

setdebug(1)


Gain = 1.0
int mixfd = -1
int dspfd = -1

proc openAudio()
{
///////////////////////////  DSP AUDIO device SETUP ////////////////////////////// 

// get open dsp

   dspfd = dspopen("/dev/dsp1")

// get open  mixer

   mixfd = mixeropen("/dev/mixer1")

// set dsp,mixer

//<<"%V$dspfd $mixfd \n"
   if (dspfd == -1) {
    <<"Error opening /dev/dsp1\n"
   }
   if (mixfd == -1) {
    <<"Error opening mixer\n"
   }
   
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

proc displayComment ( cmsg) 
{
    <<" $csmg "
    sWo(commwo,@clear,@clipborder,@textr,cmsg,0.1,0.5)

}

proc samp2time( ns)
{
  float t; 
  t =ns/ Sf
<<"%V$t \n"
 // float t = ns/ Sf
  return t

}

proc getNpixs()
{
   SGCL = wogetclip(sgwo)

   nxpixs = SGCL[3] -  SGCL[1]
   nypixs = SGCL[4] -  SGCL[2]

<<"%V$SGCL \n"

   CL = wogetclip(taswo)

<<"%V$CL \n"

    nf = npts/ wshift

    nxpts = nxpixs  *  wshift

<<"%V$nxpixs $nypixs $nf\n"
<<"%V $npts $nxpts \n"

    bufend = nxpts - FFTSZ

   return nxpixs
}
//-----------------------------


int smic_factor = 0x4a4a // ? alters mic gain via mixer device /dev/mixer1



proc do_record()
{

  openAudio()
 
  if (dspfd != -1) {

     setRecordParams(dspfd,mixfd, SampFreq,1, smic_factor)

     recordAudioBuffer(dspfd, sbn, 0, 15 * SampFreq )   // five seconds worth into beginning of buffer YS


  closeAudio()
  }

}
//--------------------------------------------------


proc computeSpecandPlot(rtb , rtf)
{

// YS is our float buffer containing the whole signal
// we want to compute spectrogram for the selected subregion
// nxpts is number of xpixels in spectrograph window 
// one spec per pixel

   int st = rtb * Freq
   int stend = rtf * Freq
<<"%V $rtb $rtf $st $stend \n"

   if ((st >=0)   && (stend < (25 *Freq))) { 

   dt = FineTimeSince(T,1)  // reset timer

   nxp = getNpixs()

  // bufend = st + nxpts - FFTSZ
   bufend = npts - FFTSZ
   
   xp = 0

   frames = 0
   spi = st
   
   int winshift = 0
 
   winshift = (stend- st) / nxp


   while (spi < stend) {

     end = st + wlen - 1

     real = YS[st:end]
     rsz = Caz(real)

//<<"%V$frames $st $rsz $real[0] $real[fftend]\n"

     if (show_tas) {
        sWo(tawo,@redraw,@clearclip)
        vdraw(tawo,real,0,1,0)
      }

    rtx = st / Freq

     sGl(cop_gl,@cursor,rtx,y0,rtx,y1)

    //sGl(co_gl,@cursor,end,y0,end,y1)

     zx = ZC(real,Zxthres)

     rmsv = RMS(real)

     real *= swin

     imag[FFTSZ-1] = 0;
     
     imag = 0.0

     isz = Caz(imag)

//<<"%V$st $isz $imag[0] $imag[fftend]\n"
//<<"%V$zx $rmsv \n"
     
    spec(real,imag,FFTSZ,0)

//<<"$real[0:20]\n"

    st += winshift

    if (show_spec) {
     sWo(spwo,@redraw,@clearclip,WHITE_)
     //vdraw(spwo,real[0:hwlen-1],0,1.0,0)
     Vdraw(spwo,real[0:hwlen-1],0,1.0,1,0,8000)
   }

   powspec = real[0:hwlen-1]

   if ((xp % 2) == 0) {
     pixstrip[0][::] = round(v_range(v_zoom(powspec,ncb),-10,100,0,ng))
   }
   else {
     pixstrip[1][::] = round(v_range(v_zoom(powspec,ncb),-10,100,0,ng))

     plotPixRect(sgwo, pixstrip, Gindex, xp,0, 2,1)
     //sWo(commwo,@clear,@textr," $tx $frames \n",0.1,0.5)
   }

    xp++

    if (st > bufend) {
        break
    }

    if (xp > nxp) {
       break
    }


    if ((frames % 16)  == 0) {

        // sleep(0.7)  // SHM full check  -- need to check
    }

    frames++
  }



  dt = FineTimeSince(T,1)

  dtsecs = dt / 1000000.0

<<"compute and plot time took $dtsecs  frames $frames \n"

  //sWo(commwo,@clear,@clipborder,@textr,"compute & plot time took $dtsecs  frames $frames \n",0.1,0.5)

   displayComment("compute & plot time took $dtsecs  frames $frames \n")
  }
  
}

//========================================


proc showSlice ( tx )
{
<<"In $_proc \n"
int sti;

//     int sti = (tx * Freq)

     sti = (tx * Freq)

     end = sti + wlen - 1

<<"%V$sti $end $(end-sti)\n"

     real = YS[sti:end]

<<" $real[0:24] \n"


    // sWo({tawo,spwo},@clearpixmap)

     sWo(tawo, @redraw, @clearclip, LIGHTGRAY_,@clearpixmap)
     sWo(spwo, @redraw, @clearclip, WHITE_,@clearpixmap)

// gline?
//<<"$real[0:wlen-1] \n"



     //vDraw(tawo,real[0:wlen-1],0,1.0,1,0,wlen-1)
     vDraw(tawo,real[0:wlen-1],0,1.0,0) // the real size may not be set here - use full spec 0:wlen-1
//     vDraw(tawo,real,0,1.0) // the real size may not be set here - use full spec 0:wlen-1

     sWo(tawo, @clipborder,BLACK)
   rsz = Caz(real)
<<"$rsz  \n"
     // swindow and compute powspec

     real *= swin

     imag[wlen] = 0
         
     imag = 0.0
     
     spec(real,imag,FFTSZ,0)

     powspec = real[0:hwlen-1]

     Vdraw(spwo,real[0:hwlen-1],0,1.0,1,0,8000)
     sWo(spwo, @clipborder,BLACK)
     RP = wogetrscales(taswo)   // via PIPE msg 

   //<<"%V$RP \n"

     rx = RP[1]
     ry = RP[2]
     rX = RP[3]
     rY = RP[4]

    //sWo({tawo,spwo},@showpixmap,@clipborder) // ? anonymous array causes crash?
    //sWo(tawo,@showpixmap,@clipborder)
    //sWo(spwo,@showpixmap,@clipborder)

    displayComment("time $tx sample $sti %V6.2f$rx $rX  $tx\n")

//    sGl(co2_gl,@cursor,tx,y0,tx,y1)
//    sGl(co_gl,@cursor,tx,y0,tx,y1)
<<"Done $_proc \n"
}//------------------------------------------


proc playBuff(wb, st, fi)
{
<<"In $_proc \n"
<<"play $dspfd $wb $st $fi \n"
openAudio()
  playBuffer(dspfd, wb, st, fi)
closeAudio()
<<"Done $_proc \n"
}
//---------------------------------------------
proc writeVox()
{
int start_n;
int stop_n;

     GV = glineGetValues(co2_gl)
     GV1 = glineGetValues(co3_gl)

     ps_tx1 = GV[0]
     ps_tx2 = GV1[0]

     start_n = ps_tx1 * Freq
     stop_n = ps_tx2 * Freq  

  nsw =   writeSignal(sbn,"out.vox",start_n, stop_n);

  <<"wrote $nsw samples to out.vox\n"

}
//---------------------------------------------

proc selSection( tx)
{
//int s1;
// display a section of the VOX buffer

<<"In $_proc $tx \n"

    int s1 = tx * Freq

    //s1 = tx * Freq

<<"$s1 \n"
// bracket around

    s1 -= nxpts/2

    int s2 = s1 + nxpts

    float tx1 = s1/ Freq

<<"$tx1 \n"

    sGl(co_gl,@cursor,tx1,y0,tx1,y1)

// FIX   sGl(co1_gl,@cursor,tx+3,y0,tx+3,y1)  // arg not parsed

    float tx2 = s2/ Freq


<<"$tx2 \n"

    sGl(co1_gl,@cursor,tx2,y0,tx2,y1)  // arg not parsed

    //sWo(taswo,@clearpixmap,@clipborder,@clearclip,BLUE_)

   // sWo(taswo,@clearpixmap,@clipborder,@clearclip,BLUE_)

 //   drawSignal(tawo, sbn, s1, s2)

    displayComment("select  $tx1 $tx2  --- $s1 $s2 \n")

   // sWo(tawo,@scales, tx1,-26000, tx2, 26000)  // via SHM

//    sGl(co2_gl,@cursor,0)  // show if it is already active  

//    sGl(co3_gl,@cursor)  // show if it is already active  


    //axnum(taswo, 1, tx1,tx2,0.25,-1,"g")
      axnum(tawo, -1)
    //sWo(taswo,@showpixmap)
    
    sGl(co2_gl,@cursor)  // show if it is already active  
    sGl(co3_gl,@cursor)  // show if it is already active  

<<"Out $_proc \n"

}


proc playSection( )
{
<<"In $_proc  \n"
//int s1;
//int s2;
// play a section of the buffer
// play time between cursors in voxwo

     GV = glineGetValues(co_gl)
     GV1 = glineGetValues(co1_gl)

     ps_tx1 = GV[0]
     ps_tx2 = GV1[0]
     
     int s1 = ps_tx1 * Freq
     int s2 = ps_tx2 * Freq

// s1 = ps_tx1 * Freq
// s2 = ps_tx2 * Freq  

     displayComment("play $ps_tx1 $ps_tx2 $s1 $s2 \n")

     playBuff(sbn, s1, s2)

//   sGl(co1_gl,@cursor,tx1,y0,tx1,y1)
// FIX   sGl(co1_gl,@cursor,tx+3,y0,tx+3,y1)  // arg not parsed
<<"Done $_proc \n"
}

proc playBCtas( )
{
<<"In $_proc  \n"
// play a section of the buffer
// play time between cursors in tas 
//int s1;
//int s2;

     GV = glineGetValues(co2_gl)
     GV1 = glineGetValues(co3_gl)

     ps_tx1 = GV[0]
     ps_tx2 = GV1[0]
     
     int s1 = ps_tx1 * Freq
     int s2 = ps_tx2 * Freq

  

     <<"play section  %V$ps_tx1 $ps_tx2 $s1 $s2 \n"

     displayComment("play $ps_tx1 $ps_tx2 $s1 $s2 \n")

     playBuff(sbn, s1, s2)
<<"Done $_proc \n"
}
//---------------------------------------------

proc showSelectRegion()
{
<<"In $_proc  \n"
int s1;
int s2;
      GV = glineGetValues(co2_gl)
      GV1 = glineGetValues(co3_gl)

<<"cursors at %V$GV $GV1 \n"


     //sWo(commwo,@clear,@textr,"%V6.3f$GV \n",0.1,0.7)
     //sWo(commwo,@textr,"%V6.3f$GV1 \n",0.1,0.3)

     new_stx = GV[0]
     new_fin = GV1[0]



//     int s1 = new_stx * Freq
//     int s2 = new_fin * Freq

      s1 = new_stx * Freq
      s2 = new_fin * Freq

<<"%V$new_stx $new_fin $s1 $s2 $nxpts \n"

<<"clearing %V$taswo \n"

  //  sWo(taswo,@redraw,@clearclip,GREEN_)

   sWo(taswo,@redraw)

   sWo(taswo,@clearclip,RED_)
   
   sWo(taswo,@scales, new_stx,-26000, new_fin, 26000)  // via SHM

   drawSignal(taswo, sbn, s1, s2)

    // axnum(taswo, 1, new_stx,new_fin,1.0,-1,"g")

   axnum(taswo, -1)
    
   //displayComment("%V$rx $rX $ry $rY \n")

     sWo(sgwo,@clearclip,@clearpixmap)
//     sWo(taswo,@scales, new_stx,-32000, new_fin, 32000)  // via SHM

   computeSpecandPlot(new_stx, new_fin)

   RP = wogetrscales(taswo)   // via PIPE msg 

   //<<"%V$RP \n"
   rx = RP[1]
   ry = RP[2]
   rX = RP[3]
   rY = RP[4]

  // <<"%V$rx $rX $ry $rY \n"

   sWo(taswo,@scales, new_stx,-26000, new_fin, 26000)  // via SHM
   sWo(sgwo,@scales, new_stx,0, new_fin, 100)  

   axnum(sgwo,-3)
   
   displayComment("%V6.2f$new_stx $new_fin $rx $rX\n")
//   sWo({taswo,voxwo},@clipborder)

<<"Done $_proc \n"
}

//-------------------------------------------

proc getVoxTime()
{


}



proc voxFileRead(vfname)
{

////////////// READ FILE INTO BUFFER   ///////////////////////////

  vds = readsignal(sbn,vfname)

<<"%V $sbn $vds \n"

  // find range of signal
  // just copy buffer back out so we can process it
  // we will add builtin processing later
   isz= Caz(YS)
   <<"%V$isz\n"
   YS = getSignalFromBuffer(sbn,0,vds-2)
   osz= Caz(YS)
   <<"%V$osz\n"
  //<<"%(16,, ,\n)$YS[0:32] \n"

<<" $YS[3] \n"
<<"Done $_proc \n"




  return vds
}//-------------------------------------

proc setUpNewVoxParams()
{
<<"In $_proc  \n"

            npts = (ds/512) * 512
            sz = Caz(YS)

<<"%V $ds $npts $sz $YS[3]\n"


            mm= minmax(YS)
            y0 = mm[0]
            y1 = mm[1]
   <<"%V$mm \n"
                

}//-------------------------------------



vox_type = ".vox"


proc do_wo_options(w_wo)
{
<<"In $_proc  \n"

        if (w_wo == qwo) {
                  do_loop = 0;
        }
	
        else if (w_wo == playsr_wo) {
                   playSection (tx)
        }
        else if (w_wo == playbc_wo) {
                playBCtas()
        }
        else if (w_wo == selectsr_wo) {
                showSelectRegion()
        }
/{	
        else if (w_wo == res_wo) {
//                 <<"%V$msgw[1] $wshift\n"
                 if (msgw[1] @= "low") {
                    <<" res low\n"
                    wshift = hwlen
                 }
                 else if (msgw[1] @= "med") {
                    wshift = qwlen
                 }
                 else if (msgw[1] @= "high") {
                    wshift = owlen
                 }
                 tx_shift = samp2time(wshift/2)

                  getNpixs()
                  selSection (tx)

        }
/}
    else if (w_wo == voxwo) {

              tx = btn_rx // x val ---- time in voxwo

              if (button == 1) {
                sGl(co2_gl,@cursor,tx,y0,tx,y1)  
              }
              else if (button == 3) {
                sGl(co3_gl,@cursor,tx,y0,tx,y1)  
              }

              sGl(cosg_gl,@cursor,tx,0,tx,100)  

              //showSlice (tx)
	      
        }
        else if (w_wo == sgwo) {

              tx = btn_rx // x val ---- time in voxwo

              sGl(cosg_gl,@cursor,tx,0,tx,100)  

             // showSlice (tx)
        }
        else if (w_wo == taswo) {

              tx = btn_rx // time 

              if (button == 1) {
                sGl(co2_gl,@cursor,tx,y0,tx,y1)  
              }
              else if (button == 3) {
                sGl(co3_gl,@cursor,tx,y0,tx,y1)  
              }

              selSection (tx)
	      
              txa = tx - 2.0
	      if (txa < 0) {
                txa = 0
              } 
              txb = txa + 4.0
              //sWo(tawo,@scales, txa ,-26000, txb, 26000)  // via SHM

              showSlice (tx)

              displayComment("%6.2f$tx $txa $txb \n")

        }
        else if (w_wo == record_wo) {

            do_record()

            //SB = getSignalFromBuffer(sbn,0,ds)
	    YS = getSignalFromBuffer(sbn,0,ds)

            //YS = SB
                
            sWo(voxwo, @redraw, @clearclip, BLUE_)
            drawSignal(voxwo, sbn, 0, npts)

        }
        else if (w_wo == read_wo) {

         <<"pop up a window to look for vox files?\n"


	 
          fname = naviwindow("Vox File Locator", " Search for vox files " , "sp_phrase.vox", vox_type);

             <<"got $fname\n"
          //  fname = "ec1.0-9.vox"
	    // check it exists then


            ds=voxFileRead(fname)

            <<"read $ds from file \n"

            setUpNewVoxParams()

            // position cursors
            sGl(co2_gl,@cursor,0,y0,0,y1)
            sGl(co3_gl,@cursor,10,y0,10,y1)  


            sWo(voxwo, @redraw,@clearclip,WHITE_)
            drawSignal(voxwo, sbn, 0, npts)
	    
	 //   sWo(taswo, @redraw,@clearclip,WHITE_)
         //   drawSignal(taswo, sbn, 0, npts)	    

            showSelectRegion()

            sWo(butawo,@border,@drawon,@clipborder,@fonthue,BLACK_,@redraw)
        <<"done with read and process of vox file \n"
        }	
        else if (w_wo == write_wo) {
            // write current select region to out.vox
            writeVox()
        }
}


proc do_key_options(key)
{
<<"In $_proc  \n"
       switch (key) 
       {

         case 'R':
            tx += 0.1
              selSection (tx)
              txa = tx - 2.0
	      if (txa < 0) {
                txa = 0
              } 
              txb = txa + 4.0
              sWo(taswo,@scales, txa ,-30000, txb, 31000)  // via SHM
         break;
         case 'T':
            tx -= 0.1
              selSection (tx)
              txa = tx - 2.0
	      if (txa < 0) {
                txa = 0
              } 	      
              txb = txa + 4.0
              sWo(taswo,@scales, txa ,-30000, txb, 31000)  // via SHM
         break;
         case 'Q':
            tx -= tx_shift  // this should be adjustable by key
            showSlice (tx)
            sGl(co2_gl,@cursor,tx,y0,tx,y1)  
            sGl(cosg_gl,@cursor,tx,0,tx,100)  
         break;
         case 'S':
            tx += tx_shift
            showSlice (tx)
            sGl(co2_gl,@cursor,tx,y0,tx,y1)  
            sGl(cosg_gl,@cursor,tx,0,tx,100)  
         break;


       }

}


// it needs to be using xgs

 Graphic = CheckGwm()
   
  if (!Graphic) {
     X=spawngwm()
  }



 int sb = 0
 int sbn = -1

 fname = _clarg[1]

 //sb = atoi(_clarg[2])

<<"%V$fname $sb\n"


// create an audio buffer

  sbn = createSignalBuffer()

<<"%V$sbn \n"


float SYS[];
float YS[];

//short SB[]; //signal buffer -- do we need local copy instead of using sbn?

int ds;
int npts;
float y0
float y1
float mm[]


   ds = voxFileRead( fname)

   setUpNewVoxParams()

// file read 

// work through buffer and produce spec-slice , rms and zx tracks
// cepstral track
   int nbp = 0
   int frames = 0

// can we do a spec class ?


 float Freq = 16000.0
 int SampFreq = Freq;
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

int Zxthres = 10

float RmsTrk[]
float ZxTrk[]
RmsTrk = 1.0
ZxTrk = 1.0


<<" $(Caz(RmsTrk)) \n"


// real input --- simple version
// real - swin of buffer
// imag is zeroed
// real buffer on output of spec contains the power spectrum
// overlap smoothing by half shift 


int ncb = 90

uchar pixstrip[2][ncb]

////////////////////////////////////////// GREY SCALE ////////////////////////////////////////////////
 ng = 128
 Gindex = 150  //  150 is just above our resident HTLM color map
 tgl = Gindex + ng


 SetGSmap(ng,Gindex)  // grey scale  


///////////////////////////////// WINDOW - GRAPH SETUP ////////////////////////////////////////////////


  ssw = cWi(@title,"TA_and_Spec",@resize,0.02,0.02,0.99,0.99,0)   // Main Window
  setGwindow(ssw,@bhue,"skyblue")
  // whole signal
  wox = 0.01
  woX = 0.98

  ts = ds / Freq
  
  voxwo=cWo(ssw,"GRAPH",@resize,wox,0.85,woX,0.98)
  sWo(voxwo,@name,"Vox",@clip,0.01,0.01,0.99,0.99, @pixmapon, @drawon,@save,@border, @clipborder,"red",@penhue,"green")
  sWo(voxwo,@scales,0,mm[0],ts,mm[1])
  //sWo(voxwo,@help," audio signal in buffer ")
  RP = wogetrscales(voxwo)

   //<<"%V%6.2f$RP\n"

  //
  
  taswo=CWo(ssw,"GRAPH",@resize,wox,0.70,woX,0.84)
  sWo(taswo,@name,"TA",@clip,0.01,0.15,0.99,0.99, @pixmapoff, @drawon,@save,@border, @clipborder,"green",@penhue,"pink")
  sWo(taswo,@scales,0,mm[0],ts/2,mm[1])


  // spectograph window 
  sgwo=CWo(ssw,"GRAPH",@resize,wox,0.5,woX,0.68)
  sWo(sgwo,@penhue,"green",@name,"SG",@pixmapon,@drawon,@save)
  sWo(sgwo,@clip,0.01,0.01,0.99,0.99, @border, @clipborder,"red")
  sWo(sgwo,@scales,0,0,npts,120)
  //sWo(sgwo,@help," spectrograph ")

  cosg_gl  = cGl(sgwo,@type,"CURSOR",@color,RED_,@ltype,"cursor")


  // slice windows
  spwo=CWo(ssw,"GRAPH",@resize,0.5,0.15,0.95,0.48)
  sWo(spwo,@scales,0,-20,8000,90)
  //sWo(spwo,@penhue,"red",@name,"sgraph",@pixmapon,@drawon,@save)
  sWo(spwo,@penhue,"red",@name,"sgraph",@pixmapon,@drawon,@save)
  sWo(spwo,@clip,0.01,0.01,0.99,0.99, @clipborder,"black")
  //sWo(spwo,@help," spectral_slice ")

  tawo=CWo(ssw,"GRAPH",@resize,0.05,0.15,0.45,0.48)
  sWo(tawo,@scales,0,mm[0],FFTSZ,mm[1])
  sWo(tawo,@penhue,"blue",@name,"timeamp",@pixmapon,@drawon,@save)
  sWo(tawo,@clip,0.01,0.01,0.99,0.99, @clipborder,"black")
  //sWo(tawo,@help," time signal for spectral slice ")

  co_gl  = cGl(voxwo,@type,"CURSOR",@color,"red")  // start time
  co1_gl  = cGl(voxwo,@type,"CURSOR",@color,"blue") // finish time


  cop_gl  = CreateGline(@wid,voxwo,@type,"CURSOR",@color,"orange") // compute frame time

<<"%V $co_gl $co1_gl \n"
  co2_gl = cGl(voxwo,@type,"CURSOR",@color,"red")
  co3_gl = cGl(voxwo,@type,"CURSOR",@color,"blue")



  /// Buttons for AUDIO ops

 qwo=cWo(ssw,"BN",@name,"QUIT?",@VALUE,"QUIT",@color,ORANGE_,@help," quit application!")
 
 playsr_wo=cWo(ssw,"BN",@name,"PLAY_SR",@VALUE,"ON",@color,"skyblue",@help," Play selected region")

 playbc_wo=cWo(ssw,"BN",@name,"PLAY_BC",@VALUE,"ON",@color,"magenta",@help," Play section between cursors")

 slicesr_wo=cWo(ssw,"BN",@name,"SLICE_SR",@VALUE,"ON",@color,GREEN_, " Show spec slice for region")
 
 selectsr_wo=cWo(ssw,"BN",@name,"SELECT_SR",@VALUE,"ON",@color,"teal",@help," Process selected region")
  
 //res_wo=cWo(ssw,"BS",@name,"RESOL",@VALUE,"ON",@color,"lime", @help," frame resolution ")
 //        sWo(res_wo,@STYLE,"SVR",@CSV,"low,med,high")

 record_wo=cWo(ssw,"BN",@name,"RECORD_SR",@VALUE,"ON",@color,"teal",@help," record into selected region")

 read_wo=cWo(ssw,"BN",@name,"READ FILE",@VALUE,"ON",@color,"teal",@help," read a vox file")

 write_wo=cWo(ssw,"BN",@name,"WRITE FILE",@VALUE,"ON",@color,"blue",@help," write a vox file")

 int butawo[] = { playsr_wo, playbc_wo, slicesr_wo, selectsr_wo, record_wo, read_wo, write_wo, qwo }

 wohtile(butawo, 0.2, 0.1, 0.9, 0.14)
 sWo(butawo,@border,@drawon,@clipborder,@fonthue,BLACK_,@redraw)


///  text/command  area /////////

  commwo=CWo(ssw,"GRAPH",@resize,0.1,0.02,0.95,0.09)
  sWo(commwo,@clip,0.01,0.01,0.99,0.99, @clipborder,"black")
  sWo(commwo,@penhue,BLACK_,@name,"comms",@pixmapon,@drawon,@save)

  sWo(commwo,@clear,@clipborder,@textr,"ta_spec",0.1,0.5)


  setGwindow(ssw,@redraw)
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

// mid 
   

   tx = RP[3]/2

   //selSection (tx)

   //showSlice (tx)

//   showSelectRegion()



//   tx_shift = samp2time(wshift)
//<<"%V$wshift $tx_shift \n"


///////////////////////////////////  MAIN INTERACTIVE LOOP


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


E =1 // event handle


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

     ta slice not displayed
     select_sr immediately after read in -- causes crash
     



/}