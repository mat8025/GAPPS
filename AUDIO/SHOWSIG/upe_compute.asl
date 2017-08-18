///
///
/// upe_compute
///

// what do we need to compute on the fly
// rms ? Zx --- mel_cep , sg ??


/// files produced by fft,ceppt etc

fir_prog = "afb"

pt_file="tran.pt";

spp_file="tran.spp";

ph_file="tran.ph";

sg_file = "";
rms_file = "";



proc computePitch()
{

frlen = 44
pow_thres = 65
svar ok;
<<"starting cepstum pitch extraction  $spp_file"

<<"\n ceppt -i $vox_file -o ceppt.df -l $frlen -s 7 -n 512 -S 3 -p $pt_file -t 1.6 -b 60 -e 400 -P $pow_thres -A -z $ph_file -x $spp_file\n"

ok=!!"ceppt -i $vox_file -o ceppt.df -l $frlen -s 7 -n 512 -S 3 -p $pt_file -t 1.6 -b 60 -e 400 -P $pow_thres -A -z $ph_file -x $spp_file "

<<"finished cepstum pitch extraction\n"
  PtTrk= readChannel("tran.spp",1)
}
//=====================================================================

proc do_pt (sw)
{


# smoothed pitch

//setpen(sw,"blue",1)
//set_w_rs(sw,1,0)
//set_w_rs(sw,3,400)
<<"plot pitch in $sw\n"

  // fs = getChannelPara(spp_file,"FS",1)
 //  nvals = getChannelPara(spp_file,"NOB",1)
 //  stp = getChannelPara(spp_file,"STP",1)

 //  sWo(fewo,@scales,twRx,0,twRX,300)
 
 //  sGl(ptgl,@XI,fs,@XO,0)
 
// sWo(fewo,@scales,0,0,20,300);
 sWo(fewo,@scales,twRx,0,twRX,300)
 drawGline(ptgl)

  //plotChannel(sw,spp_file,1,1,0,5,2)
<<"done pltchn\n"
# raw pitch
//setpen(sw,"red",1)
//plot_chan(sw,spp_file,0,1,0,5,2);

//scale_taw(sw)
//w_store(sw)
}
//==================================================================

proc getNpixs( wwo)
{
   SGCL = wogetclip(wwo)

   nxpixs = SGCL[3] -  SGCL[1]
   nypixs = SGCL[4] -  SGCL[2]

<<"%V$SGCL \n"

    nf =    Nbufpts/ Wshift;
    nxpts = nxpixs  *  Wshift;

<<"%V$nxpixs $nypixs $nf\n"

   bufend = nxpts - FFTSZ;
   return nxpixs;
}
//===========================================
////////////////////////////////////////// GREY SCALE ////////////////////////////////////////////////
 int ng = 128;
 Gindex = 150;  //  150 is just above our resident HTLM color map
 tgl = Gindex + ng;
 SetGSmap(ng,Gindex);  // grey scale  
/////////////////////////////////////////////////////////////////
///  spec Variables
///

int FFTSZ = 256;
int Wlen = FFTSZ;
float Swin[];
int Hwlen = Wlen/2;

int ncb = 90;
uchar pixstrip[2][ncb];


// ZX and Rms
int Zxthres = 10;
int Wshift = Hwlen;


proc makeSmoothingWindow()
{
  Swin = Fgen(Wlen,0.0,0);
  Swindow(Swin,Wlen,"Hanning");
//  <<"%V$Swin\n";
}
//===========================================
/{
proc showRmsZx(nfr)
{

//  sWo(fewo,@ClearPixMap,@clearclip,@scales,0,0,nfr,30);
//  sGl(rmsgl,@scales,0,0,nfr,30,@ltype,"solid", @symbol,"diamond",@savescales,0,@usescales,0);
   
  drawGline(rmsgl);

  sWo(fewo,@scales,0,0,nfr,1.5,@savescales,1,@usescales,1)
  sGl(zxgl,@scales,0,0,nfr,1.5,@ltype,"solid", @symbol,"diamond",@savescales,1,@usescales,1);

  drawGline(zxgl);
   
  sWo(fewo,@showPixMap) ;    
  sWo(fewo,@clipBorder,BLACK_);
}
/}

proc showRmsZx()
{

   sWo(fewo,@ClearPixMap,@clearclip,@scales,twRx,0,twRX,30);

   drawGline(rmsgl);

   sWo(fewo,@scales,twRx,0,twRX,1.5,@savescales,1,@usescales,1)

   drawGline(zxgl,@usescales,1);


}

//===========================================

