#! /usr/local/GASP/bin/asl
#/* -*- c -*- */
# "$Id: pulse.g,v 1.1 2003/06/25 07:08:30 mark Exp mark $"

    //SetDebug(0,"pline")
SetDebug(-1)
    CheckMemory(0)


     OPenDll("uac")
     OPenDll("math")
    //     OPenDll("dsp") - FIX no crash when open wrong lib

 int start = 0
 int end = 0
 nloop = 0

 int nsecs = 0

 Graphic = CheckGwm()

<<" %v $Graphic \n"


uint ELT[5]

FineTime(ELT)

proc Status()
{

  sigstrength = last_siglock -nsecs + 20  // spec window length

  tcy  = 1.6
  tcx  = 5
  tcyd =  0.42

    //  tmsg = "$nloop %5.0f $elt secs"

    //   <<" $tmsg \n"

  lsecs = FineTimeSince(ELT,1) / 1000000.0


 <<"$nloop %3.1f $elt $Bpr $Bo2 %f %v $SpecPir %v $Einband %s $trackt $resolveC %3.1f $lsecs $pcc\n"

  if (!Graphic) 
          return lsecs

 <<" doing Graphic $Graphic \n"

  tcy -= tcyd

  tcy -= tcyd

  tcy -= tcyd

      // positive if last spectrum identifies pleth fundamental

  tcy -= tcyd

  tcy -= tcyd

  tcy -= tcyd


                    wo_set(tdprwo,"value","%3.1f $Tpr")
		    wo_set(sprwo,"value","%3.1f $Spr")
		    wo_set(spr2wo,"value","%3.1f $Spr2")
                    wo_set(cprwo,"value","%3.1f $Cpr")
                    wo_set(fprwo,"value","%3.1f $Fpr")
		    wo_set(prwo,"value","%3.1f $Bpr")



		    wo_set(o2wo,"value","%3.1f $O2")
		    wo_set(spec2wo,"value","%3.1f $Spr2O2")
		    wo_set(specwo,"value","%3.1f $SprO2")
		    wo_set(fpo2wo,"value","%3.1f $fpO2")
		    wo_set(acdcwo,"value","%3.1f $acdcO2")
		    wo_set(bo2wo,"value","%3.1f $Bo2")
		    wo_set(dco2wo,"value","%3.1f $Dcso2")
		    wo_set(mno2wo,"value","%3.1f $msO2")
		    wo_set(obtwo,"value","%3.1f $Obtv")


                    wo_set(timewo,"value","%g$elt")
		    wo_set(cmewo,"value","%3.1f$Cme")
                    wo_set(tmewo,"value","%3.1f$Tme")
                    wo_set(smewo,"value","%3.1f$Sme")
                    wo_set(aveewo,"value","%3.1f$Einband")
                    wo_set(spiwo,"value","%5.3f$SpecPir")
                    wo_set(cfwo,"value","%3.1f$CF")
                    wo_set(sswo,"value","$trackt")
                    wo_set(mswo,"value","$mtype")
                    wo_set(gacwo,"value","$lgacr_cnt")


     return lsecs
}


proc  SetLoopPars()
      {

<<" $_cproc \n"

     Epr[nloop] = Estpr 

     FLTpr[nloop] = FLpr() 

     TDpr[nloop] = pr

     Ceppr[nloop] = Cpr

     Specpr[nloop] = Spr

     TDo2[nloop] = O2

     FPo2[nloop] = fpO2
 
     Acdco2[nloop] = acdcO2

     Ac2dco2[nloop] = ac2dcO2

     // use SO2 or GSO2
     // these bins are Fftsz dependent

     MSO2 = Stats(SO2[Minpulsebin:Maxpulsebin])

     msO2 = MSO2[1]

     msO2v = MSO2[3]

      //<<" $msO2 $msO2v \n"

     Mso2[nloop] = msO2

     DMso2[nloop] = Fabs( msO2 - Lastmso2)

     Lastmso2 = msO2

     //use LPSO2 instead of SO2

}

Main_init =1
lib = "/usr/local/GASP/GASP-3.2.0/LIB"

include "$lib/tools"

include "$lib/wo"

include "$lib/module_debug"

include "pulseScreen"

include "pulseIO"

include "pulseDraw"

include "pulseCompute"
Main_init =0

     SetNameDebug("PROC_ENTRY",-1)

 ResizeFFT()

