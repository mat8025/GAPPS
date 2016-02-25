#/* -*- c -*- */
# "$Id: pulseCompute.g,v 1.1 2003/06/25 07:08:30 mark Exp mark $"
// Compute Functions - each can have IO and Display requirements

int Pks[]
int Spks[]

// Set up FFTSZ and Window lengths
 PI = 4.0 * atan(1.0)

 float Sfreq = 50.0

// Variables depending on FFTSZ

float SjThres = 50.0

int Fftsz = 1024   // default size

<<" %v $Fftsz \n"

 int Wlen = 1024
 int Cwlen = 1024 //    can be smaller at start or reset
 int hfftsz
 int specsz 
 int cepsz 
 int fftend
 int hfftend 

 float dF 

 float dFD60

 float dFT60

 float MaxPulse = 350.0 // this has to be adaptively set
 float MinPulse = 20.0 // this has to be adaptively set 

 int Minpulsebin = 5
 int Maxpulsebin = 127

 int lowspbin = 2
 int highspbin 
 int wsc = Fftsz/4

 // Pulse variables
  pr = 60.0
  last_pr = -1.0
  last_2pr = -1.0

int NPRE = 10

float Ptrack[NPRE][3]

int nprec = 0


  float Rpowspec[]
  float IRpowspec[]

  float Rlogspec[]
  float IRlogspec[]

  float Renerspec[]
  float IRenerspec[]
  float RIRenerspec[]
  float freal[]
  float fimag[]

  float cepreal[]
  float cepimag[]
  float IRcepreal[]

  float real[]
  float imag[]

  float Rreal[]
  float Rimag[]

  float IRreal[]
  float IRimag[]

  float creal[]
  float cimag[]


 Csz = Fftsz/4
 CepWt = Fgen(Csz,0,20/Csz)


proc ResizeFFT() 

{
  //<<" %v $Fftsz \n"

  if (!fix_wlen)
     Wlen = Fftsz

 hfftsz = Fftsz/2

 specsz = hfftsz -1

<<" %V $Fftsz $Wlen $hfftsz \n"

 cepsz = hfftsz
 fftend = Fftsz -1
 hfftend = hfftsz -1

 dF = Sfreq/ Fftsz

 dFD60 = dF/60.0

 dFT60 = 60.0*dF

<<" %V $dF $dFT60 $dFD60 \n"


 Minpulsebin =  Trunc (35.0/dFT60)
 Maxpulsebin =  Trunc (250.0/dFT60)

<<" %V $Fftsz $Minpulsebin $Maxpulsebin \n"

  lowspbin = 5
  highspbin = abs(800/dFT60)    // 400bpm -> spectral bin

  wsc = Fftsz/4

  Rpowspec[Fftsz] = 0
  IRpowspec[Fftsz] = 0

  Rlogspec[Fftsz] = 0
  IRlogspec[Fftsz] = 0

  Renerspec[Fftsz] = 0
  IRenerspec[Fftsz] = 0
  RIRenerspec[Fftsz] = 0
  freal[Fftsz] = 0
  fimag[Fftsz] = 0

  cepreal[Fftsz] = 0
  cepimag[Fftsz] = 0
  IRcepreal[Fftsz] = 0
}


LowEthres = 1000

proc PickBestPulse()
{

  // return  unless we have bad/ no signal

  if (SpecPir > 1000) return 0.0

  if (Einband < LowEthres)
     return 0.0

       prave = Spr

       if (nloop > 3) {
                bpi = nloop -3
                bpi2 = nloop -1
	 prave = Mean(BestPR[bpi: bpi2 ])
	   }

     if ((mtype @= "S")) 
        bnew = Fpr
     else
        bnew = Spr      


      //" PickBestPR $bave $Spr \n"

      bave = (prave + bnew) /2
    
     return bave
}


last_vo2 = 60.0

proc PickBestSPO2()
{
  // return Fpo2 unless we have bad/ no signal

  //  if (SpecPir > 6.0)      return 0.0
  dcsecs = 90

  if (SpecPir > 1000) return 0.0

  if (Einband < LowEthres)
     return 0.0

       // burst type noise
       // use DCtrk or filter pleth
       

  // always use should be good estimate as long as AC's updated 
  // when valid 

       //     bo2= acdcO2

 bo2 = -1.0 
  // which to use ?


 if ( ValidO2(SprO2)) {
     bo2 = SprO2
       }
  elif ( ValidO2(acdcO2)) {
     bo2 = acdcO2
  }
  elif ( ValidO2(Dcso2)) {
     bo2 = Dcso2
  }
  elif ( ValidO2(msO2)) {
     bo2 = msO2
  }


  // use last if invalid

  if (bo2 < 5.0)
       bo2 = last_vo2
  else
       last_vo2 = bo2

  ///   
#{
       if (last_siglock > dcsecs) {
         bo2= Dcso2
       }
#}
      

     if (MotionS >= 2) {
         bo2= Dcso2

     // sheparding
     if ( (bo2 < acdcO2) || (bo2 > 100) )
         bo2 = acdcO2

	   if (bo2 < SprO2)
              bo2 = SprO2
     }

     if (Dcso2 < acdcO2) {
       // reset lastgacr - cos its wrong
       // for now limit
         Dcso2 = acdcO2
     }

  //   wt towards acdco2

    if (bo2 > acdcO2) {
        do2 = Dcso2 - acdcO2
      if  (Dcso2 < 89) {
          bo2 -= (do2 * 0.05)
   <<" Wtd towards acdo2  %v  $Dcso2 $acdcO2 $do2 %v $bo2 !! \n"
     }
     else  if  (Dcso2 > 92) {
          bo2 += (do2 * 0.05)
     }
    }



       if (nloop > 3) {
                bpi = nloop -3
                bpi2 = nloop -1
	 bave = Mean(BestO2[bpi: bpi2 ])
	   }
       else 
         bave = bo2      


     bave = (bave + bo2)/2.0

     return bave
}

proc RtoSpo2( r)

{

      sz= Caz(r)

	// <<" %V $sz $r \n"

      rspo2 = -8.5 * r * r + -14.6 * r + 108.25

      sz= Caz(rspo2)

      <<" %V $sz $rspo2 \n"

    retval = rspo2
    return retval
}


#{

proc FindLocalPeak( av[] , bin)
  {

  pint = FineTime()
  // redo as C func
  // FIX need to blank after  maxv!!
  int ib

  mbin = bin

    //<<" %v $mbin \n"

  if (bin > 5) {
    maxv = 0

    for (ib = (bin -5) ; ib <= (bin+5) ; ib++ ) {

      if (av[ib] > maxv) {
       maxv = av[ib]
       mbin = ib
      }

      //      <<" $ib $av[ib] $mbin \n"

    }
  }

   ptsecs = FineTimeSince(pint)  / 1000000.0


   return mbin
}

#}




proc InitPars()
{
  PwrScale = 1.0/ (Fftsz)
}

proc InitPRE()
{
  for (:j = 0; j < NPRE ; j++) {
          Ptrack[j][0] = 60.0
          Ptrack[j][1] = 5
  }
}

proc ValidO2(eo2)
{
  if ((eo2 > 40.0) && (eo2 < 101))
        return 1
        return 0
}


proc PRCheck( apr)
{
  if (apr < 30) return 30
  if (apr > 250) return 250
  return apr
}

  // pulserate to Energy Spec bin
  // hz to BPM   60  : sampling rate 50Hz    bin = Trunc (apr * hfftsz / (60 * 25.0))


