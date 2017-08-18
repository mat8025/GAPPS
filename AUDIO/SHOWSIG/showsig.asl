// test spectral processing of vox file

setdebug(1);

vers = "1.2";

include "audio";


proc usage()
{

<<" showsig [OPTIONS] file \n"

<<" -f int  ---- freq default 16000 Hz \n"
<<" -c number of chans 1 mono 2 stereo  \n"
<<" signal file\n";
}
//===================================


proc checkForIntrpt()
{
int ret = 0;
  eventRead();

  if (ev_woid == intrpwo) {
<<"stop current action! ";
   ret =1;
  }
   return ret;
}
//===================================

proc displayComment ( cmsg) 
{
    <<" $cmsg "
    sWo(commwo,@clear,@clipborder,@textr,cmsg,0.1,0.5)

}
//================================================
proc samp2time( ns)
{
  float t 
  t =ns/ Sf
<<"%V$t \n"
 // float t = ns/ Sf
  return t

}
//================================================
proc getNpixs()
{

   SGCL = wogetclip(sgwo)

   nxpixs = SGCL[3] -  SGCL[1]
   nypixs = SGCL[4] -  SGCL[2]

<<"%V$SGCL \n"

   CL = wogetclip(taselwo)


<<"%V$CL \n"

    Nf = Npts/ wshift;

    //Nxpts = nxpixs  *  wshift; // every xpixel is wshift points
    Nxpts = nxpixs ; 

<<"%V$nxpixs $nypixs $Nf\n"
<<"%V $Npts $Nxpts \n"

    bufend = Nxpts - FFTSZ;


}
//================================================
proc computeSpecandPlot( t1,t2)
{

/// YS is our float buffer containing the whole signal
/// want to compute spectrogram for subregion
/// Nxpts is number of xpixels in spectrograph window 
/// one spec per pixel
<<" $_proc %V $t1 $t2 \n"
   int winshift = 512;
   getNpixs();
   dt = FineTimeSince(T,1)  // reset timer

   st = t1 * Freq;
   
   ft = t2 * Freq;

<<"%V $st $ft $bufend $FFTSZ\n";

   npts = 10 * Freq;  // 10 secs worth
   //bufend = st + Nxpts - FFTSZ;
   
   bufend = ft - FFTSZ;
   
   xp = 0;
   frames = 0;
   
   
   winshift = (bufend- st) / Nxpts;


   
   if (winshift <= 0) {
       winshift = 10;
   }
   int nf =  (bufend- st) / Nxpts;
   
   <<"%V $nf $bufend $st $winshift \n";


   sWo(sgwo,@clearclip,@clearpixmap);

   // shift then depends on num of sample points in selected region --- TBC

   while (1) {

     end = st + wlen - 1
     real = YS[st:end]
     rsz = Caz(real)

      

     if (show_tas) {
        sWo(tawo,@scales,0,-20000,FFTSZ,20000)
        sWo(tawo,@clearclip,@clearpixmap);
        DrawY(tawo,real,0,1);
	sWo(tawo,@showpixmap);
      }

     rtx = st / Freq;

     sGl(cop_gl,@cursor,rtx,y0,rtx,y1)

    //sGl(co_gl,@cursor,end,y0,end,y1)

     zx = ZC(real,Zxthres)

     rmsv = RMS(real)

     real *= swin;

     imag = 0.0
     isz = Caz(imag)

//<<"%V$st $isz $imag[0] $imag[fftend]\n"
//<<"%V$zx $rmsv \n"
     
    spec(real,imag,FFTSZ,0);

//<<"$real[0:20]\n"

    st += winshift ;

    if (show_spec) {
    // scales
    sWo(spwo,@scales,0,-20,FFTSZ/2,100)
    
    sWo(spwo,@clearclip,@clearpixmap);
    // <<"DrawY spec $hwlen \n"
     DrawY(spwo,real[0:hwlen-1],0,1);
     sWo(spwo,@showpixmap);     
   }

   powspec = real[0:hwlen-1]

   if ((xp % 2) == 0) {
     pixstrip[0][::] = round(reverse(v_range(v_zoom(powspec,ncb),-10,100,0,ng)))
   }
   else {
     pixstrip[1][::] = round(reverse(v_range(v_zoom(powspec,ncb),-10,100,0,ng)))
//<<"%V$pixstrip \n"
    // plotPixRect(sgwo, pixstrip, Gindex, xp,ncb,2,1)
     plotPixRect(sgwo, pixstrip, Gindex, xp,1,2,-1)

     }

   xp++;

    if (st > bufend)
        break;

    if ((frames % 20)  == 0) {
        // sleep(0.7)  // SHM full check  -- need to check
     <<"%V$frames $st \n"
      // if (checkForIntrpt()) {
      //   break;
      // }
     
    }
    
    frames++;
  }

  sWo(sgwo,@showpixmap);     

  dt = FineTimeSince(T,1)

  dtsecs = dt / 1000000.0

<<"compute and plot time took $dtsecs numofframes $frames \n"

  //setgwob(commwo,@clear,@clipborder,@textr,"compute & plot time took $dtsecs  frames $frames \n",0.1,0.5)

   displayComment("compute & plot time took $dtsecs  frames $frames \n")

}
//================================================


