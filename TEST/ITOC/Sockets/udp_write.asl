
stype = "XX"


char CW[64] = { "mark terry sending" }

<<" %s $CW \n"


proc StrCli( cfd)
{

 // 
  while (1) {


  // send to server socket

//   CW[] = "$Stat"

   n=GsockSendTo(A,"listen to me")

<<" done sendto $n \n"

   sleep(3)

  }

}


 Ipa = GetArgStr()

 if (Ipa @= "") {
     Ipa = "127.0.0.1"
 }

 //port = GetArgI(9871)
 port = 9871


<<"%V  $Ipa $port \n"



      A = GsockCreate(Ipa, port, "UDP")

<<" created UDP type socket index $A $port\n"

      GsockConnect(A)

      errnum = CheckError()

<<"%v $errnum \n"

<<" now reading from it \n"

      StrCli()

      STOP!

