
stype = "XX"


char CW[64] = { " sending" }

<<" %s $CW \n"

msg0 = " Sending msg to SBC"
msg1 = "udpinfo "
msg2 = "info "
msg3 = "badports "
int k = 0
   v="msg$k"
<<" $v \n"
<<" ${$v} \n"

msg = "udpinfo info badports"
ms = split(msg)
stype = "XX"



proc StrCli( cfd)
{

 // 
  while (1) {


// send to server socket

  Stat=readln(";-) ",stype)

<<" Stat $Stat \n"
   n=GsockSendTo(A,Stat)

//   n=GsockSendTo(A,ms[k])
//<<" done sendto ${ms[k]} \n"

  // msg = scat(msg,"$k")

//   sleep(10.0)
   k++
   if (k > 2)
     k =0
  }

}


// port = GetArgI(9871)

 port = 9871

// get softbbench_sbc_ip

A=ofr("/usr/people/user/softbench_sbc_ip")

Ipa = rword(A)
<<" %v $Ipa \n"

if (Ipa @= "") {
 Ipa = GetArgStr()

 if (Ipa @= "") {
     Ipa = "127.0.0.1"
 }

}

<<"%V  $Ipa $port \n"



      A = GsockCreate(Ipa, port, "UDP")

<<" created UDP type socket index $A $port\n"

      GsockConnect(A)

      errnum = CheckError()

<<"%v $errnum \n"

<<" now sending stuff to it \n"

      StrCli()

      STOP!