proc showSlice ( tx )
{

     int sti = (tx * Freq);

     end = sti + wlen - 1

     real = YS[sti:end]

     sWo({tawo,spwo},@clearpixmap)
    // setgwob(tawo,@clearclip)

//<<"draw TA\n"
     DrawY(tawo,real,0,1);

     // swindow and compute powspec
     real *= swin

     imag = 0.0
     
     spec(real,imag,FFTSZ,0);

     powspec = real[0:hwlen-1];

    // setgwob(spwo,@clearclip)
//<<"draw Spec \n"

     DrawY(spwo,real[0:hwlen-1],0,1)


   RP = wogetrscales(taselwo)   // via PIPE msg 

   //<<"%V$RP \n"
   rx = RP[1]
   ry = RP[2]
   rX = RP[3]
   rY = RP[4]

    sWo({tawo,spwo},@showpixmap,@clipborder)

    displayComment("time $tx sample $sti %V6.2f$rx $rX  $tx\n")

//    sGl(co2_gl,@cursor,tx,y0,tx,y1)



//    sGl(co_gl,@cursor,tx,y0,tx,y1)

}
//================================================

proc playBuff(wb, st, fi)
{
<<"play $Dspfd $wb $st $fi \n"

   playBuffer(Dspfd, wb, st, fi)

}
//================================================

proc selSection( tx)
{
/// display a section of the VOX buffer
/// in the ta sel window

<<" $_proc $tx \n"

    int s1 = tx * Freq;
    npts = (Timesw * Freq);
// bracket around

    if (s1 > (npts/2)) {
     s1 -= npts/2;
    }
    

    int s2 = s1 + npts;

    float tx1 = s1/ (Freq *1.0);

    sGl(co_gl,@cursor,tx1,y0,tx1,y1)

    float tx2 = s2/ (Freq *1.0);

    sGl(co1_gl,@cursor,tx2,y0,tx2,y1);  // arg not parsed

    sWo (taselwo,@clearpixmap,@clipborder)

<<"taselwo %V $tx1 $tx2 \n";

    sWo(taselwo,@scales, tx1,-32000, tx2, 32000)  // via SHM

    drawSignal(taselwo, sbn, s1, s2);

    displayComment("select  $tx1 $tx2  --- $s1 $s2 \n")

//    sGl(co2_gl,@cursor,0)  // show if it is already active  

//    sGl(co3_gl,@cursor)  // show if it is already active  


    axnum(taselwo, 1, tx1,tx2,0.25,-1,"g")
    // axnum(taselwo, -1);

    sWo(taselwo,@showpixmap);

    sGl(co2_gl,@cursor);  // show if it is already active  
    sGl(co3_gl,@cursor);  // show if it is already active  

}
//================================================

