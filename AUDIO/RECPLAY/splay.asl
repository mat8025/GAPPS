/* 
 *  @script splay.asl                                                   
 * 
 *  @comment vox play                                                   
 *  @release Beryllium                                                  
 *  @vers 1.6 C Carbon [asl 6.4.65 C-Be-Tb]                             
 *  @date 08/27/2022 20:35:52                                           
 *  @cdate 1/1/2000                                                     
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2022 -->                               
 * 
 */ 
;//----------------<v_&_v>-------------------------//;                  

// play vox or pcm files

SetDebug(1);

#include "audio";

void usage()
{

<<" splay [OPTIONS] file \n"

<<" -f int  ---- freq default 16000 Hz \n"
<<" -g real  ---- gain default 1.0  \n"
<<" -l duration in seconds\n"
<<" -c number of chans 1 mono 2 stereo  3,4 \n"
<<" -s start time seconds in file\n"

    exit(-1);
}
// test play of vox and wav files


int nchans = 1;



  openAudio();



<<"%V $_df_errno \n"



float Sfactor = 1.0;

Gain = 1.0;

float vlen = -1.0;
float fstart = 0.0;
float bstart = 0.0;



  na = argc()
<<" %V$na \n"


  if (na <=1 )
    usage()

  // OPTIONS
  ka = 1;

  Str fname = ""

    while (1) {

    opt = getArgStr(ka)

    ka++

    <<"$ka %V$opt \n"
    if (!(opt @= "")) {
    
    if (opt @= "-f") {

        Freq = getArgI(ka++)

    <<"$ka setting %V$Freq  \n"
    }
    elif (opt @= "-h") {
      <<" $opt usage \n"
      usage()
    }
    elif (opt @= "-g") {
     Gain = getArgF(ka++)
     <<" setting gain $Gain  \n"
     }
    elif (opt @= "-l") {
     vlen = getArgF(ka++)
     <<" setting max length $vlen \n"
     }
    elif (opt @= "-c") {
     nchans = getArgI(ka++)
     <<" setting %V$nchans  \n"
     }     
    elif (opt @= "-s") {
     fstart = getArgF(ka++)
     <<" setting file start time  \n"
     }          
    else {
      fname = opt
<<" setting %V$fname \n"
    }

  }
    //<<" %V$ka \n"

     if (ka >= na )
       break


    }

// which files

<<"$_clarg \n"

<<" play file is $fname \n"


      bytesize = fstat(fname,"size")
      <<"%V$bytesize \n"  // maybe just the header
/////////////////////////////////////////////////////////////////////

// is it vox header - if so
// get Freq channel info etc
// and use to set/ override defaults

<<"%V $dspfd $mixfd \n";

   getSoundParams(dspfd,mixfd);


  if (dspfd != -1) {
  ok = setSoundParams(dspfd,mixfd,Freq,nchans); 
  }
  else {

<<"WARNING!!!  sound play not setup correctly!!\n";
<<"Error opening /dev/dsp?\n"
<<" may need to load sound modules -- sudo modprobe snd-pcm-oss \n"
<<" check with ls /dev/dsp*  and retry if /dev/dsp* is listed\n"
   exit(-1)
  }

// set dsp,mixer


<<" $Gain $nchans \n"

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

 B = getSignalFromBuffer(sbn,0,npts);

 svec = Stats(B);

<<"mean %V6.4f$svec[1] min $svec[5] max $svec[6] \n"

 mm= minmax(B);

//<<" $B[0:20] \n"  ;  // TBF pexpnd arrayexpand??

//<<"%(16,, ,\n)$B[0:20] \n"

//<<"%(16,, ,\n)$B[16000:48000] \n"

<<"%V$npts $mm \n"
// set up sound params

  ok = setSoundParams(dspfd,mixfd,Freq,nchans) 

<<"%V$Freq $nchans \n"
//iread()
   if (vlen > 0) {
       npts = vlen * Freq;
   }
  <<"playBuffer %V$npts\n"

  playBuffer(dspfd, sbn, 0, npts, 1);

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

   sleep(1);

   getSoundParams(dspfd,mixfd);

<<"%V $dspfd $mixfd \n"

   fflush(1);

   closeAudio();

<<"%V $_df_errno \n"


/////////////// TBD //////

// stereo - left/right volume
// effects - 
