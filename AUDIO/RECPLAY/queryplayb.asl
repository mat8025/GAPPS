//  read a file into an audio buffer and play
//  loop -- ask for start and end times and play section of buffer
//  check for quit siqnals to stop play

setdebug(0)

OpenDll("audio","image")

//fn = "ec1.0-9.vox"
fn = _clarg[1]

// does it exist
 fds = f_exist (fn)
<<"$fn $fds \n"

if (fds == -1) {

<<" file does not exist !\n"
 stop!
}




proc playBuff(wb, st, fi)
{
   playBuffer(dspfd, wb, st, fi)
}


<<"%V$fn \n"
// create an audio buffer

 sbn = createSignalBuffer()

<<"%V$sbn \n"

// read file into buffer

  ds = readsignal(sbn,fn)

<<"%V $sbn $ds \n"

// check freq set ??

   int Freq  = 16000


// setup DSP device 

// get/open dsp

   dspfd = dspopen()

<<"%V$dspfd \n"

// get/open  mixer

   mixfd = mixeropen()

<<"%V$mixfd \n"

// set dsp,mixer

<<"%V$dspfd $mixfd \n"


   ok = setSoundParams(dspfd,mixfd) 


// play buffer

   Gain = 1.0


   playBuffer(dspfd, sbn, 0, ds/8, Gain)


   sleep(2)


   int s1 = 16000
   int s2 = 64000


   playBuff(sbn, s1, s2)

   float t1 = 0
   float t2 = ((1.0*ds)/Freq)
   yn="y"

   while (1) {

    ans = iread(" play buffer y/n [${yn}]? ") 

    if (!  (ans @= "")) { 
        yn = ans
    }
    if (yn @= "n") { 
       break
    }

    t_ans = iread(" start time [${t1}] ") 
      if ( ! (t_ans @= "")) {
          t1 = atof(t_ans)
      } 

    t_ans = iread(" finish time [%4.2f${t2}] ") 
      if ( ! (t_ans @= "")) {
          t2 = atof(t_ans)
      } 


    s1 = t1 * Freq
    s2 = t2 * Freq

    playBuff(sbn, s1, s2)

   
   }


   close(dspfd)
   close(mixfd)

 stop!