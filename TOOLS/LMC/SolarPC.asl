#/* -*- c -*- */
# "$Id: SolarPC,v 1.1 2003/06/25 07:08:30 mark Exp mark $"

    // read Solar data from pox instrument
    //    SetDebug(0,"pline")

SetDebug(0)

     nf= OpenDll("uac",1)

<<" Opened uac found  $nf functions \n"

proc qhandler()
{
<<" $0 script $_cproc Caught QUIT signal - \n"
 done = 1
<<" Setting done $done \n"
    // send shutdown msg to  driver code

    sleep(2)
    // wait and then

 STOP!
}

Send_baud =0

proc ihandler()
{
 Send_baud = 1
<<" script $_cproc Caught INT signal $Send_baud \n"

}

int SQ[]

int ncs = 0

proc rthandler()
{

// use internal SIGNUM list to tell which if rthandler use for group
// of signals
   ncs++

   SQ= GetSig()
    <<" $ncs Caught RT signal $SQ[*]\n"
}


proc SendBaud()
{
   <<" Sending \n"
     SdevSet(A,"speedo", 9600, "cs",8, "stop",1,"parity","none", "rts","none","mode","raw")
     SdevSet(A,"speedi", 9600, "cs",8, "stop",1,"parity","none", "rts","none","mode","raw")
     sleep(1)
     // write baud message to 3500
     Send_baud =0
}


    SigHandler("qhandler", "QUIT")
 // SigHandler("ihandler", "INT")

  RTsigvec = Igen(32,33,1)

// handles all RT signals - ?? test speed of service / blocking ??

  SigHandler("rthandler", RTsigvec)

// opens a serial device , reads and echos to stdout

na = GetArgc()
<<" %v $na \n"
for (i = 0 ; i < na ; i ++) {
av = $i
<<" arg $i $av\n"
}


<<" setup channel  $1  \n"
  channel = $1 

if (channel == 15) {
 <<" using COM 0
  sdevice = "/dev/ttyS0"
}
 else  {
sdevice = scat("/dev/ttyUSB","$(channel-1)")

}

<<" opening $channel $sdevice \n"

 A= SdevOpen(sdevice)

<<" serial FD $A \n"

 pid = GetPid()

 pip_id = GetPipIndex()

  //<<" $0 %v $pid  $pip_id\n"
// check that we are connected to mother script

 if (pip_id < 0) {
  <<" invalid pip \n"
  STOP!
 }

  // intial serial line discipline

 SendBaud()

 done = 0

  // this inits with handles to serial channel and pipe fds

 sleep(1)


  Fbuf = sdevRead(A,1024,0)

  sz = Caz(Fbuf)

<<" flushed $sz \n"


 ProConInit_Solar(pip_id,A)

 nscans = 0

 while ( ! done) {

   //<<"RunSolar \n"
   err=ProConRun_Solar()
   
   sleep(0.001)
   //yieldProcess()

   nscans++

 }



 SdevClose(A)

STOP!




 /////////////////////////////////////////// TODO ////////////////////////////////////////////////////////

 // needs to echo - messages to another ttyUSB for desat rigg!


//////////////////////////////////////////////////////////////////////////////////////////////////////////

