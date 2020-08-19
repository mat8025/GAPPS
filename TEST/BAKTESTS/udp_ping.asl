
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

dt = 0.001

Stat = "hello"

it =GetTime()
df = 1.0
proc StrCli( cfd)
{
 k = 0
 // 
 max = 0
 min = 0
 uint ts
 T = FineTime()
  while (1) {


   ts =FineTimeSince(T)
   ts /= 1000000.0

   f= k * dt * df
   y = Sin(f)

   max = y
   min = Cos(f* 1.7)

   tn = Tan(f)
// send to server socket

//  Stat=readln(";-) ",stype)

//<<" Stat $Stat \n"
   Stat = "$k $ts $min $max $tn"
   n=GsockSendTo(A,Stat)
   df += 0.01
   sleep(0.5)
   k++

   if ((k % 2000) == 0) {
       df = 1.0
   }

  }

}


// port = GetArgI(9871)

 port = 9871

// get softbbench_sbc_ip


     Ipa = "127.0.0.1"


<<"%V  $Ipa $port \n"


      A = GsockCreate(Ipa, port, "UDP")

<<" created UDP type socket index $A $port\n"

      GsockConnect(A)

      errnum = CheckError()

<<"%v $errnum \n"

<<" now sending stuff to it \n"

      StrCli()

      STOP!

