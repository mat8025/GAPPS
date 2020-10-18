//
//
//

proc StrEcho( )
{

 // 

  while (1) {

       CR=GsockRead(A,"connect",1024)

       if (scmp(CR,"quit")) {
        <<" shutting down \n"
        break;
       }

       CR->reverse()

       GsockWrite(A,"connect",CR)

  }

}

// test socket code

// server

// create socket

// on server side the address can be any
// it is of type SOCK_STREAM AF_INET by default
  
  //port_id = 9895

int  port_id = atoi(_clarg[1])

 if (port_id @= "") {
    port_id = 9869
 }

  A = GsockCreate("any",port_id)

// and GsockCreate does the bind
// now listen on that socket - port
// backlog default is 1024

  GsockListen(A)
<<"Socket created server listening on our socket handle $A \n"
 
    
//
// i_read("->")
// setdebug(0,"step")
//


    while (1) {


 // block till get connection
<<" AT accept \n"
         Cfd = GsockAccept(A)

<<" got connected $Cfd \n"

          if (Cfd == -1) {
<<"badness $Cfd not accepted \n"
           stop()
          }

          cpid = Clone()

<<" did clone $cpid \n"

          <<"%V$cpid \n"

          if (cpid == 0) {

            GsockClose(A,"listen")
            // do serving
            StrEcho()

            STOP!

         }

          GsockClose("connect")

        // now open another for next client

         port_id++
         
         A = GsockCreate("any",port_id)
        <<" new socket $A $port_id \n"
            GsockListen(A)

//          STOP!

    }