proc PR2ESB( prx)
{

  int  xbin = prx/dFT60
    //  <<" PR2ESB $prx $xbin  $dF\n"
  return xbin 
}

  // pulse-rate to Cepstral bin     bin = Trunc (50.0/apr * 60)

proc PR2CB( apr)
{
  if (apr <= 0.0) apr = 1

    bin = Trunc (3000.0/apr)
    //<<" $_cproc %V $apr  $bin \n"

    return bin  
}


  // pulserate to Energy Spec bin apr = 25.0/hfftsz * bin  * 60.0

proc ESB2PR( bin)
{
  apr = dFT60 * bin
   return apr
}

// pulse rate O2 derived from energy spectrum 

proc PRESO2( apr)
{
     pint = FineTime()

     napr = PRCheck(apr)

<<" $napr \n"
       //     ebin = PR2ESB( napr)
    
     ebin = Trunc(napr/dFT60)
       // finding local peak appears crucial

       <<" %v $ebin \n"

     ebin = FindLocalPeak(IRenerspec,ebin)

       <<" %v $ebin \n"

     pmO2 = SO2[ebin]

       //     MSO2 = Stats(GSO2[ebin-3:ebin+3])

       ptmp = SO2[ebin-4:ebin+4]

       sz = Caz(ptmp)

              <<" $sz $ebin %v $ptmp \n"

       tmpiv = Sel(ptmp,">",20)

       sz = Caz(tmpiv)

              <<" $sz  %v $tmpiv \n"

       mO2 = pmO2

       if (sz > 3) {

       nptmp = ptmp[tmpiv]

       sz = Caz(nptmp)

              <<" $sz  %v $nptmp \n"

       tmpiv = Sel(nptmp,"<",100)

       sz = Caz(tmpiv)

              <<" $sz  %v $tmpiv \n"
       if (sz > 1) {
       ptmp = nptmp[tmpiv]



       //       nptmp = ptmp[Sel(ptmp,">",20)]
       //       ptmp = nptmp[Sel(nptmp,"<",100)]


       //       MSO2 = Stats(SO2[ebin-3:ebin+3],30,">")
       //       aO2 =  MSO2[6]

       sz = Caz(ptmp)
              <<" $sz  %v $ptmp \n"
       mO2 = median(ptmp)
       }

       }



       //<<"%V $apr $napr $ebin $mO2 $aO2 \n"
       //<<"%V $SO2[ebin-3:ebin+3] \n"
       //<<"%V $tmp \n"
       //       <<" %V  %3.1f $pmO2 $mO2 \n"

      ptsecs = FineTimeSince(pint)  / 1000000.0
	 //<<" Done $_cproc  in $ptsecs\n"

	 //<<" %v $mO2 \n"
     return mO2
}

float Sme = 0.0
float Tme = 0.0
float Tme2 = 0.0
float nTme2 = 0.0
int espw 

proc TDD( twlen)
{
  e1 = twlen -2

  e2 = twlen -1

  //  <<" %V  $e1 $e2 \n"
    // get differences of RED input vec -


  MM = Stats( InRed[0: e1] )

  Tme2 = MM[4]

  nTme2 = Tme2/MM[1]

  Tddr = InRed[0: e1] - InRed[ 1 :e2] 

  // get normalised version

  Rednd = Tddr/ ( InRed[0: e1] + InRed[ 1 :e2] )

    // repeat for IR
  Tddir = (InIR[0: e1] - InIR[ 1 :e2] )

<<" ${Tddir[0:10]} \n"

  IRnd = Tddir / ( InIR[0: e1] + InIR[ 1 :e2] )

  MM = Stats( Tddir)

<<" $MM \n"

   ymax = MM[6]
   ymin = MM[5]  
   ymean = MM[1]   
   ysd = MM[4]

  <<"$nloop TDD %V %6.2f $ymin $ymax $ymean $ysd \n"

  Pks = Peaks(Tddir,(ymax * 0.50))

<<" $Pks \n"

    //  Pks = Peaks(Tddir,(ymean + 2.0*ysd))


    //////////// SpikeDetection ////////////////////


  pkind = Sel(Pks,">",0)
  pksz = Caz(pkind)

  // lets get an ave periodicity from indices of Pks

    PdaRMS = Rms(Tddir)

    SrPdaRMS = Rms(Stddir)

    Tme =  100.0 * SrPdaRMS/PdaRMS

    tdpr = 0.0
    tdpr1 = 0.0

    if (pksz > 2) {

      // ph = pkind[1: (pksz -1) ] - pkind[0: (pksz -2) ]

       ph = pkind[1: pksz -1 ] - pkind[0: pksz -2 ]
			     // actual want the most common interval not mean
       MM = Stats(ph)
       mnp = MM[1]

       //<<" %v $ph \n"

       hs= hist(ph,2,0,200,1)

       // <<" $hs \n"

       hci = hs[0] * 2

       if (hci > 0)
           tdpr1 =  3000.0/hci 

       <<"%v $mnp \n"
	     if (mnp > 0.0)
       tdpr = 3000.0/mnp 
       else
       tdpr = 0.0
	     //<<" $tdpr $tdpr1 \n"
    }

    Tpr = tdpr1

    Stddir = Tddir   
    
  maxspw = 20 //  1/3 of period??
  espw = 20

  if (Tpr > 30.0)
  espw =  50/( Tpr / 60 *2)

<<" %V $Tpr $espw \n"

#{
  if ((espw > 5) && (espw < 30) && (MotionS == 0))
        maxspw = espw
#}

    Spks = Spikes(Stddir,maxspw,200.0)

  if (Graphic) 
      DrawTDD()


    return tdpr1
}


proc StepSignal()
{



  end += step
  wlen = end-start

    if (wlen <= Wlen) {
       Swindow(swin,wlen,"Hanning")
       Cwlen = wlen
      }
    else {
       Swindow(swin,Wlen,"Hanning")
       start += step
     }

  <<" $_cproc %V $start $end $step $wlen $Wlen\n"
}



proc SpikeRemoval(doit)
{

  rithres = 200.0
  rnthres = 2.0

  InRed = Red[ start : end+5]

    //InRed = Red[start : end-1]
    //<<" $InRed[0:16] \n"

  InIR = IR[start : end+5] 

  insz = Caz(InRed)
    //<<" %v $insz \n"

  if (Graphic) 
    DrawInput(vp)

    //  <<" %v $insz \n"
    if (doit && (nloop > 3)) {


  InRed = Red[start-5 : end+5]

  insz = Caz(InRed)

    //<<" %v $insz \n"

  InIR = IR[start-5: end+5] 

    MM = Stats( InIR)
    ymin = MM[5]
    ymax = MM[6]  
    dys = ymax - ymin 
    meanys = MM[1]

      //<<"$nloop prespike %v $ymin $ymax  $dys $meanys\n"

  nrr=ImpulseReject(InRed,2,rithres)

  nirr=ImpulseReject(InIR,2,rithres)

  InRed = InRed[5:fftend+5]

  insz = Caz(InRed)

  InIR = InIR[5:fftend+5]

    MM = Stats( InIR)
    ymin = MM[5]
    ymax = MM[6]  
    dys = ymax - ymin 
    meanys = MM[1]

    <<"$nloop postspike %v $ymin $ymax  $dys $meanys $nrr $nirr\n"

    if (Graphic) 
    DrawInput(srw)

    }
}


