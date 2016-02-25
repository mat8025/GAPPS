#"$Id: lmc,v 1.5 2004/10/06 22:01:42 clinical Exp clinical $"

SetDebug(0,"notunique")
//SetDebug(0,"pline")

// configure monitors to channels (this will be replaced shortly)
// any non-zero channel value configures selected monitor to that channel.


uchar driver_menu[100] = " 3500/OEM\nSolar/Dash"

int CDF_fh = -1
int DSR_fh = -1

float cbw_ms = 0
int cbw_br = 0
int cbw_cnt = 0
float cbw_st = 0.0


proc ComputeBW(ms, br ,st)
{
//    <<"lt: %6.3f $ms %d $br \r"

    cbw_ms += ms
    cbw_br += br
    cbw_cnt++
    cbw_st += st

  if (cbw_ms > 100) {

    mbw = cbw_br/ cbw_ms  * 1000
    ave_ll = cbw_ms/ cbw_cnt
    cbw_st *= 1000.0
    pc_st = cbw_st/ (cbw_ms + cbw_st) * 100
   <<" MBW %6.2f $mbw  $ave_ll  $pc_st \r"
   cbw_ms = 0.0
   cbw_br = 0
   cbw_cnt = 0
   cbw_st = 0.0

  }


}


proc Set3500Baud( wcf)
{
  // <<" Sending $bmsg \n"

     <<"Setting 3500 Baud for $wcf  \n"

     SdevSet(wcf,"speedo", 19200, "cs",8, "stop",1,"parity","none", "rts","hard","mode","raw")

     sleep(1)
     // write baud message to 3500

     SdevWrite(wcf, "\x1BDCE\x0D",5)

     sleep(1) // interval important -

  SdevSet(wcf,"speedi", 57600, "cs",8, "stop",1,"parity","none", "rts","hard")

}

proc SetSolarBaud(wcf)
{
   <<" Setting Solar Line $wcf \n"
     SdevSet(wcf,"speedo", 9600, "cs",8, "stop",1,"parity","none", "rts","none","mode","raw")
     SdevSet(wcf,"speedi", 9600, "cs",8, "stop",1,"parity","none", "rts","none","mode","raw")
     sleep(1)
}

proc OpenMonSL(wc)
{
// keep list of serial lines open
// reuse them - not close&reopen - because of flakey USB serial driver

 val = SerialLines[wc]
 <<" $_cproc $wc  $val \n"

 if (wc == 15) {
 <<" using COM 0
  sdevice = "/dev/ttyS0"
 }
 else 
 sdevice = scat("/dev/ttyUSB","$(wc-1)")

  if ( val == -1) {

 chnfd= SdevOpen(sdevice)

<<" opening $wc $sdevice $chnfd \n"

  SerialLines[wc] = chnfd

  sleep(1)

  for (isl = 0 ; isl < Nmons; isl++)
  <<"  $SerialLines[isl] "
  <<" \n"
 }
 else {


    chnfd = SerialLines[wc]

 <<" already open $wc $sdevice $chnfd \n"

 }


  return chnfd

}

proc Set35DriverChan( wc) 
{
<<" setup channel  wc  \n"
<<" driver 3500, channel is $wc \n"

   chnfd = OpenMonSL(wc)

 if (chnfd != -1)
    Set3500Baud(chnfd)

  return chnfd
}


proc SetSolarDriverChan( wc) 
{
<<" driver Solar, channel is $wc \n"

   chnfd = OpenMonSL(wc)

  if (chnfd != -1)
    SetSolarBaud(chnfd)

    return chnfd
}