//   GLOBAL VECTORS
 float Red[]
 float IR[]
 float Tddr[]
 float Tddir[]
 float Stddir[]
 float Tdsr[]
 float Tdsir[]
 float Rednd[]
 float FRed[]
 float IRnd[]
 float fpRednd[] 
 float fpirdd[]
 float fpirds[]

 float NRed[]
 float NIR[]

 float InRed[]
 float InIR[]



 float IRNscale = 1.0
 float RedNscale = 1.0
 float IRscale = 1.0
 float Redscale = 1.0


  float lov[]
  float irlov[]
  float Fpl[10+]
  float Firpl[10+]
  
// second channel

  float freal2[]
  float fimag2[]

  float lov2[]
  float irlov2[]
  float Fpl2[]
  float Firpl2[]


  float TDpr[]
  float BestPR[5+]
  float TDo2[]

  float FPo2[5+]
  float Acdco2[5+]
  float Mso2[5+]
  float DMso2[5+]
  float DOb1[5+]
  float BestO2[5+]

  float Spvvec[5+]

  float Lastmso2 = 90
  float LastOb1 = 90
  float LastObt = 90
// factor to 'fit' Ob1 values to SpO2 track

  float Dcffm = 3.0
  float Dcffa = -10.0 


// Oxygen Bands

  float Obt
  float Ob0
  float Ob1
  float Ob2
  float Ob3
  float Ob4
  float Ob5
  float Ob6


  float M0so2[50+]

  float M1so2[50+]
  float M2so2[50+]
  float M3so2[50+]
  float M4so2[50+]
  float M5so2[50+]
  float M6so2[50+]


  float Epso2[50+]
  float Ep2so2[50+]
  float Ep3so2[50+]

  float SACDC[2+][512]

  float Ac2dco2[50+]

  float DCso2[50+]

  float Specpr[]

  float FLTpr[]
  float Ceppr[]

  float Epr[]

  float Eso2[]

  float Estpr = 70
  float Cpso2[50+]

  float SprO2v[50+]

//
  float Siglock[]
  float GoodAC[]
  float gac

  float MeS[50+]


//  Motion/Noise Measures
  float MEst[]
  float TMEst[]
  float SMEst[]
  float CCws[]  // red/ir correlation whole signal
  float CCtc[] // red/ir correlation  tracking channel
  float VVws[]  // red/ir correlation whole signal
  float VVtc[] // red/ir correlation  tracking channel
  float VVnc[] // red/ir correlation  noise/comparison channel


// PI Measures

  float SPI[]


// GLOBAL PARAMETERS

 float BBpr = 0.0
 float Tpr = 0.0
 float Spr = 0.0
 float Cpr = 0.0
 float Fpr = 0.0
 float Bpr = 0.0

 float Smpr = 0.0
 float Spr2 = 0.0

 float O2 = 0.0
 float fpO2 = 0.0
 float SmprO2 = 0.0  // max peak
 float Spr2O2  // alternate candidate
 float SprO2   // choice
 float Bo2 = 0.0
 float msO2 = 0.0

  FRed = Fgen(hfftsz,0,0)
  IR = Fgen(20,0,1)

  TDpr = Fgen(5,0,0)
  TDo2 = Fgen(5,0,0)

  FLTpr = Fgen(5,0,0)
  
  lov[0:hfftend] = 0.0
  Fpl[0:hfftend] = 0.0

//<<" %v $Fpl \n"

  irlov[0:hfftend] = 0.0
  Firpl[0:hfftend] = 0.0

//<<" %v $Firpl \n"

  fimag[0:fftend] = 0.0
  freal[0:fftend] = 0.0

// second channel

  lov2[0:hfftend] = 0.0
  Fpl2[0:hfftend] = 0.0

  irlov2[0:hfftend] = 0.0
  Firpl2[0:hfftend] = 0.0

  fimag2[0:fftend] = 0.0
  freal2[0:fftend] = 0.0
  f2lcb = fftend/2
  fimag2[f2lcb:fftend] = 1.0
  freal2[f2lcb:fftend] = 1.0


float bpm = 90.0  // initial guess

  int start_secs = 0
  int stop_secs = -1

  noisef="nf"

     //<<" $CepWt \n"

 // CHECK GRAPHIC DISPLAY

  set_nloop = 0