proc SmWindow( cwlen)
{

  <<" ${InRed[0:16]} \n"

  wlm1 = cwlen -1

  real = Fgen(Fftsz,0.0,0.0)

  image = real

  sreal = InRed[0:wlm1]

  <<" ${sreal[0:16]} \n"

  simag = InIR[0:wlm1]

   Rdc = Rms(sreal)

   IRdc = Rms(simag)

    MM=Stats(sreal)

    //<<" %v $MM \n"
    Ravedc = MM[1]

    sreal = sreal -MM[1]

  <<" ${sreal[0:16]} \n"

    sreal = Dcfilter(sreal)

  <<" ${sreal[0:16]} \n"

    // FIX - 
    //    real -= MM[1]

//<<" $real[0:16] \n"

    MM=Stats(simag)

//    imag -= MM[1]

   simag = simag - MM[1]

    simag = Dcfilter(simag)

   IRavedc = MM[1]

   sreal *= swin

   simag *= swin 

    //   <<" %V $Rdc  $IRdc $Ravedc $IRavedc \n"

    Rdc = Ravedc
    IRdc = IRavedc

    if (IRdc <=0) IRdc = 1.0
    if (Rdc <=0) Rdc = 1.0


   // preemphasize spec
   //real = swin *  Tddr
   //imag = swin * Tddir

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

#{
      sz= Cab(sreal)
<<" sreal %v $sz \n"
      sz= Cab(real)
<<" real %v $sz \n"
#}
   }

  //    DrawInput(vp)
}


  float rsac
  float irsac

  float RSAC[]
  float IRSAC[]

  float GRSAC[]
  float GIRSAC[]


DODB = 0


float Enerthres = 500000.0
float PwrScale = 1


proc PowerSpec()
     {


   Fft(real,imag,Fftsz)

   // get Copy to perform FFT convolution

   // doing complex input RED in real IR in imag
   // have to decode if we want separate RED and IR spec

   creal  = real
   cimag  =  imag

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


   //   Rlogspec = log10(Rreal[0 : specsz ]) * 10.0
   //   IRlogspec = log10(IRreal[0 : specsz ]) * 10.0

   Rlogspec = log10(Rreal[0 : specsz ]) * 10.0

   IRlogspec = log10(IRreal[0 : specsz ]) * 10.0

<<" after log \n"

   Rpowspec = Rreal[0 : specsz]

   IRpowspec = IRreal[0 : specsz]

   Renerspec = Sqrt(Rpowspec)  

   IRenerspec = Sqrt(IRpowspec)

   // scale these ??
   
  //   powsz = Caz(Rpowspec)

  //   frsz = Caz(FRed)

  //   fplsz = Caz(Fpl)
  // Display

   RSAC= Vsmooth(Renerspec,3) // ?? scale/overflow how many bins to use?

   rsac = Rlogspec[wsc]

   IRSAC = Vsmooth(IRenerspec,3)

<<" %v ${IRSAC[0:16]} \n"

   // use thres anybelow set to thres
   // want only those bands where there are significant peaks

   // should be lowest amp of significant peak
   // should this be amp of tracking peak ??

<<" $RSAC \n"

   Enerthres =  Mean(RSAC)

  fperr = CheckError()
   if (fperr) {
      Enerthes = 10000.0
   }

<<" $Enerthres \n"

   // SET THIS  THRES BASED ON TRACKING !!
   // since in Tapping - tracking peak is typically much lower than main
   Enerthres *= 0.2

   //   KT = Sel(Renerspec,"<",Enerthres)

   KT = Sel(RSAC,"<",Enerthres)

   sz = Caz(KT) 

<<" $sz %v $KT \n"
  
   GRSAC = RSAC
   sz = Caz(RSAC)

 <<" $sz ${GRSAC[0:8]} \n"

   GIRSAC = IRSAC

   sz = Caz(GIRSAC)

 <<" $sz ${GIRSAC[0:8]} \n"

	if (KT[0] != -1) {
         GRSAC[KT] = 2.0
         GIRSAC[KT] = 1.0
        }



   KTI = IGen(120,0,1)

   //   bbin = PR2ESB( Smpr)

   int bbin = Smpr/dFT60

<<" %V $bbin \n"

   int cbin = Fpr/dFT60
 
   int dbin = Spr2/dFT60

   int ebin = Tpr/dFT60

   int fbin = Cpr/dFT60
   
   <<" $bbin $cbin  $dbin\n"
   

   // remove other candidates ??
   rm_other_cands = 0

   if (rm_other_cands) {

   KTY = KTI[bbin-3:bbin+3:1, cbin-3:cbin+3:1, dbin-3:dbin+3:1, ebin-3:ebin+3:1, fbin-3:fbin+3:1]

   //   <<" %v $KTY \n"
   
   KTI = KTI[~KTY]
   
   //   <<" %V $KTI \n"

     GRSAC[KTI] = 2.0

     GIRSAC[KTI] = 1.0

   }

   irsac = IRlogspec[wsc]

 if (Graphic) 
   DrawPowerSpec()

 if (Graphic) 
   DrawLogSpec(1)
					  // IO
     //      nbw =w_data(Bdf,Rpowspec[0:specsz],"float")

<<" exit PowerSpec \n"
     }



int Cpks[]
int csz 
float ceppeak

proc Cepstrum()
 {
   // going to zero pad and expand cepstrum for more resolution 

     tsz = Fftsz

       //tsz = hfftsz // no zero pad for now

     cepreal = Rlogspec[0: specsz] * cswin

       //cepreal = Renerspec[0: specsz] * cswin

       // smooth ??

     cepzp = Fgen(hfftsz,0.0)

     cepreal = cepreal @+ cepzp

     cepimag = Fgen (tsz,0.0)

     Fft(cepreal,cepimag,tsz,1)

     csz = tsz/2

       // only interested in first half

     cepreal = cepreal * cepreal + cepimag * cepimag

       // TRY
       //     cepreal = Sqrt(cepreal)
       //     IRcepreal = IRenerspec[0: specsz] * cswin


     IRcepreal = IRlogspec[0: specsz] * cswin

       // smooth ??

     IRcepreal = IRcepreal @+ cepzp

     cepimag = Fgen (tsz,0.0)

     Fft(IRcepreal,cepimag,tsz,1)

       // only interested in first half

     IRcepreal = IRcepreal * IRcepreal + cepimag * cepimag

       // TRY
       //     IRcepreal = Sqrt(IRcepreal)


       //  scale_factor ??
       //     cepreal *= cepscale
       //    cepreal = cepreal * CepWt 

       //  <<" $cepreal \n"
       //  <<" %v $CepWt \n"
       //     cepreal = cepreal * CepWt 
       //     <<" $cepreal \n"

  if (Graphic) 
     DrawCepstrum(tsz)

 }


float Specthres = 5000.0

float spr2 = 0.0
float spr3 = 0.0

int spp1bin
int spp2bin
int spp3bin

// 30bpm = 0.5HZ    0.5/ sf/Fftsz  = 30bpmbin  nearest 10

int spbstart = Minpulsebin

int spbend = Maxpulsebin   // 330 bpm  bin

int hsb[]
float srir[]
int hsbsz  

