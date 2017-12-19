// test record of vox  files

//OpenDll("audio")
include "audio";

setdebug(1);

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

<<"%V $Dspfd $Mixfd \n"

   getSoundParams(Dspfd,Mixfd);

<<"RECORD Now!\n"

RecordFile(vox_file,Dspfd,Mixfd,how_long, Freq, 1,smic_factor);

   getSoundParams(Dspfd,Mixfd);

// release devices

   closeAudio()


STOP("RECORDING COMPLETE to $vox_file \n")


