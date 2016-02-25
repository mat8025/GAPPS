
#/* -*- c -*- */
# "$Id: sread3500,v 1.1 2003/06/25 07:08:30 mark Exp mark $"

    // read 3500 data from pox instrument

    //    SetDebug(0,"pline")

SetDebug(0,"unique")

nf= OpenDll("uac",1)
<<" Opened uac found  $nf functions \n"


uchar DB1[]
uchar DB2[]
uchar ev[3] = { 0,1,2 }

uchar rev[3] = { 0x81,0x82,0x83 }

proc AddBuf( ibuf)
{

  //<<" %x $ibuf \n"
  sz= Caz(ibuf)
    dsz = Caz(DB1)
  //<<" %x $DB1 \n"
  DB2 = DB1 @+ ibuf

    //<<" %x $DB2 \n"

  DB1 = DB2

    sz = Caz(DB1)

    // <<" addbuf %v $sz \n"

}

//int SSI[] = { 0x81, 0x83 }

proc XtractRec()
{

 nxrec = 0

  while (1) {

  sz = Caz(DB1)
  
  if (sz == 0) 
     break
  
       ssi = vfindval(DB1, { 0x81, 0x83 })

       starti= ssi[0]
       stopi = ssi[1]
       
       //       <<" $sz $starti $stopi \n"

    if (starti == -1)
          break

    if (stopi == -1)
          break
 
    if (stopi > starti) {

    nc = stopi- starti + 1

    // forward process record
    // another
    //partial - transfer to DB2

    //<<" extract/forward record  $nc \n"
    // repeat till no more records
    nrec = DB1[starti;stopi] 
   

    rnrec = Rescape(nrec,0x81,ev,rev)

    // rnrec has escape values removed
    // start & stop char removed

    //    if (rnrec[1] == 36)  <<" OXI %x $nrec \n"

    //    <<" 3500 rec type $rnrec[1] \n"

    // write/forward/process

    db2 = DB1[stopi+1;sz-1]

    recsz = Caz(rnrec)
    // now copy on to

    DB1 = db2

     sz = Caz(DB1)
	 //<<" %v $recsz new %v $sz \n"

 
    ok=writepipmsg(pip_id,rnrec,recsz)

    b3500rtoa(Ba,rnrec)

     nxrec++
    }
    else {
      // partial message - shuffle left
     db2 = DB1[stopi+1;sz-1]
     DB1 = db2
    }

  }

 <<" xtracted $nxrec records \n"

}


proc qhandler()
{
<<" $0 script $_cproc Caught QUIT signal - \n"
 done = 1
<<" DONE closing serial line $A \n"
 SdevClose(A)
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
  // <<" Sending $bmsg \n"

<<"Setting Baud for $A $channel \n"

     SdevSet(A,"speedo", 19200, "cs",8, "stop",1,"parity","none", "rts","hard","mode","raw")

     sleep(1)
     // write baud message to 3500

     SdevWrite(A, "\x1BDCE\x0D",5)

     Send_baud =0

     sleep(1) // interval important -

     SdevSet(A,"speedi", 57600, "cs",8, "stop",1,"parity","none", "rts","hard")

}

 SigHandler("qhandler", "QUIT")

 // SigHandler("ihandler", "INT")

  RTsigvec = Igen(32,33,1)

// handles all RT signals - ?? test speed of service / blocking ??

  SigHandler("rthandler", RTsigvec)

// opens a serial device , reads and echos to stdout

  dopack = 1


na = GetArgc()
<<" %v $na \n"

for (i = 0 ; i < na ; i ++) {
av = $i
<<" $i $av\n"

}




<<" setup channel  $1  \n"
  channel = $1 


<<" ### in dri3500, channel is $channel \n"
if (channel == 15) {
<<" using COM 0
  sdevice = "/dev/ttyS0"
}
 else 
sdevice = scat("/dev/ttyUSB","$(channel-1)")

<<" opening $channel $sdevice \n"


 A= SdevOpen(sdevice)

<<" $A \n"


<<" in DevDri3500 \n"

 pid = GetPid()

 pip_id = GetPipIndex()

<<" $0 %v $pid  $pip_id\n"

// check that we are connected to mother script

 if (pip_id < 0) {
  <<" invalid pip \n"
  STOP!
 }

//Aset = SdevGet(A)

 SendBaud()

 done = 0




  // double buffer serial-stream 
  // so we can pull out records
  // categorize and optional send out
  // and/or decode

  // this inits with handles to serial channel and pipe fds

  Fbuf = sdevRead(A,1024,0)

  sz = Caz(Fbuf)

<<" flushed $sz \n"

  ProConInit_3500(pip_id,A, channel)

 nscans = 0

 while ( ! done) {

   err=ProConRun_3500()

   sleep(0.001)

   nscans++
  
   //   if (nscans > 1000) break

 }



 SdevClose(A)

STOP!




 /////////////////////////////////////////// TODO ////////////////////////////////////////////////////////

 // needs to echo - messages to another ttyUSB for desat rigg!


//////////////////////////////////////////////////////////////////////////////////////////////////////////