proc SpecPulse()
{
  // spectral range to look for pleth peak should be adaptive

  if (nloop >= 2) {

    AdjustSpRange(Spr ,Tpr)

#{
    irsz = Caz(IRenerspec)

    rsz = Caz(Renerspec)

<<" %V $irsz $rsz \n"

#}

    //    RIRenerspec = IRenerspec + Renerspec

    RIRenerspec = IRenerspec 

    //    RIRenerspec /= 2.0

    pkskirt = 5

    Spks = Peaks(RIRenerspec, Specthres)

    pkind = Sel(Spks,">",0)

    Nspks = Caz(pkind)

    // where is max peak in entire allowable range?

    mmi = MinMaxI(RIRenerspec[Minpulsebin:Maxpulsebin])

    // want a harmonic sieve - which are the largest peaks 
    // that are not harmonics of others
    // and number of resulting peaks will also be a motion/artficact measure

    spp1bin = mmi[1]

    //  Smpr = ESB2PR(spp1bin)
    Smpr = dFT60 * spp1bin

    //<<" %V $mmi $Minpulsebin  $Smpr \n"

      // now three peaks in restricted range

    srir = Vsmooth(RIRenerspec,3)

    //    hsb = Hsieve(RIRenerspec,spbstart,spbend,20)

    hsb = Hsieve(srir,Minpulsebin, Maxpulsebin ,10, 2000)

    //    Famp = RIRenerspec[hsb[0]]


    hsbsz = Caz(hsb)

    <<" %v $hsb  \n"

    <<" %v $hsbsz \n"

    spp2bin = 5
    spp3bin = 5

    if (hsbsz >= 1) {
    spp1bin = hsb[0]
    }

    if (hsbsz >= 2) {
    spp2bin = hsb[1]
    }
    
    if (hsbsz >= 3) {
    spp3bin = hsb[2]
    }


    //Track

    Spr = SpecTrack(spp1bin,spp2bin,spp3bin)

     if (Spr < 35) {
   <<"WARNING low pulserate %v $Spr @loop $nloop \n"
       }


    show_track = 1

    if (Graphic) {
    if (show_track) {
    // found

     bbin = PR2ESB( Spr2)
    // other best bet
     PlotVLine(psw,bbin,0,0.4,"yellow")

     bbin = PR2ESB( Spr)
    // best bet
     PlotVLine(psw,bbin,0,0.5,"green")

    }

    W_ShowPixMap(psw)
    }

  }
    // <<" Done SpecPulse \n"
}

float SpecPir

float Pir

float Einband

float IRamp = 1.0
float Ramp = 1.0

float Qos =0

float Mp1 = 0.0
float Mp2 = 0.0
float Mp3 = 0.0


proc SpecPI()
{
  // produce a spectral based PI estimate
  // Rpr is arbitrated pulse-rate
  Pscale = 10.0

  ebin = PR2ESB (Rpr)

  // what is amp of IR pulse component

  ebin = FindLocalPeak(IRenerspec,ebin)

<<" $ebin \n"

  IRamp = IRenerspec[ebin]

<<" $IRamp \n"

  Ramp = Renerspec[ebin]

<<" $Ramp \n"

#{ 
  irdc = IRenerspec[0]
  rdc = Renerspec[0]
#}

  SpecPir = (Ramp/Rdc * 0.0563  + IRamp/IRdc * 0.3103) * Pscale
  
<<" $SpecPir \n"

  lpbin = PR2ESB (40)
  hpbin = PR2ESB (250)

<<" $lpbin $hpbin \n"

  //<<" ${IRenerspec[lpbin:hpbin]} \n"


  Einband = Mean(IRenerspec[lpbin:hpbin])

  SPI[nloop] = log(SpecPir)



  fperr = CheckError()
   <<" $Rpr $ebin %v $SpecPir  $Einband  $fperr\n"

  //  if (fperr != 0)   STOP!
}


proc AdjustSpRange( stpr , tdpr )
{


  if ( (trackt @= "LOST") || (trackt @= "START") ) {
    spbstart = Minpulsebin+2   // bpm bin
    spbend = Maxpulsebin-2   // 330+ bpm  bin
    }
  else {

      float apr
      float bpr

      float cpr

      cpr = stpr


	if ( (cpr < MinPulse) || (cpr > MaxPulse)) {
          apr = MinPulse
          bpr = MaxPulse
          cpr = 70.0
          trackt = "LOST"
             }

      //<<" %v $cpr $apr $bpr \n"

   if ( trackt @= "LOCK" ) {
      apr = cpr * 0.2    
      bpr = cpr * 2.5
   }

   if ( trackt @= "SEARCH" ) {
      apr = cpr * 0.4    
      bpr = cpr * 3.0
   }

   apr = 40.0

   spbstart = PR2ESB(apr)

     // tapping

     if ( ! (mtype @= "W")) {

      bpr = tdpr * 0.7

  <<" tapping limits $mtype %v $tdpr %v $spbstart $spbend  \n" 

     }


   spbend = PR2ESB(bpr)

     // search limits
     //<<" %v $spbstart $spbend  \n"

     // sanity check
     if (spbstart < Minpulsebin) spbstart = Minpulsebin+2
     if (spbend > Maxpulsebin) spbend = Maxpulsebin-2
    
				 if (spbend <= spbstart) {
                    <<" ERROR AdjustSP - resetting search limits $stpr $cpr $apr $bpr  %v $trackt \n"
                                   spbstart = Minpulsebin
                                   spbend = Maxpulsebin
                                 }

  }

  //  <<" %V $trackt $spbstart $spbend \n"
}

proc AdjustCepRange(tdpr)
{



  if ( (trackt @= "LOST") || (trackt @= "START") ) {
  Cepstart = 8  
  Cepend = 101  
    }
  else {

   if ( trackt @= "LOCK" ) {
      apr = Bpr * 0.6    
      bpr = Bpr * 1.8
   }

   if ( trackt @= "SEARCH" ) {
      apr = Bpr * 0.4    
      bpr = Bpr * 2.2
   }

   // Cepstrum low->high in quefrency
   // Cepstrum high->low in frequency


   Cepstart = PR2CB(bpr)

   Cepend = PR2CB(apr)
     // search limits

   if (Cepstart < 8) Cepstart = 8
   if (Cepend > 101) Cepend = 101

		       if (Cepstart > Cepend) {
                         Cepstart = 8
                         Cepend = 101
                        }

  }

  <<" %V $trackt $Cepstart $Cepend \n"
}





// just track two leading

float LastCpr = 60

proc CepTrack(cpr1b, cpr2b)
{
     // which of the Cep candidates tracks best
     // input cepbins



      if (cpr1b <= 0.0)
          cpr1b = 1

      if (cpr2b <= 0.0)
          cpr2b = 1

	    //      if (cpr3b <= 0.0)  cpr3b = 1

  float acpr = 1.0 /(cpr1b/ 50.0) * 60.0

  float bcpr  = 1.0 /(cpr2b/ 50.0) * 60.0

	    //  float ccpr  = 1.0 /(cpr3b/ 50.0) * 60.0

     //<<" %v $Estpr %v $cpr1  %v $cpr2  %v $cpr3  \n"  
   
	    //  <<" %v $Estpr %v $acpr  %v $bcpr  %v $ccpr  \n"  


  // which is closest

      est_pr = (LastCpr + LastSpr)/ 2.0

  if (mtype @= "W") {
     est_pr = Spr
  }


     Cpr = acpr

      //  if close in amp track

      if (Cmax2 > (Cmax1 * 0.9)) {

     dcp1 = Abs(Cpr-est_pr)
	    // weight biggest
     dcp2 = Abs(bcpr-est_pr) * 1.2

     if ((est_pr > 30) && (est_pr < 350)) {

     if ( dcp1 > dcp2)
          Cpr = bcpr
     }

      }

//<<" %v $Cpr $(typeof(Cpr))\n"

  LastCpr = Cpr
  return Cpr
}

float LastSpr = 60.0

float LastS1 = 60.0

float LastS2 = 60.0
float LastS3 = 60.0
float LastS4 = 60.0
float Spv = 1.0
float Smear = 1.0

int  Spchange = 0

proc SpecTrack(pr1b, pr2b, pr3b)