proc ExDesatPkt()
{
      channel = dpbuff[0]
      tag = dpbuff[2]
      if (channel == 0xFE) {
         if (tag == 0x10) {
             <<" Got a menu request \n"
             driver_menu[0] = 0x11  // insert command tag as first byte
             dmsz = 20
             ok=putdesatpacket(DSR_fh, 254, driver_menu, dmsz)
             <<" Sent driver menu $driver_menu with size $dmsz \n "
         } else if (tag == 0x12) {
             new_channel = dpbuff[3];
             new_driver = dpbuff[4];
 <<" Got a channel assignment request (chan $new_channel, dri $new_driver ) \n"
               // First kill of any existing driver on the new channel
		// (This also takes care of driver==0, which is used to
		//  kill the existing driver without replacement)

		    if (PipIds[new_channel] >= 0) { 
		      DeleteMon( PipIds[new_channel])
		      PipIds[new_channel] = -1
		      driver_registry[new_channel] = 0
		    }

	     if (new_driver == 1) {
		 add_3500(new_channel)
		 driver_registry[new_channel] = 1
             } else if (new_driver == 2) {
                 add_solar(new_channel)
		 driver_registry[new_channel] = 2
             }

	     desat_buff[0] = 0x13
	     desat_buff[1] = new_channel
	     desat_buff[2] = 0

             ok=putdesatpacket(DSR_fh, 254, desat_buff, 3)

             //<<" Sent driver menu $driver_menu with size $sz \n "
         } else if (tag == 0x16) {
                done = 0;
                for (i=size; done == 0; i--) {
                   if (dpbuff[i] == 92) {    // it's a back slash
                       name_start = i+1;
                       done = 1;
                   }
                   if (i < 3) {
                      name_start = i+1;
                      done = 1;
                   }
                }
                name_end = size-2
    		new_filename_len = scpy(new_filename, dpbuff[name_start;name_end])
             <<" Got a filename change request\n"
             <<"     size: $new_filename_len ( $name_start , $name_end )\n"
             <<"     string: $new_filename  \n"
             <<"     uchar: $dpbuff[name_start;name_end] \n"

	     desat_buff[0] = 0x17
	     desat_buff[1] = 0
       // acknowledge new name
             ok=putdesatpacket(DSR_fh, 254, desat_buff, 2)

          for (channel=0;channel<Nmons;channel++) {
		    if (PipIds[channel] >= 0) { 
		      KillKid( PipIds[channel])
                    }
          }

   
      fclose(CDF_fh)

      opfile = new_filename;

      open_data_file(new_filename)


          t1 = utime()

        for (channel=0;channel<Nmons;channel++) {
	     if (driver_registry[channel] == 1) {
		 add_3500(channel)
             } else if (driver_registry[channel] == 2) {
                 add_solar(channel)
             }
           }

         } else {

             <<" Got packet, tag $tag on channel $channel\n"
             <<" $dpbuff\n"
         }

      } else {
    //  string = dpbuff[1;size]

<<" Received Desat packet size $size $channel $tag\n"
      }
}

int Nactmons = 0

proc CountMons()
{
int k =0
  for (monitor=0; monitor< Nmons; monitor++) {
    if (PipIds[monitor] >= 0) { 
        k++
    }
  }
   Nactmons = k
<<" %v $Nactmons \n"
   return k
}



uchar desat_buff[10]


chan_3500_A = 0
chan_3500_B = 0
chan_3500_C = 0
chan_3500_D = 0
chan_3500_E = 0

chan_solar_A = 0
chan_solar_B = 0
chan_solar_C = 0
chan_solar_D = 0
chan_solar_E = 0

chan_3900 = 0
//dashchan = 7


// spawn off other spi
// comm via pipes

// set this to zero - if mem problems - 1 uses a smart realloc



SetMemOption(1)

nf= OpenDll("uac",1)

<<" Opened uac found  $nf functions \n"

proc qhandler()
{
<<" script $_cproc Caught QUIT signal - \n"


<<" Shutting Down - Deleting Monitor Objects \n"


   STOP!

}


SigHandler("qhandler", "QUIT")


DA=ofw("mp_debug")

proc KillKid( id)
{
<<" Killing $id \n"
     ok = KillChild(id)
}


proc DeleteMon( id)
{
<<" DeleteMon $id \n"

}

proc open_data_file(filename) {

   for (i=1; i<1000; i++) {
      fullname = "${dirstring}/${filename}-${i}.cdf"
      status = fstat(fullname)
      <<"Check file $fullname  status= $status \n"
      if (scmp(status, "regular") != 1) {
         break
      }
   } 

   CDF_fh= fopen(fullname,"wb")

   <<"New file $fullname\n"

// initialize the new file with magic cookie and version numbers

   uchar major_rev = 0
   uchar minor_rev = 0

   w_data(CDF_fh, "CDFF", major_rev, minor_rev)

}


proc PutDSR()
{
    if ( (CB1[0] == 1) && (sz >= 45)) {
        ok=putdesatpacket(DSR_fh, monitor, CB1, sz)
        ngop++
        ViewMon() 
   }
}


proc ViewMon()
{
      if ((ngop % (10)) == 0) {
      <<"$ngop $monitor "
          dcgoptoa(1,CB1)
        }
}


char CB1[4096+]


char SLR[10]

      SLR[0]  = 1    // HOST_CLOCK_TICK