proc playSection( )
{
// play a section of the buffer
// play time between cursors in voxwo

     GV = glineGetValues(co_gl)
     GV1 = glineGetValues(co1_gl)

     ps_tx1 = GV[0]
     ps_tx2 = GV1[0]
     
     int s1 = ps_tx1 * Freq

     int s2 = ps_tx2 * Freq  

     displayComment("play $ps_tx1 $ps_tx2 $s1 $s2 \n")

     playBuff(sbn, s1, s2)

//   sGl(co1_gl,@cursor,tx1,y0,tx1,y1)
// FIX   sGl(co1_gl,@cursor,tx+3,y0,tx+3,y1)  // arg not parsed

}
//================================================
proc playBCtas( )
{
// play a section of the buffer
// play time between cursors in tas 

     GV = glineGetValues(co2_gl)
     GV1 = glineGetValues(co3_gl)

     ps_tx1 = GV[0]
     ps_tx2 = GV1[0]
     
     int s1 = ps_tx1 * Freq

     int s2 = ps_tx2 * Freq  

     displayComment("play $ps_tx1 $ps_tx2 $s1 $s2 \n")

     playBuff(sbn, s1, s2)

}
//================================================

proc showSelectRegion()
{

      GV =  glineGetValues(co_gl);
      GV1 = glineGetValues(co1_gl);

     //setgwob(commwo,@clear,@textr,"%V6.3f$GV \n",0.1,0.7)
     //setgwob(commwo,@textr,"%V6.3f$GV1 \n",0.1,0.3)

     new_stx = GV[0];
     new_fin = GV1[0]; // can't control this
<<"%V $new_stx $new_fin \n"
     new_fin = new_stx + 5; // check for end



     if (new_fin < new_stx) {
      tmpt = new_fin;
      new_fin = new_stx;
      new_stx = tmpt;
<<"needed to swap times! %V$new_stx $new_fin  $Nxpts \n"      
     }

<<"%V $new_stx $new_fin \n"


     int s1 = new_stx * Freq;
     int s2 = new_fin * Freq;

// sWo(taselwo,@clearclip,@clear,@clearpixmap)

// sWo(taselwo,@scales, new_stx,-32000, new_fin, 32000)  // via SHM

//   
<<"taselwo %V $new_stx $new_fin $s1 $s2\n";
     sWo(taselwo,@scales, new_stx,-32000, new_fin, 32000);  // via SHM

     drawSignal(taselwo, sbn, s1, s2);

     sWo(taselwo,@save)

     axnum(taselwo, 1, new_stx,new_fin,1.0,-1,"g")
    // axnum(taselwo, -1)
    
   //displayComment("%V$rx $rX $ry $rY \n")

     sWo(sgwo,@clearclip,@clearpixmap);
//     sWo(taselwo,@scales, new_stx,-32000, new_fin, 32000)  // via SHM

   computeSpecandPlot(new_stx, new_fin);

   RP = wogetrscales(taselwo)   // via PIPE msg 

   <<"%V$RP \n"
   rx = RP[1]
   ry = RP[2]
   rX = RP[3]
   rY = RP[4]

   <<"%V$rx $rX $ry $rY \n"
<<"taselwo %V $new_stx $new_fin \n";
   sWo(taselwo,@scales, new_stx,-32000, new_fin, 32000)  // via SHM
   axnum(taselwo,-1);
   sWo(sgwo,@scales, new_stx,0, new_fin, 100)  

   axnum(sgwo,-3)
   displayComment("%V6.2f$new_stx $new_fin $rx $rX\n")
   sWo({taselwo,voxwo},@clipborder)  
}
//================================================

proc getVoxTime()
{


}
//================================================