{
     // which of the Spec candidates tracks best
     // input specbins

  //  <<"SpecT %V $pr1b   $pr2b   $pr3b  \n"

  //  float apr = ESB2PR( pr1b)

  apr = dFT60 * pr1b

  bpr  = dFT60 * pr2b
  
  dpr  = dFT60 * pr3b


  //  Spv  = Fabs(apr- LastS1)  +  Fabs(bpr- LastS2)  +  Fabs(dpr- LastS3)  

  hs = Fabs(apr-bpr)

  Spv  = Fabs(apr- LastS1)  +  Fabs(bpr- LastS2)  +  Fabs(dpr -LastS3) +  Fabs( hs -LastS4)

  Spv *= 0.5

  Spvvec[nloop] = Spv

  LastS1 = apr
  LastS2 = bpr
  LastS3 = dpr
  LastS4 = hs


  // which is closest

     Spr = apr

  if (bpr > 30)
     Spr2 = bpr
  else
     Spr2 = apr

  // chose a pr estimate


     est_pr = LastSpr

  if (mtype @= "W") {
    est_pr = Tpr
  }

  if (est_pr < 30.0) {
    // goto biggest
      est_pr = apr
  }


    if (nloop > 2) {

     if (est_pr > 30) {

       if ( Fabs(Spr-est_pr) > Fabs(bpr-est_pr)) {
	 if (bpr > 30.0) {
          Spr = bpr
          Spr2 = apr
         }

     if ( Fabs(Spr-est_pr) > Fabs(dpr-est_pr)) {
       if (dpr > 30.0) {
         Spr = dpr
         Spr2 = bpr
       }
        }
       }
     }

    }

  // pr of max amp spec component

  if (Spr2 < Spr) {
       tmp = Spr2
       Spr2 = Spr
       Spr = tmp
  }


  //<<" %v $Spr \n"

  // <<" %V %3.1f $est_pr $apr  $bpr  $dpr  picked $Spr  \n"  

  // <<" %V %3.1f $Smpr $Spr2 \n"  
     

  dts = Fabs(Spr-LastSpr)
  spc = LastSpr / 100  * 30

  if (dts > spc) {
    // too much start count
      Spchange++
      if (Spchange > 4) {
      LastSpr = Spr
      Spchange = 0
      }
      else {
            Spr = LastSpr
      }
  }
  else {
      LastSpr = Spr
      Spchange = 0
  }

  if (Spr < 30)
      Spr = LastSpr

  //<<" Done SpecTrack \n"
  return Spr
}



int Ncpks = 0
float Cpkthres = 30000.0
float Cpr2 = 0.0
int ecprbin = 0
int Cepstart = 8
int Cepend = 101


float Cepso2 = 0.0
float Cepampsc = 10000000.0
float pkcepreal[]

float Cmax1
float Cmax2


proc CepPulse()
{
   // Extract Cep Peaks
   // Determine Pulse from Cep Peaks
   // and Track

  // weight Cepstrum for decaying cep peak ampl??
  // ? doubling

  //    Cpks = Peaks(cepreal,(ceppeak * 0.25))
  //    Cepend = csz - 5
<<" %v  $nloop \n"

  if (nloop >= 5) {

    int cpr1bin
    int cpr2bin
    int cpr3bin

    AdjustCepRange(Spr)

    dmn = Cab(cepreal)

    //<<" %v $dmn \n"

  <<"%V $Cepstart $Cepend \n"

  cmax = minmax(cepreal[Cepstart:Cepend])

  Cmax1 = cmax[1]

  Cpks = Peaks(cepreal[Cepstart:Cepend], Cpkthres)

  //<<" $Cpks \n"


  pkind = Sel(Cpks,">",0)

  //<<" $pkind \n"
  if (pkind[0] == -1)
  Ncpks = 0
  else
  Ncpks = Caz(pkind)

  ME(Cmax1)

  

      // <<"\n %v $ceppeak %v $Ncpks  $Cepstart $Cepend\n"


     pkcepreal = cepreal

     mmi = MinMaxI(pkcepreal[Cepstart:Cepend])

     cpr1bin = mmi[1]

     // find next best

     pkcepreal[cpr1bin-3:cpr1bin+3] = 0.0

     mmi = MinMaxI(pkcepreal[Cepstart:Cepend])

     cpr2bin = mmi[1]

  cmax = minmax(pkcepreal[Cepstart:Cepend])

  Cmax2 = cmax[1]

 <<" %v $Cmax1 %v $Cmax2 %v  $Ncpks $Cpkthres %v $Cme \n"

       CepTrack(cpr1bin,cpr2bin)

     //     cpr = 1.0 /(cpr1bin/ 25.0) * 60.0

     bbin = PR2CB( Cpr)
            
     <<" %v $bbin  $Cpr\n"

    // Cep O2



     Ceprac = cepreal[bbin]
     Cepirac = IRcepreal[bbin]


       // FIX not ratio but not log sub either

   //      Cepacdc = sqrt((10.0^(Ceprac/Cepampsc)))/ sqrt((10.0^(Cepirac/Cepampsc))) * IRdc/Rdc

<<" %V $Ceprac $Cepirac  \n"

      Cepacdc = (Ceprac/Cepirac) * IRdc/Rdc

<<" %V $IRdc $Rdc \n"

      Cepso2 =  RtoSpo2 (Cepacdc)

    //    <<" $Ceprac $Cepirac %v $Cepacdc  %v $Cepso2\n"
    // Cep reference O2
       //       Ceprac = cepreal[20]
	 //       Cepirac = IRcepreal[20]
	 //      Cepacdc = Ceprac/Cepirac * IRdc/Rdc
    //<<" $Ceprac $Cepirac $Cepacdc \n"
	 //      Cep2so2 =  (-8.5 *  Cepacdc *  Cepacdc) + -14.6 *  Cepacdc + 108.25


     ecprbin = PR2ESB(Cpr)  

    //    <<" $cpr1bin $cpr2bin $Cpr $Cpr2 \n"
       //     W_SetPen(cdw,"green")

    if( CheckError()) {
      //         STOP!
    }


       if (Graphic) {
     PlotVLine(cdw,bbin,0,1,"green")
     PlotVLine(cdw,Cepend,0,0.5,"black")
     PlotVLine(cdw,Cepstart,0,0.5,"black")
     W_ShowPixMap(cdw)
     gsync()
       }
  }

}




int Lcbin = -1
int Ucbin = -1
int stepchange = 0
float CF = 80.0

int FixFilter = 0

proc AdaptFC(pr, force)
 {
   // only do this if pr estimate has changed
   // bandpass filter around target pr
   // pulserate to Hz
   // set_debug("0,"pline")

   if (pr <= MinPulse) return
   if (pr > MaxPulse) return
   if (FixFilter) return

   if ( ! (mtype @= "W") ) return
  
   if (! force) {
		 // if no motion set pr

    dpr =  Abs (last_pr - pr)

    if (dpr < 10) {
     stepchange = 0
     return
    }

    if (dpr > 20) {
         stepchange++
	 //<<" THINKING STEPCHANGE  $stepchange !!  $pr \n"
	 if (stepchange < 3)
                  return 
	 <<" DOING STEPCHANGE !! \n"
    }

   }
   else {
     //<<" FORCING $pr !! \n"
   }

     stepchange = 0

//	 <<" AF around $pr \n"
       if (force == 2) {
          mpr = (CF - pr) /2
	  //<<"ResolveAdapt $CF $mpr $pr \n"
          pr = CF - mpr

       }

   <<" adjusting %V $CF to $pr \n"
  CF = pr


  last_pr = pr;
   // bandwidth should be adaptive to CF

   abw = 5     // typically 10
   hfe = 1  // typically 5

  phz = pr / 60.0

   cbin = Trunc(phz/dF)

     freal = Fgen(Fftsz,0.0,0)

   // which bins - real +ve

     sz  = Caz(freal)
     int a = cbin - abw
     if (a <=0) a = 1

     Lcbin = a

     int b = cbin + abw + hfe

     if (b >= (Fftsz-1)) b= Fftsz -1
     Ucbin = b
// reflect around NYQ

     int c = Fftsz -b
   //<<" $c \n"


     int d = Fftsz -a

//<<" $freal  \n"

//     <<" $pr %V $cbin $a $b $c $d \n"

     freal[a:b] = 1.0

//<<"OK %V $a $b $freal  \n"

     freal[a-1] = 0.5

//<<"OK $freal  \n"

     freal[b+1] = 0.5

//<<"b $freal  \n"

     c = Fftsz -b
     d = Fftsz -a

//<<"%V $c  $d \n"

     freal[ c: d] = 1.0

//<<"%V $c $d $freal  \n"

     freal[c-1] = 0.5

     freal[d+1] = 0.5

   // copy to imag
//<<" $freal  \n"

     fimag = freal
 }