proc ReadMonitor(monitor)
{    
  pipid = PipIds[monitor]

  sz=ReadPipV(pipid, CB1)

  if (sz < 0) {
<<[2]" ERROR $sz monitor $monitor read\n"
   nerrs++
   return 0
  }

  if (sz > 100) 
    <<[2]" $sz $monitor record too big! \n" 
  else {

    DCWriteMF(CDF_fh, monitor, sz, CB1)
             //<<"\v Monitor $monitor read $sz $CB1[0;sz-1]\r"
    PutDSR()
  }

  return sz
}




char tag
uint fadc
char redrv;
char irdrv
char led
char gain
	 
ushort diag;
ushort sdflag;
uint unk = 0;

uint redv
uint irv
uint dmax


childwaitsecs = 0.05

proc add_solar(monitor)
{
//   PipIds[monitor] =  SpawnSpi("SolarPC", monitor)

     chn_fd = SetSolarDriverChan( monitor) 

   PipIds[monitor] =  ProConInit_Solar(-1, chn_fd, monitor, CDF_fh, DSR_fh)

 <<" add Solar $monitor $chn_fd  $PipIds[monitor] \n"

}

proc add_3500(monitor) {

//   PipIds[monitor] =  SpawnSpi("dri3500", monitor)

// return handle to 3500 object

   chn_fd=Set35DriverChan( monitor) 

// pass over cdf file handle - so driver module can write directly to cdf file

   PipIds[monitor] =  ProConInit_3500(-1,chn_fd,monitor, CDF_fh, DSR_fh)

 <<"  add_3500: for channel $monitor,  pip_id $PipIds[monitor] \n"

 }


proc add_3900(monitor) {
   PipIds[monitor] =  SpawnSpi("dev3900", monitor)
 <<"  3900 pip_id $PipIds[monitor] \n"
  sleep(childwaitsecs)
}

// pass in chan and pip_id


RecSolar = 0

// after received packet from solar then send another request
// 

last_tm = 0
last_dtick = 0
tm =0


idate = localtime()
<<" $tm $(date()) $idate\n"

<<"  $idate\n"
   dir_year = idate[5]+1900
   dir_month = idate[4]+1
   dir_day = idate[3]
   if (dir_month < 10) {
      dirstring = "/pulse/${dir_year}_0${dir_month}_${dir_day}"
   } else {
      dirstring = "/pulse/${dir_year}_${dir_month}_${dir_day}"
   }

<<"Directory string: $dirstring\n"
   status = fstat("/pulse")
   <<"/pulse status: $status \n"
   if (scmp(status, "directory") != 1) {
      <<"Cannot proceed without /pulse directory.\n"
      <<"You must create this as root with write permission for clinical.\n"
      exit
   }

   status = fstat("$dirstring")
   <<"final directory status: $status \n"
   if (scmp(status, "directory") != 1) {
      <"mkdir $dirstring"
   }


proc time_tick()
{
  tm = utime()

  if ((tm - last_tm) >= 1 ) {

   last_tm = tm

//   idate = localtime()
//<<[DA]" $tm $(date()) $idate\n"


   // idate to cdf file
   npb=packb(UCV,"C,S,C,I,",ms_chan,5,1,tm)

  niw= w_data(CDF_fh,UCV[0;npb-1])
//<<[DA]" %V $npb $niw %x $UCV\n"


// for any device active send it a heart-beat
// should do this for any element of PipIds >= 0
// Make sure Time goes into CDF file channel 0

    for (monitor=0; monitor<Nmons; monitor++) {
      if (PipIds[monitor] >= 33   ) { // time_tick to Solars
// write update command to monitor buffers - 
//          <<" time_tick to $PipIds[monitor] \n"
          dcwritecommand(PipIds[monitor], SLR, 1)
      }
    }


  if ( (tm - last_dtick) >= 10) {
//    <<" $(date()) \n"
       last_dtick = tm
//      WriteChild(pip_id2,SLR,1)
  }

  }
}



proc ShowTotal()
{
<<"                                                                                           \r"
<<"$nerrs\t$nscans\t$Csz[1;8]\t$totbr \r"
// <<"$nerrs\t$nscans\t$csz[1]\t$c2sz\t$c3sz\t$c4sz\t$c5sz\t$c6sz\t$c7sz\t$c8sz\t$totbr \r"
}



uchar UCV[100+]

showtotal = 0
// lets put DesatRigg serial line on usb7

Nmons = 16

int PipIds[32]
int driver_registry[32]
int SerialLines[32]


for (monitor=0;monitor<Nmons;monitor++) {
  PipIds[monitor] = -1
  driver_registry[monitor] = 0
  SerialLines[monitor] = -1
}



 sdevice = "/dev/ttyUSB7"
 //sdevice = "/dev/ttyUSB15"
 //sdevice = "/dev/ttyS1"

