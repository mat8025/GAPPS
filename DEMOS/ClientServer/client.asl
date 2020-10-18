//%*********************************************** 
//*  @script client.asl 
//* 
//*  @comment test client socket functions 
//*  @release CARBON 
//*  @vers 1.3 Li Lithium [asl 6.2.76 C-He-Os]                               
//*  @date Thu Oct 15 09:55:34 2020 
//*  @cdate 1/1/2008 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
myScript = getScript();
// client  TCP

stype = "XX"

char CW[64] = { "client app" }

<<" %s $CW \n"

proc StrCli( cfd)
{

  while (1) {

  Stat = iread("type message:-")
//<<" Stat $Stat \n"

// send to server socket

   n=gsockWrite(A,"listen",Stat)

// read response from server socket

   CR=gsockRead(A,"listen",64,1)

// now output to stdout

<<"%s$CR \n"

  }

}


 if (argc() < 3) {
  <<" usage:  asl client.asl <Ip address e.g. loopback  (127.0.0.1) or 192.168.0.xx> <port e.g. 9869> \n"
  <<"where xx is ip number of machine running the server\n"
  exit()
 }
 
   pid = getAslPid() ; 


int  port = atoi(_clarg[2])

 Ipa = ""
 Ipa = _clarg[1]

<<"%V$pid $port $Ipa \n"



   A = gsockCreate(Ipa, port)

<<" created socket index $A $port\n"

      gsockConnect(A)

      errnum = checkError()

<<" $errnum \n"

      StrCli()

exit()

