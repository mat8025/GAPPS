
stype = "UDP"


char CR[64] = { "mark terry serving" }

//<<"%s$CR \n"

//    Stat=ireadln(";-) ",stype)
//<<"$Stat \n"



proc StrCli( cfd)
{
 int k = 1;
 // 

  while (1) {

    Stat = "echo_$k";

//    Stat=ireadln(";-) ",stype)

    <<"%V$Stat \n"

  // send to server socket

//   CW[] = "$Stat"

   n=GsockWrite(A,"listen",Stat)

//<<" done write $n \n"

  // read from server socket

   CR=GsockRead(A,"listen",64,1)

  // now output to stdout
 
   <<"%s$CR \n"

   sleep(0.1);
   k++;
  }

}

 Ipa = GetArgStr()

 if (Ipa @= "") {
     Ipa = "127.0.0.1"
 }


 wport = GetArgI()
// port = 9871

<<"%V$wport $Ipa \n"


     A = GsockCreate(Ipa, wport, "TCP")

<<" created socket index $A $wport\n"

      GsockConnect(A)

      errnum = CheckError()

<<"%V$errnum \n"

      StrCli()

      STOP!

////////////////////////////////////////////////