proc do_wo_options(w_wo)
{

        if (w_wo == qwo) {
                  do_loop = 0;
        }
        else if (w_wo == playsr_wo) {
                   playSection (tx);
        }
        else if (w_wo == playbc_wo) {
                playBCtas();
        }
        else if (w_wo == selectsr_wo) {
                showSelectRegion();
        }
        else if (w_wo == res_wo) {
                 <<"%V$ev_keyw $wshift\n"
                 if (ev_woval @= "low") {
                    <<" res low\n"
                    wshift = hwlen
                 }
                 else if (ev_woval @= "med") {
                    wshift = qwlen
                 }
                 else if (ev_woval @= "high") {
                    wshift = owlen
                 }
		 
                 tx_shift = samp2time(wshift/2)

                  getNpixs();
                  selSection (tx);

        }
        else if (w_wo == taselwo) {

              tx = ev_rx; // x val ---- time in voxwo

              if (ev_button == 1) {
                sGl(co2_gl,@cursor,tx,y0,tx,y1)  
              }
              else if (ev_button == 3) {
                sGl(co3_gl,@cursor,tx,y0,tx,y1)  
              }

              sGl(cosg_gl,@cursor,tx,0,tx,100)  

              showSlice (tx);

        }
        else if (w_wo == sgwo) {

              tx = ev_rx; // x val ---- time in voxwo

              sGl(cosg_gl,@cursor,tx,0,tx,100)  

              showSlice (tx);

        }
        else if (w_wo == voxwo) {

              tx = ev_rx; // time in voxwo

              selSection (tx);

              txa = tx - 2.0;
              txb = tx + 2.0;
	      
<<"taselwo %V $txa $txb \n";

              sWo(taselwo,@scales, txa ,-30000, txb, 31000)  // via SHM

              showSlice (tx)

              displayComment("%6.2f$tx $txa $txb \n");

        }
}
//================================================

proc do_key_options(key)
{

       switch (key) 
       {

         case 'R':
              tx += 0.1
              selSection (tx)
              txa = tx - 2.0
              txb = tx + 2.0
	      <<"taselwo %V $txa $txb \n";	      
              sWo(taselwo,@scales, txa ,-30000, txb, 31000)  // via SHM
         break;
         case 'T':
              tx -= 0.1;
              selSection (tx)
              txa = tx - 2.0
              txb = tx + 2.0
              sWo(taselwo,@scales, txa ,-30000, txb, 31000)  // via SHM
         break;
         case 'Q':
            tx -= tx_shift  // this should be adjustable by key
            showSlice (tx)
            sGl(co2_gl,@cursor,tx,y0,tx,y1)  
            sGl(cosg_gl,@cursor,tx,0,tx,100)  
         break;
         case 'S':
            tx += tx_shift;
            showSlice (tx);
            sGl(co2_gl,@cursor,tx,y0,tx,y1)  
            sGl(cosg_gl,@cursor,tx,0,tx,100)  
         break;


       }

}
//================================================



/////////////////////// MAIN ////////////////////////////////

 Graphic = CheckGwm();

  if (!Graphic) {
    Xgm = spawnGwm("XYZ")
  }


 int sb = 0
 int sbn = -1

 float Freq = 16000.0; // default

 float fstart = 0.0;
  int nchans = 1; // display not setup for stereo yet
  int bufend = 0;
  int Nf = 0;
  int Nxpts =0;
  int Npts = 0;

  float Timesw = 5.0;  // default length for selection

   na = GetArgc();

   ka = 1;
   fname = _clarg[ka];

   if (fname @= "") {
<<"no file to view \n";
   usage();
   exit();
   }

   ka++;
    
    while (1) {

    if (ka > na )
       break;
       
    opt = GetArgStr(ka);

    ka++;

    //<<"$ka %V$opt \n"
    if (!(opt @= "")) {
    
    if (opt @= "-f") {
        Freq = getArgI(ka)
    ka++
    <<"$ka setting %V$Freq  \n"
    }
    elif (opt @= "-h") {
      <<" $opt usage \n"
      usage()
    }
    elif (opt @= "-c") {
     nchans = getArgI(ka)
     <<" setting %V$nchans  \n"
     }     
    elif (opt @= "-s") {
     fstart = getArgF(ka)
     <<" setting file start time  \n"
     }          

     }


    }



 //sb = atoi(_clarg[2])

<<"%V$fname $sb\n"


