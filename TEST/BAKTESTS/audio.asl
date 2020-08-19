//%*********************************************** 
//*  @script audio.asl 
//* 
//*  @comment test ALSA  API
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                  
//*  @date Sun Mar 31 09:14:48 2019 
//*  @cdate Sun Mar 31 09:14:48 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%

include "debug.asl"
debugON()
setdebug(1,@pline);


///
///  demo asl interface to alsa API -- play and record
///
/{
/*
     open_the_device();
      set_the_parameters_of_the_device();
      while (!done) {
           // one or both of these 
           receive_audio_data_from_the_device();
	   deliver_audio_data_to_the_device();
      }
      close_the_device()

*/
/}
// openAudio();
ok=getsignalspace(500)
<<"get Sbuf $ok\n"

int handle =0;

// rc=sndopen(&handle,"sysdefault:CARD=AUDIO");

////////////////////  OPEN DEVICE ////////////////////////////////
 rc=sndopen(&handle,"sysdefault:CARD=PCH");


<<"%V $rc $handle\n"

/{/*
//  Allocate a hardware parameters object. */
//  snd_pcm_hw_params_alloca(&params);
//
//  Fill it in with default values. 
//  snd_pcm_hw_params_any(handle, params);
/}*/

  ret=sndallochwparams();

<<"allochw$ret \n"


 srate = 16000;
 
 ret = sndsetsrate(srate);

<<"sndsetsrate  $ret $srate\n"
frames = 32;
ret = sndsetframes(frames);

<<"sndsetframes  $ret $frames\n"

setchannels =0;
if (setchannels) {
nchan = 1;

 ret = sndsetchannels(nchan);

<<"setchannels  $ret $nchan\n"
}


rc = sndwrthwparams  ();

<<"sndWrtHwParams $rc\n"


 ret = sndclose();

<<"setclose  $ret \n"


