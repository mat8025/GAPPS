
//setdebug(1)

char CR[128] = { "mark terry serving" }

proc StrEcho( )
{

 // 
  while (1) {

        CR=GsockRead(A,"connect",1024)
        bcr = srev(CR)
 
<<"%s$bcr\n"

        GsockWrite(A,"connect",CR)
  }

}

// test socket code

// server

// create socket

// on server side the address can be any
// it is of type SOCK_STREAM AF_INET by default
Ipa = "any"

wport = GetArgI(1)

 port = 9871


<<"%V$Ipa $port $wport\n"


  A = GsockCreate("any", wport, "TCP")

//  A = GsockCreate("any",port)

// and GsockCreate does the bind

// now listen on that socket - port

// backlog default is 1024

  GsockListen(A)

<<"server listening on $A  port $wport\n"


    while (1) {

 // block till get connection
<<"connect to  $A\n"

         Cfd = GsockAccept(A)

<<"got connected $Cfd \n"

           cpid = Clone()

<<" did clone $cpid \n"

          <<"%V$cpid \n"
          if (cpid == 0) {

            GsockClose(A,"listen")
            // do serving
            StrEcho()

            exit()
          }

          GsockClose(A,"connect")


<<" EXIT \n"
     exit()

    }

<<" never gets here !\n"


exit()

