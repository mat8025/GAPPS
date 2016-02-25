#/* -*- c -*- */
// test record of vox  files

OpenDll("audio","image")

int Freq  = 16000
float Sfactor = 1.0

nsecs = 10
int Nsamps = nsecs * 16000


short Sbuf[Nsamps]

proc RecBuff()
{
// recording thread
  tid = GthreadGetId()

<<" Start Recording ! \n"

  SetSoundParams(dspfd, mixfd, Freq, 1)

  RecordBuffer(Sbuf, dspfd, Nsamps, 1)

<<" Done Recording ! \n"

  GthreadExit(tid)

}

proc DisplayBuff()
{
// display thread
  tid = GthreadGetId()

  while (1) {

  svec = Stats(Sbuf)

//   <<"%6.2f $svec \r"
//    sleep(0.5)

  <<"mean %V6.4f$svec[1] min $svec[5] max $svec[6] \r"

  }

   GthreadExit(tid)

}



// which files

//sf = $2
//bytesize = fstat(sf,"size")
<<"%v $bytesize \n"
how_long = 3.0
// OPTIONS
<<"%V$_clarg \n"


aud_file = "gt.aud"

ka = 0

      while (AnotherArg()) {

	opt = GetArgStr()

<<"%V$ka $opt \n"

      if (opt @= "-f") {
         Freq = GetArgI()
       <<" setting %v$Freq  \n"
       }
     elif (opt @= "-l") {
      how_long = GetArgF()
    <<" setting %V$how_long \n"
     }
     else {
      aud_file = opt
     }

     ka++
   }


fsecs = how_long
Nsamps = fsecs * Freq

<<" setting record circular buffer time to $how_long secs $Nsamps samples  record output file $aud_file\n"

// get/open dsp

  dspfd = dspopen()

// get/open  mixer

  mixfd = mixeropen()

// set dsp,mixer

<<"%V $dspfd $mixfd \n"

   recid = gthreadcreate("RecBuff")

   displayid = gthreadcreate("DisplayBuff")

     nt = gthreadHowMany()

  <<" WAITING for $(nt-1) other threads to finish \n"

      ttyin("in main waiting for any key-stroke to stop recording !!:")

      gthreadSetFlag(recid,1)

      gthreadExit(displayid)

     Gthreadwait()
// release devices

     nt = gthreadHowMany()

  <<" WAITING for $(nt-1) other threads to finish \n"


// write Sbuf to file
   A=ofw(aud_file)

   wAudHeader(A,"freq",)

   Wdata(A,Sbuf)

   close(dspfd)

   close(mixfd)

   STOP("DONE RECORD - output in $aud_file\n")


