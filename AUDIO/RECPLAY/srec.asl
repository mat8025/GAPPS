//%*********************************************** 
//*  @script srec.asl 
//* 
//*  @comment vox record 
//*  @release CARBON 
//*  @vers 1.5 B Boron                                                     
//*  @date Mon Mar 25 11:08:22 2019 
//*  @cdate 1/1/2000 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
// test record of vox  files
/*
#include "debug.asl";


  debugON();
  setdebug(1,@keep,@~pline,@~trace);
  FilterFileDebug(REJECT_,"~storetype_e");
  FilterFuncDebug(REJECT_,"~ArraySpecs",);
*/
#include "audio";


void usage()
{

 <<"srec  [OPTIONS]  to_file [default rec.vox]\n"
 <<" -f int   [sampling frequency      default 16000 Hz]\n"
 <<" -l real  how long secs [default 5 secs] \n"

}



float Sfactor = 1.0;

float how_long = 5.0;

Str vox_file = "rec.vox";

  // parse OPTIONS
  na = argc();
<<"%V$na \n"

  if (na <=1 )    usage();

// OPTIONS
<<"%V$_clarg \n";
 ka = 0;

      while (AnotherArg()) {

	opt = getArgStr()

<<"%V$ka $opt \n"

      if (opt @= "-f") {
         Freq = GetArgI()
       <<" setting %V$Freq  \n"
         ka++
       }

      elif (opt @= "-a") {
         smic_factor = GetArgN()
       <<" setting %Vx$smic_factor  \n"
          ka++
      }


     elif (opt @= "-l") {
 
      how_long = GetArgF()
    <<" setting %V$how_long \n"
      ka++
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

<<"%V $dspfd $mixfd \n"

   S=getSoundParams(dspfd,mixfd);
<<"pre: $S\n"
<<"RECORD Now!\n"

   RecordFile(vox_file,dspfd,mixfd,how_long, Freq, 1,smic_factor);

   R=getSoundParams(dspfd,mixfd);
<<"after: $R\n"
// release devices

   closeAudio()


<<"RECORDING COMPLETE to $vox_file \n"

exit()

/*

//   mic gain not working ?? - clipping


*/

