#! /usr/local/GASP/bin/spi

SetDebug(0,"notunique")
//SetDebug(0,"pline")

// configure monitors to channels (this will be replaced shortly)
// any non-zero channel value configures selected monitor to that channel.

uchar desat_buff[10]
int B

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
 done = 1
<<" Setting done $done \n"
 STOP!
}


 SigHandler("qhandler", "QUIT")


DA=ofw("mp_debug")

proc KillKid( id)
{
     ok = KillChild(id)

//   kp=GetPipPid(id)
//   if (kp >= 0)
//   <" kill -3 $kp "

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
   B= fopen(fullname,"wb")
   <<"New file $fullname\n"

// initialize the new file with magic cookie and version numbers

   uchar major_rev = 0
   uchar minor_rev = 0

   w_data(B, "CDFF", major_rev, minor_rev)
}

char CB1[4096+]


char SLR[10]

      SLR[0]  = 1    // HOST_CLOCK_TICK

proc ReadMonitor(monitor)
{    
  pipid = PipIds[monitor]

  sz=ReadPipV(pipid, CB1)

  if (sz < 0) {
<<" ERROR $sz monitor $monitor read\n"
   nerrs++
   return 0
  }

  if (sz > Csz[monitor]) {
     Csz[monitor] = sz
  }
  totbr += sz

  if (sz > 0) {

    DCWriteMF(B, monitor, sz, CB1)
             //<<"\v Monitor $monitor read $sz $CB1[0;sz-1]\r"

    if (CB1[0] == 1) {
      if (sz >= 45) {
        ok=putdesatpacket(DRsl, monitor, CB1, sz)
        ngop++
  
        if ((ngop % 10) == 0) {
      <<"$ngop $monitor "
          dcgoptoa(1,CB1)
        }
      }
    }
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


childwaitsecs = 0.2

proc add_solar(monitor)
{
   PipIds[monitor] =  SpawnSpi("SolarPC", monitor)
 <<" Solar pip_id $PipIds[monitor] \n"
  // sleep(childwaitsecs)
  // send first data request
 //  WriteChild(PipIds[monitor],SLR,1)
   sleep(childwaitsecs)
}

proc add_3500(monitor) {
   PipIds[monitor] =  SpawnSpi("dri3500", monitor)
 <<"  add_3500: for channel $monitor,  pip_id $PipIds[monitor] \n"
  sleep(childwaitsecs)
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



  niw= w_data(B,UCV[0;npb-1])
//<<[DA]" %V $npb $niw %x $UCV\n"


// for any device active send it a heart-beat
// should do this for any element of PipIds >= 0

    for (monitor=0; monitor<32; monitor++) {
      if (PipIds[monitor] >= 0   ) {
        WriteChild(PipIds[monitor], SLR, 1)
        RecSolar = 0
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

NSCANS = 50000000

uchar UCV[100+]

showtotal = 0
// lets put DesatRigg serial line on usb7

 sdevice = "/dev/ttyUSB7"
 DRsl= SdevOpen(sdevice)

 // do both at once
 SdevSet(DRsl,"speedo", 38400, "cs",8, "stop",1,"parity","none", "rts","hard","mode","raw")
 SdevSet(DRsl,"speedi", 38400, "cs",8, "stop",1,"parity","none", "rts","none","mode","raw")


// deactivate for now
 // DRsl = -1

int PipIds[32]
int driver_registry[32]

for (monitor=0;monitor<32;monitor++) {
  PipIds[monitor] = -1
  driver_registry[monitor] = 0
}

// should use PipIds
// each channel setup struct/class - channel number, pip_id data-buffer
//


 if (chan_3500_A) {
   add_3500(chan_3500_A)
 }

 if (chan_3500_B) {
   add_3500(chan_3500_B)
 }

 if (chan_3500_C) {
   add_3500(chan_3500_C)
 }

 if (chan_3500_D) {
   add_3500(chan_3500_D)
 }

 if (chan_3500_E) {
   add_3500(chan_3500_E)
 }

 if (chan_solar_A) {
   add_solar(chan_solar_A)
 }

 if (chan_solar_B) {
   add_solar(chan_solar_B)
 }

 if (chan_solar_C) {
   add_solar(chan_solar_C)
 }

 if (chan_solar_D) {
   add_solar(chan_solar_D)
 }

 if (chan_solar_E) {
   add_solar(chan_solar_E)
 }

 if (chan_3900) {
   add_3900(chan_3900)
 }

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


 DCWriteMF(B, 255, sz, systemID)

 t1 = utime()

// need select on pips to find out which to read from if any
// 
int rerr
int nerrs = 0

// channels_data_sizes
int Csz[32]

uint session_total = 0
nrecs = 0
ngop = 0


// upto 16 channels 


uchar dpbuff[100+]
int size
int new_channel

 resetdb = dbfseek(0,1)

while (1) {

   size = getDesatPacket(DRsl, dpbuff)
   if (size > 0) {
      channel = dpbuff[0]
      tag = dpbuff[2]
      if (channel == 0xFE) {
         if (tag == 0x10) {
             <<" Got a menu request \n"
             uchar driver_menu[100] = " 3500/OEM\nSolar/Dash"
//<<" $driver_menu \n"
             //driver_menu[5] = 0x0a  // don't know how to do '\n'
             driver_menu[0] = 0x11  // insert command tag as first byte
             sz = 20
             ok=putdesatpacket(DRsl, 254, driver_menu, sz)
             <<" Sent driver menu $driver_menu with size $sz \n "
         } else if (tag == 0x12) {
             new_channel = dpbuff[3];
             new_driver = dpbuff[4];
             <<" Got a channel assignment request (chan $new_channel, dri $new_driver ) \n"
               // First kill of any existing driver on the new channel
		// (This also takes care of driver==0, which is used to
		//  kill the existing driver without replacement)

		    if (PipIds[new_channel] >= 0) { 
		      KillKid( PipIds[new_channel])
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

             ok=putdesatpacket(DRsl, 254, desat_buff, 3)

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
             ok=putdesatpacket(DRsl, 254, desat_buff, 2)
for (channel=0;channel<32;channel++) {
		    if (PipIds[channel] >= 0) { 
		      KillKid( PipIds[channel])
                    }
}
   
fclose(B)
opfile = new_filename;
 //B= ofw(opfile)
 //B= fopen(new_filename,"ab")
open_data_file(new_filename)


 t1 = utime()

for (channel=0;channel<32;channel++) {
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

//  dbfseek(resetdb)

  totbr = 0

 for (monitor=0; monitor<32; monitor++) {
   if (PipIds[monitor] >= 0) {
     totbr += ReadMonitor(monitor)
   }
 }


   nscans++
                                                         

   if ((nscans % 5000) == 0) {
        t2 = utime()
        dsecs = t2 -t1

      <<"\v %V $nscans $nrecs $nerrs  $dsecs                               \n"
      <<[DA]" %V $nscans $nrecs $nerrs $session_total $dsecs  $(date())  \n"
   }

   if (showtotal && totbr > 0)
         ShowTotal()

    time_tick()
    sleep(0.01)
    yieldprocess()

    session_total += totbr                                                         

  }
   



<<" EXITING !! %v $nerrs $(date())  \n"
// kill my children

  for (monitor=0; monitor<32; monitor++) {
    if (PipIds[monitor] >= 0) { 
      KillKid( PipIds[monitor])
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