float ZxRmsFS = 0.0;
proc computeZxRms()
{
// do this for entire signal
  int spi = 0;
  sbend = getSigbEnd(Sbn);
  int kf = 0;
  
  wshift = Wlen/2;
  end = spi + Wlen - 1;
  ZxRmsFS = wshift * 1.0/Sf;
  
  while (end < sbend) {
     
     YS=getSignalFromBuffer(Sbn,spi,end);

     zx = ZC(YS,Zxthres)

     ZxTrk[kf] = zx;
     rmsv = RMS(YS)

     RmsTrk[kf] = 0.0;

     if (rmsv > 0.0) {
       RmsTrk[kf] = 10*log10(rmsv) -20
     }

     spi += wshift;
     end += wshift;

     kf++;
  }


  sGl(rmsgl,@X0,@XI,ZxRmsFS);
  sGl(zxgl,@X0,@XI,ZxRmsFS);
  
<<"Done compute of Zx and RMS \n"
}

//===========================================


proc computeSpecandPlot(rtb, rtf)
{

/// YS is our float buffer containing the whole signal
// we want to compute spectrogram for the selected subregion
// nxpts is number of xpixels in spectrograph window 
// one spec per pixel

   float imag[];
   float real[];
   
   int winshift = 0;
   int st = rtb * Sf;
   int stend = rtf * Sf;

   makeSmoothingWindow();

<<"%V $rtb $rtf $st $stend \n"

   sbend = getSigbEnd(Sbn);


 if ((st >=0) && (stend < sbend)) { 

   dt = FineTimeSince(Tim,1);  // reset timer

   nxp = getNpixs(sgwo);

  // bufend = st + nxpts - FFTSZ
   bufend = Nbufpts - FFTSZ;
   
   xp = 0;

   frames = 0;
   spi = st;
 
   winshift = (stend- st) / nxp;

<<"% V$winshift $st $stend $nxp   $(nxp*winshift) \n"

//  
//
//<<"%V $ysz  \n"
//<<"$YS[0] $YS[ysz-1]\n"
   
  //  sWo(fewo,@ClearPixMap,@clearClip);
    
 while (spi < stend) {

     end = st + Wlen - 1;
    // <<"%V$st $Wlen $end \n"

     if (end > Nbufpts) {
<<"ERROR $end > $Nbufpts \n"
     }

     YS=getSignalFromBuffer(Sbn,st,end);
     ysz = Caz(YS);
   //<<"$YS[0:20] \n"
   //<<"%V $ysz  \n"
     //real = YS[st:end]
     real = YS;
     //rsz = Caz(real);

//<<"%V$rsz\n"

<<"%V$frames $st $rsz $real[0] $real[fftend]\n"

     rtx = st / Sfreq;

//     sGl(cop_gl,@cursor,rtx,y0,rtx,y1)


/{/*
     zx = ZC(real,Zxthres)

//<<"$frames $zx\n"

     ZxTrk[frames] = zx;

     rmsv = RMS(real)

     RmsTrk[frames] = 0.0;

     if (rmsv > 0.0) {
       RmsTrk[frames] = 10*log10(rmsv) -20
     }

/}*/


//<<"real $real[0:20]\n"

     real *= Swin;
     
//<<"real $real[0:20]\n"
//<<"real $real[220:255]\n"
//<<"%V$ng \n";
    // iread()
     imag = vgen(FLOAT_,256,0);
     
     //imag[FFTSZ-1] = 0;
     //imag = 0.0;
     
//      <<"imag $imag[0:10] \n"

// isz = Caz(imag); // FIX

//<<"%V$st $isz $imag[0] $imag[fftend]\n"
//<<"%V$zx $rmsv \n"
     
     spec(real,imag,FFTSZ,0);

//<<"$real[0:20]\n"

     st += winshift;

     powspec = real[0:Hwlen-1];
//<<"%V$powspec \n"

   if ((xp % 2) == 0) {
     pixstrip[0][::] = round(reverse(v_range(v_zoom(powspec,ncb),-10,100,0,ng)))
   }
   else {
     pixstrip[1][::] = round(reverse(v_range(v_zoom(powspec,ncb),-10,100,0,ng)))
//<<"%V$pixstrip \n"
    // plotPixRect(sgwo, pixstrip, Gindex, xp,ncb,2,1)
     plotPixRect(sgwo, pixstrip, Gindex, xp,1,2,-1)
     
     
     //sWo(commwo,@clear,@textr," $tx $frames \n",0.1,0.5)
     //<<"plotpixrect $xp $pixstrip[0][0:20]\n";
    }

    xp++;

    if (st > bufend) {
        break;
    }

    if (xp > nxp) {
       break;
    }

    frames++
  }

  // Resize(RmsTrk,frames)
  // Resize(ZxTrk,frames)
  // showRmsZx(frames);

  dt = FineTimeSince(Tim,1)
  dtsecs = dt / 1000000.0;

<<"compute and plot time took $dtsecs  frames $frames \n"

// sWo(commwo,@clear,@clipborder,@textr,"compute & plot time took $dtsecs  frames $frames \n",0.1,0.5)

// displayComment("compute & plot time took $dtsecs  frames $frames \n");
   
  }
  
}

//========================================

winc = showInclude()
<<"%V$winc\n"
<<"Done include upe_compute.asl $(showInclude()) \n"

