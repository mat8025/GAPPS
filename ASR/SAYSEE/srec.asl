// test record of vox  files

OpenDll("audio","image")

proc usage()
{

 <<"srec  [OPTIONS] file \n"
 <<" -f int  ---- freq default 16000 Hz \n"
 <<" -l real  ---- how long secs     \n"
    STOP("\n")
}


int Freq  = 16000

int smic_factor = 0x5a5a


float Sfactor = 1.0

how_long = 3.0

vox_file = "a.vox"

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


// get/open dsp

   dspfd = dspopen("/dev/dsp1") // could be dsp0 or dsp?
 
// get/open  mixer

   mixfd = mixeropen("/dev/mixer1")

// set dsp,mixer

<<"%V $dspfd $mixfd \n"

   getSoundParams(dspfd,mixfd);

   RecordFile(vox_file,dspfd,mixfd,how_long, Freq, 1,smic_factor)

   getSoundParams(dspfd,mixfd);

// release devices

   close(dspfd)

   close(mixfd)


STOP("DONE \n")


