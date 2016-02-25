// read HMR2300
// all commands need pause between WE and value

proc GetResp()
{
  si_pause(0.1)
  Line = sdevreadline(DRsl,256, 10)

  if (Caz(Line) > 1) {
     <<" << %s $Line \n"
  }

}

proc  set_ascii()
{
  sdevwrite(DRsl,"*99WE\r")
  si_pause(0.1)
  sdevwrite(DRsl,"*99A\r")

}

proc set_rate(rate)
{
 sdevwrite(DRsl,"*99WE\r")
  si_pause(0.1)
 sdevwrite(DRsl,"*99R=$rate\r")
}


read_ascii = 1
poll = 1

proc qhandler()
{
<<" script $_cproc Caught QUIT signal - \n"
 done = 1
<<" Setting done $done \n"
 STOP!
}


// SigHandler("qhandler", "QUIT")
 Setdebug(1)


 sdevice = "/dev/ttyUSB0"

 DRsl= SdevOpen(sdevice)
 <<" %v $DRsl \n"



 if (DRsl == -1)
     STOP!

 //sdevset(DRsl,"speed",19200,"parity","null","stop",1,"data",8, "flow","none")

sdevset(DRsl,"speed",9600,"parity","null","stop",2,"data",8, "flow","none")

//  

 char Line[256];
 Line[0] = 27;
 Line[1] = 0;


 sdevwrite(DRsl,Line,1)




 sdevwrite(DRsl,"*99WE\r")
 sdevwrite(DRsl,"*99!BR=S\r")

  GetResp()


#{
 sdevwrite(DRsl,"*99WE\r")
 sdevwrite(DRsl,"*99!BR=F\r")
 sdevset(DRsl,"speed",19200,"parity","null","stop",1,"data",8, "flow","none")
#}

// sdevwrite(DRsl,"*99C\r")

   sdevwrite(DRsl,"*99Q\r")


    GetResp()

// sdevwrite(DRsl,"*99C\r")

     set_rate(20)


     GetResp()


     set_ascii()


     GetResp()

 if (read_ascii) {

     set_ascii()

     GetResp()

 }
 else {
<<"setting binary \n"
  sdevwrite(DRsl,"*99WE\r")
  sdevwrite(DRsl,"*99B\r")
     GetResp()


 }

// sdevwrite(DRsl,"*99WE\r")
// sdevwrite(DRsl,"*99!BR=F\r")





 lc = 0



  sdevwrite(DRsl,"*99#\r")

     GetResp()


   sdevwrite(DRsl,"*99F\r")

     GetResp()





// sdevwrite(DRsl,"*99C\r")


 sdevwrite(DRsl,"*99Q\r")

     GetResp()




  a=iread("->")

// sdevwrite(DRsl, "*99P\r")
 sdevwrite(DRsl, "*99C\r")


 sdevwrite(DRsl,"*99Q\r")

     GetResp()


  a=iread("->")



 short X;
 short Y;
 short Z;
 char ce
 int sz
 
 short S[20]


   if (poll) {
   sdevwrite(DRsl, "*99P\r")
   }
 lc = 0

 char NC[256]
 int bad_read =0
 while (1) {

   //Line = sdevreadline(DRsl,7, 10)

//  a=iread("->")

  
  si_pause(0.04)
   if (poll) {
   sdevwrite(DRsl, "*99P\r")
   }
  si_pause(0.05)


 if (read_ascii) {
  Line = sdevreadline(DRsl,256, 10)
  if (Caz(Line) > 1) {
      <<"$lc %s $Line \n"
  }
 }
 else {

   if (poll) {
   sdevwrite(DRsl, "*99P\r")
   }
     sz =sdevreadbuf(DRsl,NC,14,1)
         bscan(NC,0,X,Y,Z,ce)
     //sz = Caz(Line)


   if ((sz == 7) && (ce == 10)) {

//      NC=Line



      //   <<"$lc $sz %x $NC[0] $NC[1] $NC[2] $NC[3] $NC[4] $NC[5] $NC[6] \n"
      if ((lc % 5) == 0) {
      <<"%V $lc $sz %d $X $Y $Z  %d $ce\n"
      }
   }
   else {
<<"$lc misread $sz \n"
   }
}

  lc++

  if (lc > 10000)
    break;

 }




///  restore


 Line[0] = 27;
 Line[1] = 0;


 sdevwrite(DRsl,Line,1)
 //sdevwrite(DRsl,"*99C\r")
