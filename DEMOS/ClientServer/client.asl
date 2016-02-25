// client  TCP

stype = "XX"

char CW[64] = { "client app" }

<<" %s $CW \n"

proc StrCli( cfd)
{

  while (1) {

  Stat = iread("type message:-")
<<" Stat $Stat \n"

// send to server socket

   n=GsockWrite(A,"listen",Stat)

// read response from server socket

   CR=GsockRead(A,"listen",64,1)

// now output to stdout

<<"%s$CR \n"

  }

}


 if (argc() < 3) {
  <<" usage:  asl client.asl <Ip address e.g. loopback  (127.0.0.1) or 192.168.0.xx> <port e.g. 9869> \n"
  exit()
 }

int  port = atoi(_clarg[2])

 Ipa = ""
 Ipa = _clarg[1]

<<"%V$port $Ipa \n"



   A = GsockCreate(Ipa, port)

<<" created socket index $A $port\n"

      GsockConnect(A)

      errnum = CheckError()

<<" $errnum \n"

      StrCli()

exit()