proc FDFilter()
{

    real = creal * freal
    imag = cimag * fimag

       <<" %v ${freal[0:16]} \n"
       <<" %v ${fimag[0:16]} \n"
    //<<" %v $creal[0:5] \n"
    //<<" %v $freal[0:5] \n"
 
  Fft(real,imag,Fftsz,-1)

      <<" Done FDFilter \n"

}


int Lcbin2 = -1
int Ucbin2 = -1
float CF2= 0.0

proc Adapt2FC(pr, force)
 {
   // only do this if pr estimate has changed

   // bandstop filter around potential noise component ?
   // bandpass
   // pulserate to Hz

   if (! force) {

    if (pr <= MinPulse) return
		 // if no motion set pr

    if (pr > MaxPulse) return

    dpr =  Abs (last_2pr - pr)

    if (dpr < 6) {
     return
    }
 }

  last_2pr = pr;
  CF2= pr
  Abw = 20
  hfe = 3
  phz = pr / 60.0

   cbin = Trunc(phz/dF)

     freal2 = Fgen(Fftsz,0.0,0)
   // which bins - real +ve

     int a = cbin - Abw

     if (a <=0) a = 1

     Lcbin2 = a

     int b = cbin + Abw + hfe

     if (b >= (Fftsz-1)) b= Fftsz -1

   //<<" %V $a $b $Abw $hfe $cbin \n"


     Ucbin2 = b
// reflect around NYQ

     int c = Fftsz -b
     int d = Fftsz -a

     freal2[a:b] = 1.0
     freal2[a-1] = 0.5
     freal2[b+1] = 0.5
     freal2[c:d] = 1.0
     freal2[c-1] = 0.5
     freal2[d+1] = 0.5

   //   <<"AF2 $pr %v $cbin %v $a $b $c $d \n"

   //<<"\n %v $Lcbin2  %v $Ucbin2 \n"
   // copy to imag

     fimag2 = freal2
 }


proc FD2Filter()
{

  real = creal * freal2
  imag = cimag * fimag2

  Fft(real,imag,Fftsz,-1)

    //<<" Done $_cproc FD2Filter \n"
}


proc OverlapAdd()
{


  // real is filtered waveform

  //<<"%v $lov[0:10] \n"
  //<<"%v $Fpl[0:10] $(typeof(Fpl))\n"

    Fpl = lov + real[0: hfftend]

      //<<"%v $Fpl[0:10] $(typeof(Fpl))\n"

    lov = real[hfftsz : fftend]

    Firpl = irlov + imag[0: hfftend]

    irlov = imag[ hfftsz : fftend ]

      //    <<" %v $irlov[0:5] \n"
      //    FRed = FRed @+ Fpl
      // Fred @+= Fpl
      // scale


      //<<"%v $Fftsz $(typeof(Fftsz)) \n"

    Fpl /= Fftsz

      //<<"%v $Fpl[0:10] $(typeof(Fpl))\n"

    Firpl /= Fftsz

  if (Graphic) 
    DrawFPleth()

      //<<" Done OverLapAdd \n"
}


proc Over2lapAdd()
{

  // real is filtered waveform
    Fpl2 = lov2 + real[0: hfftend]

    lov2 = real[hfftsz : fftend]

    Firpl2 = irlov2 + imag[0: hfftend]

    irlov2 = imag[ hfftsz : fftend ]


    Fpl2 /= Fftsz
    Firpl2 /= Fftsz
      // test second channel
      //    DrawF2Pleth()
}


float Cme = 0.0

proc ME( cmaxv )

{     

     // motion Estimate
    // number of significant Cepstral Peaks
    // if there are no significant peaks - motion or no pleth
    // no peaks below thres indicates no pleth

     Cme = 95

     if (Ncpks == 0) 
     Cme = 100.0
     elif (Ncpks <= 2) {
        if (cmaxv > Cpkthres) 
        Cme = 90 * Cpkthres/(cmaxv * 1.5)
     }
     elif (Ncpks > 4)
     Cme = 100.0


     // weight me if time and cep & pulse-estimates differ

     MEst[nloop] = Cme

     Tme2 = Tme

     Tme = nTme2 * 1000

     TMEst[nloop] = Tme

     Sme = Spv

     SMEst[nloop] = Sme
    
    if (Graphic) 
     DrawME()

     //<<" Done ME \n"
}


float VVwsp = 0.0

proc spO2()

{
     // use red/Ir to compute regression slope

  // normalised delta
  // red1-red2/ ((red1+red2)/2)

  //  Rres = lfit(Rednd,IRnd)

  //Rednd *= 1000
  //IRnd  *= 1000

    Rres = rpc(IRnd,Rednd)

      //<<" \n WS  %6.4f $Rres \n"

    rval = Rres[0]

   <<" $rval \n"

    o2 =  RtoSpo2(rval)

    CCws[nloop] = Rres[1]
    VVws[nloop] = Rres[4]
    VVwsp = Rres[4]

    return o2
}



float Rdc = 1.0
float IRdc = 1.0
int IRpks[]


// Extract pulse from filtered IR pleth
proc FLpr()
{


    pksz = 0
    flpr = -1
    
      MM = Stats(Firpl)

      ymax = MM[6]  


    IRpks  = Peaks( Firpl ,(ymax * 0.1))
  
     pkind = Sel(IRpks,">",0)

     pksz = Caz(pkind)
     flpr1 = 0.0

<<" $pksz \n"

    if (pksz > 3) {

      //ph = pkind[1:(pksz-1) ] - pkind[0:(pksz-2) ] 

     ph = pkind[1: pksz-1 ] - pkind[0: pksz-2 ] 


       MM = Stats(ph)

       hs= hist(ph,2,0,200,1)
       // <<" $hs \n"
       hci = hs[0] * 2

       if (hci > 0)
           flpr1 =  50.0/hci * 60.0
       //       mnp = MM[1]

       flpr = 50.0/MM[1] * 60.0

       //<<" $pksz  %v $tdpr \n"
    }

    Fpr = flpr1

  W_SetPen(tdw,"green")
  V_Draw(tdw,IRpks,1.0)
  W_ShowPixMap(tdw)

    return flpr1
}


//float Rac = 0.0

Rac = 0.0

IRac = 0.0

//<<" %v  $Rac $(typeof(Rac))\n"

float VVtcp = 0.0


