#! /usr/local/GASP/bin/asl


proc StrEcho( )
{

 // 
  int k = 0
 
 while (1) {

       CR=GsockRead(A,"connect",1024)

       sz = Caz(CR)
      if (sz == -1)
       STOP!
       err= Cerror(CR)
   if (err == -1)
         STOP!


//<<" msg sz $sz \n"

  if (sz > 0) {

 <<" $k read $sz chars >>> %s $CR \n"

      RC = srev(CR)

       nw=GsockWrite(A,"connect",RC)

// <<" %v $nw \n"

     k++
   }

        //     sleep (1)

  }

}




Ipa = "any"

port = GetArgI(9871)


<<"%V  $Ipa $port \n"


// test socket code

// server

// create socket

  pid = GetPid()

<<" mypid $pid \n"

// on server side the address can be any
// it is of type SOCK_STREAM AF_INET by default

//  A = GsockCreate("any",port,"TCP")
  A = GsockCreate("any",port)

<<" Create Socket index $A on port $port\n"

// and GsockCreate does the bind

// now listen on that socket - port

// backlog default is 1024

  GsockListen(A)

  cpid = 0
 
   while (1) {

 // block till get connection
<<" waiting on a friend \n"

         Cfd = GsockAccept(A)

<<" got connected $Cfd \n"

     if (Cfd != -1) {


           cpid = Clone()

          if (cpid == 0) {
          <<" did clone $cpid \n"
          <<" %v $cpid \n"

            GsockClose(A,"listen")
            // do serving
            StrEcho()
            <<" should not get here ! \n"
            STOP!
          }

          <<" did clone $cpid \n"
          <<" %v $cpid \n"

       } 
       else {
         <<" bad connect \n"
           STOP!
       }

          GsockClose(A,"connect")
    }



