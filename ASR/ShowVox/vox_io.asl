///
/// upe_io



Tim = FineTime();


vox_type = 'vox\|pcm\|phn' ; // regex for vox or pcm

vox_dir= "/asr/barn/ASR/FL/spanish/fjm"; // no trailing spaces for chdir to work
vox_file =  "";

proc get_the_file ()
{

 fname = naviwindow("Vox/pcm Files ", " Search for vox/pcm files ", \
                      "a.vox", vox_type, vox_dir);

 timit_file = scut(fname,-4);
// sig_file =  scat (timit_file,".vox");
 sig_file =  scat (timit_file,".pcm");
 vox_file =  scat (timit_file,".vox");
 ok = fstat(sig_file,"size") ; // read 

<<"%V$timit_file  $sig_file $ok \n"

// vox_dir should be updated
  if (ok) {
    vox_dir = spat(sig_file,"/",0,-1);
  }


  return ok;
}
//=======================================================


int Nbufpts; // number of sample points in the signal buffer
float tX;




proc read_the_signal()
{
<<"%V$sig_file \n"
              Nbufpts = readsignal(Sbn, sig_file)
              tX = Nbufpts/Sfreq;

}
//============================

proc new_file()
{
	go_on=get_the_file ()
            if (go_on) {

                read_the_signal()
  
<<"%V $Sbn $tX  \n"
                //success= read_the_signal(0,0,1)
		
		get_data_files()
                //show_sg()
		//show_rms()
		//do_pt(lw)
		read_the_labels();
		<<"calling Pitch $spp_file\n"
		computePitch();
		computeZxRms();
             }
        return go_on;
}
//====================================================


proc update_files()
{
	    if (Transcribe_type @= "UPE") {
		write_timit_labels(timit_gp,upe_file,timit_file)
                  }
	    if (Transcribe_type @= "WORD") {
		write_timit_labels(timit_w,wrd_file,timit_file)
                }
}


proc write_tokens()
{
   if (Transcribe ) {
	    
	    if (Transcribe_type @= "UPE") {
                write_labels(timit_gp,guplab_file,timit_file)
		write_timit_labels(timit_gp,upe_file,timit_file)
             }
	    if (Transcribe_type @= "WORD") {
		write_timit_labels(timit_w,wrd_file,timit_file)
             }
    }
}
//===========================================



proc get_data_files()
{
sg_file = scat(timit_file,".sg")
rms_file = scat(timit_file,".rms")
//spp_file= scat(timit_file,".spp")
}
//===============================================



Gain = 1.0
int mixfd = -1
int dspfd = -1

proc openAudio()
{

// get open dsp
 if ((dspfd != -1) &&  (mixfd != -1)) {
      //<<"audio already open\n";
      return;
 }

 <<"opening audio \n";
// find out which host and which dsp/mixer devices are present !
 hn = !!"hostname"

        dsp_good = 0;

        dspfd = dspopen("/dev/dsp1");
        if (dspfd != -1) {
         if (mixfd == -1) {
          mixfd = mixeropen("/dev/mixer1") 
         if (mixfd != -1) {
	 <<"using dsp1 mixer1\n"
           dsp_good = 1;
         }
         }

        }

    if (!dsp_good) {

        dspfd = dspopen("/dev/dsp2");
        if (dspfd != -1) {
         if (mixfd == -1) {
          mixfd = mixeropen("/dev/mixer2") 
         if (mixfd != -1) {
           dsp_good = 1;
	   	 <<"using dsp2 mixer2\n"
         }
         }
    }
    }
    
    if (!dsp_good) {

        dspfd = dspopen("/dev/dsp3");
        if (dspfd != -1) {
         if (mixfd == -1) {
          mixfd = mixeropen("/dev/mixer3") 
         if (mixfd != -1) {
	 <<"using dsp3 mixer3\n"
           dsp_good = 1;
         }
         }
    }
   }

// look for sound devices
// get open  mixer
// set dsp,mixer


<<"%V$dspfd $mixfd \n"

   if (dspfd == -1) {
    <<"Error opening /dev/dsp?\n"
    <<" may need to load sound modules -- sudo modprobe snd-pcm-oss \n"
    <<" check with ls /dev/dsp*  and retry if /dev/dsp* is listed\n"
   }
   
   if (mixfd == -1) {
    <<"Error opening /dev/mixer?\n"
   }



   ok = setSoundParams(dspfd,mixfd) 

   Gain = 1.0;
}
//=======================================
proc closeAudio()
{
 if (dspfd != -1) {
   close(dspfd)
 }
   dspfd = -1;
 if (mixfd != -1) {
   close(mixfd)
 }
   mixfd = -1;
}
//=======================================
