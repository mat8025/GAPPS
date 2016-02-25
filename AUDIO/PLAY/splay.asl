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


      //  while (AnotherArg(ka) ) {

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

      sf = opt
<<" setting %V$sf \n"
    }
    }
    //<<" %V$ka \n"

     if (ka > na )
       break


    }

// which files




<<" play file is $sf \n"

bytesize = fstat(sf,"size")
<<"%v $bytesize \n"


  A= ofr(sf)

<<" %v $A \n"


// is it vox header - if so
// get Freq channel info etc
// and use to set/ override defaults
nchans = 1

// get/open dsp

   dspfd = dspopen()

// get/open  mixer

   mixfd = mixeropen()

// set dsp,mixer

<<"%V $dspfd $mixfd \n"
<<" $gain $nchans \n"
// play the file

   PlayFile(sf,dspfd,mixfd, bytesize/2, Freq, gain, nchans)

// release devices


   fflush(1)

   close(dspfd)
   close(mixfd)



  STOP!


/////////////// TBD //////

// stereo - left/right volume
// effects - 