// create an audio buffer

 sbn = createSignalBuffer()

<<"signal buffer %V$sbn \n"

////////////// READ FILE INTO BUFFER   ///////////////////////////

  ds = readsignal(sbn,fname)

<<"%V $sbn read $ds samples \n"

  Npts = ds;

  // find range of signal
  // just copy buffer back out so we can process it
  // we will add builtin processing later

  B = getSignalFromBuffer(sbn,0,ds)

  <<"%(16,, ,\n)$B[0:32] \n"

  mm= minmax(B)


  openAudio();

  if (Dspfd != -1) {
  ok = setSoundParams(Dspfd,Mixfd,Freq,nchans); 
  }
  else {

<<"WARNING!!!  sound play not setup correctly!!\n";
  }

////////////////////////////////////////////////////////
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

<<"%V$dsz $Npts $hdr_size\n"

    B=rdata(A,SHORT)

<<"%(10,, ,\n)$B[0:99] \n"

<<"B $mm \n"
/}

int dsz = Caz(B);

    Npts = ds/512 * 512 ; // should be number of frames

    <<"%V$dsz $Npts \n"


float SYS[]
float YS[]

      YS= B 

      mm= minmax(YS)

<<"%(10,, ,\n)$B[0:99]\n"
<<"$mm \n"


  y0 = mm[0];
  y1 = mm[1];


// file read 
// work through buffer and produce spec-slice , rms and zx tracks
// cepstral track


   int nbp = 0;
   int frames = 0;

 Sf = Freq;
 dt = 1.0/Sf;

 FFTSZ = 1024;
 fftend = FFTSZ -1

 wlen = FFTSZ

 hwlen = wlen/2
 qwlen = wlen/4
 owlen = wlen/8

 int wshift = hwlen;

 swin = Fgen(wlen,0.5,0)

 Swindow(swin,wlen,"Hamming");

 int st = 0;
 end = st + wlen - 1;

float real[wlen];
float imag[wlen];

int Zxthres = 10;

float RmsTrk[];
float ZxTrk[];

RmsTrk = 1.0;
ZxTrk = 1.0;


<<" $(Caz(RmsTrk)) \n"


// real input --- simple version
// real - swin of buffer
// imag is zeroed
// real buffer on output of spec contains the power spectrum
// overlap smoothing by half shift 




int ncb = 90;

uchar pixstrip[2][ncb];

/////////////////////// GREY SCALE //////////////////////////////
 ng = 128;
 Gindex = 150;  //  150 is just above our resident HTLM color map
 tgl = Gindex + ng;

 SetGSmap(ng,Gindex);  // grey scale  

