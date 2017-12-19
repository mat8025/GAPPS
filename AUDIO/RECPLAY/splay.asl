// play vox or pcm files

SetDebug(1);

include "audio";

proc usage()
{

<<" splay [OPTIONS] file \n"

<<" -f int  ---- freq default 16000 Hz \n"
<<" -g real  ---- gain default 1.0  \n"
<<" -l duration in seconds\n"
<<" -c number of chans 1 mono 2 stereo  3,4 \n"
<<" -s start time seconds in file\n"

    STOP("\n")
}
// test play of vox and wav files

//OpenDll("audio")


nchans = 1;



  openAudio();



<<"%V $_df_errno \n"

int Freq  = 16000; // default

float Sfactor = 1.0;

gain = 1.0;

vlen = -1.0;
fstart = 0.0;
bstart = 0.0;



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
    elif (opt @= "-l") {
     vlen = getArgF(ka)
     <<" setting max length  \n"
     }
    elif (opt @= "-c") {
     nchans = getArgI(ka)
     <<" setting %V$nchans  \n"
     }     
    elif (opt @= "-s") {
     fstart = getArgF(ka)
     <<" setting file start time  \n"
     }          
    else {

      fname = opt
<<" setting %V$fname \n"
    }
    }
    //<<" %V$ka \n"

     if (ka > na )
       break


    }

// which files



<<" play file is $fname \n"

      bytesize = fstat(fname,"size")
      <<"%V$bytesize \n"  // maybe just the header
/////////////////////////////////////////////////////////////////////

// is it vox header - if so
// get Freq channel info etc
// and use to set/ override defaults

<<"%V $Dspfd $Mixfd \n";

   getSoundParams(Dspfd,Mixfd);


  if (Dspfd != -1) {
  ok = setSoundParams(Dspfd,Mixfd,Freq,nchans); 
  }
  else {

<<"WARNING!!!  sound play not setup correctly!!\n";
  }

// set dsp,mixer


<<" $gain $nchans \n"

//iread()
////////////// READ FILE INTO BUFFER   ///////////////////////////

 int sbn = -1

// create an audio buffer
  sbn = createSignalBuffer()

<<"%V$fname $sbn \n"

  nds = readsignal(sbn,fname,vlen,fstart,bstart);

<<"%V $sbn $nds \n"

  npts = nds
  //npts = 4095;
  // find range of signal
  // just copy buffer back out so we can process it
  // we will add builtin processing later

 B = getSignalFromBuffer(sbn,0,npts)

 svec = Stats(B)

<<"mean %V6.4f$svec[1] min $svec[5] max $svec[6] \n"

 mm= minmax(B)

<<"%(16,, ,\n)$B[0:20] \n"

//<<"%(16,, ,\n)$B[16000:48000] \n"

<<"%V$npts $mm \n"
// set up sound params

  ok = setSoundParams(Dspfd,Mixfd,Freq,nchans) 

<<"%V$Freq $nchans \n"
//iread()
   if (vlen > 0) {
       npts = vlen * Freq;
   }
  <<"playBuffer %V$npts\n"

  playBuffer(Dspfd, sbn, 0, npts, 1);

//ans =iread();
///////////////////////////////////////////////////////

// play the file
// why not play the buffer???



   // play all of it
   //
   nwords = bytesize/2;
   nwords = -1;

   if (vlen > 0) {
       nwords = vlen * Freq;
   }


//  <<"playFile %V$nwords\n"
//   PlayFile(fname,dspfd,mixfd, nwords, Freq, gain, nchans)

//iread()
// try this again - with proper  settings ?

//  playBuffer(dspfd, sbn, 0, n, 1);
// release devices

   sleep(1)

   getSoundParams(Dspfd,Mixfd);

<<"%V $Dspfd $Mixfd \n"

   fflush(1)

   closeAudio()

<<"%V $_df_errno \n"

  STOP!


/////////////// TBD //////

// stereo - left/right volume
// effects - 
