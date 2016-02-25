// play vox or pcm files


proc usage()
{

<<" splay [OPTIONS] file \n"

<<" -f int  ---- freq default 16000 Hz \n"
<<" -g real  ---- gain default 1.0  \n"

    STOP("\n")

}

// test play of vox and wav files
SetDebug(0)


OpenDll("audio","image")

int Freq  = 16000

float Sfactor = 1.0

gain = 1.0

  na = GetArgc()
<<" %V$na \n"



  if (na <=1 )
    usage()

  // OPTIONS
  ka = 1

  fname = ""

    while (1) {

    opt = GetArgStr(ka)

    ka++

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
    elif (opt @= "-g") {
     gain = getArgF(ka)
     <<" setting gain $gain  \n"
     }
    else {

      fname = opt
<<" setting %V$sf \n"
    }
    }
    //<<" %V$ka \n"

     if (ka > na )
       break


    }

// which files




<<" play file is $sf \n"

bytesize = fstat(fname,"size")
<<"%V$bytesize \n"

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

 svec = Stats(B)

<<"mean %V6.4f$svec[1] min $svec[5] max $svec[6] \n"

 mm= minmax(B)

<<"%(16,, ,\n)$B[0:32] \n"
<<"%V$mm \n"

///////////////////////////////////////////////////////



// is it vox header - if so
// get Freq channel info etc
// and use to set/ override defaults
   nchans = 1

// get/open dsp

   dspfd = dspopen("/dev/dsp1")

   if (dspfd == -1) {
<<"ERROR can't open dsp device - exiting!\n"
   exit()
   }

// get/open  mixer

   mixfd = mixeropen()

   getSoundParams(dspfd,mixfd);

// set dsp,mixer

<<"%V $dspfd $mixfd \n"
<<" $gain $nchans \n"
// play the file

   PlayFile(fname,dspfd,mixfd, bytesize/2, Freq, gain, nchans)

// release devices
   sleep(5)


   getSoundParams(dspfd,mixfd);

   fflush(1)

   close(dspfd)
   close(mixfd)



  STOP!


/////////////// TBD //////

// stereo - left/right volume
// effects - 