// DEFAULT ARGS

  fname = $2

<<" %v $fname $(typeof(fname)) \n"

  fix_wlen = 0
  make_signal = 0
  add_noise = 0
  RIRscale = 0

  Noisepts = 0
  do_rmspike = 1
  int  trackchannel2 = 0

  FixFilter = 0 // freeze filter for test
  Setfixfilter = 0
  DoResolve = 1 //   default use Resolve

  ltsecs = 0

// PARSE ARGS

  DoKeyBoardPause = 0

 narg = argc()
 ac = 3
 wo2 =""

cwd = GetDir() 

<<" PARSING ARGS \n"

 while (ac <= narg) {

      wo2 = $ac
 
      //   <<" PARSING ARGS $ac  $wo2\n"

      if (wo2 @= "simulate") {
  make_signal = 1
  // use saw-tooth
       }

           if (wo2 @="fftsize") {
                 ac++
                 Fftsz = $ac
                 ResizeFFT()
	   }

           if (wo2 @="wlen") {
                 ac++
                 Wlen = $ac
                 fix_wlen = 1
	   }


           if (wo2 @="normalize") {
                 normalize = 1
           }

           if (wo2 @="noresolve") {
                  DoResolve = 0
           }

           if (wo2 @="fixfilter") {
                 Setfixfilter = 1
           }

           if (wo2 @="spiker") {
                 ac++
                 argonoff = $ac
                 if (argonoff @="ON")
                 do_rmspike =1 
                 else
                 do_rmspike =0
           }


            if (wo2 @= "step") {
              DoKeyBoardPause = 1
	      //<<" %v $DoKeyBoardPause \n"
            }


  if (wo2 @= "bpm") {
  ac++
  bpm = $ac
  }

     if (scmp(wo2,"nloop",5)) {
     ac++
     set_nloop = $ac
    }

      //<<" checking for start arg $wo2 \n"

           if (wo2 @= "start") {

	     //<<" FOUND Setting StartSecs to $wo2 \n"

           ac++
           start_secs = $ac


           }

      //<<" checking for stop arg $wo2 \n"

           if (wo2 @="stop") {
	     <<" FOUND Setting stop_secs to $wo2 \n"
           ac++
           stop_secs = $ac
           }


           if (wo2 @="noise") {
           ac++
           noisef = $ac
           add_noise = 1
           }



           if (wo2 @="irs") {
           ac++
           IRscale = $ac
           RIRscale =1
           }

           if (wo2 @="reds") {
           ac++
           Redscale = $ac
           RIRscale =1
           }


           if (wo2 @="redns") {
           ac++
           RedNscale = $ac
           }

           if (wo2 @="irns") {
           ac++
           IRNscale = $ac
           }

 ac++

 }


///////////////////////////////////////

// setup arrays dependent of fftsz
  float cswin[hfftsz]
  float swin[Wlen]

/////////////////////////

  cepimag[0:hfftend] = 0.0
  cepreal[0:hfftend] = 0.0


<<" start $start_secs stop $stop_secs \n"



  if (make_signal) {

     // start heart rate at 40
	// secs
     maxpts = set_nloop * 50

     SigInject(maxpts,bpm)

     }

 else {

     <<" Reading $fname \n"

    maxpts = ReadPulseFile(fname)

    if (maxpts <= 10) {
       <<" ERROR too few pts \n"
           stop!
       }

 }

<<" %v $set_nloop \n"

<<" %v $dF\n"

  if (RIRscale) {
        ScaleRIR()
  }


  if (add_noise) {
    // for length of input signal add in NRed and NIR
      AddNoiseF()
  }


// insert intial zero pad of 5 secs
 
#{
   <<" $Red[0:15] \n"


   Red = Fgen(256,0,0) @+ Red

   <<" $Red[0:15] \n"


   IR = Fgen(256,0,0) @+ IR

   <<" $IR[0:15] \n"

#}




// Using Hanning smoothing window - for smooth dB spec prior producing cepstrum

  Swindow(cswin,hfftsz,"Hanning")

  sz = Caz(swin)

  <<" Hanning %v $sz  %v $Wlen %v $Fftsz\n"

  dmn = Cab(swin)
     // <<" $dmn \n"