// deactivate for now
 DSR_fh = -1
 DSR_active = 1

if (DSR_active) {
 DSR_fh= SdevOpen(sdevice)

 SerialLines[8] = DSR_fh

 // do both at once
 SdevSet(DSR_fh,"speedo", 38400, "cs",8, "stop",1,"parity","none", "rts","hard","mode","raw")
 SdevSet(DSR_fh,"speedi", 38400, "cs",8, "stop",1,"parity","none", "rts","none","mode","raw")

}

// TEST FIXME - Solar crash if not open DSR serial line
 DSR_fh = -1
// Max mons 32 
// limit to 16




// should use PipIds
// each channel setup struct/class - channel number, pip_id data-buffer
//





 << "PipIds: $PipIds\n"

 sleep(1)

<<" MP active $1 \n"

  ms_chan = 255

  nscans = 0

  opfile = $2

  if (opfile @= "")
     opfile= "test"

<<" %v $opfile \n"


open_data_file(opfile)

// write a system description packet

 uchar systemID[100] = " lmc Rev. 20040927"  //note extra blank at position 0
 systemID[0] = 0;  //position 0 holds tag, replace blank with tag 0x00

 sz=18;            //we need to replace this with a computed size ASAP


 DCWriteMF(CDF_fh, 255, sz, systemID)

 t1 = utime()

// need select on pips to find out which to read from if any
// 
int rerr
int nerrs = 0

// channels_data_sizes
int Csz[32]

nrecs = 0
ngop = 0


// upto 16 channels 


uchar dpbuff[100+]
int size = 0
int new_channel

 resetdb = dbfseek(0,1)


int lmsz = 0
int lmblks = 0

//  Setup fixed 3500's & Solar

  add_solar(1)

  sleep(2)

  add_3500(2)

  sleep(1)

  add_3500(3)

  sleep(1)


  add_3500(4)

  sleep(1)

  add_3500(5)



#{




  add_3500(6)

  add_3500(7)

#}
 // channel 8 is DSR line



  T= FineTime()

int totbr
float msecs

float slp_intv = 0.02

while (1) {

   size = getDesatPacket(DSR_fh, dpbuff)
   
   if (size > 0) {
      ExDesatPkt()
      CountMons()
//   write to driver command buffers if message for particular driver

   }


  totbr = 0

//   
//   RunMonitors


  for (monitor=0; monitor<Nmons; monitor++) {

   if (PipIds[monitor] >= 0) {
         // id tells us which monitor/type to run
         totbr += DCRunMonitor(PipIds[monitor])
   }

  }

  nrecs += totbr

  nscans++

   if ((nscans % 5000) == 0) {
        t2 = utime()
        dsecs = t2 -t1
      nerrs = Check35errs()
      <<"\v %V $nscans $nrecs $nerrs  $dsecs                               \n"
      <<[DA]" %V $nscans $nrecs $nerrs  $dsecs  $(date())  \n"
   }


    time_tick()



//    yieldprocess()


    dt =FineTimeSince(T,1)
    msecs = dt/1000.0

    if ( msecs > 250)
    <<" $nscans loop takes too long $msecs \n"

    if (msecs < 20) {
    sleep(slp_intv)
    ComputeBW(msecs, totbr, slp_intv)
    }
    else
    ComputeBW(msecs, totbr, 0.0)

    FineTimeSince(T,1)

  }
   



<<" EXITING !! %v $nerrs $(date())  \n"
// kill my children

  for (monitor=0; monitor< Nmons; monitor++) {
    if (PipIds[monitor] >= 0) { 
//      KillKid( PipIds[monitor])
//      DeleteDriver
      PipIds[monitor] = -1
    }
  }
<< "PipIds: $PipIds\n"



STOP!


///////////////////////////////// TODO ///////////////////////////////////////////////
// report incomplete msg read - how to fix
// need to merge and make packets
// SpawnSpi args for passing channel numbers - line discipline
//
// commands M --> C
//
// test Child Read
//
// list on DSline for commands
// act on commands
//  OO version Odev - for list of active Odev's do Odev->read()
// GUI - for setup/Monitor




// thread version


#{
// MEMCHECK
   nmblks = CountMemBlocks()

 if (nmblks > lmblks) {
<<" $nscans %v $nmblks \n"
    lmblks = nmblks
 }

   msz = MemSize()

 if (msz > lmsz) {
<<" $nscans %v $msz \n"
   lmsz = msz
 }

#}