proc fpspO2()
{

  // Fftsz ??
  twlen = hfftsz

  twl2 = twlen - 2
  twl1 = twlen - 1

  scale_nd = 100000.0

  fpro2 = 90.0

    //<<"fpspO2 1 \n"

  fpRednd = (Fpl[0:twl2]-Fpl[1:twl1]) / (InRed[0: twl2 ]+ InRed[ 1 :twl1 ])

  fpRednd *= scale_nd

    //  sz = Caz(fpRednd)

   <<" ${fpRednd[0:5]} \n"

   MM= Stats(fpRednd)
   ymin = MM[5]
   ymax = MM[6]  
   scale = ymax - ymin

    //  <<" %v $ymax %v $ymin  %v $scale ${fpRednd[0]}\n"
    //sz = Caz(Firpl)
    //  <<" $sz \n"
    //  <<" %v ${Firpl[0:10]} \n"


  fpIRnd = (Firpl[0:twl2]-Firpl[1:twl1])/ (InIR[0:twl2]+InIR[1: twl1])

  fpIRnd *= scale_nd

  if (Graphic) {
  W_SetPen(rrw,"blue")

  W_SetRS(rrw,ymin,ymin,ymax,ymax)

  VV_Draw(rrw,fpRednd,fpIRnd)

  W_ShowPixMap(rrw)
  }


 // Rres = lfit(fpIRnd,fpRednd)

  Rres = rpc(fpIRnd,fpRednd)

  <<" \n FP%v %6.4f $Rres \n"

  rval = Rres[0]
  <<" $rval \n"

  fpro2 =  RtoSpo2(rval)

  <<" %v $fpro2 %v $rval \n"

    //  <<"\n acdcO2%v $racdc $acdcO2 \n"

    CCtc[nloop] = Rres[1]

    VVtc[nloop] = Rres[4]
    VVtcp = Rres[4]

  return fpro2
}


float Sacdc[]
float SO2[]
float LPSO2[]

float GSO2[]
float lgacr = 0.0

float acdcO2

float Racdc = 1.0

proc ACDCspO2()

{
 
  pint = FineTime()

   float racdc = 1.0

   Rac = Rms(Fpl)

   IRac = Rms(Firpl)


 //   <<" %v $Rac %v $IRac \n"
    racdc = 1.0

   if (Rdc > 0.0 && IRac > 0.0) {
     Racdc = (Rac/Rdc) * IRdc/IRac
     //<<" %V $Rac $Rdc $IRdc $IRac   $Racdc\n"
   }


     acdcO2 = RtoSpo2(Racdc)


 //   <<" $acdcO2 \n"

 if (irsac != 0.0) {

   sacdc = (rsac/Rdc) * IRdc/irsac

   lso2 = RtoSpo2( sacdc)
   //   <<" %V $rsac $irsac  $sacdc $lso2\n"
 }
 else
    lso2 = 0.0


   Sacdc = (RSAC/Rdc) * IRdc/IRSAC

   //   <<" $Sacdc[0:30] \n"

   SO2 =  (-8.5 * Sacdc * Sacdc) + -14.6 * Sacdc + 108.25

   //<<" $SO2[5:30] \n"

   lRdc = log10(Rdc*Rdc) * 10

   lIRdc = log10(IRdc*IRdc) * 10

   //   Sacdc = (Rlogspec/Rdc) * IRdc/IRlogspec

   //   Sacdc = (Exp(Rlogspec-IRlogspec)) * IRdc/Rdc

   Sacdc = Rlogspec/IRlogspec * IRdc/Rdc

   //   Sacdc = (Rlogspec-lRdc) * (lIRdc-IRlogspec)

   LPSO2 =  (-8.5 * Sacdc * Sacdc) + -14.6 * Sacdc + 108.25

   // adjust

    //   LPSO2 = (LPSO2 -100) * 3 + 105

   //   LPSO2 = Exp(LPSO2 * 2.3)

   Sacdc = (GRSAC/Rdc) * IRdc/GIRSAC

   GSO2 =  (-8.5 * Sacdc * Sacdc) + -14.6 * Sacdc + 108.25

   so2 =  (-8.5 * sacdc * sacdc) + -14.6 * sacdc + 108.25


   Cep2so2 = SO2[ecprbin]
   
   //   <<"SpecO2  $so2 ${SO2[wsc]} \n"
     //   <<"SpecO2  $so2 $SO2 \n"

   ptsecs = FineTimeSince(pint)  / 1000000.0
  //<<" Done $_cproc  in $ptsecs\n"

}

float ac2dcO2 = 95

proc AC2DCspO2()
{

   Rac = Rms(Fpl2)

   IRac = Rms(Firpl2)

   racdc = (Rac/Rdc) * IRdc/IRac

  ac2dcO2 = RtoSpo2(racdc)
}



proc UpdatePRE ( pr , wt)

{
// also time of each estimate
  if (wt < 5) return

  if (nprec < NPRE) {
          Ptrack[nprec][0] = pr
          Ptrack[nprec][1] = wt
          Ptrack[nprec][2] = nsecs

          nprec++
          if (wt >= 10) {

	    :j = nprec

	    while (j < NPRE) {
	      //<<" $_cproc %v $j < $NPRE  \n"
                  Ptrack[j][0] = pr
                  Ptrack[j][1] = wt
                  Ptrack[j][2] = nsecs
                  j++

	    }
          }
  }
  else {
    //  <<" RotatingRow  $Ptrack \n" 

          Ptrack = RotateRow(Ptrack,-1)

          Ptrack[NPRE-1][0] = pr
          Ptrack[NPRE-1][1] = wt
          Ptrack[NPRE-1][2] = nsecs

	    //  <<" $Ptrack \n"
  }
}

float Py[]
float Px[]

float NPy[]
float NPx[]

proc GetPRE ()

{
     // get best pulse estimate based on recent history
  // lets use only those of 5 > wt

  Py = Ptrack[*][0]
  Px = Ptrack[*][2]
    //<<"%v $Py \n"
    //<<"%v  $Px \n"

    NPx = Fgen(10,nsecs-5,1)
    NPy = NPx * 0.0
    MM = Stats(Ptrack[*][0])

  c_spline(Px,Py,NPx,NPy)

  cs_pre = NPy[7]
  pre = MM[1]
 
 if (Graphic) 
  DrawPRE()

    // only use spline predictor - if close to ave
    if (cs_pre > 30.0 && cs_pre < 300) {
      dacs = Fabs(pre-cs_pre)
      if (dacs < 10) {
	//      <<" $Ptrack \n"
	//<<" %V $pre $cs_pre \n"
       pre = cs_pre
      }
    }

  return pre
}


float lgpr = 0.0

float WMotion = 15.0
float SMotion = 28.0

mtype ="W"
int MotionS = 0
trackt = "START"
mcode = 0
tcode = 0
resolveC = "OK"
last_siglock = 0
prev_siglock = 0

float Rpr = 0.0


proc MotionState()
{

  if (Sme >= 100.0) {
      MotionS = 3
      return "S"
  }

  if (Tme >= 50.0) {
      MotionS = 3
      return "S"
  }


  if (Tme < 10.0) {
      MotionS = 0
      return "W"
  }

  if (Cme >= 100.0) {
      MotionS = 3
      return "S"
  }


  dm = DMso2[nloop]
  dov = DOb1[nloop]

  dotm = 0
  domtv = 10 * dov

  if ( (dm > 2.0) && (dm > domtv) ) {
       dotm = 1
  }

  // <<" DiffO2Tracks $dm $do $domtv $dotm \n"



 <<" $nloop $dotm DiffO2Tracks  %4.1f $dm   $dov   $msO2 $Ob1  Spv $Spv  $Tme2  %6.4f $nTme2\n"

  if ( dotm) {
      MotionS = 3
      // <<" DiffO2Tracks MOTION \n"

  if (Tme < 20.0) {
      MotionS = 1
      return "M"
  }

      return "S"
  }


  if (Spv > SjThres) {
      MotionS = 2

  if (Tme < 20.0) {
      MotionS = 1
      return "M"
  }
      return "S"
  }


  if (Tme >= 25.0) {
      MotionS = 2
      return "S"
  }

  // need to wt and combine these measures mainly using Tme (SD of pleth) now

  if (Cme < 70.0) {
      MotionS = 0
      return "W"
  }

      MotionS = 1
      return "M"
}