///////////////////// WINDOW - GRAPH SETUP //////////////////////


  ssw = cWi(@title,"TA_and_Spec(${vers})",@resize,0.02,0.02,0.99,0.99,0)   // Main Window
  sWi(ssw,@bhue,"skyblue")
  // whole signal
  wox = 0.01;
  woX = 0.98;

  ts = ds / Freq;
  // whole signal
  voxwo=cWo(ssw,@GRAPH,@resize,wox,0.85,woX,0.98)
  sWo(voxwo,@name,"Vox",@clip,0.01,0.01,0.99,0.99)
  sWo(voxwo,@pixmapon, @drawon,@save,@border, @clipborder,"red",@penhue,GREEN_)
  sWo(voxwo,@scales,0,mm[0],ts,mm[1])
  sWo(voxwo,@help," audio signal in buffer ");
  
  RP = wogetrscales(voxwo);

  <<"%V%6.2f$RP\n"
  // suitable section size <= 10 secs

  sts = ts;
  
  if (sts > 3.0) {
      sts = 3.0;
  }

  swox = 0.3;
  swoX = 0.7;

  // selected signal section
  taselwo=cWo(ssw,@GRAPH,@resize,swox,0.70,swoX,0.84)
  sWo(taselwo,@name,"TA",@clip,0.01,0.15,0.99,0.99,
  sWo(taselwo,@pixmapon, @drawoff,@save,@border, @clipborder,"green",@penhue,PINK_,@savepixmap)
  sWo(taselwo,@scales,0,mm[0],sts,mm[1]);


  // sWo(taselwo,@help," selected section of audio signal ")
  // spectograph window 
  sgwo=cWo(ssw,@GRAPH,@resize,swox,0.5,swoX,0.68)
  sWo(sgwo,@penhue,"green",@name,"SGRAPH",@pixmapon,@drawon,@save,@savepixmap);
  sWo(sgwo,@clip,0.01,0.01,0.99,0.99, @border, @clipborder,"red")
  sWo(sgwo,@scales,0,0,Npts,120)
  sWo(sgwo,@help," spectrograph ")

  cosg_gl  = cGl(sgwo,@type,"CURSOR",@color,"red") 


  // slice windows
  spwo=cWo(ssw,@GRAPH,@resize,0.05,0.15,0.45,0.48)
  sWo(spwo,@scales,0,-20,FFTSZ/2,90)
  //SWo(spwo,@penhue,"red",@name,"sgraph",@pixmapon,@drawon,@save)
//  sWo(spwo,@penhue,"red",@name,"sgraph",@pixmapon,@drawoff,@save)

  sWo(spwo,@penhue,RED_,@name,"SSLICE",@pixmapon,@drawoff,@save,@savepixmap)
  sWo(spwo,@clip,0.01,0.01,0.99,0.99, @clipborder,BLACK_)
  //sWo(spwo,@help," spectral_slice ")

  tawo=cWo(ssw,@GRAPH,@resize,0.5,0.15,0.95,0.48)

  //sWo(tawo,@scales,0,mm[0],1024,mm[1])
  sWo(tawo,@scales,0,-24000,FFTSZ,24000);
  
  //sWo(tawo,@penhue,BLUE_,@name,"timeamp",@pixmapon,@drawoff,@save)
  sWo(tawo,@penhue,BLUE_,@name,"timeamp",@pixmapon,@drawoff,@save,@savepixmap)
  sWo(tawo,@clip,0.01,0.01,0.99,0.99, @clipborder,BLACK_)
  //sWo(tawo,@help," time signal for spectral slice ")



  ///////////////  CURSORS //////////////////////
  co_gl  = cGl(voxwo,@type,"CURSOR",@color,RED_)  // start time

  co1_gl = cGl(voxwo,@type,"CURSOR",@color,BLUE_) // finish time

  cop_gl  = cGl(voxwo,@type,"CURSOR",@color,GREEN_) // compute frame time


<<"%V $co_gl $co1_gl \n"


  co2_gl = cGl(taselwo,@type,"CURSOR",@color,RED_)
  co3_gl = cGl(taselwo,@type,"CURSOR",@color,BLUE_)

  // Buttons for AUDIO ops

 bx = 0.2
 by = 0.1
 bX = 0.3
 bY = 0.14
 bwidth = 0.1
 bpad = 0.01


 qwo=cWo(ssw,@ONOFF,@name,"QUIT?",@VALUE,"QUIT",@color,ORANGE_)
 sWo(qwo,@help," click to quit")
 sWo(qwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black")

 bx = bX + bpad
 bX = bx + bwidth

 intrpwo=cWo(ssw,@ONOFF,@name,"Interrupt?",@VALUE,"QUIT",@color,ORANGE_)
 sWo(intrpwo,@help," click to interrupt")
 sWo(intrpwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black")

 bx = bX + bpad
 bX = bx + bwidth

 playsr_wo=cWo(ssw,@ONOFF,@name,"PLAY_SR",@VALUE,"ON",@color,"skyblue")
 sWo(playsr_wo,@help," click to play selected region")
 sWo(playsr_wo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black")

 bx = bX + bpad
 bX = bx + bwidth

 playbc_wo=cWo(ssw,@ONOFF,@name,"PLAY_BC",@VALUE,"ON",@color,"magenta")
 sWo(playbc_wo,@help," click to play between cursors")
 sWo(playbc_wo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black")


 slicesr_wo=cWo(ssw,@ONOFF,@name,"SLICE_SR",@VALUE,"ON",@color,"green")
 sWo(slicesr_wo,@help," click to show spec slice for region")
 sWo(slicesr_wo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black")

 selectsr_wo=cWo(ssw,@ONOFF,@name,"SELECT_SR",@VALUE,"ON",@color,"teal")
 sWo(selectsr_wo,@help," click to activate selected region")
 sWo(selectsr_wo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black")

 // @MENU ?
 res_wo=cWo(ssw,"BS",@name,"RESOL",@VALUE,"ON",@color,"lime")
 sWo(res_wo,@help," frame resolution ")
 sWo(res_wo,@STYLE,"SVR",@CSV,"low,med,high")
 sWo(res_wo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black")


 int butawo[] = { playsr_wo, playbc_wo, slicesr_wo, selectsr_wo, res_wo, intrpwo, qwo }

// arrange using htile
   wohtile(butawo, 0.2, by, 0.9, bY);
   sWo(butawo,@redraw)

  //  text/command wo

  commwo=cWo(ssw,@GRAPH,@resize,0.1,0.02,0.95,0.09)
  sWo(commwo,@clip,0.01,0.01,0.99,0.99, @clipborder,"black");
  sWo(commwo,@penhue,"black",@name,"comms",@pixmapon,@drawon,@save);
  sWo(commwo,@clear,@clipborder,@textr,"ta_spec",0.1,0.5);


  sWi(ssw,@redraw)
  gflush()
  gsync()
  sleep(1);
  
// wait till XGS responds ??

///////////////////////////////////////////////////////////////////////////////////////////////////////


  
  getNpixs();

  int xp = 0

  float tx = 0.0
  float txa = 0.0;
  float txb = 0.0;

  float tx_shift;

//  tx_shift = samp2time(wshift/2)
//  tx_shift = samp2time(wshift)

  tx_shift = 0.0125;


   if (Nxpts < Npts) {
     SYS = YS[0:Nxpts];  // want about 3 secs worth
   }
   else {
     SYS = YS  // want about 3 secs worth
     bufend = Npts - FFTSZ;
   }

    tasX = Nxpts/ Sf; 

    

    drawSignal(voxwo, sbn, 0, Npts);


    sWo(taselwo,@scales,0,mm[0],10.0,mm[1]);

    drawSignal(taselwo, sbn, 0, 10*Freq);

    // I think drawSignal should update the xscales --- according to the number of signal points it plots


//  DrawY(voxwo,YS,1,0.75)
//  DrawY(taselwo,SYS,1,0.75)

  show_tas = 0;
  show_spec = 0;
  
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



   //computeSpecandPlot(0)

   sleep(1);

//  sWo({taselwo,sgwo,voxwo},@save)

// mid 
   
   tx = RP[3] * 0.5;

   selSection (tx);

   showSlice (tx)

   //showSelectRegion(); // this takes too long and we need to be able to interrupt


//   tx_shift = samp2time(wshift)
//<<"%V$wshift $tx_shift \n"


///////////////////////////////////  MAIN INTERACTIVE LOOP


Svar msg;


wScreen = 0;

int do_loop = 1;
int w_wo = 0

include "gevent"

//   sWo({taselwo,sgwo,voxwo},@showpixmap)

   while (do_loop) {

       sWo({taselwo,sgwo,voxwo},@clearpixmap);
       
        eventWait();

        do_wo_options(ev_woid);

        do_key_options(ev_keyc);

       sWo({taselwo,sgwo,voxwo},@showpixmap);

   //  sleep(0.1)

   }


// close up
closeAudio()
exitgs(1)



/{/*
/////////////////// TBD //////////////////////////////////

 rms track
 zx  track
 cep pitch track
 format extraction
 phoneme label from database
 wo cursors
  
 A B comparisons with another vox


 a -c option to concatenate files ?



 FIX
     ta draw clears clipborder
     cursor lines - need to be re-inited after a redraw
     crash on FPE errors?


/}*/