//<<" $swin \n"

     // now select Red and IR data from input vector
     // -------------------

  MM= Stats(Red)
  ymin = MM[5]
  ymax = MM[6]

 <<" %v $ymin $ymax \n"

  MMIR= Stats(IR)

  yirmin = MMIR[5]
  yirmax = MMIR[6]

   if (yirmin < ymin) {
      ymin = yirmin
      <<" yirmin < ymin \n"
      }


 if (yirmax > ymax)
    ymax = yirmax

 <<" $ymin $ymax \n"

    ymin = yirmin

 float Rir[]

  step = hfftsz // step should be hfftsz for overlap  to work properly !!
                //  half wlen?

 //step = hfftsz/2


   specsz = hfftsz -1



 if (Graphic) {

    SetUpWin()

    <<" %v $o2sw \n"

    ClearWindows()
  }


   InitPars()


     //  AdaptFC(130.0,1)
     //  Adapt2FC(120.0,1)

     // initial start

  AdaptFC(bpm,1)

  Adapt2FC(140.0,1)


     // Run as Fixed ?
     // allow tracking - slow/fast
     if (Setfixfilter)
     FixFilter = 1;


  //MemWatch("AdaptFC")

   nloop = 0

   start = Trunc (start_secs * 50)
     end = start  // initial

   pcc = end/maxpts * 100.0


// Using Hanning smoothing window
// initial set up of Hanning
   StepSignal()

   mblks = CountMemBlocks()
   lmblks = mblks

     // one cycle of pulse
     // 60 bpm is 1Hz is 50 samples at 50Hz sampling rate

