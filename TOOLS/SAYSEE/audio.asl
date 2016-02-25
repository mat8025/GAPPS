// audio.asl


proc openAudio()
{
///////////////////////////  DSP AUDIO device SETUP ////////////////////////////// 

// get open dsp

   dspfd = dspopen()

// get open  mixer

   mixfd = mixeropen()

// set dsp,mixer

<<"%V$dspfd $mixfd \n"

   ok = setSoundParams(dspfd,mixfd) 

   Gain = 1.0
}

proc closeAudio()
{
 if (dspfd != -1)
   close(dspfd)
 if (mixfd != -1)
   close(mixfd)
}




proc playBuff(wb, st, fi)
{

<<"play $dspfd $wb $st $fi \n"

   playBuffer(dspfd, wb, st, fi)

}



proc playSection( )
{
// play a section of the buffer
// play time between cursors in voxwo

     GV = glineGetValues(co_gl)
     GV1 = glineGetValues(co1_gl)

     ps_tx1 = GV[0]
     ps_tx2 = GV1[0]
     
     int s1 = ps_tx1 * Freq

     int s2 = ps_tx2 * Freq  

     displayComment("play $ps_tx1 $ps_tx2 $s1 $s2 \n")

     playBuff(sbn, s1, s2)

//   setGline(co1_gl,@cursor,tx1,y0,tx1,y1)
// FIX   setGline(co1_gl,@cursor,tx+3,y0,tx+3,y1)  // arg not parsed

}

proc playBCtas( )
{
// play a section of the buffer
// play time between cursors in tas 

     GV = glineGetValues(co2_gl)
     GV1 = glineGetValues(co3_gl)

     ps_tx1 = GV[0]
     ps_tx2 = GV1[0]
     
     int s1 = ps_tx1 * Freq

     int s2 = ps_tx2 * Freq  

     displayComment("play $ps_tx1 $ps_tx2 $s1 $s2 \n")

     playBuff(sbn, s1, s2)

}


//////////////////