proc SetTcode()
{

            tcode = 0
<<" %v $trackt \n"
           if (trackt @= "SEARCH")
               tcode = 1
	       else if (trackt @= "LOCK")
               tcode = 2
	       else if (trackt @= "LOST")
               tcode = 0
               else
               tcode = 0

}


int Slc = 0

int lgacr_cnt = 0

proc WeakMotion()
{

          mcode = 1
          trackt = "SEARCH"

	  apr = (Spr - Cpr)
          apr1 = (Tpr - Cpr)

          chk_cnt = lgacr_cnt
          lgacr_cnt = 0  //  reset 


       if (Einband > 1000.0) { // this thres TBD

  	      lgacr_cnt = chk_cnt + 1 // incr if all tests are passed

	      GoodAC[nloop] = 1.0
              
              if (lgacr_cnt >= 3) {

              lgacr= Ramp/IRamp 
	      //              lgacr = Rac/IRac 
              prev_siglock = last_siglock
              last_siglock = nsecs
              Siglock[nloop] = 4.0
		//<<"%v $Slc $VVtcp $VVwsp siglock $last_siglock \n"

              }

       }


  
          if ( Abs(apr) < 5 || Abs(apr1) < 5) {

	    if (Abs(apr) < Abs(apr1)) {
   	     apr = (Spr + Cpr)/2
	    }
	    else {
	      apr = (Tpr + Cpr) /2
            }

	    //	  apr = (Spr + Cpr)/2

	  apr = Spr 

          AdaptFC(apr,0)

          UpdatePRE(apr,10.0)

          lgpr = apr

          trackt = "LOCK"

	  //<<" SIGNAL LOCK  !!  $apr \n"
	  //          lgacr = Rac/IRac
	  //<<"Weak motion cep_spec corresponds  $apr \n"
	  }

	  else {

          AdaptFC(Spr,0)

          UpdatePRE(Spr,8.0)
          }
}


proc ModerateMotion()
{
          lgacr_cnt = 0  //  reset 

          mcode = 2

//<<" MODERATE motion $Ncpks $me $lgpr spec2 $spr2 $ds2  $spr3 $ds3\n"
//AdaptFC(Spr,0)

        if (Rpr != CF) {
          resolveC = "RESOLVE"
	  //<<" Resolving via O2 from $CF to $Rpr \n"
    // this should nudge tracking channel in right direction

#{
         if (nloop < 10)
          AdaptFC(Rpr,2)

#}

	  if (trackt @= "LOST")
          AdaptFC(Rpr,2)
          else
          AdaptFC(Rpr,0)

        }
       
          if ( Abs(Fpr - Spr) < 15) {
                apr = (Spr + Fpr)/2
	        AdaptFC(apr,0)
                UpdatePRE(apr,7)

		  //                lgacr = Rac/IRac 
		  //                last_siglock = nsecs

                trackt = "LOCK"
           }


}


proc StrongMotion()
{
          lgacr_cnt = 0  //  reset 

          mtype ="S"

          mcode = 3

	if (Abs(Spr -Cpr) < 30) {

                apr = (Spr + Cpr)/2
            
           if ( Abs(Fpr - apr) < 20) {
                apr = (apr + Fpr)/2
	        AdaptFC(apr,0)
                UpdatePRE(apr,6)

		//                lgacr = Rac/IRac 
		//                last_siglock = nsecs

                trackt = "LOCK"

	   }
           else {

	        AdaptFC(apr,0)
                UpdatePRE(apr,5)
		//                lgacr = Rac/IRac 
		//                last_siglock = nsecs
                trackt = "SEARCH"

	   }

	}
        elif (Fpr >= 30) {
          UpdatePRE(Fpr,2.0)
                trackt = "LOST"
        }


}

proc Arbiter()
{       

mtype ="W"

resolveC = "OK"

        GoodAC[nloop] = 0.0
        Siglock[nloop] = 0.0

        mtype = MotionState()

        MeS[nloop] = MotionS

        Rpr = ResolveO2()

        if (mtype @= "W" ) {

          WeakMotion()

        }
        elif ( mtype @= "M") {

              ModerateMotion()
        }
        else {

              StrongMotion()
        }

//<<" Arbiter $nloop Motion $mtype %4.1f \t$me $lgpr  $pr $Spr $Cpr $Fpr  \n"

     // reference channel

//        Adapt2FC(pr,0)

     // want to plot each channels O2 with also mean spec O2
     // which track is more consistent

       SetTcode()


}




float Dcso2 = 0.0
float Dc1so2
float Dc2so2


proc DCtrk()
{
  // use the last good ac ratio
    dcr= 1.0 * IRdc/Rdc  // force fixed
  Dc1so2=  RtoSpo2(dcr) 
    dcr= 2.0 * IRdc/Rdc  // force fixed
  Dc2so2=   RtoSpo2(dcr)

  dcr= lgacr * IRdc/Rdc

  Dcso2=   RtoSpo2(dcr)
    //    <<"DCT %v $lgacr   $Dcso2 $IRdc $Rdc\n"


}

proc CompareO2()
{
  pint = FineTime()

  if (nloop > 5) {
    int a = nloop-5
    int b = nloop-1
      cv = Mso2[a:b]
    dista = sdm(Acdco2[a:b],cv)
    distf = sdm(FPo2[a:b],cv)
    distt = sdm(TDo2[a:b],cv)
      //<<" $nloop  $distt $dista $distf \n"

  }

   ptsecs = FineTimeSince(pint)  / 1000000.0



}

DoResolve = 1

proc ResolveO2()
{

  if (!DoResolve) return Fpr

    ro2pr = 0.0

      // should also look at O2 for max energy spec peak
      // and other contenders

  //    dc1 =  PRESO2( Spr) - msO2

    ro2_b =  PRESO2( Spr)


    dc1 = ro2_b -msO2

  // dc2 =  PRESO2( Smpr) - msO2

 ro2_a =  PRESO2( Smpr) 

 dc2 = ro2_a - msO2



  // average over last n readings ?

  // use DCTO2 or OOBO2 if value available 
  // resolved peak should be closest to the DC or OOB measure

     ro2pr = Smpr

  if (Spr > 20) {

  if (msO2 > 85.0) {

   if (dc1 > dc2)
        ro2pr = Spr
   else
        ro2pr = Smpr
  }
  else {

   if (dc1 > dc2)
        ro2pr = Smpr
   else
        ro2pr = Spr

  }

  }


  // if same O2 or close content chose lowest - since probably using harmonic

  do2 = abs (ro2_a - ro2_b)

  if (do2 < 1.0) {
    if (Smpr > Spr)
          ro2pr = Spr
    else
          ro2pr = Smpr
  }


  //<<"\n resolve %V %3.1f $dc1 $dc2 $msO2  $Spr  $Smpr $ro2pr \n"
  //<<" $Fpr $Smpr $Spr $Spr2 $Cpr $Tpr $ro2pr \n"



     return ro2pr
}

# End 