<<" start mainloop $end $maxpts $step\n"

   step_hr = 0.5
     // Signal Flow

   InitPRE()

     //  w_file(Pdf,"# nloop elt CF Tpr Smpr Spr2 Spr Cpr Fpr Rpr Bpr \n")

     //  w_file(Odf,"# nloop elt RO2 SmprO2 Spr2O2 SprO2 fpO2 acdcO2 msO2 Dcso2 Co2 Bo2 Ob1 Ob2 Ob3 Ob4 Ob5 Obt  Rdc IRdc\n")

     //  w_file(Mdf,"# nloop mcode tcode elt Cme  Spir VVtcp VVwsp Gac Einband Tme \n")


  <<" SE %V $start $end \n"


   while (end < maxpts) {

      pcc = end/maxpts * 100.0

      SpikeRemoval(do_rmspike)

      //MemWatch("SpikeRemoval")

       if (Graphic) {    
           ConfigScreen()
       }

      // get an estimate
      if (nloop > 10)
      Estpr = GetPRE()
      else
      Estpr = Spr

      pr = TDD(Cwlen)

     //MemWatch("TDD")

      O2 = spO2()
  
   // Hanning Smooth

     SmWindow(Cwlen)

     //MemWatch("SmWindow")

     PowerSpec()

     //MemWatch("PowerSpec")

   // Find Harmonic Spacing

   // Amp of Red/IR  for AC info


     Cepstrum()

     //MemWatch("Cepstrum")

     CepPulse()

     //MemWatch("CepPulse")

     SpecPulse()

     //MemWatch("SpecPulse")

    // IFFT to TD

     FDFilter()


     OverlapAdd()

    // spo2

     fpO2 = fpspO2()

     if ( trackchannel2) {

      // second channel

     FD2Filter()

     Over2lapAdd()

     AC2DCspO2()

       }

     ACDCspO2()

     DrawO2Spec()

     //MemWatch("ME")
     pint = FineTime()

      SetLoopPars()

     ptsecs = FineTimeSince(pint)  / 1000000.0

      <<" 1 Updated Arrays in $ptsecs\n"


      // bins 5 30 - 20- 90 bpm
     MSO2 = Stats(LPSO2[10:20])

     Ob1 = MSO2[1]

     M1so2[nloop] = Ob1

     DOb1[nloop] = Fabs( Ob1 - LastOb1)

     Obt = LastObt + (Ob1 -LastOb1) * Dcffm

     Obtv = Obt + Dcffa

     M0so2[nloop] = Obtv

     LastObt = Obt

      //     <<" OBT %v $Ob1 %v $LastOb1 %v $Dcffm %v $Obt \n"

     LastOb1 = Ob1

     MSO2 = Stats(LPSO2[21:40])

     Ob2 = MSO2[1]
     M2so2[nloop] = Ob2

      // fixed acratio's

     Ob3 = 1.0 *  IRdc/Rdc
     Ob3 = RtoSpo2( Ob3)
     M3so2[nloop] = Ob3

     Ob4 = 2.0 *  IRdc/Rdc
     Ob4 = RtoSpo2( Ob4)
   
     M4so2[nloop] = Ob4


     Ob5 = Rdc * .000004
     M5so2[nloop] = Ob5

       ptsecs = FineTimeSince(pint)  / 1000000.0

     <<" 2 Updated Arrays in $ptsecs\n"

      //<<" %V %3.2f $Obt $Ob1 $Ob2 $Ob3 $Ob4 $Ob5 \n"

     //     MSO2 = Stats(SO2[250:500])
      //     MSO2 = Stats(LPSO2[250:500])
      //     Ob6 = MSO2[1]
      //     M6so2[nloop] = Ob6


     //////////////

     SprO2 = PRESO2( Spr)

<<" %v $SprO2 \n"

     //MemWatch("PRESO2_Spr")

     Epso2[nloop] = SprO2

     Spr2O2 = PRESO2( Spr2)

     SmprO2 = PRESO2( Smpr)

     Ep2so2[nloop] = SmprO2

     Eso2[nloop] = PRESO2( Estpr)

     Cpso2[nloop] =  PRESO2( Cpr)

     SprO2v[nloop] =  SprO2

     SACDC[nloop][*] = SO2

      //<<" \n $SACDC \n"

     ptsecs = FineTimeSince(pint)  / 1000000.0

     <<" Updated Arrays in $ptsecs\n"
 
     CompareO2()

     Arbiter()

     //MemWatch("Arbiter")

     SpecPI()          

     DCtrk()

     //MemWatch("SpikePI")

     Bpr = PickBestPulse()

     Bo2 = PickBestSPO2()


     DCso2[nloop] = Dcso2

     //MemWatch("PickBest")

     BestPR[nloop] =  Bpr

     BestO2[nloop] =  Bo2
   

   if (  Graphic ) {
         DrawPoxPars()
    }

  
   StepSignal()

   gac = GoodAC[nloop]

   nloop++

   <<" $nloop  > $set_nloop \n"

   if (set_nloop && (nloop > set_nloop)) break


     //   msize = MemSize()

      elt = end/50.0   // initial 1/2 windowlength before start process

 // <<" $nloop\t%4.2f $pr $Cpr $Fpr $O2 $fpO2 $acdcO2 %7.3f ${IRnd[0]} ${Rednd[0]} %4.1f $Cme $elt \r"

     nsecs = Trunc(elt)

      // <<" $nloop\t %V %5.0f $elt $CF $pr $Cpr $Fpr $O2 $fpO2 $acdcO2 $Cme $mtype \n"
//MemWatch("PreStatus")

      howlong = Status()

<<" $howlong \n"

      rts = (nsecs - ltsecs) /howlong

      ltsecs = nsecs

//MemWatch("Status")

      // keep this in same form as Sattrend oxd output

    w_file(Oxd,"%4.2f $elt $BBpr $Tpr $Cpr $Spr $Smpr $Spr2 $Fpr $Bpr $Rpr $CF $Spv $Smear $Cme $tcode ")
   w_file(Oxd," %4.1f $Qos $Tme $Sme $Cme $SmprO2 $Spr2O2 $SprO2 $Cepso2 $acdcO2  $Dcso2 $msO2 $Bo2 $Pir $SpecPir $Rdc $IRdc $mcode\n") 

       BannerParams(nloop)

      if ((stop_secs > 0) && (nsecs > stop_secs)) {

<<" $nsecs > $stop_secs -- breaking loop ! \n"

                break
      }


      if (DoKeyBoardPause) {

        aks = ttyin("press key for next loop")
      }


   mblks = CountMemBlocks()

   dmb = (mblks - lmblks)

    <<" %v $nloop %v $dmb %v $mblks loopspeed $howlong   $rts\n\n"

   lmblks = mblks

   <<" %v $nloop $nsecs $stop_secs\r"

   }

  
   stop_secs = nsecs

   CloseIO()

   SaveWindows()

<<" \n Pulse Tracking Complete \n"


 if (! Graphic) 
     STOP!

   // loop and redisplay 

  Redisplay()


  DisplayLoop()


STOP!

