/* 
 *  @script audio.asl                                                   
 * 
 *  @comment procs for audio play/record                                                   
 *  @release Beryllium                                                  
 *  @vers 1.6 C Carbon [asl 6.4.65 C-Be-Tb]                             
 *  @date 08/27/2022 20:35:52                                           
 *  @cdate 1/1/2000                                                     
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2022 -->                               
 * 
 */ 
;//----------------<v_&_v>-------------------------//;                  

///////////////////////////  DSP AUDIO device SETUP ////////////////////////////// 


float Gain = 1.0
int mixfd = -1
int dspfd = -1
int Freq  = 16000; // default

void openAudio()
{
<<"opening audio !\n"
// get open dsp

// find out which host and which dsp/mixer devices are present !

    dspfd = dspopen("/dev/dsp") // correct for mercury
    if (dspfd == -1) {
     dspfd = dspopen("/dev/dsp1") // correct for mars
    }
   <<"%V $dspfd \n"
// look for sound devices
// get open  mixer
    mixfd = mixeropen("/dev/mixer")
   if (mixfd == -1) {
    mixfd = mixeropen("/dev/mixer1")
   }

// set dsp,mixer

//<<"%V$dspfd $mixfd \n"
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
void closeAudio()
{
 if (dspfd != -1)
   close(dspfd)
 if (mixfd != -1)
   close(mixfd)
}
//=======================================

int smic_factor = 0x3a3a // ? alters mic gain via mixer device /dev/mixer1

void do_record()
{

  openAudio()
 
  if (dspfd != -1) {

     setRecordParams(dspfd,mixfd, SampFreq,1, smic_factor)

     recordAudioBuffer(dspfd, sbn, 0, 15 * SampFreq )
     // 15 seconds worth into beginning of buffer YS

  closeAudio()
  }

}
//--------------------------------------------------

void playBuff(int wb, int st, int fi)
{
<<"In $_proc \n"
<<"play $dspfd $wb $st $fi \n"
openAudio();
  playBuffer(dspfd, wb, st, fi)
closeAudio();
<<"Done $_proc \n"
}
//---------------------------------------------

void playBCtas( )
{
//<<"In $_proc  \n"
// play a section of the buffer
// play time between cursors in tas 
//int s1;
//int s2;

     GV = glineGetValues(co2_gl);
     GV1 = glineGetValues(co3_gl);

     ps_tx1 = GV[0];
     ps_tx2 = GV1[0];
     
     int s1 = ps_tx1 * Freq;
     int s2 = ps_tx2 * Freq;

     <<"play section  %V$ps_tx1 $ps_tx2 $s1 $s2 \n"

     displayComment("play $ps_tx1 $ps_tx2 $s1 $s2 \n");

     playBuff(sbn, s1, s2)

//<<"Done $_proc \n"
}
//---------------------------------------------
float  samp2time(int ns)
{
  float t; 
  t =ns/ Sf;
<<"%V$t \n"
 // float t = ns/ Sf
  return t;

}
//=======================================

void playSection( )
{
<<"In $_proc  \n"
//int s1;
//int s2;
// play a section of the buffer
// play time between cursors in voxwo

     GV = glineGetValues(co_gl);
     GV1 = glineGetValues(co1_gl);

     ps_tx1 = GV[0];
     ps_tx2 = GV1[0];
     
     int s1 = ps_tx1 * Freq;
     int s2 = ps_tx2 * Freq;

// s1 = ps_tx1 * Freq
// s2 = ps_tx2 * Freq  

     <<"%V $s1 $s2 \n"
     
     displayComment("play $ps_tx1 $ps_tx2 $s1 $s2 \n")

     playBuff(sbn, s1, s2);

//   sGl(co1_gl,@cursor,tx1,y0,tx1,y1)
// FIX   sGl(co1_gl,@cursor,tx+3,y0,tx+3,y1)  // arg not parsed
//<<"Done $_proc \n"
}
//===============================================================


void getVoxTime()
{


}

//====================================================