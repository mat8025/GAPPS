// test record of vox  files

//OpenDll("audio")
include "audio";
proc usage()
{

 <<"srec  [OPTIONS] file \n"
 <<" -f int  ---- freq default 16000 Hz \n"
 <<" -l real  ---- how long secs     \n"

}


int Freq  = 16000;

int smic_factor = 0x5a5a;


float Sfactor = 1.0;

how_long = 5.0

vox_file = "rec.vox"

  // parse OPTIONS
  na = GetArgc()
<<"%V$na \n"

  if (na <=1 )    usage()

// OPTIONS
<<"%V$_clarg \n"
ka = 0

      while (AnotherArg()) {

	opt = GetArgStr()

<<"%V$ka $opt \n"

      if (opt @= "-f") {
         Freq = GetArgI()
       <<" setting %V$Freq  \n"
       }

      elif (opt @= "-a") {
         smic_factor = GetArgN()
       <<" setting %Vx$smic_factor  \n"
       }


     elif (opt @= "-l") {
 
      how_long = GetArgF()
    <<" setting %V$how_long \n"
     }
     else {
      vox_file = opt
     }
     ka++
   }


// which files


<<" setting record time $how_long \n"

// is it vox header - if so
// get Freq channel info etc
// and use to set/ override defaults

 openAudio();
/{
// get/open dsp
   dspfd = dspopen("/dev/dsp") // correct for mercury
    if (dspfd == -1) {
     dspfd = dspopen("/dev/dsp1") // correct for mars
    }

  if (dspfd == -1) {
    <<"Error opening /dev/dsp?\n"
    <<" may need to load sound modules -- sudo modprobe snd-pcm-oss \n"
    <<" check with ls /dev/dsp*  and retry if /dev/dsp* is listed\n"
    exit()
   }

// look for sound devices
// get open  mixer

   mixfd = mixeropen("/dev/mixer")
   if (mixfd == -1) {
    mixfd = mixeropen("/dev/mixer1")
   }
// set dsp,mixer


/}
<<"%V $Dspfd $Mixfd \n"




   getSoundParams(Dspfd,Mixfd);

<<"RECORD Now!\n"
   RecordFile(vox_file,Dspfd,Mixfd,how_long, Freq, 1,smic_factor);

   getSoundParams(Dspfd,Mixfd);

// release devices

   close(Dspfd)

   close(Mixfd)


STOP("RECORDING COMPLETE to $vox_file \n")


